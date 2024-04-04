//
//  APIs.swift
//  swiftui-mv-state-pattern
//
//  Created by Leo Wirasanto Laia on 04/04/24.
//

import Foundation

enum APIs {
    case orders
    case addOrder
    
    private var baseURL: URL {
        URL(string: "https://island-bramble.glitch.me")!
    }
    
    var url: URL {
        switch self {
        case .orders:
            baseURL.appending(path: "/orders")
        case .addOrder:
            baseURL.appending(path: "/newOrder")
        }
    }
}
