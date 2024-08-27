//
//  WeatherApplicationApp.swift
//  WeatherApplication
//
//  Created by marwa maky on 27/08/2024.
//

import SwiftUI
protocol WeatherViewProtocol{
    func updateWeatherInfo()
}
@main
struct WeatherApplicationApp: App {
  
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
