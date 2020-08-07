//
//  ViewController.swift
//  WeatherForecast
//
//  Created by Cuong Nguyen on 05/08/2020.
//  Copyright © 2020 Cuong Nguyen. All rights reserved.
//

import UIKit

protocol ListWeatherViewProtocol: class {
    func refreshView(_ listWeather: [WeatherItem]?)
    func startLoading()
    func finishLoading()
    func showReachabilityAlert()
    func showDownloadErrorAlert(error: Error)
}

class WeatherForeCastViewController: UIViewController, ListWeatherViewProtocol {
    @IBOutlet weak var tableView: UITableView!
    let searchBar = UISearchBar()
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var listWeather: [WeatherItem]?
    var presenter: WeatherForecastListViewPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter = WeatherForecastListViewPresenter(view: self)
        configTableView()
        configSearchBar()
        activityIndicator?.hidesWhenStopped = true
    }
    
    private func configTableView() {
        tableView.register(UINib(nibName: "WeatherForecastTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 255
        self.tableView.delegate = self
        self.tableView.dataSource = self
        tableView.allowsSelection = false
    }
    
    private func configSearchBar() {
        searchBar.delegate = self
        searchBar.sizeToFit()
        searchBar.placeholder = "Search city"
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.isTranslucent = false
        navigationItem.title = "Weather Forcast"
        showSearchBarButton(shouldShow: true)
    }
    
    func showSearchBarButton(shouldShow: Bool) {
        if shouldShow {
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search,
                                                                target: self,
                                                                action: #selector(handleShowSearchBar))
        } else {
            navigationItem.rightBarButtonItem = nil
        }
    }
    
    @objc func handleShowSearchBar() {
        searchBar.becomeFirstResponder()
        search(shouldShow: true)
    }
    
    func search(shouldShow: Bool) {
        showSearchBarButton(shouldShow: !shouldShow)
        searchBar.showsCancelButton = shouldShow
        navigationItem.titleView = shouldShow ? searchBar : nil
    }
    
    func refreshView(_ listWeather: [WeatherItem]?) {
        guard let listWeather = listWeather else { return }
        self.listWeather = listWeather
        tableView.reloadData()
    }
    
    func startLoading() {
        activityIndicator?.startAnimating()
    }
    
    func finishLoading() {
        activityIndicator?.stopAnimating()
    }
    
    func showReachabilityAlert() {
        activityIndicator?.stopAnimating()
        
    }
    
    func showDownloadErrorAlert(error: Error) {
        activityIndicator?.stopAnimating()
    }
    
}

extension WeatherForeCastViewController: UITableViewDelegate {
    
}

extension WeatherForeCastViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listWeather?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? WeatherForecastTableViewCell
        cell?.weatherItem = listWeather?[indexPath.row]
        return cell ?? UITableViewCell()
    }
}

extension WeatherForeCastViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        search(shouldShow: false)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // Throttle search reduce number of request to server after user did change text
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(self.reload(_:)), object: searchBar)
        perform(#selector(self.reload(_:)), with: searchBar, afterDelay: 0.5)
    }
    
    @objc func reload(_ searchBar: UISearchBar) {
        guard let query = searchBar.text, query.trimmingCharacters(in: .whitespaces) != "", query.count > 3 else {
            return
        }
        
        self.presenter.loadWeatherForecast(query)
    }
}

