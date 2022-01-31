//
//  FutureViewController.swift
//  HyojoonWeather
//
//  Created by HL on 2022/01/28.
//

import UIKit

class FutureViewController: UIViewController {
    
    
    @IBOutlet var lblCount: UILabel!
    
    let apiKey: String = "7c6559b7c41b7c70eda1c6f85e1f8fbb"
    let baseUrl: String = "https://api.openweathermap.org/data/2.5/forecast"
    
    var cityId: String?
    var weatherData: Array<CurrentWeather?> = []

    func getData(){
        
        if let cityId = self.cityId {
            let url: URL = URL(string: "\(baseUrl)?id=\(cityId)&appid=\(apiKey)&units=metric&lang=kr")!

            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let jsonData = data {
                    do {
                        
                        let serialized = try JSONSerialization.jsonObject(with: jsonData, options: []) as! Dictionary<String, Any>
                        let list = serialized["list"] as! Array<Dictionary<String, Any>>
                        
                        for element in list {
                            
                            let currentWeather = CurrentWeather()
                            let main = element["main"] as! Dictionary<String, Any>
                            currentWeather.tempMin = "\(main["temp_min"]!)"
                            currentWeather.tempMax = "\(main["temp_max"]!)"
                            currentWeather.humidity = "\(main["humidity"]!)"
                            self.weatherData.append(currentWeather)
                            
                        }
                        
                        DispatchQueue.main.async {
                            self.lblCount.text = "\(list.count)"
                        }
                    } catch {}
                }
            }
            task.resume()

        }
        

    }

    override func viewDidLoad() {
        super.viewDidLoad()

        getData()
    }
}
