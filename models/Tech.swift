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
        lhs.id == rhs.id
    }
    var id: UUID = UUID()
    var name: String
    var phone: String
    var email: String
    var servDone: [Service]
    var date: Date
    var isWork: Bool
    var clients: [Client] = []
    
    init(id: UUID = UUID(), name: String, phone: String = "", email: String = "", servDone: [Service] = [], date: Date = Date(), isWork: Bool = false, clients: [Client] = []) {
        self.id = id
        self.name = name
        self.phone = phone
        self.email = email
        self.servDone = servDone
        self.date = date
        self.isWork = isWork
        self.clients = clients
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(UUID.self, forKey: .id) ?? UUID()
        name = try container.decode(String.self, forKey: .name)
        phone = try container.decodeIfPresent(String.self, forKey: .phone) ?? ""
        email = try container.decodeIfPresent(String.self, forKey: .email) ?? ""
        servDone = try container.decodeIfPresent([Service].self, forKey: .servDone) ?? []
        date = try container.decodeIfPresent(Date.self, forKey: .date) ?? Date()
        isWork = try container.decodeIfPresent(Bool.self, forKey: .isWork) ?? false
        clients = try container.decodeIfPresent([Client].self, forKey: .clients) ?? []
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
        var hash = 0
        for scalar in name.unicodeScalars {
            hash = Int(scalar.value) &+ (hash << 5) &- hash
        }
        let red = max(Double((hash >> 16) & 0xFF) / 255.0, 0.35)
        let green = max(Double((hash >> 8) & 0xFF) / 255.0, 0.35)
        let blue = max(Double(hash & 0xFF) / 255.0, 0.35)
        return Color(red: red, green: green, blue: blue)
    }

    var initial: String {
        guard let first = name.first else { return "?" }
        return String(first).uppercased()
    }
    func aWorkDay() -> Int {
        var tong = 0
        for ser in serDoneToday {
            tong += ser.price
        }
        return tong
    }
}
