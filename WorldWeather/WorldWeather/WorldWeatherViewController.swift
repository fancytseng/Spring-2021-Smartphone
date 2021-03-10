//
//  ViewController.swift
//  WorldWeather
//
//  Created by Fancy Tseng on 3/9/21.
//

import UIKit
import CoreLocation
import Alamofire
import SwiftSpinner
import SwiftyJSON
import PromiseKit

//UI view part
class WorldWeatherViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var lblCity: UILabel!
    
    @IBOutlet weak var lblCondition: UILabel!
    
    @IBOutlet weak var lblTemperature: UILabel!
    
    @IBOutlet weak var lblHighLow: UILabel!
    
    let locationManager = CLLocationManager()
        
        // We need to have a class of View Model
        let viewModel = WorldWeatherViewModel()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            initializeText()
            locationManager.delegate = self
            // ask the user when we request the location of the user
            locationManager.requestWhenInUseAuthorization()
            locationManager.requestLocation()
        }
        
        func initializeText(){
            self.title = strHelloWorld
            lblCity.text = strCity
            lblCondition.text = strCondition
            lblTemperature.text = strTemperature
            lblHighLow.text = strHighLow
        }
        
        //MARK: Location Manager functions
        func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
            print(error.localizedDescription)
        }
        
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            
            // I am moving, so I will get the last location
            if let currLocation = locations.last{
                
                let lat = currLocation.coordinate.latitude
                let lng = currLocation.coordinate.longitude
 
                updateWeatherData(lat, lng)
                
//                let url = getLocationURL(lat, lng)
//                print(url)
            }
        }
        
        
    //MARK: Update the weather from ViewModel
        
    func updateWeatherData(_ lat : CLLocationDegrees, _ lng : CLLocationDegrees){
            
            let cityDataURL = getLocationURL(lat, lng)
            
            viewModel.getCityData(cityDataURL).done { city in
                // Update City Name
                self.lblCity.text = city.cityName
                
                let key = city.cityKey
                
                let currentConditionURL = getCurrentConditionURL(key)
                let fiveDayForecastURL = getFiveDayURL(key)
                
                
                self.viewModel.getCurrentConditions(currentConditionURL).done { currCondition in
                    self.lblCondition.text = currCondition.weatherText
                    self.lblTemperature.text =  "\(currCondition.imperialTemp)°"
                }.catch { error in
                    print("Error in getting current conditions \(error.localizedDescription)")
                }
                
                self.viewModel.getFiveDayConditions(fiveDayForecastURL).done { oneDay in
                    self.lblHighLow.text = "H: \(oneDay.dayTemp)° L: \(oneDay.nightTemp)°"
                    
                }.catch { error in
                    print("Error in getting five day forecast conditions \(error.localizedDescription)")
                }
            }
            .catch { error in
                print("Error in getting City Data \(error.localizedDescription)")
            }
        }
    }
