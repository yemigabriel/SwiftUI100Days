//
//  GridLayout.swift
//  Moonshot
//
//  Created by Yemi Gabriel on 11/22/21.
//

import SwiftUI

struct GridLayout: View {
    let astronauts: [Astronaut]
    let missions: [Mission]
    
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns){
                ForEach(missions) { mission in
                    NavigationLink(
                        destination: MissionView(mission: mission, astronauts: astronauts) ){
                        VStack(alignment: .center) {
                            Image(mission.image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                                .padding()
                            VStack {
                                Text(mission.displayName)
                                    .font(.headline)
                                    .foregroundColor(.white)
                                Text(mission.formattedLaunchDate)
                                    .font(.caption)
                                    .foregroundColor(.white.opacity(0.5))
                            }
                            .padding(.vertical)
                            .frame(maxWidth: .infinity)
                            .background(Color.lightBackground)
                        }
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.lightBackground)
                        )
                    }
                }
            }
            .padding([.horizontal, .bottom])
        }
        .navigationTitle("Moonshot")
        .background(Color.darkBackground.ignoresSafeArea())
        .preferredColorScheme(.dark)
//        .navigationBarItems(trailing: Toggle("Change Layout", isOn: $showingGrid))
        
    }
}

struct GridLayout_Previews: PreviewProvider {
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    
    static var previews: some View {
        GridLayout(astronauts: astronauts, missions: missions)
    }
}
