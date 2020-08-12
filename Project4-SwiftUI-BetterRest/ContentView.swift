//
//  ContentView.swift
//  Project4-SwiftUI-BetterRest
//
//  Created by Ezequiel Parada Beltran on 11/08/2020.
//  Copyright © 2020 Ezequiel Parada. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var wakeUp = defaultWaketime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    
    var body: some View {
        NavigationView{
            Form{
                Section(header: Text("When do you want to wake up?")) {
                    DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                    .labelsHidden()
                        .datePickerStyle(WheelDatePickerStyle())
                    
                    .onReceive([self.wakeUp].publisher.first()) { value in
                               self.calculateBedtime()
                    }
                    
                }
//                VStack(alignment: .leading, spacing: 0){
//                Text("When do you want to wake up?")
//                    .font(.headline)
//                DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
//                .labelsHidden()
//                    .datePickerStyle(WheelDatePickerStyle())
//                }
                Section(header: Text("Desired amount to sleep")){
                
                   
                Stepper(value: $sleepAmount, in: 4...12, step: 0.25){
                    Text("\(sleepAmount, specifier: "%g") hours")
                }
                }
                Section(header: Text("Daily coffee intake")){
                    
                    Picker(selection:  $coffeeAmount, label: Text("Select a color")) {
                        ForEach((1...20), id: \.self) {
                            Text("\($0)")
                        }
                    }.labelsHidden()
                    .pickerStyle(WheelPickerStyle())
                    .onReceive([self.coffeeAmount].publisher.first()) { value in
                               self.calculateBedtime()
                    }
                
//                Stepper(value: $coffeeAmount, in: 1...20) {
//                    if coffeeAmount == 1 {
//                        Text("1 cup")
//                    } else {
//                        Text("\(coffeeAmount) cups")
//                    }
//                }
                }
            }
        .navigationBarTitle("BetterRest")
        .navigationBarItems(trailing: Text("Your ideal bedtime is: \(alertMessage)"))
//        .navigationBarItems(trailing:
//            Button(action: calculateBedtime){
//                Text("Calculate")
//            }
//            )
//
//                .alert(isPresented: $showingAlert) {
//                    Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
//            }
        }
    }
    static var defaultWaketime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date()
    
    }
    
    
    func calculateBedtime() {
        let model = SleepCalculator()
        let components = Calendar.current.dateComponents([.hour,.minute], from: wakeUp)
        let hour = (components.hour ?? 0) * 60 * 60
        let minute = (components.minute ?? 0) * 60
        
        do {
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            
            let sleepTime = wakeUp - prediction.actualSleep
            
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            alertMessage = formatter.string(from: sleepTime)
            alertTitle = "Your ideal bedtime is..."
        } catch {
            alertTitle = "Error"
            alertMessage = "Sorry, there was a problem calculating your bedtime."
        }
        
        showingAlert = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
