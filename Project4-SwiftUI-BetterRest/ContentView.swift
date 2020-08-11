//
//  ContentView.swift
//  Project4-SwiftUI-BetterRest
//
//  Created by Ezequiel Parada Beltran on 11/08/2020.
//  Copyright © 2020 Ezequiel Parada. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var sleepAmount = 8.0
    
    
    var body: some View {
        Stepper(value: $sleepAmount) {
            Text("\(sleepAmount) hours")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
