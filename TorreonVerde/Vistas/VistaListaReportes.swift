//
//  VistaListaReportes.swift
//  TorreonVerde
//
//  Created by Sofia on 20/10/26.
//

import Foundation
import SwiftUI

struct VistaListaReportes: View {

    var body: some View {

        ContentUnavailableView(
            "Mis reportes",
            systemImage: "doc.text.magnifyingglass",
            description: Text(
                "Consulta y da seguimiento a tus reportes ambientales."
            )
        )
        .navigationTitle("Reportes")
    }
}
