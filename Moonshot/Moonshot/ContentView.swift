//
//  ContentView.swift
//  Moonshot
//
//  Created by Mariana Yamamoto on 9/24/21.
//

import SwiftUI

struct CustomText: View {
    var text: String

    var body: some View {
        Text(text)
    }

    init(_ text: String) {
        print("Creating a new CustomText")
        self.text = text
    }
}

struct ContentView: View {
    var body: some View {
        List {
            ForEach(0..<100) {
                CustomText("Item \($0)")
                        .font(.title)
            }
        }
        .frame(maxWidth: .infinity)
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
