//
//  MissionView.swift
//  Moonshot
//
//  Created by Hamid on 8/19/22.
//

import Foundation
import SwiftUI

struct MissionView: View {
    let mission: Mission
    let crew: [CrewMember]
    
    struct CrewMember {
        let role: String
        let astronaut: Astronaut
    }
    
    
    
    init(mission: Mission, astronauts: [String: Astronaut]) {
        self.mission = mission
        self.crew = mission.crew.map {member in
            if let astronaut = astronauts[member.name] {
                return CrewMember(role: member.role, astronaut: astronaut)
            }
            else {
                fatalError("Missing \(member.name)")
            }
        }
    }
    
    
    
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack {
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: geometry.size.width * 0.6)
                        .padding(.top)
                    
                    VStack(alignment: .leading) {
                        Rectangle()
                            .frame(height: 2)
                            .padding(.vertical)
                            .foregroundColor(.lightBackgroubd)
                        
                        Text("Mission Highlights")
                            .font(.title.bold())
                            .padding(.bottom, 5)
                        Text(mission.description)
                        
                        Rectangle()
                            .frame(height: 2)
                            .padding(.vertical)
                            .foregroundColor(.lightBackgroubd)
                        
                        Text("Crew")
                            .font(.title.bold())
                            .padding(.bottom, 5)

                    }
                    .padding(.horizontal)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(crew, id: \.role) { crewMeber in
                                NavigationLink {
                                    AstronautView(astronaut: crewMeber.astronaut)
                                } label: {
                                    HStack {
                                        Image(crewMeber.astronaut.id)
                                            .resizable()
                                            .frame(width: 104, height: 72)
                                            .clipShape(Capsule())
                                            .overlay(
                                                Capsule()
                                                    .strokeBorder(.white, lineWidth: 1)
                                            )
                                        VStack(alignment: .leading) {
                                            Text(crewMeber.astronaut.name)
                                                .foregroundColor(.white)
                                                .font(.headline)
                                            Text(crewMeber.role)
                                                .foregroundColor(.secondary)
                                            
                                        }
                                    }
                                    .padding(.horizontal)
                                }
                            }
                        }
                    }
                }
                .padding(.bottom)
            }
        }
        .navigationTitle(mission.diplayName)
        .navigationBarTitleDisplayMode(.inline)
        .background(.darkBackground)
    }
}

struct Mission_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    
    static var previews: some View {
        MissionView(mission: missions[0], astronauts: astronauts)
            .preferredColorScheme(.dark)
    }
    
}
