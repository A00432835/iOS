//
//  Wonders.swift
//  firstApp
//
//  Created by Aditya Tandon on 2019-07-20.
//  Copyright © 2019 Aditya Tandon. All rights reserved.
//

import Foundation

struct Wonders {
    let name: String
    let description: String?
    let userRating : Double
    let imageURL: String
    let coordinates: [Double]
    
    init ?(wonder: [String: Any]) {
        guard let properties = wonder["properties"] as? [String: Any], let geometry = wonder["geometry"] as? [String: Any] else { return nil }
        self.name = properties["name"] as? String ?? ""
        self.description = properties["description"] as? String
        self.userRating = properties["userRating"] as? Double ?? 0.0
        self.imageURL = properties["imageURL"] as? String ?? ""
        self.coordinates = geometry["coordinates"] as? [Double] ?? []
        
        
        
    }
    
}
