import SwiftUI

struct StartPage: View {
    
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
                
                LinearGradient(
                    colors: [
                        Color.black,
                        Color.purple.opacity(0.9),
                        Color(red: 0.3, green: 0.1, blue: 0.4)
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
                
                VStack(spacing: 22) {
                    
                    Spacer()
                    
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
                    
                    Image("space_placeholder") // HERE we should have the picture nasa took either on the day the user opened the app or the previous day
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 320, height: 240)
                        .clipShape(RoundedRectangle(cornerRadius: 30))
                        .shadow(color: .purple.opacity(0.5), radius: 12)
                    
                    VStack(spacing: 4) {
                        Text("Made by")
                            .foregroundColor(.white.opacity(0.7))
                            .font(.caption)
                        
                        Text("Sherry, Zahra, Ysa")
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
                            .background(Color.purple)
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
                        
                        Text("🎲 \(diceNumber)")
                            .font(.system(size: 70))
                        
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
                    .padding(.top, 50)
                    
                    Spacer()
                }
                .padding()
            }
        }
        .scrollIndicators(.hidden)
    }
}

#Preview {
    StartPage() {}
}
