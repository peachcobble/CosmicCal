//
//  PictureView.swift
//  CosmicCal
//
//  Created by Student on 5/5/26.
//

import SwiftUI

struct PictureView: View {
    let picture: Picture

    var body: some View {
        VStack {
            if (picture.media_type.contains("image")) {
                if let pictureURL = picture.picture_path {
                                let imageURL = URL(string: pictureURL)
                                AsyncImage(url: imageURL) { receivedImage in
                                    receivedImage
                                        .resizable()
                                        .scaledToFit()
                                } placeholder: {
                                    ProgressView()
                                }
                                .frame(width: 200, height:200)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .shadow(color: .black, radius: 15)
                                .padding(.top)

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
            }
        }

    }
}


#Preview {
    PictureView(picture: Picture(id: 1, title: "title", picture_path: "https://apod.nasa.gov/apod/image/2605/saturn_neptune_retrograde_1024.jpg", explanation: "What does it mean for Saturn and Neptune to be in retrograde? Featured is a composite of images taken over 34 nights...", credit: "Tunç Tezel", media_type: "image"))

}
