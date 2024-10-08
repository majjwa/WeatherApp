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
        NavigationView {
            ZStack {
                Image(backgroundImage)
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                
                VStack {
                    if let weather = presenter.weatherData {
                        VStack {
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
                                }
                            }
                            
                            KFImage(URL(string: "https:\(weather.current.condition.icon)"))
                                .resizable()
                                .scaledToFit()
                                .frame(width: 160, height: 100)
                        }
                        .padding(.top, 20)
                        
                        VStack {
                            Text("3-DAY FORECAST")
                                .font(.title2)
                                .foregroundColor(fontColor)
                            
                            Divider()
                                .background(Color.black)
                                .frame(width: 300)
                            
                            ForEach(weather.forecast.forecastday, id: \.date) { forecastDay in
                                NavigationLink(destination: NextView(selectedDate: forecastDay.date)) {
                                    HStack {
                                        Text(getDayName(from: forecastDay.date))
                                            .font(.title2).bold()
                                            .foregroundColor(fontColor)
                                        
                                        KFImage(URL(string: "https:\(forecastDay.day.condition.icon)"))
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 120, height: 60)
                                        
                                        Text("\(String(format: "%.f", forecastDay.day.maxtemp_c))°") .font(.title3)
                                            .foregroundColor(fontColor)
                                        
                                        Text("- \(String(format: "%.f", forecastDay.day.mintemp_c))°")
                                            .font(.title3)
                                            .foregroundColor(fontColor)
                                    }
                                    .padding(.vertical, 5)
                                    .background(Color.clear)
                                }
                                .buttonStyle(PlainButtonStyle())
                                
                                Divider()
                                    .frame(width: 300)
                                    .background(Color.black)
                            }
                        }
                        
                        VStack {
                            HStack(spacing: 60) {
                                Text("Visibility").font(.title).foregroundColor(fontColor)
                                Text("Humidity").font(.title).foregroundColor(fontColor)
                            }
                            HStack(spacing: 100) {
                                Text("\(String(format: "%.f", weather.current.vis_km)) Km").font(.title).foregroundColor(fontColor)
                                Text("\(String(format: "%.f", weather.current.humidity)) %").font(.title).foregroundColor(fontColor)
                            }
                            HStack(spacing: 60) {
                                Text("Feels like").font(.title).foregroundColor(fontColor)
                                Text("Pressure").font(.title).foregroundColor(fontColor)
                            }
                            HStack(spacing: 100) {
                                Text("\(String(format: "%.f", weather.current.feelslike_c))°").font(.title).foregroundColor(fontColor)
                                Text("\(String(format: "%.f", weather.current.pressure_in))").font(.title).foregroundColor(fontColor)
                            }
                        }
                    } else {
                        Text("Loading...")
                            .font(.largeTitle)
                            .foregroundColor(fontColor)
                    }
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
    func getDayName(from dateString: String) -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd"
        guard let date = inputFormatter.date(from: dateString) else {
            return " "
        }
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "EEEE"
        return outputFormatter.string(from: date)
    }
}

#Preview {
    ContentView()
}
