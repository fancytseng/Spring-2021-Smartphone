//
//  CityViewModel.swift
//  WorldWeather
//
//  Created by Fancy Tseng on 3/9/21.
//

import Foundation
import PromiseKit


class WorldWeatherViewModel{
    
    func getCityData(_ url : String) -> Promise<ModelCity> {
        
        return Promise<ModelCity>{ seal ->Void in
            
            getAFResponseJSON(url).done { json in
                
                let key = json["Key"].stringValue
                let city = json["LocalizedName"].stringValue
                let cityModel: ModelCity = ModelCity(key, city)
                
                seal.fulfill(cityModel)
            }
            .catch { error in
                seal.reject(error)
            }
        }
    }
    
    func getCurrentConditions(_ url : String) -> Promise<ModelCurrentCondition>{
        return Promise<ModelCurrentCondition> { seal ->Void in
            
            getAFResponseJSONArray(url).done { currentWeatherJSON in
                
                let weatherText = currentWeatherJSON[0]["WeatherText"].stringValue
                let weatherIcon = currentWeatherJSON[0]["WeatherIcon"].intValue
                let isDayTime = currentWeatherJSON[0]["IsDayTime"].boolValue
                let metricTemp = currentWeatherJSON[0]["Temperature"]["Metric"]["Value"].floatValue
                let imperialTemp = currentWeatherJSON[0]["Temperature"]["Imperial"]["Value"].intValue

                let currCondition = ModelCurrentCondition(weatherText, metricTemp, imperialTemp)
                currCondition.weatherIcon = weatherIcon
                currCondition.isDayTime  = isDayTime
                
                
                seal.fulfill(currCondition)
            
            }
            .catch { error in
                seal.reject(error)
            }
            
        }
    }
    
    func getOneDayConditions(_ url : String) -> Promise<ModelOneDayForecast>{
        return Promise<ModelOneDayForecast> { seal -> Void in
            
            getAFResponseJSON(url).done { json in
                
                let dayForecast = ModelOneDayForecast()
                dayForecast.headlineText = json["Headline"]["Text"].stringValue
                dayForecast.nightTemp = json["DailyForecasts"][0]["Temperature"]["Minimum"]["Value"].intValue
                dayForecast.dayTemp = json["DailyForecasts"][0]["Temperature"]["Maximum"]["Value"].intValue
                dayForecast.dayIcon = json["DailyForecasts"][0]["Day"]["Icon"].intValue
                dayForecast.nightIcon = json["DailyForecasts"][0]["Night"]["Icon"].intValue
                dayForecast.dayIconPhrase = json["DailyForecasts"][0]["Day"]["IconPhrase"].stringValue
                dayForecast.nightIconPhrase = json["DailyForecasts"][0]["Night"]["IconPhrase"].stringValue

                seal.fulfill(dayForecast)
            
            }
            .catch { error in
                seal.reject(error)
            }
            
        }
    }
    
    func getFiveDayConditions(_ url : String) -> Promise<[ModelFiveDayForecast]>{
        return Promise<[ModelFiveDayForecast]> { seal -> Void in
            
            getAFResponseJSON(url).done { json in
                
                guard let jsonArray = json["DailyForecasts"].array else {return}
                
                var fiveDayForecast = [ModelFiveDayForecast]()
                
                for eachDay in jsonArray {
                    let date = eachDay["Date"].stringValue
                    let minTemp = eachDay["Temperature"]["Minimum"]["Value"].intValue
                    let maxTemp = eachDay["Temperature"]["Maximum"]["Value"].intValue
                    let maxIcon = eachDay["Day"]["Icon"].intValue
                    let minIcon = eachDay["Night"]["Icon"].intValue
                    let day = self.getDayOfWeek(date)!
                    print(day)
                    fiveDayForecast.append(ModelFiveDayForecast(date, maxTemp, minTemp, maxIcon, minIcon, day))
                }

                seal.fulfill(fiveDayForecast)
            
            }
            .catch { error in
                seal.reject(error)
            }
            
        }
    }
    var dayArr : [String] = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
    
    func getDayOfWeek(_ today:String) -> String? {
            let formatter  = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ'"
            
            guard let todayDate = formatter.date(from: today) else { return "" }
            
            let myCalendar = Calendar(identifier: .gregorian)
            let weekDay = myCalendar.component(.weekday, from: todayDate)
            return dayArr[weekDay - 1]
    }
    
    
}
