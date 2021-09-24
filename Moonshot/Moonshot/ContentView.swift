//
//  ContentView.swift
//  Moonshot
//
//  Created by Mariana Yamamoto on 9/24/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image("Example")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 300, height: 300)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
