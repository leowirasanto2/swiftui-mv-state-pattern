//
//  DummyJSON.swift
//  swiftui-mv-state-pattern
//
//  Created by Leo Wirasanto Laia on 08/04/24.
//

import Foundation

class DummyJSON {
    enum ResponseType: String {
        case inprogress = "detail-dummy-inprogress"
        case failed = "detail-dummy-failed"
        case success = "detail-dummy-success"
    }
    
    static let shared = DummyJSON()
    
    init() {}
    
    func get<T: Codable>(_ type: ResponseType) async throws -> T {
        let responseData = try await data(type)
        return try JSONDecoder().decode(T.self, from: responseData)
    }
    
    private func data(_ type: ResponseType) async throws -> Data  {
        let url = Bundle.main.url(forResource: type.rawValue, withExtension: "json")
        guard let dataURL = url else { 
            throw NetworkError.badRequest
        }
        return try Data(contentsOf: dataURL)
    }
}
