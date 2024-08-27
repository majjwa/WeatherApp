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
    
    func getDayName(from dateString: String) -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd"
        guard let date = inputFormatter.date(from: dateString) else {
            return "Unknown Day"
        }
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "EEEE"
        return outputFormatter.string(from: date)
    }

    var body: some View {
        ZStack {
            Image(backgroundImage)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            VStack() {
               
                
                if let weather = presenter.weatherData {
                    // Current weather information
                    VStack() {
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
                            HStack(spacing: 20) {
                                Text("H: \(String(format: "%.f", forecastDay.day.maxtemp_c))°")
                                    .font(.largeTitle)
                                    .foregroundColor(fontColor)
                                
                                Text("L: \(String(format: "%.f", forecastDay.day.mintemp_c))°")
                                    .font(.largeTitle)
                                    .foregroundColor(fontColor)
                            } }
                        
                        
                        KFImage(URL(string: "https:\(weather.current.condition.icon)"))
                            .resizable()
                            .scaledToFit()
                            .frame(width: 160, height: 100)
                    }
                   
                    VStack() {
                        Text("3-DAY FORECAST")
                            .font(.title2)
                            .foregroundColor(fontColor)
                        
                        Divider()
                            .background(Color.black).frame(width: 300)
                        
                        ForEach(weather.forecast.forecastday, id: \.date) { forecastDay in
                            Button(action: {
                                print("Tapped on \(forecastDay.date)")
                            }) {
                                HStack {
                                    Text(getDayName(from: forecastDay.date))
                                        .font(.title2).bold()
                                        .foregroundColor(fontColor)
                                    
                                    KFImage(URL(string: "https:\(forecastDay.day.condition.icon)"))
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 60, height: 60)
                                    
                                    Text("\(String(format: "%.f", forecastDay.day.maxtemp_c))°")
                                    
                                    Text("- \(String(format: "%.f", forecastDay.day.mintemp_c))°")
                                        .font(.title3)
                                        .foregroundColor(fontColor)
                                }
                                .padding(.vertical, 5)
                                .background(Color.clear)
                            }
                            .buttonStyle(PlainButtonStyle())
                            Divider().frame(width: 300)
                                .background(Color.black)
                        }
                    }
                    
                    VStack(content: {
                        HStack(spacing: 60){
                            Text("Visiblity").font(.title).bold()
                            Text("Humidity").font(.title).bold()
                        }
                        HStack(spacing: 100){
                            Text("\(String(format: "%.f", weather.current.vis_km)) Km").font(.title)
                            Text("\(String(format: "%.f", weather.current.humidity)) %").font(.title)
                        }
                        HStack(spacing: 60){
                            Text("Feels like").font(.title).bold()
                            Text("Pressure").font(.title).bold()
                        }
                        HStack(spacing: 100){
                            Text("\(String(format: "%.f", weather.current.feelslike_c))°").font(.title)
                            Text("\(String(format: "%.f", weather.current.pressure_in))").font(.title)
                        }
                        
                        
                        
                    }
                    
                    
                    )

                } else {
                    Text("Loading...")
                        .font(.largeTitle)
                        .foregroundColor(fontColor)
                }
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
