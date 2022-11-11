//
//  JSONStruct.swift
//  Moonshot
//
//  Created by Hamid on 8/19/22.
//

import Foundation

struct Mission: Codable, Identifiable {
    struct Crew: Codable {
        let name: String
        let role: String
    }
    
    let id: Int
    let launchDate: Date?
    let crew: [Crew]
    let description: String
    
    var diplayName: String {
        "Apollo \(id)"
    }
    
    var image: String {
        "apollo\(id)"
    }
    
    var formattedLaunchDate: String {
        launchDate?.formatted(date: .abbreviated, time: .omitted) ?? "N/A"
    }

    
}

struct Astronaut: Codable, Identifiable {
    let id: String
    let name: String
    let description: String
}
