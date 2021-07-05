//
//  ContentView.swift
//  BetterRest
//
//  Created by Yemi Gabriel on 7/5/21.
//

import SwiftUI

struct ContentView: View {
    @State private var wakeupTime = Date()
    var tomorrow = Date().addingTimeInterval(86400)
    
    var body: some View {
        var components = DateComponents()
        components.hour = 8
        components.minute = 15
        let date = Calendar.current.date(from: components) ?? Date()
        
        let component = Calendar.current.dateComponents([.day, .hour, .minute], from: Date())
        let hour = component.hour ?? 0
        print(hour)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        let dateString = dateFormatter.string(from: Date())
        print(dateString)
        
        return VStack(spacing:20) {
                    DatePicker("Select wake up time", selection: .constant(Date())
                    )
                    
                    DatePicker("Choose wake up time", selection: $wakeupTime, in: Date()...tomorrow)
            
            DatePicker("Carpe Diem", selection: .constant(date), displayedComponents: .hourAndMinute)
                }
                .padding()
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
