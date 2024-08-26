//
//  ApiManager.swift
//  WeatherApp
//
//  Created by marwa maky on 26/08/2024.
//

import Foundation
import Alamofire

class ApiManager {
    static let shared = ApiManager()
    
    private init() {}
    
    func request<T: Decodable>(
        parameters: [String: Any]? = nil,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
let url = "https://api.weatherapi.com/v1/forecast.json?key=fea903fe73b3438cbe7160433242608&q=30.0715495,31.0215953&days=3&aqi=yes&alerts=no"
            AF.request(url, parameters: parameters, encoding: URLEncoding.default).validate().responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        let decodedObject: T = try JSONDecoder().decode(T.self, from: data)
                        completion(.success(decodedObject))
                    } catch {
                 completion(.failure(error))
                    }
                case .failure(let error):
                completion(.failure(error))
                }
            }
    }
}

