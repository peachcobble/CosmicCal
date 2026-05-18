//
//  NetworkClient.swift
//  
//
//  Created by Student on 5/4/26.
//

import SwiftUI
import Observation

@Observable
class NetworkClient {
    
    private(set) var NASAOfTheDay: NasaApod = NasaApod(date: "", explanation: "", hdurl: "", title: "")
    
    private(set) var weatherDetail: Weather = Weather(name: "", region: "", temp_c: 0.0, temp_f: 0.0, last_updated: "", feelslike_c: 0.0, feelslike_f: 0.0, uv: 0.0, change_of_rain: 0.0, change_of_snow: 0.0)
    
    func getAPOD(date: Date) async throws {
        let d = dateToString(date: date)
        let urlStr: String = "https://api.nasa.gov/planetary/apod?api_key=bO0O45xYdP4dzt7z8YNGFV4RVcjwSraFGIimsAjn&date=\(d)"
        let url: URL? = URL(string: urlStr)
        guard let urlUnwrapped = url else {
            return
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: urlUnwrapped)
            let apod = try JSONDecoder ().decode(NasaApod.self, from: data)
            NASAOfTheDay = apod
        } catch let error {
            print (error)
        }
    }
    
    func dateToString(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: date)
    }
    
    func getCurrentDate() -> String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: date)
    func getResults() -> Picture {
        return pictureDetail
    }
    
    func getWeather() async {
        let urlStr: String = "http://api.weatherapi.com/v1/current.json?key=c18a5ce374af4b0c852182435260705&q=11217&aqi=yes"
        let url: URL? = URL(string: urlStr)
        guard let urlUnwrapped = url else {
            return
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: urlUnwrapped)
            let currentWeather = try JSONDecoder().decode(Weather.self, from: data)
            weatherDetail = currentWeather
        } catch let error {
            print (error)
        }
    }
}
