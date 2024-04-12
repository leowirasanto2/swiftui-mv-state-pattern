//
//  HistoryService.swift
//  swiftui-mv-state-pattern
//
//  Created by Leo Wirasanto Laia on 12/04/24.
//

import Dependencies
import Foundation
import SwiftUI

protocol HistoryService {
    func getDummyHistoryDetail(_ type: DummyJsonImplementation.ResponseType) async throws -> HistoryDetailData
}

class HistoryServiceImp: HistoryService {
    @Dependency(\.dummyJsonService) var dummyJsonService
    
    func getDummyHistoryDetail(_ type: DummyJsonImplementation.ResponseType) async throws -> HistoryDetailData {
        let response: HistoryDetailModel = try await dummyJsonService.get(type)
        return response.data
    }
}
