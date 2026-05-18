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
                VStack {
                    HStack {
                        Text("CosmicCal")
                            .fontWeight(.bold)
                            .font(.largeTitle)
                            .foregroundStyle(.white)
                        Spacer()
                        NavigationLink(destination: CalendarPage(date: $selectedDate)) {
                            Image(systemName: calendarIcon)
                                .tint(.white)
                                .frame(maxWidth: 45, maxHeight: 45)
                                .background {
                                    RoundedRectangle(cornerRadius: 12)
                                        .tint(.accentColor)
                                        .opacity(0.25)
                                        .brightness(-2)
                                }
                                .font(.largeTitle)
                        }
                    }
                    VStack {
                        Text(networkClient.NASAOfTheDay.title)
                            .font(.title)
                        Spacer()
                            .frame(height: 10)
                        Text("Date: \(networkClient.NASAOfTheDay.date)")
                        if let imageURL = URL(string: networkClient.NASAOfTheDay.hdurl) {
                            AsyncImage(url: imageURL) { receivedImage in
                                receivedImage
                                    .resizable()
                                    .scaledToFit()
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(height: 300)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .shadow(color: .black, radius: 15)
                            .padding(.top)
                        } else {
                            Image(systemName: "photo")
                                .font(.system(size: 120, weight: .ultraLight))
                                .frame(width: 300, height: 400)
                                .background(.blue)
                                .shadow(color: .black, radius: 15)
                                .cornerRadius(15)
                                .padding(.top)
                        }
                        Text(networkClient.NASAOfTheDay.explanation)
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background{
                        RoundedRectangle(cornerRadius: 12)
                            .foregroundStyle(.tint)
                            .brightness(-0.15)
                    }
                }
                .task {
                    try? await networkClient.getAPOD(date: selectedDate)
                }
                .onChange(of: selectedDate) {
                    Task {
                        try? await networkClient.getAPOD(date: selectedDate)
                    }
                }
                .padding(30)
    //            .background {
    //                RoundedRectangle(cornerRadius: 12)
    //                    .foregroundStyle(.tint)
    //            }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea()
            }
            
        }
    }
}

#Preview {
    MainPage()
        .environment(NetworkClient())
}
