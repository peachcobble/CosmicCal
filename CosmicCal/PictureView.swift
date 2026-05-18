//
//  PictureView.swift
//  CosmicCal
//
//  Created by Student on 5/5/26.
//

import SwiftUI

struct PictureView: View {
    let picture: Picture
//    let weather: Weather

    var body: some View {
        VStack {
            if (picture.media_type.contains("image")) {
                if let pictureURL = picture.url {
                    let imageURL = URL(string: pictureURL)
                    AsyncImage(url: imageURL) { receivedImage in
                        receivedImage
                            .resizable()
                            .scaledToFit()
                    } placeholder: {
                        ProgressView()
                    }

                    .frame(width: 320, height: 240)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .shadow(color: .purple.opacity(0.5), radius: 12)
                    .padding(.top)
//                    .resizable()
//                    .aspectRatio(contentMode: .fill)
//                    .clipShape(RoundedRectangle(cornerRadius: 30))
                } else {
                    Image(systemName: "photo")
                        .font(.system(size: 120, weight: .light))
                        .frame(width: 200, height:200)
                        .foregroundStyle(.black)
                        .background(.gray)
                        .shadow(color: .black, radius: 15)
                        .cornerRadius(15)
                        .padding(.top)
                }
            } else {
                Image(systemName: "video")
                    .font(.system(size: 120))
                    .frame(width: 200, height:200)
                    .foregroundStyle(.black)
                    .background(.gray)
                    .cornerRadius(15)
                    .padding(.top)
                    .shadow(color: .purple.opacity(0.5), radius: 12)
            }

        }

    }
}


#Preview {
    PictureView(picture: Picture(title: "Saturn Retrograde", url: "https://apod.nasa.gov/apod/image/2605/saturn_neptune_retrograde_1024.jpg", explanation: "What does it mean for Saturn and Neptune to be in retrograde? Featured is a composite of images taken over 34 nights...", media_type: "image"))
}
//, weather: Weather(name: "Brooklyn", region: "New York", temp_c: 22.2, temp_f: 72, last_updated: "2026-05-13 14:15", feelslike_c: 24.4, feelslike_f: 75.9, uv: 5.6, change_of_rain: 0.0, change_of_snow: 0.0)
