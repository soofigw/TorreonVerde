//
//  VistaListaReportes.swift
//  TorreonVerde
//
//  Created by Sofia on 20/10/26.
//

import Foundation
import SwiftUI
import SwiftData

struct VistaListaReportes: View {

    @Query(sort: \Reporte.fechaCreacion, order: .reverse)
    private var reportes: [Reporte]

    @State private var textoBusqueda = ""
    @State private var filtroEstado = "Todos"
    @State private var filtroCategoria = "Todas"

    // reportes que cumplen los filtros
    private var reportesFiltrados: [Reporte] {

        reportes.filter { reporte in

            let coincideBusqueda =
                textoBusqueda.isEmpty ||
                reporte.titulo.localizedCaseInsensitiveContains(textoBusqueda) ||
                reporte.ubicacion.localizedCaseInsensitiveContains(textoBusqueda)

            let coincideEstado =
                filtroEstado == "Todos" ||
                reporte.estado == filtroEstado

            let coincideCategoria =
                filtroCategoria == "Todas" ||
                reporte.categoria == filtroCategoria

            return coincideBusqueda &&
                   coincideEstado &&
                   coincideCategoria
        }
    }

    var body: some View {

        ScrollView {

            VStack(alignment: .leading, spacing: 18) {

                // header
                HStack {

                    VStack(alignment: .leading, spacing: 4) {

                        Text("Mis reportes")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundStyle(ColoresApp.verdeOscuro)

                        Text("\(reportes.count) reportes registrados")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }

                    Spacer()

                    Image(systemName: "leaf.fill")
                        .font(.title2)
                        .foregroundStyle(ColoresApp.verdeNatural)
                }

                // barra de busqueda
                HStack(spacing: 10) {

                    Image(systemName: "magnifyingglass")
                        .foregroundStyle(.secondary)

                    TextField(
                        "Buscar por título o ubicación",
                        text: $textoBusqueda
                    )
                    .textInputAutocapitalization(.never)
                }
                .padding()
                .background(.white)
                .clipShape(
                    RoundedRectangle(cornerRadius: 12)
                )

                // filtro x estado
                VStack(alignment: .leading, spacing: 8) {

                    Text("Filtrar por estado")
                        .font(.subheadline)
                        .fontWeight(.semibold)

                    Picker(
                        "Estado",
                        selection: $filtroEstado
                    ) {

                        Text("Todos").tag("Todos")

                        ForEach(EstadoReporte.allCases) { estado in
                            Text(estado.rawValue)
                                .tag(estado.rawValue)
                        }
                    }
                    .pickerStyle(.menu)
                }

                // filtro x categoria
                HStack {

                    Text("Categoría")
                        .font(.subheadline)
                        .fontWeight(.semibold)

                    Spacer()

                    Picker(
                        "Categoría",
                        selection: $filtroCategoria
                    ) {

                        Text("Todas").tag("Todas")

                        ForEach(CategoriaReporte.allCases) { categoria in
                            Text(categoria.rawValue)
                                .tag(categoria.rawValue)
                        }
                    }
                    .tint(ColoresApp.verdeNatural)
                }

                // cant de resultados
                Text(
                    "\(reportesFiltrados.count) resultados encontrados"
                )
                .font(.caption)
                .foregroundStyle(.secondary)

                // lista de reportes
                if reportesFiltrados.isEmpty {

                    ContentUnavailableView(
                        "No se encontraron reportes",
                        systemImage: "doc.text.magnifyingglass",
                        description: Text(
                            "Prueba con otros filtros o registra un nuevo reporte."
                        )
                    )

                } else {

                    LazyVStack(spacing: 16) {

                        ForEach(reportesFiltrados) { reporte in

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
            .padding(.bottom, 40)
        }
        .background(ColoresApp.fondo)
        .toolbar(.hidden, for: .navigationBar)
    }
}

