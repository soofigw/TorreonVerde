//
//  VistaDetalleReporte.swift
//  TorreonVerde
//
//  Created by Sofia on 21/10/26.
//

import Foundation
import SwiftUI
import SwiftData

struct VistaDetalleReporte: View {

    @Environment(\.modelContext)
    private var contextoModelo

    @Environment(\.dismiss)
    private var cerrarVista

    @Bindable var reporte: Reporte

    @State private var confirmarEliminacion = false
    @State private var mostrarError = false
    @State private var mensajeError = ""

    var body: some View {

        ScrollView {

            VStack(alignment: .leading, spacing: 22) {

                // foto del problema
                if let datos = reporte.fotografia,
                   let imagen = UIImage(data: datos) {

                    Image(uiImage: imagen)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity)
                        .clipShape(
                            RoundedRectangle(cornerRadius: 18)
                        )
                }

                // info principal
                VStack(alignment: .leading, spacing: 12) {

                    Text(reporte.titulo)
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundStyle(ColoresApp.verdeOscuro)

                    Label(
                        reporte.categoria,
                        systemImage: "leaf.fill"
                    )
                    .foregroundStyle(ColoresApp.verdeNatural)

                    Label(
                        reporte.ubicacion,
                        systemImage: "mappin.circle.fill"
                    )
                    .foregroundStyle(.secondary)

                    Label(
                        reporte.fechaCreacion.formatted(
                            date: .long,
                            time: .shortened
                        ),
                        systemImage: "calendar"
                    )
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                }

                Divider()

                // descrip
                VStack(alignment: .leading, spacing: 10) {

                    Text("Descripción del problema")
                        .font(.headline)
                        .foregroundStyle(ColoresApp.verdeOscuro)

                    Text(reporte.descripcion)
                        .font(.body)
                        .foregroundStyle(.primary)
                }

                Divider()

                // seguimiento
                VStack(alignment: .leading, spacing: 14) {

                    Text("Seguimiento del reporte")
                        .font(.headline)
                        .foregroundStyle(ColoresApp.verdeOscuro)

                    Text("Actualiza el estado conforme se atienda el problema.")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)

                    Picker(
                        "Estado del reporte",
                        selection: $reporte.estado
                    ) {

                        ForEach(EstadoReporte.allCases) { estado in

                            Text(estado.rawValue)
                                .tag(estado.rawValue)
                        }
                    }
                    .pickerStyle(.menu)
                    .tint(ColoresApp.verdeOscuro)
                    .onChange(of: reporte.estado) { _, _ in
                        guardarCambios()
                    }
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(ColoresApp.crema)
                .clipShape(
                    RoundedRectangle(cornerRadius: 16)
                )

                // eliminar reporte
                Button(role: .destructive) {
                    confirmarEliminacion = true
                } label: {

                    Label(
                        "Eliminar reporte",
                        systemImage: "trash.fill"
                    )
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                }
                .buttonStyle(.bordered)
                .tint(.red)
            }
            .padding()
            .padding(.bottom, 40)
        }
        .background(ColoresApp.fondo)
        .navigationTitle("Detalle del reporte")
        .navigationBarTitleDisplayMode(.inline)
        .confirmationDialog(
            "¿Eliminar este reporte?",
            isPresented: $confirmarEliminacion,
            titleVisibility: .visible
        ) {

            Button("Eliminar definitivamente", role: .destructive) {
                eliminarReporte()
            }

            Button("Cancelar", role: .cancel) {}

        } message: {
            Text("Esta acción no se puede deshacer.")
        }
        .alert("Ocurrió un error", isPresented: $mostrarError) {
            Button("Aceptar", role: .cancel) {}
        } message: {
            Text(mensajeError)
        }
    }

    // guardar cambios de estado
    private func guardarCambios() {

        do {
            try contextoModelo.save()
        } catch {
            mensajeError = "No se pudo guardar el nuevo estado."
            mostrarError = true
        }
    }

    // eliminar el reporte de SwiftData
    private func eliminarReporte() {

        contextoModelo.delete(reporte)

        do {
            try contextoModelo.save()
            cerrarVista()
        } catch {
            mensajeError = "No se pudo eliminar el reporte."
            mostrarError = true
        }
    }
}
