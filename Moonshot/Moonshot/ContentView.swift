//
//  ContentView.swift
//  Moonshot
//
//  Created by Yemi Gabriel on 8/29/21.
//

import SwiftUI

struct ContentView: View {
    let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    @State private var showingGrid = true
    
    
    var body: some View {
        NavigationView {
            if showingGrid {
                GridLayout(astronauts: astronauts, missions: missions)
                    .navigationBarItems(trailing: Toggle("Change Layout", isOn: $showingGrid))
                    
            } else {
                ListLayout(astronauts: astronauts, missions: missions)
                    .navigationBarItems(trailing: Toggle("Change Layout", isOn: $showingGrid))
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
