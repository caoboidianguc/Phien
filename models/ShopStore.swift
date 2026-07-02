//
//  ShopStore.swift
//  Phien
//
//  Created by Jubi on 3/7/24.
//

import Foundation
//import SwiftUI

@MainActor
final class ShopStore: ObservableObject {
    
    @Published var shop: Shop = Shop(name: "DayEarn")
    @Published var chon: Bool = false
    
    private static func fileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent("tech.data")
    }
    
    func load() async throws{
        let task = Task<Shop, Error> {
            let fileURL = try Self.fileURL()
            guard let data = try? Data(contentsOf: fileURL) else {
                return shop
            }
            let newShop = try JSONDecoder().decode(Shop.self, from: data)
            return newShop
        }
        let techs = try await task.value
        self.shop = techs
    }
    
    func save(shop: Shop) async throws {
        let task = Task {
            let data = try JSONEncoder().encode(shop)
            let outfile = try Self.fileURL()
            try data.write(to: outfile)
        }
        _ = try await task.value
    }
    
    func phien(chon: Bool) -> [Tech] {
        let workingToday = shop.techs.filter { $0.isWork && $0.today }
        if chon {
            return workingToday.sorted {
                let leftCount = $0.servDone.filter(\.today).count
                let rightCount = $1.servDone.filter(\.today).count
                if leftCount != rightCount { return leftCount < rightCount }
                return $0.date < $1.date
            }
        }
        return workingToday.sorted { $0.date < $1.date }
    }
    
    func removeTech(tech: Tech) {
        shop.techs.removeAll(where: { $0.id == tech.id })
    }

    func persist() async {
        do {
            try await save(shop: shop)
        } catch {
            print("Failed to save shop data: \(error.localizedDescription)")
        }
    }

    func restore() async {
        do {
            try await load()
        } catch {
            print("Failed to load shop data: \(error.localizedDescription)")
        }
    }

}
