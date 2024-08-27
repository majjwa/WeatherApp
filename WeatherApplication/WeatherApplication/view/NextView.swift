//
//  NextView.swift
//  WeatherApplication
//
//  Created by marwa maky on 27/08/2024.
//
import SwiftUI
import Kingfisher

struct NextView: View, WeatherViewProtocol {
  
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
    ZStack{
        Image(backgroundImage)
            .resizable()
            .scaledToFill()
            .ignoresSafeArea()
        
        
    } .onAppear {
            presenter.view = self
            presenter.fetchWeather()
        }
    }
    
    func updateWeatherInfo() {
        presenter.fetchWeather()
    }
}

#Preview {
    NextView()
}
