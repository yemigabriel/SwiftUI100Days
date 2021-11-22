//
//  AstronautView.swift
//  Moonshot
//
//  Created by Yemi Gabriel on 11/22/21.
//

import SwiftUI

struct AstronautView: View {
    let astronaut: Astronaut
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Image(astronaut.id)
                    .resizable()
                    .scaledToFit()
                
                Text(astronaut.description)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding()
            }
        }
        .background(Color.darkBackground)
        .navigationBarTitle(astronaut.name, displayMode: .inline)
    }
}

struct AstronautView_Previews: PreviewProvider {
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    static var previews: some View {
        AstronautView(astronaut: astronauts[0])
            .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
    }
}
