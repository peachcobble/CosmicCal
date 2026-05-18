//
//  CalendarPage.swift
//  CosmicCal
//
//  Created by Iris Li on 5/18/26.
//

import SwiftUI

struct CalendarPage: View {
    @Binding var date: Date
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            Text("Pick a day!")
                .font(.largeTitle)
            DatePicker("Enter your birthday",
                       selection: $date,
                       displayedComponents: [.date])
                .datePickerStyle(GraphicalDatePickerStyle())
                .frame(maxHeight: 400)
            Button("Done") {
                dismiss()
            }
        }
    }
}

#Preview {
    CalendarPage(date: .constant(Date()))
}
