//
//  Reporte.swift
//  TorreonVerde
//
//  Created by Sofia on 20/10/26.
//

import Foundation
import SwiftData

// Modelo que representa un reporte ambiental
@Model
final class Reporte {

    // Identificador único del reporte
    var id: UUID

    // Información general
    var titulo: String
    var categoria: String
    var descripcion: String
    var ubicacion: String

    // Fotografía del problema ambiental
    @Attribute(.externalStorage)
    var fotografia: Data?

    // Seguimiento del reporte
    var estado: String
    var fechaCreacion: Date

    // Inicializador para crear reportes
    init(
        titulo: String,
        categoria: String,
        descripcion: String,
        ubicacion: String,
        fotografia: Data?
    ) {
        self.id = UUID()
        self.titulo = titulo
        self.categoria = categoria
        self.descripcion = descripcion
        self.ubicacion = ubicacion
        self.fotografia = fotografia

        // Todos los reportes comienzan pendientes
        self.estado = "Pendiente"
        self.fechaCreacion = Date()
    }
}

