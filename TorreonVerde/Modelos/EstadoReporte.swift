//
//  EstadoReporte.swift
//  TorreonVerde
//
//  Created by Sofia on 21/10/26.
//

import Foundation

import SwiftUI

// estados para el seguimiento
enum EstadoReporte: String, CaseIterable, Identifiable {

    case pendiente = "Pendiente"
    case enProceso = "En proceso"
    case resuelto = "Resuelto"

    var id: String {
        rawValue
    }

    var color: Color {
        switch self {
        case .pendiente:
            return ColoresApp.amarillo
        case .enProceso:
            return ColoresApp.enProceso
        case .resuelto:
            return ColoresApp.verdeNatural
        }
    }

    var icono: String {
        switch self {
        case .pendiente:
            return "clock.fill"
        case .enProceso:
            return "arrow.triangle.2.circlepath"
        case .resuelto:
            return "checkmark.circle.fill"
        }
    }
}
