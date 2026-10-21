//
//  VistaNuevoReporte.swift
//  TorreonVerde
//
//  Created by Sofia on 20/10/26.
//

import Foundation
import SwiftUI

struct VistaNuevoReporte: View {

    var body: some View {

        VStack(spacing: 20) {

            Image(systemName: "camera.fill")
                .font(.system(size: 55))
                .foregroundStyle(.green)

            Text("Nuevo reporte")
                .font(.title2)
                .fontWeight(.bold)

            Text(
                "Registra un problema ambiental que hayas encontrado en Torreón."
            )
            .multilineTextAlignment(.center)
            .foregroundStyle(.secondary)

        }
        .padding()
        .navigationTitle("Reportar")
    }
}
