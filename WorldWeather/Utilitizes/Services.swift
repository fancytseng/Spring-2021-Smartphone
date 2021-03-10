//
//  Services.swift
//  WorldWeather
//
//  Created by Fancy Tseng on 3/9/21.
//

import Foundation
import Alamofire
import SwiftyJSON
import PromiseKit

// return a JSON array
func getAFResponseJSONArray(_ url : String) -> Promise<[JSON]>{
    
    //fulfill or reject
    return Promise<[JSON]>{ seal -> Void in
        
        AF.request(url).responseJSON{ response in
            
            // If there was an error, we will reject the promise
            if response.error != nil {
                seal.reject(response.error!)
            }
            
            // get the JSON array and fulfill the promise
            let jsonArray: [JSON] = JSON(response.data).arrayValue
            seal.fulfill(jsonArray)
        }

    }
}


func getAFResponseJSON(_ url : String) -> Promise<JSON> {
    return Promise<JSON> { seal -> Void in
        
        AF.request(url).responseJSON { response in
            // If there was an error, we will reject the promise
            if response.error != nil {
                seal.reject(response.error!)
            }
            
            // get the JSON array and fulfill the promise
            let json: JSON = JSON(response.data)
            seal.fulfill(json)
        }
    }
}
