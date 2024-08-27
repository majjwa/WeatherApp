//
//  WeatherPresenter.swift
//  WeatherApplication
//
//  Created by marwa maky on 27/08/2024.
//
import Foundation

class WeatherPresenter: ObservableObject {
    @Published var weatherData: WeatherResponse?
    var view: WeatherViewProtocol?
    
    func fetchWeather() {
        ApiManager.shared.request(parameters: nil) { [weak self] (result: Result<WeatherResponse, Error>) in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self?.weatherData = response
                    self?.view?.updateWeatherInfo()
                }
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
}
