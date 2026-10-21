//
//  Reporte.swift
//  TorreonVerde
//
//  Created by Sofia on 20/10/26.
//

import Foundation
import SwiftData

@Model
final class Reporte {

    // id unico del reporte
    var id: UUID

    // info general
    var titulo: String
    var categoria: String
    var descripcion: String
    var ubicacion: String

    // foto del problema
    @Attribute(.externalStorage)
    var fotografia: Data?

    // seguimiento reporte
    var estado: String
    var fechaCreacion: Date

    // init para crear reportes
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

        // todos los reportes comienzan en pendiente
        self.estado = "Pendiente"
        self.fechaCreacion = Date()
    }
}

