//
//  ContentView.swift
//  Moonshot
//
//  Created by Mariana Yamamoto on 9/24/21.
//

import SwiftUI

enum ViewMode {
    case launchDate
    case crewNames

    var title: String {
        switch self {
        case .launchDate:
            return "View Crew Names"
        case .crewNames:
            return "View Launch Dates"
        }
    }
}

struct ContentView: View {
    let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    @State private var viewMode: ViewMode = .launchDate

    var body: some View {
        NavigationView {
            List(missions) { mission in
                NavigationLink(destination: MissionView(missions: self.missions, mission: mission, astronauts: self.astronauts)) {
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 44, height: 44)
                    VStack(alignment: .leading) {
                        Text(mission.displayName)
                            .font(.headline)
                        if self.viewMode == .launchDate {
                            Text(mission.formattedLaunchDate)
                        }
                        else {
                            let namesArray = mission.crew.map() { $0.name }
                            let fullNames = astronauts.filter { astronaut in
                                namesArray.contains(astronaut.id)
                            }
                            ForEach(fullNames, id: \.id) {
                                Text($0.name)
                                    .font(.system(size: 12))
                            }
                        }
                    }
                }
            }
            .navigationTitle("Moonshot")
            .toolbar {
                ToolbarItem(placement: ToolbarItemPlacement.navigationBarTrailing) {
                    Button(action: {
                        self.viewMode = viewMode == .launchDate ? .crewNames : .launchDate
                    }) {
                        Text(viewMode.title)
                    }
                }
            }
        }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
