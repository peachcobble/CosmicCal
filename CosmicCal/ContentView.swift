//
//  ContentView.swift
//  CosmicCal
//
//  Created by Student on 5/5/26.
//

import SwiftUI

struct ContentView: View {
    @State var selectedTab = 0
    var body: some View {
        TabView(selection: $selectedTab) {
            StartPage() { selectedTab = 1 }
                .tabItem {
                    Image(systemName: "house")
                    Text("Start")
                }
                .tag(0)
           
            MainPage()
                .tabItem {
                    Image(systemName: "calendar")
                    Text("Main")
                }
                .tag(1)
        }
    }
}

#Preview {
    ContentView()
}
