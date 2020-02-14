//
//  Pokemon.swift
//  PokedexApp
//
//  Created by mcs on 1/31/20.
//  Copyright © 2020 MCS. All rights reserved.
//

import UIKit

class PokemonModel: Decodable {
    var name: String?
    var gameIndex: Int?
    var description: String?
    var partyIcon: String?
    var animatedIcon: String?
    var types: [String]?
    var stats: [Int]?
}
