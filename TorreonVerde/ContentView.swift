//
//  ContentView.swift
//  TorreonVerde
//
//  Created by Sofia on 20/10/26.
//

import SwiftUI
import SwiftData
struct ContentView: View {

    var body: some View {

        VStack(spacing: 20) {

            Image(systemName: "leaf.fill")
                .font(.system(size: 70))
                .foregroundStyle(.green)

            Text("TorreonVerde")
                .font(.largeTitle)
                .fontWeight(.bold)

            Text("Tu ciudad, tu entorno, tu voz.")
                .font(.headline)
                .foregroundStyle(.secondary)

            Text(
                "Reporta problemas ambientales y ayuda a cuidar nuestra ciudad."
            )
            .multilineTextAlignment(.center)
            .padding(.horizontal)

        }
        .padding()
    }
}

#Preview {
    ContentView()
        .modelContainer(
            for: Reporte.self,
            inMemory: true
        )
}

