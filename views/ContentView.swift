//
//  ContentView.swift
//  Phien
//
//  Created by Jubi on 3/7/24.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.scenePhase) private var scene
    let saveAction: ()-> Void
    
    var body: some View {
        TabView {
            DayWorkView()
                .tabItem {
                    Label("", systemImage: "person.3.sequence")
                }
                
            ServicesListView()
                .tabItem {
                    Label("", systemImage: "list.bullet")
                }
        }
        .onChange(of: scene){phase in
            if phase == .inactive {
                saveAction()
            }
        }
    }//body
    
}

#Preview {
    ContentView(saveAction: {})
        .environmentObject(ShopStore())
}
