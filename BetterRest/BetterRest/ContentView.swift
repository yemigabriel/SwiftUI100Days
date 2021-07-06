//
//  ContentView.swift
//  BetterRest
//
//  Created by Yemi Gabriel on 7/5/21.
//

import SwiftUI

struct ContentView: View {
    @State private var wakeupTime = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    
    @State private var sleepTime = 0.0
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        let date = Calendar.current.date(from: components) ?? Date()
        return date
    }
    
    var body: some View {
        
        NavigationView {
            VStack {
                Form {
                    Section(header: Text("When do you want to wake up?")
                                .font(.headline)
                    ) {
                        DatePicker("Please enter a time", selection: $wakeupTime, displayedComponents: .hourAndMinute)
                            .labelsHidden()
                    }
                    Section(header: Text("Desired amount of sleep")
                                .font(.headline)
                    ) {
                        Stepper(value: $sleepAmount, in: 4...12, step: 0.25) {
                            Text("\(sleepAmount, specifier: "%g") hours")
                        }
                    }
                    Section(header: Text("Daily coffee intake")
                                .font(.headline)
                    ) {
                        Stepper(value: $coffeeAmount, in: 1...20, step: 1) { Bool in
                        } label: {
                            Text("\(coffeeAmount) \(coffeeAmount > 1 ? "cups": "cup")")
                        }
                    }

                }.frame(maxWidth: .infinity, maxHeight: 300 )
                
                
                Text("\(alertTitle)\n\(alertMessage)")
                    .font(.largeTitle)
                    .multilineTextAlignment(.center)
                
                Spacer()
                
                
              
            }
            
            .navigationBarTitle(Text("BetterRest"))
            .navigationBarItems(trailing: Button("Calculate", action: calculateBedtime))
            .alert(isPresented: $showingAlert, content: {
                Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            })
        }
        
    }
    
    func calculateBedtime() {
        let model = SleepCalculator()
        
        let components = Calendar.current.dateComponents([.hour, .minute], from: wakeupTime)
        let hours = (components.hour ?? 0) * 60 * 60
        let minutes = (components.hour ?? 0) * 60
        
        do {
            let prediction = try model.prediction(wake: Double(hours + minutes), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            
            let sleepTime = wakeupTime - prediction.actualSleep
            
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            
            alertMessage = formatter.string(from: sleepTime)
            alertTitle = "Your ideal bedtime is..."
            
        } catch  {
            // something went wrong
            alertTitle = "Error"
            alertMessage = "Sorry, there was a problem calculating your bedtime"
        }
        showingAlert = true
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
