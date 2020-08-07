# WeatherForecast
![License](https://img.shields.io/cocoapods/l/ResolutionChecker.svg?style=flat)
![](https://img.shields.io/badge/Supported-iOS13.6-4BC51D.svg?style=flat)
![](https://img.shields.io/badge/Version-Xcode11.6(11E708)-4BC51D.svg?style=flat)

## Description

WeatherForecast is an iOS application built on **MVP (Model View Presenter)** concept

Application support people search weather in whole city in the world in next 7 days.

## Feature
- [x] [Search weather forcecast in 7 days](https://github.com/cuoong/WeatherForecast)

## Requirements

- iOS 13.6
- Xcode 11.6
- Swift 5
- Pod v1.9.3 or above

## What I've done

- [x] Written by Swift.
- [x] Able to retrieve the weather information from OpenWeatherMaps API.
- [x] Allow user to input the searching term.
- [x] Able to proceed searching with a condition of the search term length more than 3 characters
- [x] Render the searched results as a list of weather items.
- [x] Support cache on RAM and preventing bunch of API request when user searh city
- [x] Manage caching mechanism & lifecycle.
- [x] Handle failures for internet connection and request error
- [x] Support the disability to scale large text
- [x] Support the disability to read out the text
- [x] Test Coverage: 60% code of the app


## MVP Concept

<img src="https://miro.medium.com/max/683/1*es5q02G0YfjnNi5POob2nQ.png" />

* `View & ViewController` - delegates user interaction events to the `Presenter` and displays data passed by the `Presenter`

```swift
@objc func reload(_ searchBar: UISearchBar) {
  guard let query = searchBar.text, query.trimmingCharacters(in: .whitespaces) != "", query.count > 3 else {
    return
  }
  self.presenter.loadWeatherForecast(query)
}
```

* `Presenter` - contains the presentation logic as call api and so on then tells the `View` what to present
```swift
func loadWeatherForecast(_ city: String) {
  // Check internet connection
  guard InternetConnection.isConnectedToInternet() else {
    self.view?.showReachabilityAlert()
    return
  }
  self.view?.startLoading()
        
  apiManager.fetchForeCastWeatherFromCity(city, successCallback: { [weak self] weatherItems in
    guard let self = self else { return }
    self.view?.finishLoading()
    self.view?.refreshView(weatherItems)
  }) { [weak self] error in
    guard let self = self else { return }
    self.view?.finishLoading()
    self.view?.showDownloadErrorAlert(error: error)
  }
}

```
* `Model` - communicates with `Network` layer

```swift
AF.request(urlRequest).responseDecodable(of: WeatherForecast.self, completionHandler: { response in
  switch response.result {
    case .success:
      guard let weatherForecast = response.value else { return }
      self.cache.insert(weatherForecast.listWeatherItems, forKey: city.lowercased(), lifeTime: self.cacheLifeTime())
      successCallback(weatherForecast.listWeatherItems)
    case .failure:
      guard let error = response.error?.underlyingError else { return }
      errorCallback(error)
      break
  }
})
```

### Useful Resources

#### MVP & Other presentation patterns

* [iOS Architecture Patterns](https://medium.com/ios-os-x-development/ios-architecture-patterns-ecba4c38de52#.67lieoiim)
* [Architecture Wars - A New Hope](https://swifting.io/blog/2016/09/07/architecture-wars-a-new-hope/)

## License

Weather Forecast is released under the MIT license. See LICENSE for details.
