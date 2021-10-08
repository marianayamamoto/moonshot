//
//  AstronautView.swift
//  Moonshot
//
//  Created by Mariana Yamamoto on 10/6/21.
//

import SwiftUI

struct AstronautView: View {
    let astronaut: Astronaut
    let missions: [Mission]

    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack {
                    Image(self.astronaut.id)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width)

                    Text(self.astronaut.description)
                        .padding()
                        .layoutPriority(1)

                    if !self.missions.isEmpty {
                        ForEach(self.missions, id: \.id) { mission in
                            HStack {
                                Image(mission.image)
                                    .resizable()
                                    .frame(width: 83, height: 60)
                                    .clipShape(Circle())
                                    .overlay(Circle().stroke(Color.primary, lineWidth: 1))

                                VStack(alignment: .leading) {
                                    HStack {
                                        Text(mission.displayName)
                                            .font(.headline)
                                    }
                                    Text(mission.formattedLaunchDate)
                                        .foregroundColor(.secondary)
                                }

                                Spacer()
                            }
                        }
                    }
                }
                Spacer(minLength: 25)
            }
        }
        .navigationBarTitle(Text(astronaut.name), displayMode: .inline)
    }

    init(missions: [Mission], astronaut: Astronaut) {
        self.astronaut = astronaut

        var matches = [Mission]()

        for mission in missions {
            if mission.crew.first(where: { crewMember in
                astronaut.id == crewMember.name
            }) != nil {
                matches.append(mission)
            }
        }

        self.missions = matches
    }
}

struct AstronautView_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")

    static var previews: some View {
        AstronautView(missions: missions, astronaut: astronauts[0])
    }
}
