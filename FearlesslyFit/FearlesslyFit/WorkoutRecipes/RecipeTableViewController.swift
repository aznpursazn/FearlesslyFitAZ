//
//  RecipeTableViewController.swift
//  FearlesslyFit
//
//  Created by Kathy Nguyen on 11/27/18.
//  Copyright © 2018 Kathy Nguyen. All rights reserved.
//

import UIKit

class RecipeTableViewController: UITableViewController {

    @IBOutlet var recipesTable: UITableView!
    
    var recipeInfo:recipes = recipes()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return recipeInfo.getCount()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recipe", for: indexPath) as! RecipeTableViewCell
        let recipe = recipeInfo.getInfo(row: indexPath.row)
        cell.recipeImage.image = recipe.image
        cell.recipeTitle.text = recipe.name
        return cell
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if(segue.identifier == "detailedRecipe") {
            let selectedIndex: IndexPath = self.recipesTable.indexPath(for: sender as! UITableViewCell)!
            
            let recipe = recipeInfo.getInfo(row: selectedIndex.row)
            
            if let viewController: RViewController = segue.destination as? RViewController {
                viewController.fi = recipe.image
                viewController.nr = recipe.name
                viewController.ing = recipe.ingredients
                viewController.ins = recipe.instructions
            }
        }
    }

}
