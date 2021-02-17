//
//  TableViewController.swift
//  TableViewXib
//
//  Created by Fancy Tseng on 2/17/21.
//

import UIKit

class TableViewController: UITableViewController {

    let cities = ["Sesttle", "Portland", "SFO", "LA", "Diego", "NY", "Miami", "Colorado", "Austin"]
    let values = ["46", "48", "61F", "57", "63", "30", "77", "16", "30"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return cities.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("TableViewCell", owner: self, options: nil)?.first as! TableViewCell
        cell.lblCity.text = cities[indexPath.row]
        cell.lblValue.text = values[indexPath.row] + "F"
        return cell
    }
   
}
