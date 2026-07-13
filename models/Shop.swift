//
//  Shop.swift
//  Phien
//
//  Created by Jubi on 3/7/24.
//

import Foundation
struct Shop: Codable {
    var id: UUID
    let name: String
    var phone: String = ""
    var email: String = ""
    var services: [Service]
    var techs: [Tech]
    var clients: [Client]
    var chon: Bool = false
    
    init(id: UUID = UUID(), name: String, services: [Service] = [], techs: [Tech] = [], clients: [Client] = [], phone: String = "", email: String = "", chon: Bool = false) {
        self.id = id
        self.name = name
        self.phone = phone
        self.email = email
        self.services = services
        self.techs = techs
        self.clients = clients
        self.chon = chon
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(UUID.self, forKey: .id) ?? UUID()
        name = try container.decode(String.self, forKey: .name)
        phone = try container.decodeIfPresent(String.self, forKey: .phone) ?? ""
        email = try container.decodeIfPresent(String.self, forKey: .email) ?? ""
        services = try container.decodeIfPresent([Service].self, forKey: .services) ?? []
        techs = try container.decodeIfPresent([Tech].self, forKey: .techs) ?? []
        clients = try container.decodeIfPresent([Client].self, forKey: .clients) ?? []
        chon = try container.decodeIfPresent(Bool.self, forKey: .chon) ?? false
    }
}

let dayEarn = Shop(name: "DayEarn")

extension Shop {
    static var dv: [Service] = [Service(name: "Fishing", price: 20), Service(name: "Sing Along", price: 23)]
}

