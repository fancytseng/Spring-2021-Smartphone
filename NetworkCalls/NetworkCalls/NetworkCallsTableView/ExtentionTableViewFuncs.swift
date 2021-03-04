//
//  ExtentionTableViewFuncs.swift
//  NetworkCalls
//
//  Created by Fancy Tseng on 3/3/21.
//

import UIKit

extension TableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return commodityArr.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("CommodityTableViewCell", owner: self, options: nil)?.first as! CommodityTableViewCell

        cell.lblName.text = "\(commodityArr[indexPath.row].name) "
        
        cell.lblPrice.text = "$\(commodityArr[indexPath.row].price)"

        return cell
    }
}
