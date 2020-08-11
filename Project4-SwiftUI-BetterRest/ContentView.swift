//
//  ContentView.swift
//  Project4-SwiftUI-BetterRest
//
//  Created by Ezequiel Parada Beltran on 11/08/2020.
//  Copyright © 2020 Ezequiel Parada. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var wakeUp = Date()
    
    
    var body: some View {
        DatePicker("Please enter a date", selection: $wakeUp, displayedComponents: .hourAndMinute)
        .labelsHidden()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
