//
//  ContentView.swift
//  WeatherApplication
//
//  Created by marwa maky on 27/08/2024.
//
import SwiftUI

struct ContentView: View, WeatherViewProtocol {
    @StateObject private var presenter = WeatherPresenter()
    
    var currentHour: Int {
        Calendar.current.component(.hour, from: Date())
    }
    
    var backgroundImage: String {
        currentHour >= 5 && currentHour < 18 ? "morning" : "night"
    }
    
    var fontColor: Color {
        currentHour >= 5 && currentHour < 18 ? .black : .white
    }
    var body: some View {
        ZStack {
            Image(backgroundImage)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            if let weather = presenter.weatherData {
                VStack {
                    Text("Location: \(weather.location.country)")
                    Text("Temperature: \(weather.current.temp_c)°C")
                        .font(.largeTitle)
                        .foregroundColor(fontColor)
                }
                .padding()
            } else {
                Text("Loading...")
                    .font(.largeTitle)
                    .foregroundColor(fontColor)
            }
        }
        .onAppear {
            presenter.view = self
            presenter.fetchWeather()
        }
    }
    
    func updateWeatherInfo() {
        presenter.fetchWeather()
    }
}

#Preview {
    ContentView()
}
