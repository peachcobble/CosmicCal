//
//  DataModel.swift
//  
//
//  Created by Student on 5/4/26.
//

import Foundation
import SwiftUI

struct PictureResponse: Codable {
    var page: Int
    var results: [Picture]
}

struct Picture: Identifiable,Codable {
    var id: Int
    var title: String
    var picture_path: String?
    var explanation: String
    var credit: String
    var next_picture: String
}
