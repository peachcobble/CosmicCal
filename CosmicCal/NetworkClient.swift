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
    
    private(set) var moonPhase: MoonResponse = MoonResponse(image: MoonImage(url: "", width: 0, height: 0), phase: 0.0, age: 0.0)
    
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
    
    func getMoonPhase(date: Date) async throws {
        let d = dateAndTimeToString(date: date)
        let urlString = "https://svs.gsfc.nasa.gov/api/dialamoon/\(d)"
        
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        do {
            let decodedData = try JSONDecoder().decode(MoonResponse.self, from: data)
            moonPhase = decodedData
        } catch let error {
            print(error)
        }
        
    }
    
    func getMoonPhase(date: String) async throws {
        let urlString = "https://svs.gsfc.nasa.gov/api/dialamoon/\(date)"
        
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        do {
            let decodedData = try JSONDecoder().decode(MoonResponse.self, from: data)
            moonPhase = decodedData
        } catch let error {
            print(error)
        }
        
    }
    
    func getAPOD(date: String) async throws {
        let urlStr: String = "https://api.nasa.gov/planetary/apod?api_key=bO0O45xYdP4dzt7z8YNGFV4RVcjwSraFGIimsAjn&date=\(date)"
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
    
    func dateAndTimeToString(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter.string(from: date)
    }
    
    func getCurrentDate() -> String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: date)
    }
    
    func getCurrentDateAndTime() -> String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter.string(from: date)
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
    
    
    func getMoonDescription(phase: Double, age: Double) -> String {
        let phaseName: String
        if (age >= 0 && age < 1.0) || (age >= 28.53 && age <= 29.53) {
            phaseName = "New Moon"
        }
        else if age >= 1.0 && age < 6.4 {
            phaseName = "Waxing Crescent"
        }
        else if age >= 6.4 && age < 8.4 {
            phaseName = "First Quarter"
        }
        else if age >= 8.4 && age < 13.8 {
            phaseName = "Waxing Gibbous"
        }
        else if age >= 13.8 && age < 15.8 {
            phaseName = "Full Moon"
        }
        else if age >= 15.8 && age < 21.1 {
            phaseName = "Waning Gibbous"
        }
        else if age >= 21.1 && age < 23.1 {
            phaseName = "Third Quarter"
        }
        else if age >= 23.1 && age < 28.53 {
            phaseName = "Waning Crescent"
        }
        else {
            phaseName = "Unknown Phase"
        }
        
        let illuminationString = String(format: "%.1f%%", phase)
        let ageString = String(format: "%.1f", age)
        
        return "This image shows a \(phaseName) with \(illuminationString) illumination, \(ageString) days into the cycle."
    }

}
