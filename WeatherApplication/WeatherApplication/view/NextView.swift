//
//  NextView.swift
//  WeatherApplication
//
//  Created by marwa maky on 27/08/2024.
//
import SwiftUI
import Kingfisher

struct NextView: View, WeatherViewProtocol {
    var selectedDate: String
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
                if let forecastDay = presenter.weatherData?.forecast.forecastday.first(where: { $0.date == selectedDate }) {
                    ScrollView {
                        VStack(spacing: 10) {
                            ForEach(forecastDay.hour.filter { hour in
                            
let hourDate = ISO8601DateFormatter().date(from: hour.time) ?? Date()
let hourComponent = Calendar.current.component(.hour, from: hourDate)
 //return hour >= currentHour
return hourComponent >= currentHour
                            }, id: \.time_epoch) { hour in
                                HStack {
Text(hour.time.components(separatedBy: " ").last == "\(currentHour):00" ? "Now" : hour.time.components(separatedBy: " ").last ?? "")
                                       
                                        .font(.title)
                                        .foregroundColor(fontColor)

                                    
                                    
                                    
                                    
KFImage(URL(string: "https:\(hour.condition.icon)"))
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 160, height: 100)

                                    Text("\(String(format: "%.f", hour.temp_c))°C")
                                        .foregroundColor(fontColor)
                                        .font(.title)
                                }
                                .padding(.vertical, 5)
                            }
                        }
                    }
                } else {
                    Text("No data available")
                        .foregroundColor(fontColor)
                }
            }
            .padding()
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
    NextView(selectedDate: "2024-08-28")
}
