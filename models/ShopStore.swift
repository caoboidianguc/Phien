//
//  ShopStore.swift
//  Phien
//
//  Created by Jubi on 3/7/24.
//

import Foundation

@MainActor
final class ShopStore: ObservableObject {
    
    @Published var shop: Shop = Shop(name: "DayEarn")
    
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
    func phien() -> [Tech]{
        return self.shop.techs.sorted(by: {$0.date.compare($1.date) == .orderedAscending})
    }
    
    func removeTech(tech: Tech){
        shop.techs.removeAll(where: {$0.id == tech.id})
    }
}
