//
//  Bundle-Decodable.swift
//  Moonshot
//
//  Created by Hamid on 8/19/22.
//

import Foundation

extension Bundle {
    func decode<T: Codable>(_ file:String) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("faild to locate the \(file)")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("failed to load the \(file)")
        }
        
        let decoder = JSONDecoder()
        
        let formatter = DateFormatter()
        formatter.dateFormat = "y-MM-dd"
        decoder.dateDecodingStrategy = .formatted(formatter)
        
        
        guard let loaded = try? decoder.decode(T.self, from: data) else {
            fatalError("failed to decode \(file)")
        }
        return loaded
    }
}
