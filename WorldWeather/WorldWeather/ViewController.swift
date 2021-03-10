//
//  ViewController.swift
//  WorldWeather
//
//  Created by Fancy Tseng on 3/9/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var lblHelloWorld: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initializeText()
    }
    
    func initializeText(){
        lblHelloWorld.text = strHelloWorld
       }

}

