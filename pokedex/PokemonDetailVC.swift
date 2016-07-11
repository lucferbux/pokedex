//
//  PokemonDetailVC.swift
//  pokedex
//
//  Created by lucas fernández on 10/07/16.
//  Copyright © 2016 lucas fernandez. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {
    
    // MARK: - Variables and Constants
    var pokemon: Pokemon!
    
    // MARK: - Functions and IBOutlets
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var mainImg: UIImageView!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var defenseLbl: UILabel!
    @IBOutlet weak var heightLbl: UILabel!
    @IBOutlet weak var pokemonIdLbl: UILabel!
    @IBOutlet weak var weightLbl: UILabel!
    @IBOutlet weak var attackLbl: UILabel!
    @IBOutlet weak var nextEvlLbl: UILabel!
    @IBOutlet weak var currentEvoLbl: UIImageView!
    @IBOutlet weak var nextEvoLbl: UIImageView!
    
    
    
    @IBAction func btnBackPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        nameLbl.text = pokemon.name
    }
    
    
}
