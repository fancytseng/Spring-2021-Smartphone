//
//  TableViewCell.swift
//  WorldWeather
//
//  Created by Fancy Tseng on 3/10/21.
//

import UIKit

class TableViewCell: UITableViewCell {

    
    @IBOutlet weak var lblDayOfWeek: UILabel!
    
    @IBOutlet weak var lblMaxTemp: UILabel!
    
    @IBOutlet weak var lblMinTemp: UILabel!
    
    @IBOutlet weak var icon: UIImageView!
    
    @IBOutlet weak var iconMin: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
