//
//  ContentView.swift
//  swiftui-mv-state-pattern
//
//  Created by Leo Wirasanto Laia on 04/04/24.
//

import SwiftUI

struct ContentView: View {
    @State var path: [RoutePath] = []
    var body: some View {
        CoffeeOrderListScreen(path: $path)
            .environmentObject(Model(httpClient: HttpClient.shared))
    }
}

#Preview {
    ContentView()
}
