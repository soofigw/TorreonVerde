//
//  ContentView.swift
//  TorreonVerde
//
//  Created by Sofia on 20/10/26.
//

import SwiftUI
import SwiftData

struct ContentView: View {

    // pestana seleccionada
    @State private var pestañaSeleccionada = 0

    var body: some View {

        TabView(selection: $pestañaSeleccionada) {

            NavigationStack {
                VistaInicio(
                    pestañaSeleccionada: $pestañaSeleccionada
                )
            }
            .tabItem {
                Label("Inicio", systemImage: "house.fill")
            }
            .tag(0)

            NavigationStack {
                VistaListaReportes()
            }
            .tabItem {
                Label("Reportes", systemImage: "list.bullet")
            }
            .tag(1)

            NavigationStack {
                VistaNuevoReporte()
            }
            .tabItem {
                Label("Reportar", systemImage: "plus.circle.fill")
            }
            .tag(2)
        }
        .tint(.green)
    }
}

#Preview {
    ContentView()
        .modelContainer(
            for: Reporte.self,
            inMemory: true
        )
}
