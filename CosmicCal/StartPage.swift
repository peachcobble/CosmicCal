import SwiftUI

struct StartPage: View {
    let navMainPage: () -> Void
    
    var body: some View {
        ScrollView {
            VStack {
                Text("Welcome to CosmicCal")
                    .font(.title)
                    .padding(.top, 50)
                Image("space_placeholder")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 220)
                    .padding()
                Text("by:")
                    .font(.headline)
                Text("Sherry, Zahra, Ysa")
                Text("Michelle, Vicky")
                    .padding(.bottom, 15)
                Text("This calendar shows NASA's picture of the day. You can pick any date and see what space looked like on that day. It's kind of like scrolling through space history.")
                    .padding()
               
                Button(action: navMainPage) {
                    Text("Start")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.horizontal, 30)
                }
                Spacer()
            }
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}

#Preview {
    StartPage() {}
}
