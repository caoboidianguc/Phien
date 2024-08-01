//
//  Tech.swift
//  Phien
//
//  Created by Jubi on 3/7/24.
//

import SwiftUI
import Foundation

struct Tech: Identifiable, Codable, Equatable {
    static func == (lhs: Tech, rhs: Tech) -> Bool {
        if lhs.name == rhs.name && lhs.phone == rhs.phone {
            return true
        }
        return false
    }
    var id: UUID = UUID()
    var name: String
    var phone: String
    var email: String
    var servDone: [Service]
    var date: Date
    var isWork: Bool
    var clients: [Client] = []
    
    init(name: String, phone: String = "", email: String = "", servDone: [Service] = [], date: Date = Date(), isWork: Bool = false) {
        self.name = name
        self.phone = phone
        self.email = email
        self.servDone = servDone
        self.date = date
        self.isWork = isWork
    }
    
    var today: Bool {
        date.formatted(date: .numeric, time: .omitted) == Date().formatted(date: .numeric, time: .omitted)
    }
    var serDoneToday: [Service] {
        self.servDone.filter {$0.today}
    }
}


extension Tech {
    static let techMau = [Tech(name: "Quang", isWork: false),
                          Tech(name: "Linh", isWork: false),
                          Tech(name: "Jubi")]
    var maungauNhien: Color {
        let red = CGFloat.random(in: 0...1)
        let xanh = CGFloat.random(in: 0...1)
        let luc = CGFloat.random(in: 0...1)
        return Color(red: red, green: xanh, blue: luc)
    }
    func aWorkDay() -> Int {
        var tong = 0
        for ser in serDoneToday {
            tong += ser.price
        }
        return tong
    }
}
