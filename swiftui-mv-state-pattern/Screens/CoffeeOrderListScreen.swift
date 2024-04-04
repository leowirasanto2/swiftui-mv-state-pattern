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
    @State private var addOrderSheetPresented: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    ForEach(model.orders) { order in
                        NavigationLink(value: order) {
                            VStack {
                                HStack {
                                    Text("#" + order.name.replacingOccurrences(of: " ", with: "") + UUID().uuidString.prefix(4))
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
                if selection == .orderDetailScreen {
                    Text("order detail screen")
                } else {
                    Text("Unavailable screen")
                }
            })
            .navigationTitle("Orders")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add order") {
                        addOrderSheetPresented = true
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
            .sheet(isPresented: $addOrderSheetPresented, content: {
                Text("add order sheet")
            })
        }
    }
}

#Preview {
    CoffeeOrderListScreen(path: .constant([]))
        .environmentObject(Model(httpClient: HttpClient.shared))
}
