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
            ContentView(){
                Task{
                    do {
                        try await shop.save(shop: shop.shop)
                    } catch {
                        fatalError(error.localizedDescription)
                    }
                }
            }
            .environmentObject(shop)
           .onAppear {
                    Task {
                        do {
                            try await shop.load()
                        } catch {
                            fatalError(error.localizedDescription)
                        }
                    }
                }
                .refreshable {
                    do {
                        try await shop.save(shop: shop.shop)
                        try await shop.load()
                    } catch {
                        fatalError(error.localizedDescription)
                    }
                }
        }
    }
}
