import SwiftUI

struct StartPage: View {
    @Environment(NetworkClient.self) private var networkClient
    let navMainPage: () -> Void
    
    @State private var diceNumber = 1
    @State private var spinTitle = false
    @State private var isScaled = false
    
    let funFacts = [
        "If you could drive to the Moon at highway speed, it would take about 6 months.",
        "A sunset on Mars appears blue instead of orange.",
        "One million Earths could fit inside the Sun.",
        "Saturn could float in water because it’s mostly gas.",
        "There are more stars in space than grains of sand on Earth.",
        "Space is completely silent because sound cannot travel in a vacuum."
    ]
    
    var randomFact: String {
        funFacts[diceNumber - 1]
    }
    
    var body: some View {
        
        ScrollView {
            ZStack {
            
                
                VStack(spacing: 22) {
                    
                    Spacer(minLength: 50)
                    
                    Text("CosmicCal")
                        .font(.system(size: 42, weight: .black, design: .rounded))
                        .foregroundColor(.white)
                        .rotationEffect(.degrees(spinTitle ? 1800 : 0))
                        .animation(.linear(duration: 5), value: spinTitle)
                        .onAppear {
                            spinTitle = true
                        }
                    
                    
                    Text("Explore space through time")
                        .foregroundColor(.white.opacity(0.8))
                        .italic()
                    
                    // HERE we should have the picture nasa took either on the day the user opened the app or the previous day
                    VStack {
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
                    }
                    .task {
                        try? await networkClient.getAPOD(date: networkClient.getCurrentDate())
                    }
                    
                    VStack(spacing: 4) {
                        Text("Made by")
                            .foregroundColor(.white.opacity(0.7))
                            .font(.caption)
                        
                        Text("Sherry, Zahraa, Ysa")
                            .foregroundColor(.white)
                            .fontWeight(.semibold)
                        
                        Text("Michelle, Vicky")
                            .foregroundColor(.white)
                            .fontWeight(.semibold)
                    }
                    
                    Text("Pick any date and see NASA’s astronomy picture from that day. Find out what NASA captured on the day you were born!")
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding()
                        .fixedSize(horizontal: false, vertical: true)
                        .background(Color.white.opacity(0.1))
                        .cornerRadius(20)
                        .padding(.horizontal)
                    
                    Button(action: {
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.4)) {
                            isScaled.toggle()
                        }
                        // delay action a bit so user sees bounce
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                            navMainPage()
                        }
                    }) {
                        Text("Start Exploring ✨")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .glassEffect()
                            .cornerRadius(20)
                            .padding(.horizontal, 40)
                    }
                    
                    VStack(spacing: 20) {
                        
                        Text("🎲 Cosmic Dice")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        
                        Text("Roll the dice to unlock a random space fact")
                            .foregroundColor(.white.opacity(0.8))
                            .multilineTextAlignment(.center)
                            .frame(width: 200)
                        
                        Text("🎲 \(diceNumber)")
                            .font(.system(size: 70))
                            .foregroundStyle(.white)
                            .bold()
                        
                        Button {
                            diceNumber = Int.random(in: 1...6)
                        } label: {
                            Text("Roll Dice")
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding()
                                .frame(width: 180)
                                .background(
                                    LinearGradient(
                                        colors: [.purple, .blue],
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    )
                                )
                                .cornerRadius(20)
                        }
                        
                        Text(randomFact)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .padding()
                            .background(Color.white.opacity(0.1))
                            .cornerRadius(20)
                            .padding(.horizontal)
                    }
                    .padding([.top, .bottom], 20)
                    .background{
                        RoundedRectangle(cornerRadius: 12)
                            .foregroundStyle(.tint)
                            .opacity(0.3)
                            .brightness(-0.5)
                    }
                    
                    Spacer()
                }
                .padding()
            }
        }
        .scrollIndicators(.hidden)
        .background(LinearGradient(
            colors: [
                Color.black,
                Color.purple.opacity(0.7),
                Color(red: 0.3, green: 0.1, blue: 0.5)
            ],
            startPoint: .top,
            endPoint: .bottom
        ))
        .ignoresSafeArea()
    }
}

#Preview {
    StartPage() {}
        .environment(NetworkClient())
}
