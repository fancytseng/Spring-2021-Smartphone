//
//  TableViewController.swift
//  NetworkCalls
//
//  Created by Fancy Tseng on 3/3/21.
//

import UIKit

class TableViewController: UITableViewController {
    
    var commodityArr : [Commodity] = [Commodity]()
    
    @IBOutlet var tblCommodities: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        getData()
    }
}
