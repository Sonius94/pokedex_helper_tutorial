//
//  CaughtPokemonTableViewController.swift
//  PokedexHelper
//
//  Created by Tom Kastek on 07.02.18.
//  Copyright © 2018 Sonius94. All rights reserved.
//

import UIKit
import CoreData

class CaughtPokemonTableViewController: UITableViewController {
    var caughtPokemon: [NSManagedObject] = []

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // PART 1: LOAD POKEMON
        fetchCaughtPokemon()
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
            
            // PART 2: SAVE
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                return
            }
            
            let managedContext = appDelegate.persistentContainer.viewContext
            
            let entity = NSEntityDescription.entity(forEntityName: "Pokemon", in: managedContext)!
            
            let newPokemon = NSManagedObject(entity: entity, insertInto: managedContext)
            newPokemon.setValue(pokemonName, forKey: "name")
            
            do {
                try managedContext.save()
                self.caughtPokemon.append(newPokemon)
            } catch let error {
                print(error)
            }
            
            self.tableView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default)
        
        alert.addTextField()
        alert.addAction(cancelAction)
        alert.addAction(saveAction)
        
        present(alert, animated: true)
    }
    
    func fetchCaughtPokemon() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Pokemon")
        
        do {
            caughtPokemon = try managedContext.fetch(fetchRequest)
        } catch {
            print("that was a fail. Try it another time ;)")
        }
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
        
        // PART 3: ACCES SINGLE POKEMON
        let pokemon = caughtPokemon[indexPath.row]
        cell.textLabel?.text = pokemon.value(forKey: "name") as? String
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
