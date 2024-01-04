//
//  Project.swift
//  Friendzone
//
//  Created by Macmaurice Osuji on 4/26/23.
//


import Foundation

struct Friend: Codable, Identifiable, Hashable {
    
    let id: String
    let name: String
    
}
    
struct Person: Codable, Identifiable, Hashable {
    let id: String
    let isActive: Bool
    let name: String
    let age: Int
    let company: String
    let email: String
    let address: String
    let about: String
    let registered: String
    let tags: [String]
    let friends: [Friend]
    
    //converting the time in isoformatted registered date to show only the time
    var lastSeen: String {
        let newFormatter = ISO8601DateFormatter()
        let date = newFormatter.date(from: registered)!
        return String(date.formatted(date: .omitted, time: .shortened))
    }

    var joinDate: String {
        let newFormatter = ISO8601DateFormatter()
        let date = newFormatter.date(from: registered)!
        return String(date.formatted(date: .abbreviated, time: .omitted))
    }

    var followers: Int {
        return age + 22
    }

}


class Project: ObservableObject {
    @Published var persons = [Person]()
    
}

