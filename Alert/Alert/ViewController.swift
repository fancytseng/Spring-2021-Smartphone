//
//  ViewController.swift
//  Alert
//
//  Created by Fancy Tseng on 2/24/21.
//

import UIKit

class ViewController: UIViewController {

    
    var globalTxtField: UITextField?
        
    @IBOutlet weak var lblText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func alertAction(_ sender: UIButton) {
        let alert = UIAlertController(title: "Sample Alert", message: "Message", preferredStyle: .alert)
                
                let OK = UIAlertAction(title: "OK", style: .default) { (alertAction) in
                    print("Ok Pressed")
                    self.lblText.text = self.globalTxtField?.text
                }
                
                let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (alertAction) in
                    print("Cancel Pressed")
                }
                alert.addTextField { (txtField) in
                    txtField.placeholder = "Type Something"
                    self.globalTxtField  = txtField
                }
                
                
                alert.addAction(OK)
                alert.addAction(cancel)
                
                self.present(alert, animated: true, completion: nil)
    }


}

