//
//  AddOrderScreen.swift
//  swiftui-mv-state-pattern
//
//  Created by Leo Wirasanto Laia on 04/04/24.
//

import SwiftUI

struct AddOrderScreen: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var model: Model
    @State private var name = ""
    @State private var coffeeName = ""
    @State private var total: Double = 0.0
    @State private var size: CoffeeSize = .small
    
    var body: some View {
        Form {
            TextField("Name", text: $name)
            TextField("Coffee name", text: $coffeeName)
            TextField("Total", value: $total, format: .number)
            
            Picker("Coffee size", selection: $size) {
                ForEach(CoffeeSize.allCases) { size in
                    Text(size.rawValue)
                }
            }.pickerStyle(.segmented)
            
            HStack {
                Spacer()
                Button("Place order") {
                    Task {
                        do {
                            try await placeOrder()
                        } catch {
                            print(error.localizedDescription)
                        }
                    }
                }.buttonStyle(BorderedProminentButtonStyle())
                Spacer()
            }
        }
    }
    
    private func placeOrder() async throws {
        let order = CoffeeOrder(name: name, coffeeName: coffeeName, total: total, size: size)
        do {
            try await model.placeOrder(placedOrder: order)
            dismiss()
        } catch {
            throw NetworkError.badRequest
        }
    }
}

#Preview {
    AddOrderScreen()
        .environmentObject(Model(httpClient: HttpClient.shared))
}
