//
//  CategoriaReporte.swift
//  TorreonVerde
//
//  Created by Sofia on 20/10/26.
//

import Foundation
import Foundation

// categorias para los reportes
enum CategoriaReporte: String, CaseIterable, Identifiable {

    case basura = "Basura y residuos"
    case agua = "Fugas de agua"
    case areasVerdes = "Áreas verdes"
    case aire = "Contaminación del aire"
    case quemas = "Quema de residuos"
    case otros = "Otros problemas"

    var id: String {
        rawValue
    }

    // iconos
    var icono: String {
        switch self {
        case .basura:
            return "trash.fill"
        case .agua:
            return "drop.fill"
        case .areasVerdes:
            return "tree.fill"
        case .aire:
            return "wind"
        case .quemas:
            return "flame.fill"
        case .otros:
            return "exclamationmark.circle.fill"
        }
    }
}
