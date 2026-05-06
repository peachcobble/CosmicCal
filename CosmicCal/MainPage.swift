import SwiftUI

struct MainPage: View {
    let calendarIcon: String = "calendar.circle"
    
    var body: some View {
        VStack {
            HStack {
                Text("CosmicCal")
                    .font(.largeTitle)
                Spacer()
                Button(action: {
                    
                }) {
                    Image(systemName: calendarIcon)
                        .frame(maxWidth: 45, maxHeight: 45)
                        .background {
                            RoundedRectangle(cornerRadius: 12)
                        }
                }
                .font(.largeTitle)
                .tint(.accentColor)
                .opacity(0.25)
                .brightness(-2)
            }
            Spacer()
                .frame(maxHeight: 30)
            HStack {
                
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: 500)
            .background{
                RoundedRectangle(cornerRadius: 12)
            }
        }
        .padding(30)
        .frame(maxWidth: 350, maxHeight: 600)
        .background{
            RoundedRectangle(cornerRadius: 12)
                .foregroundStyle(.tint)
        }
    }
}

#Preview {
    MainPage()
}
