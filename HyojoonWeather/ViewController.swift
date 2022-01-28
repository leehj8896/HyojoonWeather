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
    
    func getData(_ cityId: String){
        let url: URL = URL(string: "\(baseUrl)?id=\(cityId)&appid=\(apiKey)")!
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let jsonData = data {
                do {
                    let serialized = try JSONSerialization.jsonObject(with: jsonData, options: [])
                    print(serialized)
                } catch {}
            }
        }
        task.resume()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tvListView.dequeueReusableCell(withIdentifier: "cityCell", for: indexPath) as! CityCell
        let name = cities[indexPath.row][0]
        let cityId = cities[indexPath.row][1]
        getData(cityId)
        cell.lblName.text = name
        return cell
    }
}

