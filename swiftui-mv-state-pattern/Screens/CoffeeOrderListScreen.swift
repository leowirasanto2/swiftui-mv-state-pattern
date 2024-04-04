//
//  CoffeeOrderListScreen.swift
//  swiftui-mv-state-pattern
//
//  Created by Leo Wirasanto Laia on 04/04/24.
//

import SwiftUI

struct CoffeeOrderListScreen: View {
    @Binding var path: [RoutePath]
    @EnvironmentObject var model: Model
    
    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                ScrollView {
                    ForEach(model.orders) { order in
                        Button {
                            path = [.orderDetailScreen]
                        } label: {
                            VStack {
                                HStack {
                                    Text("#" + order.name.replacingOccurrences(of: " ", with: ""))
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                }
                                .padding()
                                Divider()
                            }
                        }
                    }
                }
            }
            .navigationDestination(for: RoutePath.self, destination: { selection in
                if selection == .addOrderScreen {
                    AddOrderScreen()
                } else if selection == .orderDetailScreen {
                    Text("order detail screen")
                }
            })
            .navigationTitle("Orders")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add order") {
                        path = [.addOrderScreen]
                    }
                }
            }
            .task {
                do {
                    try await model.loadOrders()
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
}

#Preview {
    CoffeeOrderListScreen(path: .constant([]))
        .environmentObject(Model(httpClient: HttpClient.shared))
}
