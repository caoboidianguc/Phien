//
//  Client.swift
//  Phien
//
//  Created by Jubi on 3/9/24.
//

import Foundation

struct Client: Codable, Identifiable, Equatable {
    static func == (lhs: Client, rhs: Client) -> Bool {
        if lhs.name == rhs.name && lhs.sdt == rhs.sdt {
            return true
        }
        return false
    }
    struct History: Codable {
        var date: Date
        var service: Service
    }
    
    var id: UUID
    var name: String
    var sdt: String
    var desc: String
    var email: String
    var points: Int
    var services: [Service]
    var firstCome: Date
    var visit: Date
    var birthDay: Date?
    var tag: String
    var history: [History] = []
    
    init(id: UUID = UUID(), name: String, sdt: String, desc: String = "", email: String = "", points: Int = 0, services: [Service] = [], firstCome: Date = Date.now, visit: Date, birthDay: Date? = nil, tag: String = "") {
        self.id = id
        self.name = name
        self.sdt = sdt
        self.desc = desc
        self.email = email
        self.points = points
        self.services = services
        self.firstCome = firstCome
        self.visit = visit
        self.birthDay = birthDay
        self.tag = tag
    }
    
}
