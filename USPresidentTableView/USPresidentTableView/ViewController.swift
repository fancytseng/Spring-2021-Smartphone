//
//  ViewController.swift
//  USPresidentTableView
//
//  Created by Fancy Tseng on 2/9/21.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tblView: UITableView!
    
    let names = ["George Washington", "John Adams", "Thomas Jerrferson", "Lyndon B. Johnson", "James Madison", "James Monroe", "John Quincy Adams", "Andrew Jackson"]
        
        override func viewDidLoad() {
            super.viewDidLoad()
            // Do any additional setup after loading the view.
            tblView.delegate = self
            tblView.dataSource = self
        }
        


        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return names.count;
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = names[indexPath.row]
            return cell
        }
    }

