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
            VStack {
                HStack(alignment: .center, spacing: 16) {
                    switch viewModel.state {
                    case .loading:
                        ProgressView {
                            Text("fetching")
                        }
                    default:
                        Button(action: viewModel.didSelectSuccessButton, label: {
                            Text("Success")
                        })
                        Button(action: viewModel.didSelectInProgressButton, label: {
                            Text("In Progress")
                        })
                        Button(action: viewModel.didSelectFailedButton, label: {
                            Text("Failed")
                        })
                    }
                }
                .padding()
                
                VStack(alignment: .leading) {
                    Text(viewModel.status)
                    Text(viewModel.locationName)
                    Text(viewModel.transactionDate)
                    Text("\(viewModel.chargedAmount)")
                    Text("\(viewModel.generatedKwh)")
                    Text(viewModel.image)
                    Text("\(viewModel.adminFee)")
                    Text("\(viewModel.discount)")
                    Text(viewModel.orderID)
                }
                
                
            }
        }
        .onAppear {
            viewModel.onAppear()
        }
    }
}

#Preview {
    HistoryDetailScene(viewModel: .init())
}
