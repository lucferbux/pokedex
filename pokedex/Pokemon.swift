//
//  Pokemon.swift
//  pokedex
//
//  Created by lucas fernández on 07/07/16.
//  Copyright © 2016 lucas fernandez. All rights reserved.
//

import Foundation

class Pokemon {
    // MARK: - Stored properties
    private var _name: String!
    private var _pokedexId: Int!
    private var _description: String!
    private var _type: [String]!
    private var _defense: String!
    private var _weight: String!
    private var _height: String!
    private var _attack: String!
    private var _nextEvoultionTxt: String!
    
    // MARK: - Computed properties - Getters and Setters
    var name: String {
        return _name
    }
    var pokedexID: Int {
        return _pokedexId
    }
    
    // MARK: - Initializers
    init(name: String, pokedexId: Int) {
        self._name = name
        self._pokedexId = pokedexId
    }
    
}