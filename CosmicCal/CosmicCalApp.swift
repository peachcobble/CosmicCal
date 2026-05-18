//
//  CosmicCalApp.swift
//  CosmicCal
//
//  Created by Student on 5/5/26.
//

import SwiftUI

@main
struct CosmicCalApp: App{
    
    @State private var networkClient = NetworkClient()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(networkClient)
        }
    }
}

#Preview {
    ContentView()
        .environment(NetworkClient())
}
