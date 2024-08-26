//
//  weatherAppPresenter.swift
//  WeatherApp
//
//  Created by marwa maky on 26/08/2024.
//

// TestApiManager.swift
import Foundation

func testApiManager() {
    ApiManager.shared.request(parameters: nil) { (result: Result<WeatherResponse, Error>) in
        switch result {
        case .success(let weatherResponse):
            // Print the weather response
            print("Weather Response:")
            print("Location: \(weatherResponse.location.name), \(weatherResponse.location.country)")
            print("Temperature: \(weatherResponse.current.temp_c)°C")
            print("Condition: \(weatherResponse.current.condition.text)")
            print("Wind Speed: \(weatherResponse.current.wind_mph) mph")
            print("Humidity: \(weatherResponse.current.humidity)%")
        case .failure(let error):
            // Print the error
            print("Error: \(error)")
        }
    }
}
