//
//  Stats.swift
//  Dex3
//
//  Created by Jimmy Ghelani on 2023-09-09.
//

import SwiftUI
import Charts

struct Stats: View {
    @EnvironmentObject var pokemon: Pokemon
    
    var body: some View {
        Chart(pokemon.stats) { stat in
            BarMark(
                x: .value("Value", stat.value),
                y: .value("Stat", stat.label)
            )
            .annotation(position: .trailing) {
                Text("\(stat.value)")
                    .font(.subheadline)
                    .padding(.top, -5)
                    .foregroundStyle(.secondary)
            }
        }
        .frame(height: 200)
        .padding([.leading, .bottom, .trailing])
        .foregroundStyle(Color(pokemon.types![0].capitalized))
        .chartXScale(domain: 0...pokemon.highestStat.value + 10)
    }
}

#Preview {
    Stats()
        .environmentObject(SamplePokemon.samplePokemon)
}
