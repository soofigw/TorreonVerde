//
//  VistaNuevoReporte.swift
//  TorreonVerde
//
//  Created by Sofia on 20/10/26.
//

import Foundation

import SwiftUI
import SwiftData
import PhotosUI

struct VistaNuevoReporte: View {

    // bdd local
    @Environment(\.modelContext)
    private var contextoModelo

    // info formulario
    @State private var titulo = ""
    @State private var categoria: CategoriaReporte?
    @State private var descripcion = ""
    @State private var ubicacion = ""

    // foto seleccionada
    @State private var fotografiaSeleccionada: PhotosPickerItem?
    @State private var datosFotografia: Data?

    // alerta
    @State private var mostrarError = false
    @State private var mensajeError = ""
    @State private var mostrarConfirmacion = false

    // validar campos
    private var formularioValido: Bool {
        !titulo.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
        categoria != nil &&
        !descripcion.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
        !ubicacion.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
        datosFotografia != nil
    }

    var body: some View {

        ScrollView {

            VStack(alignment: .leading, spacing: 22) {

                // Encabezado informativo
                VStack(alignment: .leading, spacing: 8) {

                    Label(
                        "Ayuda a cuidar Torreón",
                        systemImage: "leaf.fill"
                    )
                    .font(.headline)
                    .foregroundStyle(ColoresApp.verdeOscuro)

                    Text(
                        "Registra un problema ambiental que hayas encontrado en tu comunidad."
                    )
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(ColoresApp.crema)
                .clipShape(
                    RoundedRectangle(cornerRadius: 16)
                )

                // titulo
                VStack(alignment: .leading, spacing: 8) {

                    Text("Título del reporte *")
                        .font(.headline)

                    TextField(
                        "Ej. Basura acumulada en terreno",
                        text: $titulo
                    )
                    .textInputAutocapitalization(.sentences)
                    .padding()
                    .background(.white)
                    .clipShape(
                        RoundedRectangle(cornerRadius: 12)
                    )
                }

                // categoria
                VStack(alignment: .leading, spacing: 8) {

                    Text("Categoría *")
                        .font(.headline)

                    Picker(
                        "Selecciona una categoría",
                        selection: $categoria
                    ) {

                        Text("Selecciona una categoría")
                            .tag(nil as CategoriaReporte?)

                        ForEach(CategoriaReporte.allCases) { opcion in

                            Label(
                                opcion.rawValue,
                                systemImage: opcion.icono
                            )
                            .tag(Optional(opcion))
                        }
                    }
                    .tint(ColoresApp.verdeOscuro)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .background(.white)
                    .clipShape(
                        RoundedRectangle(cornerRadius: 12)
                    )
                }

                // descripcion
                VStack(alignment: .leading, spacing: 8) {

                    Text("Descripción *")
                        .font(.headline)

                    TextEditor(text: $descripcion)
                        .frame(height: 120)
                        .scrollContentBackground(.hidden)
                        .padding(8)
                        .background(.white)
                        .clipShape(
                            RoundedRectangle(cornerRadius: 12)
                        )

                    Text("Describe qué sucede y por qué representa un problema.")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }

                // ubi
                VStack(alignment: .leading, spacing: 8) {

                    Text("Ubicación *")
                        .font(.headline)

                    TextField(
                        "Colonia, calle o referencia",
                        text: $ubicacion
                    )
                    .textInputAutocapitalization(.words)
                    .padding()
                    .background(.white)
                    .clipShape(
                        RoundedRectangle(cornerRadius: 12)
                    )
                }

                // foto
                VStack(alignment: .leading, spacing: 12) {

                    Text("Fotografía del problema *")
                        .font(.headline)

                    PhotosPicker(
                        selection: $fotografiaSeleccionada,
                        matching: .images
                    ) {

                        VStack(spacing: 12) {

                            if let datosFotografia,
                               let imagen = UIImage(data: datosFotografia) {

                                Image(uiImage: imagen)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(maxHeight: 220)
                                    .clipShape(
                                        RoundedRectangle(cornerRadius: 12)
                                    )

                                Text("Cambiar fotografía")
                                    .font(.subheadline)
                                    .fontWeight(.semibold)

                            } else {

                                Image(systemName: "camera.fill")
                                    .font(.system(size: 40))

                                Text("Seleccionar fotografía")
                                    .fontWeight(.semibold)

                                Text("Desde la galería del dispositivo")
                                    .font(.caption)
                            }
                        }
                        .foregroundStyle(ColoresApp.verdeOscuro)
                        .frame(maxWidth: .infinity)
                        .padding(24)
                        .background(ColoresApp.crema)
                        .clipShape(
                            RoundedRectangle(cornerRadius: 16)
                        )
                    }
                    .onChange(of: fotografiaSeleccionada) { _, nuevaFoto in

                        Task {
                            // esto es para evitar que se quede una foto anterior
                            datosFotografia = nil

                            guard let nuevaFoto else {
                                return
                            }

                            do {
                                if let datos = try await nuevaFoto
                                    .loadTransferable(type: Data.self),
                                   UIImage(data: datos) != nil {

                                    datosFotografia = datos

                                } else {
                                    mensajeError = "No se pudo leer la fotografía."
                                    mostrarError = true
                                }
                            } catch {
                                mensajeError = "Ocurrió un error al cargar la fotografía."
                                mostrarError = true
                            }
                        }
                    }
                }

                // guardar reporte
                Button {
                    guardarReporte()
                } label: {

                    Label(
                        "Guardar reporte",
                        systemImage: "checkmark.circle.fill"
                    )
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(ColoresApp.amarillo)
                    .foregroundStyle(ColoresApp.verdeOscuro)
                    .clipShape(
                        RoundedRectangle(cornerRadius: 14)
                    )
                }

                Text("* Todos los campos son obligatorios.")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .frame(maxWidth: .infinity)
            }
            .padding()
            .padding(.bottom, 40)
        }
        .background(ColoresApp.fondo)
        .navigationTitle("Nuevo reporte")
        .alert("No se pudo guardar", isPresented: $mostrarError) {
            Button("Aceptar", role: .cancel) {}
        } message: {
            Text(mensajeError)
        }
        .alert("Reporte guardado", isPresented: $mostrarConfirmacion) {
            Button("Aceptar", role: .cancel) {}
        } message: {
            Text("Tu reporte ambiental se registró correctamente.")
        }
    }

    // guardar un nuevo reporte
    private func guardarReporte() {

        guard formularioValido else {

            mensajeError = "Completa todos los campos y selecciona una fotografía."
            mostrarError = true
            return
        }

        guard let categoriaSeleccionada = categoria else {
            return
        }

        let nuevoReporte = Reporte(
            titulo: titulo.trimmingCharacters(in: .whitespacesAndNewlines),
            categoria: categoriaSeleccionada.rawValue,
            descripcion: descripcion.trimmingCharacters(in: .whitespacesAndNewlines),
            ubicacion: ubicacion.trimmingCharacters(in: .whitespacesAndNewlines),
            fotografia: datosFotografia
        )

        contextoModelo.insert(nuevoReporte)

        do {
            try contextoModelo.save()

            limpiarFormulario()
            mostrarConfirmacion = true

        } catch {

            contextoModelo.delete(nuevoReporte)

            mensajeError = "No fue posible guardar el reporte. Inténtalo nuevamente."
            mostrarError = true
        }
    }

    // limpiar los campos desp de guardar
    private func limpiarFormulario() {

        titulo = ""
        categoria = nil
        descripcion = ""
        ubicacion = ""
        fotografiaSeleccionada = nil
        datosFotografia = nil
    }
}
