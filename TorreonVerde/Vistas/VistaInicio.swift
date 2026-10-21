//
//  VistaInicio.swift
//  TorreonVerde
//
//  Created by Sofia on 20/10/26.
//

import Foundation
import SwiftUI
import SwiftData

struct VistaInicio: View {

    // consulta reportes almacenados
    @Query(sort: \Reporte.fechaCreacion, order: .reverse)
    private var reportes: [Reporte]

    // cambiar pestana
    @Binding var pestañaSeleccionada: Int

    // estadisticas calculadas
    private var totalReportes: Int {
        reportes.count
    }

    private var reportesPendientes: Int {
        reportes.filter {
            $0.estado == "Pendiente"
        }.count
    }

    private var reportesResueltos: Int {
        reportes.filter {
            $0.estado == "Resuelto"
        }.count
    }

    var body: some View {

        ScrollView {

            VStack(alignment: .leading, spacing: 24) {

                // header
                HStack(spacing: 12) {

                    Image(systemName: "leaf.fill")
                        .font(.title2)
                        .foregroundStyle(.green)
                        .padding(12)
                        .background(
                            Color.green.opacity(0.12)
                        )
                        .clipShape(
                            RoundedRectangle(cornerRadius: 12)
                        )

                    VStack(alignment: .leading) {

                        Text("TorreonVerde")
                            .font(.title2)
                            .fontWeight(.bold)

                        Text("Cuidemos nuestra ciudad")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }

                    Spacer()

                    Image(systemName: "mappin.circle.fill")
                        .font(.title2)
                        .foregroundStyle(.green)
                }

                // Tarjeta de bienvenida
                VStack(alignment: .leading, spacing: 16) {

                    Text("BIENVENIDO A TORREONVERDE")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundStyle(.white.opacity(0.8))

                    Text("Tu ciudad, tu entorno, tu voz.")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundStyle(.white)

                    Text(
                        "Ayuda a construir un Torreón más limpio y sostenible."
                    )
                    .font(.subheadline)
                    .foregroundStyle(.white.opacity(0.9))

                    Button {
                        pestañaSeleccionada = 2
                    } label: {

                        Label(
                            "Crear reporte",
                            systemImage: "plus.circle.fill"
                        )
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(.white)
                        .foregroundStyle(Color.green)
                        .clipShape(
                            RoundedRectangle(cornerRadius: 12)
                        )
                    }
                }
                .padding(22)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(
                    LinearGradient(
                        colors: [
                            Color(red: 0.13, green: 0.42, blue: 0.26),
                            Color(red: 0.20, green: 0.58, blue: 0.35)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .clipShape(
                    RoundedRectangle(cornerRadius: 20)
                )

                // estadisticas
                VStack(alignment: .leading, spacing: 14) {

                    Text("Resumen de reportes")
                        .font(.headline)

                    HStack(spacing: 10) {

                        TarjetaEstadistica(
                            titulo: "Total",
                            cantidad: totalReportes,
                            icono: "doc.text.fill",
                            color: .blue
                        )

                        TarjetaEstadistica(
                            titulo: "Pendientes",
                            cantidad: reportesPendientes,
                            icono: "clock.fill",
                            color: .orange
                        )

                        TarjetaEstadistica(
                            titulo: "Resueltos",
                            cantidad: reportesResueltos,
                            icono: "checkmark.circle.fill",
                            color: .green
                        )
                    }
                }

                // reportes recientes
                VStack(alignment: .leading, spacing: 14) {

                    HStack {

                        Text("Reportes recientes")
                            .font(.headline)

                        Spacer()

                        Button("Ver todos") {
                            pestañaSeleccionada = 1
                        }
                        .font(.subheadline)
                        .foregroundStyle(.green)
                    }

                    if reportes.isEmpty {

                        ContentUnavailableView(
                            "Aún no tienes reportes",
                            systemImage: "leaf",
                            description: Text(
                                "Cuando registres un problema ambiental, aparecerá aquí."
                            )
                        )

                    } else {

                        ForEach(reportes.prefix(3)) { reporte in

                            VStack(alignment: .leading, spacing: 6) {

                                Text(reporte.titulo)
                                    .font(.headline)

                                Text(reporte.ubicacion)
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)

                                Text(reporte.estado)
                                    .font(.caption)
                                    .foregroundStyle(.green)
                            }
                            .frame(
                                maxWidth: .infinity,
                                alignment: .leading
                            )
                            .padding()
                            .background(
                                Color(.secondarySystemGroupedBackground)
                            )
                            .clipShape(
                                RoundedRectangle(cornerRadius: 14)
                            )
                        }
                    }
                }
            }
            .padding()
        }
        .background(Color(.systemGroupedBackground))
        .toolbar(.hidden, for: .navigationBar)
    }
}
