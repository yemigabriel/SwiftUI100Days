//
//  MissionView.swift
//  Moonshot
//
//  Created by Yemi Gabriel on 9/12/21.
//

import SwiftUI

struct CrewMember {
    let role: String
    let astronaut: Astronaut
}

struct MissionView: View {
    let mission: Mission
    let crew: [CrewMember]
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack {
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: geometry.size.width * 0.7)
                        .padding(.top)
                    
                    Text(mission.formattedLaunchDate)
                    
                    CustomDivider()
                    
                    VStack(alignment:.leading) {
                        Text("Mission Highlights")
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/.bold())
                            .padding(.bottom, 5)
                        
                        Text(mission.description)
                            .fixedSize(horizontal: false, vertical: true)
                            .frame(maxHeight: .infinity)
                        
                        CustomDivider()
                        
                        Text("Crew")
                            .font(.title.bold())
                            .padding(.bottom, 5)
                    }
                    .padding(.horizontal)
                    
                    CrewView(crew: crew)
                    
                }
                .padding(.bottom)
                
            }
        }
        .navigationBarTitle(Text(mission.displayName), displayMode: .inline)
        .background(Color.darkBackground.ignoresSafeArea())
    }
    
    init(mission: Mission, astronauts: [Astronaut]) {
        self.mission = mission
        self.crew = mission.crew.map({ member in
            if let astronaut = astronauts.first(where: { astronaut in
                member.name == astronaut.id
            }) {
                return CrewMember(role: member.role, astronaut: astronaut)
            } else {
                fatalError("Missing \(member.name)")
            }
        })
    }
    
}

struct MissionView_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    
    static var previews: some View {
        MissionView(mission: missions[0], astronauts: astronauts)
            .preferredColorScheme(.dark)
    }
}

