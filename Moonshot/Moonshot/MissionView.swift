//
//  MissionView.swift
//  Moonshot
//
//  Created by Mariana Yamamoto on 10/6/21.
//

import SwiftUI

struct MissionView: View {
    struct CrewMember {
        let role: String
        let astronaut: Astronaut
    }

    let mission: Mission
    let missions: [Mission]
    let astronauts: [CrewMember]

    var body: some View {
        GeometryReader { geo in
            ScrollView(.vertical) {
                VStack {
                    Image(self.mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: geo.size.width * 0.7)
                        .padding(.top)
                    Text(self.mission.formattedLaunchDate)
                    Text(self.mission.description)
                        .padding()

                    ForEach(self.astronauts, id: \.role) { crewMember in
                        NavigationLink(destination: AstronautView(missions: self.missions, astronaut: crewMember.astronaut)) {
                            HStack {
                                Image(crewMember.astronaut.id)
                                    .resizable()
                                    .frame(width: 83, height: 60)
                                    .clipShape(Circle())
                                    .overlay(Circle().stroke(Color.primary, lineWidth: 1))

                                VStack(alignment: .leading) {
                                    HStack {
                                        Text(crewMember.astronaut.name)
                                            .font(.headline)
                                        if crewMember.role == "Commander" {
                                            Image("commander")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 65)

                                        }
                                    }
                                    Text(crewMember.role)
                                        .foregroundColor(.secondary)
                                }

                                Spacer()
                            }
                            .padding(.horizontal)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                Spacer(minLength: 25)
            }
        }
    }

    init(missions: [Mission], mission: Mission, astronauts: [Astronaut]) {
        self.mission = mission
        self.missions = missions

        var matches = [CrewMember]()

        for member in mission.crew {
            if let match = astronauts.first(where: { astronaut in
                astronaut.id == member.name
            }) {
                matches.append(CrewMember(role: member.role, astronaut: match))
            } else {
                fatalError("Missing \(member)")
            }
        }

        self.astronauts = matches
    }
}

struct MissionView_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    static var previews: some View {
        MissionView(missions: missions, mission: missions[1], astronauts: astronauts)
    }
}
