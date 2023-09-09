//
//  PokemonViewModel.swift
//  Dex3
//
//  Created by Jimmy Ghelani on 2023-09-08.
//

import Foundation

@MainActor
class PokemonViewModel: ObservableObject {
    enum Status {
        case notStarted
        case fetching
        case success
        case failed(error: Error)
    }
    
    @Published private(set) var status = Status.notStarted
    
    private let controller: FetchController
    
    init(controller: FetchController) {
        self.controller = controller
        Task {
            await getPokemon()
        }
    }
    
    private func getPokemon() async {
        self.status = .fetching
        
        do {
            guard var pokedex = try await controller.fetchAllPokemon() else {
                print("Pokemon have already been got. We good.")
                status = .success
                return
            }
            
            pokedex.sort { $0.id < $1.id }
            
            for pokemon in pokedex {
                let newPokemon = Pokemon(context: PersistenceController.shared.container.viewContext)
                newPokemon.id = Int16(pokemon.id)
                newPokemon.name = pokemon.name
                newPokemon.attack = Int16(pokemon.attack)
                newPokemon.defense = Int16(pokemon.defense)
                newPokemon.hp = Int16(pokemon.hp)
                newPokemon.types = pokemon.types
                
                newPokemon.organizeTypes()
                
                newPokemon.specialAttack = Int16(pokemon.specialAttack)
                newPokemon.specialDefense = Int16(pokemon.specialDefense)
                newPokemon.sprite = pokemon.sprite
                newPokemon.shiny = pokemon.shiny
                newPokemon.speed = Int16(pokemon.speed)
                newPokemon.favorite = false
                
                try PersistenceController.shared.container.viewContext.save()
            }
            status = .success
        } catch {
            status = .failed(error: error)
        }
    }
}
