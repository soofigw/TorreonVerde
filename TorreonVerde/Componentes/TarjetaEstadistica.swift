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
                .foregroundStyle(ColoresApp.verdeOscuro)

            Text(titulo)
                .font(.caption)
                .foregroundStyle(ColoresApp.textoSecundario)
                .lineLimit(1)
                .minimumScaleFactor(0.7)

        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 18)
        .padding(.horizontal, 6)
        .background(.white)
        .clipShape(
            RoundedRectangle(cornerRadius: 16)
        )
        .overlay {
            RoundedRectangle(cornerRadius: 16)
                .stroke(
                    ColoresApp.verdeNatural.opacity(0.12),
                    lineWidth: 1
                )
        }
    }
}
