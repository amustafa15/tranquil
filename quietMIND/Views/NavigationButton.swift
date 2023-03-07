//
//  NavigationButton.swift
//  quietMind
//
//  Created by Ameen Mustafa on 2/17/22.
//

import Foundation
import SwiftUI

struct NavigationButton<Destination: View, Label: View>: View {
    var action: () -> Void = { }
    var destination: () -> Destination
    var label: () -> Label

    @State private var isActive: Bool = false

    var body: some View {
        Button(action: {
            self.action()
            self.isActive.toggle()
        }) {
            self.label()
              .background(
                ScrollView { // Fixes a bug where the navigation bar may become hidden on the pushed view
                    NavigationLink(
                        destination: LazyDestination { self.destination() },
                                                 isActive: self.$isActive)
                    {
                        EmptyView()
                    }
                }
              )
              .foregroundColor(Color.ColorPrimary)
              .font(.title2)
              .padding()
//              .frame(minWidth: 250)
              .frame(minWidth: 0, maxWidth: 200, minHeight: 0, maxHeight: 40, alignment: .center)
              .overlay(
                  Capsule(style: .continuous)
                    .stroke(Color.ColorPrimary, lineWidth: 3)
              )
        }
        
    }
}

// This view lets us avoid instantiating our Destination before it has been pushed.
struct LazyDestination<Destination: View>: View {
    var destination: () -> Destination
    var body: some View {
        self.destination()
    }
}
