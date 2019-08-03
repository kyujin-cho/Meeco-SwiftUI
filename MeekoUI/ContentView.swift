//
//  ContentView.swift
//  MeekoUI
//
//  Created by Kyujin Cho on 7/19/19.
//  Copyright © 2019 Kyujin Cho. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabbedView {
            BoardList()
                .tabItem { Text("Boards") }
            .tag(0)
        }
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
