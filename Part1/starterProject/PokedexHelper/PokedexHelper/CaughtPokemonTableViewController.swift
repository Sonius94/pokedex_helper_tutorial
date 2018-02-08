//
//  CaughtPokemonTableViewController.swift
//  PokedexHelper
//
//  Created by Tom Kastek on 07.02.18.
//  Copyright © 2018 Sonius94. All rights reserved.
//

import UIKit

class CaughtPokemonTableViewController: UITableViewController {
    var caughtPokemon: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func addPokemon(_ sender: Any) {
        showAddPokemonAlert()
    }
}

extension CaughtPokemonTableViewController {
    func showAddPokemonAlert() {
        let alert = UIAlertController(title: "New Pokemon", message: "Add a new caught Pokemon", preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Save", style: .default) {
            [unowned self] action in
            guard let textField = alert.textFields?.first, let pokemonName = textField.text else {
                return
            }
            
            self.caughtPokemon.append(pokemonName)
            self.tableView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default)
        
        alert.addTextField()
        alert.addAction(cancelAction)
        alert.addAction(saveAction)
        
        present(alert, animated: true)
    }
}

// MARK: - Table view data source
extension CaughtPokemonTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return caughtPokemon.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CaughtPokemonCell", for: indexPath)
        
        cell.textLabel?.text = caughtPokemon[indexPath.row]
        return cell
    }
}

// MARK: - Navigation
extension CaughtPokemonTableViewController {
    /*
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
}
