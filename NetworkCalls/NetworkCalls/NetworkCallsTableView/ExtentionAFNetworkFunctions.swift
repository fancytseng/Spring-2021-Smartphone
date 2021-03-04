//
//  ExtentionAFNetworkFunction.swift
//  NetworkCalls
//
//  Created by Fancy Tseng on 3/3/21.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON
import SwiftSpinner
import PromiseKit

extension TableViewController {
    
    // MARK : Get URL for all the Commodities
    func getURL() -> String {
        
        return apiURL + apiKey
    }
    
    // MARK: Get data for all the commodities
    func getData() {
        // Get url for the commodity
        let url = getURL();
        
        getQuickShortQuote(url)
            .done{ (commodities) in
                self.commodityArr = [Commodity]()
                for commodity in commodities {
                    self.commodityArr.append(commodity)
                }
                self.tblCommodities.reloadData()
        }
            .catch { (error) in
                print("Error in getting all the commodity values \(error)")
            }
    } // end of function
    
    func getQuickShortQuote(_ url : String) -> Promise<[Commodity]> {
        
        return Promise<[Commodity]> { seal -> Void in
            
            SwiftSpinner.show("Getting Commodity Name and Price")
            AF.request(url).responseJSON { response in
                SwiftSpinner.hide()
                if response.error == nil {
                    
                    var arr = [Commodity]()
                    guard let data = response.data else {return seal.fulfill( arr ) }
                    guard let commodities = JSON(data).array else {
                        return seal.fulfill( arr ) }
                    
                    if commodities.count == 0 {
                        return
                    }
                    
                    for commodity in commodities {
                        
                        let name = commodity["name"].stringValue
                        let price = commodity["price"].floatValue
          
                        let commodity = Commodity(name : name, price : price)
                        commodity.name = name
                        commodity.price = price
                        arr.append(commodity)
                    }
                    
                    seal.fulfill( arr)
                    
                }
                else {
                    seal.reject(response.error!)
                }
            }// end of AF request
        }// end of Promise return
        
    } // end of function
}

