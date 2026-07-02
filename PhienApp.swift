//
//  PhienApp.swift
//  Phien
//
//  Created by Jubi on 3/7/24.
//

import SwiftUI

@main
struct PhienApp: App {
    @StateObject var shop = ShopStore()

    var body: some Scene {
        WindowGroup {
            ContentView {
                Task {
                    await shop.persist()
                }
            }
            .environmentObject(shop)
            .task {
                await shop.restore()
            }
            .refreshable {
                await shop.persist()
                await shop.restore()
            }
        }
    }
}