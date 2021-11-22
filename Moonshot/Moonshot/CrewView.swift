//
//  CrewView.swift
//  Moonshot
//
//  Created by Yemi Gabriel on 11/22/21.
//

import SwiftUI


struct CrewView: View {
    let crew: [CrewMember]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(crew, id: \.role) { crewMember in
                    NavigationLink(
                        destination: AstronautView(astronaut: crewMember.astronaut),
                        label: {
                            HStack {
                                Image(crewMember.astronaut.id)
                                    .resizable()
                                    .frame(width: 104, height: 72)
                                    .clipShape(Capsule())
                                    .overlay(Capsule().stroke(Color.white, lineWidth: 1))
                                
                                VStack(alignment: .leading) {
                                    Text(crewMember.astronaut.name)
                                        .foregroundColor(.white)
                                        .font(.headline)
                                    Text(crewMember.role)
                                        .foregroundColor(.secondary)
                                }
                                
                            }
                            .padding(.horizontal)
                        })
                    
                }
            }
        }
    }
}

struct CrewView_Previews: PreviewProvider {
    static var previews: some View {
        CrewView(crew: [CrewMember(role: "pilot", astronaut: Astronaut(id: "id", name: "name", description: "desc"))])
    }
}
