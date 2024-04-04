//
//  CoffeeOrder.swift
//  swiftui-mv-state-pattern
//
//  Created by Leo Wirasanto Laia on 04/04/24.
//

import Foundation

enum CoffeeSize: String, Codable, CaseIterable, Identifiable {
    case small = "Small"
    case medium = "Medium"
    case large = "Large"
    
    var id: CoffeeSize { self }
}

struct CoffeeOrder: Identifiable, Codable, Hashable {
    var id: Int?
    let name: String
    let coffeeName: String
    let total: Double
    let size: CoffeeSize
}
