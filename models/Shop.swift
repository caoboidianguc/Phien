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
    var techs : [Tech]
    var clients: [Client]
    var chon: Bool = false
    
    init(id: UUID = UUID(), name: String, services: [Service] = [], techs: [Tech] = [], clients: [Client] = []) {
        self.id = id
        self.name = name
        self.services = services
        self.techs = techs
        self.clients = clients
    }
    
    
}

let dayEarn = Shop(name: "DayEarn")

extension Shop {
    static var dv: [Service] = [Service(name: "Fishing", price: 20), Service(name: "Sing Along", price: 23)]
    
    
}
