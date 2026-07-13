//
//  Service.swift
//  Phien
//
//  Created by Jubi on 3/7/24.
//

import Foundation

struct Service: Identifiable, Codable, Equatable {
    var id: UUID
    var name: String
    var price: Int
    var startTime: Date

    init(id: UUID = UUID(), name: String, price: Int, startTime: Date = Date()) {
        self.id = id
        self.name = name
        self.price = price
        self.startTime = startTime
    }

    
    func pickedForTurn(at time: Date = .now) -> Service {
        Service(name: name, price: price, startTime: time)
    }

    var today: Bool {
        startTime.formatted(date: .numeric, time: .omitted) == Date().formatted(date: .numeric, time: .omitted)
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        // Old saves had no stored `id` (id was computed from startTime).
        id = try container.decodeIfPresent(UUID.self, forKey: .id) ?? UUID()
        name = try container.decode(String.self, forKey: .name)
        price = try container.decode(Int.self, forKey: .price)
        startTime = try container.decodeIfPresent(Date.self, forKey: .startTime) ?? Date()
    }
}

let allServices = [
    Service(name: "Dip", price: 30),
    Service(name: "buon dua", price: 20),
    Service(name: "noi chuyen phiem", price: 21),
    Service(name: "choi game", price: 40),
    Service(name: "lam co", price: 36),
    Service(name: "sua xe", price: 5)
]
