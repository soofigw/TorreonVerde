//
//  TarjetaReporte.swift
//  TorreonVerde
//
//  Created by Sofia on 21/10/26.
//

import Foundation
import SwiftUI

struct TarjetaReporte: View {

    let reporte: Reporte

    private var estadoActual: EstadoReporte {
        EstadoReporte(rawValue: reporte.estado) ?? .pendiente
    }

    var body: some View {

        VStack(alignment: .leading, spacing: 12) {

            // foto del reporte
            if let datos = reporte.fotografia,
               let imagen = UIImage(data: datos) {

                Image(uiImage: imagen)
                    .resizable()
                    .scaledToFill()
                    .frame(height: 170)
                    .frame(maxWidth: .infinity)
                    .clipped()
                    .clipShape(
                        RoundedRectangle(cornerRadius: 12)
                    )
            }

            HStack(alignment: .top, spacing: 8) {

                Text(reporte.titulo)
                    .font(.headline)
                    .foregroundStyle(ColoresApp.verdeOscuro)

                Spacer(minLength: 4)

                Text(reporte.estado)
                    .font(.caption2)
                    .fontWeight(.semibold)
                    .foregroundStyle(ColoresApp.verdeOscuro)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 6)
                    .background(
                        estadoActual.color.opacity(0.25)
                    )
                    .clipShape(Capsule())
            }

            Label(
                reporte.categoria,
                systemImage: "leaf.fill"
            )
            .font(.subheadline)
            .foregroundStyle(ColoresApp.verdeNatural)

            Label(
                reporte.ubicacion,
                systemImage: "mappin.circle"
            )
            .font(.subheadline)
            .foregroundStyle(.secondary)

            HStack {

                Text(
                    reporte.fechaCreacion,
                    format: .dateTime.day().month().year()
                )
                .font(.caption)
                .foregroundStyle(.secondary)

                Spacer()

                Label(
                    "Ver detalles",
                    systemImage: "arrow.right"
                )
                .font(.caption)
                .fontWeight(.semibold)
                .foregroundStyle(ColoresApp.verdeNatural)
            }
        }
        .padding(14)
        .background(.white)
        .clipShape(
            RoundedRectangle(cornerRadius: 18)
        )
        .overlay {
            RoundedRectangle(cornerRadius: 18)
                .stroke(
                    ColoresApp.verdeNatural.opacity(0.12),
                    lineWidth: 1
                )
        }
    }
}
