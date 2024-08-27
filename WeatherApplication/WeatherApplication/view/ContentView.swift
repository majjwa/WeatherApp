//
//  ContentView.swift
//  WeatherApplication
//
//  Created by marwa maky on 27/08/2024.
//
import SwiftUI
import Kingfisher

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
            
            VStack {
                if let weather = presenter.weatherData {
                    VStack(spacing: 1) {
                        Text("\(weather.location.name)")
                            .font(.largeTitle)
                            .bold()
                            .foregroundColor(fontColor)
                        
                        Text("\(String(format: "%.f", weather.current.temp_c))°C")
                            .font(.largeTitle)
                            .bold()
                            .foregroundColor(fontColor)
                        
                        Text("\(weather.current.condition.text)")
                            .font(.largeTitle)
                            .foregroundColor(fontColor)
                        
                        if let forecastDay = weather.forecast.forecastday.first {
                            Text("H: \(String(format: "%.f", forecastDay.day.maxtemp_c))° L: \(String(format: "%.f", forecastDay.day.mintemp_c))°")
                                .font(.largeTitle)
                                .foregroundColor(fontColor)
                        }
                        
                        KFImage(URL(string: "https:\(weather.current.condition.icon)"))
                            .resizable()
                            .scaledToFit() // Use scaledToFit to maintain aspect ratio
                            .frame(width: 160, height: 100)
                    }
                    .padding()
                    
                    VStack {
                        Text("3-DAY FORECAST")
                            .font(.title2)
                            .foregroundColor(fontColor)
                        Divider().background(Color.black)  .frame(width: 300)                    }
                    .padding()
                } else {
                    Text("Loading...")
                        .font(.largeTitle)
                        .foregroundColor(fontColor)
                }
            }
            .padding(100)
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
