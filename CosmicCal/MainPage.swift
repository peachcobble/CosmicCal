import SwiftUI

struct MainPage: View {
    @State private var networkClient = NetworkClient()
    @State private var selectedDate = Date.now
    
    let calendarIcon: String = "calendar.circle"
    let date: String = ""
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(.tintColor)
                    .ignoresSafeArea()
                ScrollView {
                    VStack(spacing: 20) {
                        HStack {
                            Text("CosmicCal")
                                .fontWeight(.bold)
                                .font(.largeTitle)
                                .foregroundStyle(.white)
                            Spacer()
                            NavigationLink(destination: CalendarPage(date: $selectedDate)) {
                                Image(systemName: calendarIcon)
                                    .tint(.white)
                                    .frame(width: 45, height: 45)
                                    .background {
                                        RoundedRectangle(cornerRadius: 12)
                                            .tint(.accentColor)
                                            .opacity(0.25)
                                            .brightness(-2)
                                    }
                                    .font(.largeTitle)
                            }
                        }
                        VStack(alignment: .leading, spacing: 10) {
                            Text(networkClient.NASAOfTheDay.title)
                                .font(.title)
                                .bold()
                            
                            Text("Date: \(networkClient.NASAOfTheDay.date)")
                                .font(.subheadline)
                            
                            if let imageURL = URL(string: networkClient.NASAOfTheDay.hdurl) {
                                AsyncImage(url: imageURL) { receivedImage in
                                    receivedImage
                                        .resizable()
                                        .scaledToFit()
                                } placeholder: {
                                    ProgressView()
                                }
                                .frame(maxHeight: 250)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .shadow(color: .black.opacity(0.3), radius: 15)
                            } else {
                                Image(systemName: "photo")
                                    .font(.system(size: 120, weight: .ultraLight))
                                    .frame(maxWidth: .infinity, minHeight: 200)
                                    .background(.blue)
                                    .clipShape(RoundedRectangle(cornerRadius: 15))
                                    .shadow(color: .black.opacity(0.3), radius: 15)
                            }
                            
                            Text(networkClient.NASAOfTheDay.explanation)
                                .font(.body)
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background {
                            RoundedRectangle(cornerRadius: 12)
                                .foregroundStyle(.tint)
                                .brightness(-0.15)
                        }
                        
                        VStack(alignment: .leading) {
                            Text("Moon Phase")
                                .font(.title)
                                .bold()
                            
                            HStack(spacing: 15) {
                                if let imageURL = URL(string: networkClient.moonPhase.image.url) {
                                    AsyncImage(url: imageURL) { receivedImage in
                                        receivedImage
                                            .resizable()
                                            .scaledToFit()
                                    } placeholder: {
                                        ProgressView()
                                    }
                                    .frame(maxHeight: 150)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                    .shadow(color: .black.opacity(0.3), radius: 15)
                                } else {
                                    Image(systemName: "photo")
                                        .font(.system(size: 80, weight: .ultraLight))
                                        .frame(width: 120, height: 120)
                                        .background(.blue)
                                        .clipShape(RoundedRectangle(cornerRadius: 15))
                                        .shadow(color: .black.opacity(0.3), radius: 15)
                                }
                                
                                Text(networkClient.getMoonDescription(phase: networkClient.moonPhase.phase, age: networkClient.moonPhase.age))
                                    .font(.subheadline)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background {
                            RoundedRectangle(cornerRadius: 12)
                                .foregroundStyle(.tint)
                                .brightness(-0.15)
                        }
                    }
                    .padding()
                }
            }
            .task {
                try? await networkClient.getAPOD(date: selectedDate)
                try? await networkClient.getMoonPhase(date: selectedDate)
            }
            .onChange(of: selectedDate) { _, newValue in
                Task {
                    try? await networkClient.getAPOD(date: newValue)
                    try? await networkClient.getMoonPhase(date: newValue)
                }
            }
        }
    }
}

#Preview {
    MainPage()
}
