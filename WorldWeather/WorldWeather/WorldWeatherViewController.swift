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
class WorldWeatherViewController: UIViewController, CLLocationManagerDelegate, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var currentIcon: UIImageView!
    
    @IBOutlet weak var currentHIcon: UIImageView!
    
    @IBOutlet weak var currentLIcon: UIImageView!
    
    var fiveDayArr : [ModelFiveDayForecast] = [ModelFiveDayForecast]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fiveDayArr.count

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("TableViewCell", owner: self, options: nil)?.first as! TableViewCell
        cell.lblDayOfWeek.text = fiveDayArr[indexPath.row].day
        cell.lblMaxTemp.text = "\(fiveDayArr[indexPath.row].maxTemp)"
        cell.lblMinTemp.text = "\(fiveDayArr[indexPath.row].minTemp)"
        cell.icon.image = UIImage(named: "\(fiveDayArr[indexPath.row].maxIcon)-s")
        cell.iconMin.image = UIImage(named: "\(fiveDayArr[indexPath.row].minIcon)-s")
        return cell
    }

    @IBOutlet weak var lblCity: UILabel!
    
    @IBOutlet weak var lblCondition: UILabel!
    
    @IBOutlet weak var lblTemperature: UILabel!
    
    @IBOutlet weak var lblHighLow: UILabel!
    
    @IBOutlet weak var lblTable: UITableView!
    
    let locationManager = CLLocationManager()
    
    // We need to have a class of View Model
    let viewModel = WorldWeatherViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeText()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        lblTable.delegate = self
        lblTable.dataSource = self
    }
    
    func initializeText(){
        self.title = strWorldWeather
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
        
        if let currLocation = locations.last{
            
            let lat = currLocation.coordinate.latitude
            let lng = currLocation.coordinate.longitude
            
            print(lat)
            print(lng)
            updateWeatherData(lat, lng)
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
            let oneDayForecastURL = getOneDayURL(key)
            
            let fiveDayForecastURL = getFiveDayURL(key)
            
            self.viewModel.getCurrentConditions(currentConditionURL).done { currCondition in
                self.lblCondition.text = currCondition.weatherText
                self.lblTemperature.text =  "\(currCondition.imperialTemp)°"
                //Add current temp icon
                self.currentIcon.image = UIImage(named: "\(currCondition.weatherIcon)-s")
            }.catch { error in
                print("Error in getting current conditions \(error.localizedDescription)")
            }
            
            self.viewModel.getOneDayConditions(oneDayForecastURL).done { oneDay in
                self.lblHighLow.text = "H: \(oneDay.dayTemp)° L: \(oneDay.nightTemp)°"
                //Add current H and L icon
                self.currentHIcon.image = UIImage(named: "\(oneDay.dayIcon)-s")
                self.currentLIcon.image = UIImage(named: "\(oneDay.nightIcon)-s")
            }.catch { error in
                print("Error in getting one day forecast conditions \(error.localizedDescription)")
            }
            self.viewModel.getFiveDayConditions(fiveDayForecastURL).done { fiveDay in
                self.fiveDayArr = [ModelFiveDayForecast]()
                
                for eachDay in fiveDay{
                    self.fiveDayArr.append(eachDay)
                }
                self.lblTable.reloadData()
            }.catch { error in
                print("Error in getting five-day forecast conditions \(error.localizedDescription)")
            }
        }
        .catch { error in
            print("Error in getting City Data \(error.localizedDescription)")
        }
    }
}
