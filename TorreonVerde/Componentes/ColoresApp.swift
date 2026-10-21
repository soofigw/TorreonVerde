//
//  ColoresApp.swift
//  TorreonVerde
//
//  Created by Sofia on 20/10/26.
//

import Foundation
import SwiftUI

// paleta d colores
enum ColoresApp {

    // colores principales
    static let verdeOscuro = Color(
        red: 32/255, green: 92/255, blue: 59/255
    )

    static let verdeNatural = Color(
        red: 59/255, green: 150/255, blue: 89/255
    )

    static let amarillo = Color(
        red: 242/255, green: 201/255, blue: 76/255
    )

    // colores d fondo
    static let crema = Color(
        red: 255/255, green: 245/255, blue: 214/255
    )

    static let fondo = Color(
        red: 247/255, green: 249/255, blue: 245/255
    )

    // colores d texto
    static let textoPrincipal = verdeOscuro
    static let textoSecundario = Color.gray

    // colores para estados de reportes
    static let pendiente = amarillo
    static let enProceso = Color.orange
    static let resuelto = verdeNatural
}
