//
//  RegisterDepenency.swift
//  swiftui-mv-state-pattern
//
//  Created by Leo Wirasanto Laia on 12/04/24.
//

import Dependencies
import Foundation

extension DependencyValues {
    var dummyJsonService: DummyJsonService {
        get { self[DummyJsonServiceKey.self] }
        set { self[DummyJsonServiceKey.self] = newValue }
    }
    
    var historyService: HistoryService {
        get { self[HistoryServiceKey.self] }
        set { self[HistoryServiceKey.self] = newValue }
    }
}

private struct DummyJsonServiceKey: DependencyKey {
    static var liveValue: DummyJsonService = DummyJsonImplementation()
}

private struct HistoryServiceKey: DependencyKey {
    static var liveValue: HistoryService = HistoryServiceImp()
}
