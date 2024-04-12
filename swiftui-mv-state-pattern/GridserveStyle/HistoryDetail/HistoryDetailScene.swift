//
//  HistoryDetailScene.swift
//  swiftui-mv-state-pattern
//
//  Created by Leo Wirasanto Laia on 08/04/24.
//

import SwiftUI

struct HistoryDetailScene: View {
    @StateObject var viewModel: HistoryDetailViewModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                if viewModel.state == .loading {
                    ProgressView {
                        Text("fetching")
                    }
                    .padding()
                }

                HStack(spacing: 16) {
                    Button(action: viewModel.didSelectSuccessButton, label: {
                        Text("Success")
                    })
                    Spacer()
                    Button(action: viewModel.didSelectInProgressButton, label: {
                        Text("In Progress")
                    })
                    Spacer()
                    Button(action: viewModel.didSelectFailedButton, label: {
                        Text("Failed")
                    })
                }
                .disabled(viewModel.state == .loading)
                .padding()
                
                VStack(alignment: .leading) {
                    createRow(title: "Order id", value: viewModel.orderID)
                    createRow(title: "Status", value: viewModel.status)
                    createRow(title: "Location", value: viewModel.locationName)
                    createRow(title: "Transaction date", value: viewModel.transactionDate)
                    createRow(title: "Generated kWh", value: "\(viewModel.generatedKwh)")
                    createRow(title: "Admin fee", value: "\(viewModel.adminFee)")
                    createRow(title: "Discount", value: "\(viewModel.discount)")
                    createRow(title: "Total amount", boldTitle: true, value: "\(viewModel.chargedAmount)", boldValue: true)
                }
                .padding(.horizontal)
            }
        }
        .frame(maxWidth: .infinity)
        .onAppear {
            viewModel.onAppear()
        }
    }
    
    private func createRow(title: String, boldTitle: Bool = false, value: String, boldValue: Bool = false) -> some View {
        HStack {
            Text(title)
                .fontWeight(boldTitle ? .semibold : .regular)
            Spacer()
            Text(value)
                .fontWeight(boldValue ? .semibold : .regular)
        }
    }
}

#Preview {
    HistoryDetailScene(viewModel: .init())
}
