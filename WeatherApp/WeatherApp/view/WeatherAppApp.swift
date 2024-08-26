//
//  WeatherAppApp.swift
//  WeatherApp
//
//  Created by marwa maky on 26/08/2024.
//

import SwiftUI

@main
struct WeatherAppApp: App {
    init() {
          // Call test function here
          testApiManager()
      }
      
    var body: some Scene {
        
        WindowGroup {
            ContentView()
        }
    }
}
