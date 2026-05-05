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
            StartPage(selectedTab: $selectedTab)
                .tabItem {
                    Image(systemName: "house")
                    Text("Start")
                }
                .tag(0)
           
            VStack {
                Text("Main Page")
                    .font(.title)
               
                Text("Calendar + NASA stuff here")
                    .padding()
            }
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
