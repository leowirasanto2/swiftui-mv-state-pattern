//
//  HistoryDetailModel.swift
//  swiftui-mv-state-pattern
//
//  Created by Leo Wirasanto Laia on 08/04/24.
//

import Foundation

// MARK: - HistoryDetailModel
struct HistoryDetailModel: Codable {
    let status: Bool
    let data: HistoryDetailData
}

// MARK: - HistoryDetailData
struct HistoryDetailData: Codable, Equatable {
    let status, locationName, transactionDate: String
    let chargedAmount: Double
    let generatedKwh: Double
    let image: String
    let adminFee, discount: Double
    let orderID: String

    enum CodingKeys: String, CodingKey {
        case status
        case locationName = "location_name"
        case transactionDate = "transaction_date"
        case chargedAmount = "charged_amount"
        case generatedKwh = "generated_kwh"
        case image
        case adminFee = "admin_fee"
        case discount
        case orderID = "order_id"
    }
}
