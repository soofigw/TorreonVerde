//
//  TarjetaEstadistica.swift
//  TorreonVerde
//
//  Created by Sofia on 20/10/26.
//

import Foundation
import SwiftUI

struct TarjetaEstadistica: View {

    let titulo: String
    let cantidad: Int
    let icono: String
    let color: Color

    var body: some View {

        VStack(spacing: 10) {

            Image(systemName: icono)
                .font(.title2)
                .foregroundStyle(color)

            Text("\(cantidad)")
                .font(.system(size: 28, weight: .bold))
                .foregroundStyle(.primary)

            Text(titulo)
                .font(.caption)
                .foregroundStyle(.secondary)
                .lineLimit(1)
                .minimumScaleFactor(0.7)

        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 18)
        .padding(.horizontal, 6)
        .background(
            Color(.secondarySystemGroupedBackground)
        )
        .clipShape(
            RoundedRectangle(cornerRadius: 16)
        )
    }
}
