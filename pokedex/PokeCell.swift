//
//  PokeCell.swift
//  pokedex
//
//  Created by lucas fernández on 07/07/16.
//  Copyright © 2016 lucas fernandez. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {
    
    // MARK: - @IBOutlet
    @IBOutlet weak var thumbImg: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    
    // MARK: - Variables and constants
    var pokemon: Pokemon!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.cornerRadius = 5.0
    }
    
    func configureCell(pokemon: Pokemon){
        self.pokemon = pokemon
        
        nameLbl.text = self.pokemon.name.capitalizedString
        thumbImg.image = UIImage(named: "\(self.pokemon.pokedexID)")
    }
    
    
    
    
}
