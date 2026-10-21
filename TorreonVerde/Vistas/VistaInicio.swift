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

    @Query(sort: \Reporte.fechaCreacion, order: .reverse)
    private var reportes: [Reporte]

    @Binding var pestañaSeleccionada: Int

    private var totalReportes: Int {
        reportes.count
    }

    private var reportesPendientes: Int {
        reportes.filter { $0.estado == "Pendiente" }.count
    }

    private var reportesResueltos: Int {
        reportes.filter { $0.estado == "Resuelto" }.count
    }

    var body: some View {

        ScrollView {

            VStack(alignment: .leading, spacing: 24) {

                // header
                HStack(spacing: 12) {

                    Image(systemName: "leaf.fill")
                        .font(.title2)
                        .foregroundStyle(ColoresApp.verdeOscuro)
                        .padding(12)
                        .background(ColoresApp.crema)
                        .clipShape(
                            RoundedRectangle(cornerRadius: 12)
                        )

                    VStack(alignment: .leading, spacing: 4) {

                        Text("TorreonVerde")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundStyle(ColoresApp.verdeOscuro)

                        Text("Cuidemos nuestra ciudad")
                            .font(.caption)
                            .foregroundStyle(ColoresApp.textoSecundario)
                    }

                    Spacer()

                    Image(systemName: "sun.max.fill")
                        .font(.title2)
                        .foregroundStyle(ColoresApp.amarillo)
                }

                // tarjeta principal
                VStack(alignment: .leading, spacing: 16) {

                    HStack(spacing: 8) {
                        Image(systemName: "leaf.fill")

                        Text("BIENVENIDO A TORREONVERDE")
                    }
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundStyle(ColoresApp.amarillo)

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
                        .background(ColoresApp.amarillo)
                        .foregroundStyle(ColoresApp.verdeOscuro)
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
                            ColoresApp.verdeOscuro,
                            ColoresApp.verdeNatural
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .clipShape(
                    RoundedRectangle(cornerRadius: 20)
                )

                // resumen d reportes
                VStack(alignment: .leading, spacing: 14) {

                    Text("Resumen de reportes")
                        .font(.headline)
                        .foregroundStyle(ColoresApp.verdeOscuro)

                    HStack(spacing: 10) {

                        TarjetaEstadistica(
                            titulo: "Total",
                            cantidad: totalReportes,
                            icono: "doc.text.fill",
                            color: ColoresApp.verdeOscuro
                        )

                        TarjetaEstadistica(
                            titulo: "Pendientes",
                            cantidad: reportesPendientes,
                            icono: "clock.fill",
                            color: ColoresApp.amarillo
                        )

                        TarjetaEstadistica(
                            titulo: "Resueltos",
                            cantidad: reportesResueltos,
                            icono: "checkmark.circle.fill",
                            color: ColoresApp.verdeNatural
                        )
                    }
                }

                // reportes recientes
                VStack(alignment: .leading, spacing: 14) {

                    HStack {

                        Text("Reportes recientes")
                            .font(.headline)
                            .foregroundStyle(ColoresApp.verdeOscuro)

                        Spacer()

                        Button("Ver todos") {
                            pestañaSeleccionada = 1
                        }
                        .font(.subheadline)
                        .foregroundStyle(ColoresApp.verdeNatural)
                    }

                    if reportes.isEmpty {

                        VStack(spacing: 12) {

                            Image(systemName: "leaf.circle.fill")
                                .font(.system(size: 48))
                                .foregroundStyle(
                                    ColoresApp.verdeNatural
                                )

                            Text("Aún no tienes reportes")
                                .font(.headline)
                                .foregroundStyle(
                                    ColoresApp.verdeOscuro
                                )

                            Text(
                                "Cuando registres un problema ambiental, aparecerá aquí."
                            )
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                            .multilineTextAlignment(.center)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(28)
                        .background(.white)
                        .clipShape(
                            RoundedRectangle(cornerRadius: 18)
                        )

                    } else {

                        
                        ForEach(reportes.prefix(3)) { reporte in

                            NavigationLink {

                                VistaDetalleReporte(reporte: reporte)

                            } label: {

                                TarjetaReporte(reporte: reporte)
                            }
                            .buttonStyle(.plain)
                        }

                    }
                }
            }
            .padding()
        }
        .background(ColoresApp.fondo)
        .toolbar(.hidden, for: .navigationBar)
    }
}
