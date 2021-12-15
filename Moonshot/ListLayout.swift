//
//  ListLayout.swift
//  Moonshot
//
//  Created by Yemi Gabriel on 11/22/21.
//

import SwiftUI

struct ListLayout: View {
    
    let astronauts: [Astronaut]
    let missions: [Mission]
    
    var body: some View {
        List {
            ForEach(missions, id: \.id) { mission in
                NavigationLink(
                    destination: MissionView(mission: mission, astronauts: astronauts) ){
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 44, height: 44)
                    
                    VStack(alignment: .leading) {
                        Text(mission.displayName)
                            .font(.headline)
                        Text(mission.formattedLaunchDate)
                    }
                }
            }
            .listRowBackground(Color.darkBackground.ignoresSafeArea())
        }
        .onAppear(perform: {
            UITableView.appearance().backgroundColor = .clear
        })
        .background(Color.darkBackground.ignoresSafeArea())
        .navigationTitle("Moonshot")
        .preferredColorScheme(.dark)
    }
}

struct ListLayout_Previews: PreviewProvider {
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    
    static var previews: some View {
        ListLayout(astronauts: astronauts, missions: missions)
    }
}
