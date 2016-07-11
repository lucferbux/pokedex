//
//  ViewController.swift
//  pokedex
//
//  Created by lucas fernández on 07/07/16.
//  Copyright © 2016 lucas fernandez. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate{
    
    // MARK: - Global variables and constants
    
    var pokemon = [Pokemon]()
    var fileteredPokemon = [Pokemon]() //Array for filtered searches
    var audioPlayer: AVAudioPlayer!
    var inSearchMode = false
    

    
    // MARK: - Outlets and Actions
    @IBOutlet weak var collection: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    @IBAction func musicControlAction(sender: UIButton!) {
        if audioPlayer.playing {
            audioPlayer.stop()
            sender.alpha = 0.2
        }else {
            audioPlayer.play()
            sender.alpha = 1.0
        }
    }
    
    
    // MARK: - Life cycle funcs
    override func viewDidLoad() {
        super.viewDidLoad()

        collection.delegate = self
        collection.dataSource = self
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.Done
        collection.keyboardDismissMode = UIScrollViewKeyboardDismissMode.OnDrag
        
        initAudio()
        parsePokemonCSV()
        //hideKeyboardWhenTappedAround()

    }

    // MARK: - Custom functions
    
    
    func parsePokemonCSV() {
        let path = NSBundle.mainBundle().pathForResource("pokemon", ofType: "csv")!
        
        do{
            let csv = try CSV(contentsOfURL: path)
            let rows = csv.rows
            
            for row in rows {
                let pokeId = Int(row["id"]!)!
                let name = row["identifier"]!
                let poke = Pokemon(name: name, pokedexId: pokeId)
                pokemon.append(poke)
            }
            
        }catch let err as NSError {
            print(err.debugDescription)
        }
        
    }
    
    
    func initAudio() {
        let path = NSBundle.mainBundle().pathForResource("music", ofType: "mp3")!
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOfURL: NSURL(string: path)!)
            audioPlayer.prepareToPlay()
            audioPlayer.numberOfLoops = -1
            audioPlayer.play()
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    // MARK: - Collection Protocol functions
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCellWithReuseIdentifier("PokeCell", forIndexPath: indexPath) as? PokeCell {
            
            let poke: Pokemon!
            
            if inSearchMode {
               poke = fileteredPokemon[indexPath.row]
            }else {
               poke = pokemon[indexPath.row]
            }
            cell.configureCell(poke)
            
            return cell
        }
        
        return UICollectionViewCell() //Return a generic if fails
        
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        var poke: Pokemon!
        
        if inSearchMode{
            poke = fileteredPokemon[indexPath.row]
        }else{
            poke = pokemon[indexPath.row]
        }
        
        performSegueWithIdentifier("PokemonDetailVC", sender: poke)
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if inSearchMode{
            return fileteredPokemon.count
        }
        
        return pokemon.count
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        return CGSizeMake(105, 105)
        
    }
    
    // MARK: - Search Delegate functions
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text == nil || searchBar.text == "" {
            inSearchMode = false
            view.endEditing(true)
            collection.reloadData()
        }else {
            inSearchMode = true
            let lower = searchBar.text!.lowercaseString
            fileteredPokemon = pokemon.filter({$0.name.rangeOfString(lower) != nil})
            collection.reloadData()
        }
    }
    
    // MARK: - Segue function
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "PokemonDetailVC" {
            if let detailVC = segue.destinationViewController as? PokemonDetailVC {
                if let poke = sender as? Pokemon {
                    detailVC.pokemon = poke
                }
            }
        }
    }

}




// MARK: - ViewController Extension

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    


}
