//
//  ViewController.swift
//  HyojoonWeather
//
//  Created by HL on 2022/01/27.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var tvListView: UITableView!
    
    let apiKey: String = "7c6559b7c41b7c70eda1c6f85e1f8fbb"
    let baseUrl: String = "https://api.openweathermap.org/data/2.5/weather"
    let imgBaseUrl: String = "https://openweathermap.org/img/wn/"
    
    let cities: [[String]] = [
        ["공주", "1842616"],
        ["광주", "1841808"],
        ["구미", "1842225"],
        ["군산", "1842025"],
        ["대구", "1835327"],
        ["대전", "1835224"],
        ["목포", "1841066"],
        ["부산", "1838519"],
        ["서산", "1835895"],
        ["서울", "1835847"],
        ["속초", "1836553"],
        ["수원", "1835553"],
        ["순천", "1835648"],
        ["울산", "1833742"],
        ["익산", "1843491"],
        ["전주", "1845457"],
        ["제주", "1846266"],
        ["천안", "1845759"],
        ["청주", "1845604"],
        ["춘천", "1845136"],
    ]
    
    var weatherData: Array<CurrentWeather?> = Array(repeating: nil, count: 20)
    var count = 0
    
    func getData() {
        
        for i in 0...19 {
            let cityId = cities[i][1]
            let url: URL = URL(string: "\(baseUrl)?id=\(cityId)&appid=\(apiKey)&units=metric&lang=kr")!

            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let jsonData = data {
                    do {
                        
                        let currentWeather = CurrentWeather()
                        
                        currentWeather.cityName = self.cities[i][0]
                        currentWeather.cityId = self.cities[i][1]
                        
                        let serialized = try JSONSerialization.jsonObject(with: jsonData, options: []) as! Dictionary<String, Any>
                        
                        let main = serialized["main"] as! Dictionary<String, Any>
                        currentWeather.temperature = "\(main["temp"]!)"
                        currentWeather.humidity = "\(main["humidity"]!)"
                        currentWeather.feelsLike = "\(main["feels_like"]!)"
                        currentWeather.pressure = "\(main["pressure"]!)"
                        currentWeather.tempMin = "\(main["temp_min"]!)"
                        currentWeather.tempMax = "\(main["temp_max"]!)"
                        
                        let weather = serialized["weather"] as! Array<Dictionary<String, Any>>
                        currentWeather.description = "\(weather[0]["description"]!)"
                        currentWeather.iconUrl = "\(self.imgBaseUrl)\(weather[0]["icon"]!).png"
                        
                        let wind = serialized["wind"] as! Dictionary<String, Any>
                        currentWeather.windSpeed = "\(wind["speed"]!)"

                        self.weatherData[i] = currentWeather
                        
//                        print("Request: \(i)")
                        self.count += 1
                        if self.count == 20 {
                            DispatchQueue.main.async {
                                print("Request Complete")
                                self.tvListView.reloadData()
                            }
                        }
                    } catch {}
                }
            }
            task.resume()

        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let segueId = segue.identifier, segueId == "sgDetail" {
            if let detailViewController = segue.destination as? DetailViewController {
                
                if let indexPath = tvListView.indexPathForSelectedRow {
                    detailViewController.currentWeather = weatherData[indexPath.row]
                }
                
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tvListView.dequeueReusableCell(withIdentifier: "cityCell", for: indexPath) as! CityCell
        
        if let currentWeather = self.weatherData[indexPath.row] {
            cell.lblName.text = currentWeather.cityName!
            cell.lblTemperature.text = currentWeather.temperature!
            cell.lblHumidity.text = currentWeather.humidity!
            do {
                let url = URL(string: currentWeather.iconUrl!)
                let data = try Data(contentsOf: url!)
                cell.imgIcon.image = UIImage(data: data)
            } catch  {}
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}

