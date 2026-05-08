
import SwiftUI

struct StartPage: View {
    
    let navMainPage: () -> Void
    
    var body: some View {
        
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
                
                Button(action: navMainPage) {
                    Text("Start Exploring ✨")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.purple)
                        .cornerRadius(20)
                        .padding(.horizontal, 40)
                }
                
                Spacer()
            }
            .padding()
        }
    }
}

#Preview {
    StartPage() {}
}
// integrate, commit with message, then pull, push
