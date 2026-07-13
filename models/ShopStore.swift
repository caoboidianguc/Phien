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
    /// True after the first restore attempt finishes (success or failure).
    @Published private(set) var didFinishRestore = false
    
    private static func fileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            .appendingPathComponent("tech.data")
    }
    
    func load() async throws {
        let fileURL = try Self.fileURL()
        guard let data = try? Data(contentsOf: fileURL), !data.isEmpty else {
            return
        }
        do {
            shop = try JSONDecoder().decode(Shop.self, from: data)
        } catch {
            // Keep empty shop rather than crashing or leaving UI stuck.
            print("Shop decode failed, starting fresh: \(error.localizedDescription)")
        }
    }
    
    func save(shop: Shop) async throws {
        let data = try JSONEncoder().encode(shop)
        let outfile = try Self.fileURL()
        try data.write(to: outfile, options: [.atomic])
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
        defer { didFinishRestore = true }
        do {
            try await load()
        } catch {
            // Corrupt or incompatible save must not freeze/crash the app.
            print("Failed to load shop data: \(error.localizedDescription)")
        }
    }

    /// Saves current state, then reloads so the list re-sorts and "today" flags refresh.
    func refresh() async {
        await persist()
        do {
            try await load()
        } catch {
            print("Failed to refresh shop data: \(error.localizedDescription)")
        }
        // Ensure observers re-render even if disk data is identical (e.g. day rollover).
        objectWillChange.send()
    }

}
