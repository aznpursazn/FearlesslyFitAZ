//
//  WorkoutTableViewController.swift
//  FearlesslyFit
//
//  Created by Kathy Nguyen on 11/27/18.
//  Copyright © 2018 Kathy Nguyen. All rights reserved.
//

import UIKit

class WorkoutTableViewController: UITableViewController {

    @IBOutlet var workoutsTable: UITableView!
    
    var workInfo:workouts = workouts()
    
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
        return workInfo.getCount()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "workout", for: indexPath) as! WorkoutTableViewCell
        var workout = workInfo.getInfo(row: indexPath.row)
        cell.workoutTitle.text = workout.name
        return cell
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if(segue.identifier == "detailedWorkout") {
            let selectedIndex: IndexPath = self.workoutsTable.indexPath(for: sender as! UITableViewCell)!
            
            let workout = workInfo.getInfo(row: selectedIndex.row)
            
            if let viewController: WViewController = segue.destination as? WViewController {
                viewController.nw = workout.name
                viewController.lvl = workout.level
                viewController.instr = workout.instructions
            }
        }
    }
}
