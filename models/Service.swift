//
//  Service.swift
//  Phien
//
//  Created by Jubi on 3/7/24.
//

import Foundation

struct Service: Identifiable, Codable {
    //neu id = UUID() khi technician chon service giong nhau, thoi gian finished se dong bo
    var id: Date {
        self.startTime
    }
    var name: String
    var price: Int
    var startTime: Date
    
    init(name: String, price: Int, startTime: Date = Date() ) {
        
        self.name = name
        self.price = price
        self.startTime = startTime
    }
    var today: Bool {
        startTime.formatted(date: .numeric, time: .omitted) == Date().formatted(date: .numeric, time: .omitted)
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
