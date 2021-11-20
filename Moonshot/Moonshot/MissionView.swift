//
//  MissionView.swift
//  Moonshot
//
//  Created by Yemi Gabriel on 9/12/21.
//

import SwiftUI

struct MissionView: View {
    let mission: Mission
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack {
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: geometry.size.width * 0.7)
                        .padding(.top)
                    
                    Text(mission.description)
//                        .fixedSize()
                        .frame(maxHeight: .infinity)
                        .padding()
                        
                    
                    Spacer(minLength: 25)
                    
                }
                
            }
        }
        .navigationBarTitle(Text(mission.displayName), displayMode: .inline)
    }
}

struct MissionView_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static var previews: some View {
        MissionView(mission: missions[0])
    }
}
