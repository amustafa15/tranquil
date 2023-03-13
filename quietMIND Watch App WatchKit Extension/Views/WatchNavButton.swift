//
//  WatchNavButton.swift
//  quietMIND Watch App WatchKit Extension
//
//  Created by Ameen Mustafa on 3/8/23.
//

import SwiftUI

struct WatchNavButton<Destination: View, Label: View>: View {
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
//              .opacity(50.0)
//              .font(.title2)
//              .padding()
              .buttonStyle(.plain)
              .frame(width: 150, height: 20, alignment: .center)
              .overlay(
                  Capsule(style: .continuous)
                    .stroke(Color.ColorPrimary, lineWidth: 1)
                    .frame(width: 150, height: 40, alignment: .center)
              )
        }.background(Color.black)
    }
}

// This view lets us avoid instantiating our Destination before it has been pushed.
struct LazyDestination<Destination: View>: View {
    var destination: () -> Destination
    var body: some View {
        self.destination()
    }
}

//struct WatchNavButton_Previews: PreviewProvider {
//    static var previews: some View {
//        WatchNavButton()
//    }
//}
