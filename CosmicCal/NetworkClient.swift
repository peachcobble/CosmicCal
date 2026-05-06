//
//  NetworkClient.swift
//  
//
//  Created by Student on 5/4/26.
//

import SwiftUI

@Observable
class NetworkClient {
    private(set) var picture: [Picture] = []
    private(set) var pictureDetail: Picture = Picture(id: 0, title: "", picture_path: "", explanation: "", credit: "", media_type: "")
    
    func getAPOD() async {
        let urlStr: String = "https://api.nasa.gov/planetary/apod?api_key=bO0O45xYdP4dzt7z8YNGFV4RVcjwSraFGIimsAjn"
        let url: URL? = URL(string: urlStr)
        guard let urlUnwrapped = url else {
            return
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: urlUnwrapped)
            let pictureOfDay: PictureResponse = try JSONDecoder ().decode(PictureResponse.self, from: data)
            for image in pictureOfDay.results {
                picture.append(image)
            }
        } catch let error {
            print (error)
        }
    }
}
