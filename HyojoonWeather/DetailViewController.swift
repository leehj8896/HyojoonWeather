//
//  DetailViewController.swift
//  HyojoonWeather
//
//  Created by HL on 2022/01/28.
//

import UIKit

class DetailViewController: UIViewController {
    
    
    @IBOutlet var lblName: UILabel!
    @IBOutlet var lblTemp: UILabel!
    @IBOutlet var lblFeelsLike: UILabel!
    @IBOutlet var lblHumidity: UILabel!
    @IBOutlet var lblTempMin: UILabel!
    @IBOutlet var lblTempMax: UILabel!
    @IBOutlet var lblPressure: UILabel!
    @IBOutlet var lblWindSpeed: UILabel!
    @IBOutlet var lblDescription: UILabel!
    @IBOutlet var imgIcon: UIImageView!
    
    var currentWeather: CurrentWeather?

    override func viewDidLoad() {
        super.viewDidLoad()

        if let currentWeather = self.currentWeather {
            DispatchQueue.main.async {
                self.lblName.text = currentWeather.cityName
                self.lblTemp.text = "\(currentWeather.temperature!) ºC"
                self.lblFeelsLike.text = "\(currentWeather.feelsLike!) ºC"
                self.lblHumidity.text = "\(currentWeather.humidity!) %"
                self.lblTempMin.text = "\(currentWeather.tempMin!) ºC"
                self.lblTempMax.text = "\(currentWeather.tempMax!) ºC"
                self.lblPressure.text = "\(currentWeather.pressure!) hPa"
                self.lblWindSpeed.text = "\(currentWeather.windSpeed!) m/s"
                self.lblDescription.text = currentWeather.description!
                print(currentWeather.feelsLike!)
                print(currentWeather.tempMax!)
                
                do {
                    let url = URL(string: currentWeather.iconUrl!)
                    let data = try Data(contentsOf: url!)
                    self.imgIcon.image = UIImage(data: data)
                } catch  {}
            }
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let segueId = segue.identifier, segueId == "sgFuture" {
            if let futureViewController = segue.destination as? FutureViewController {
                
                futureViewController.currentWeather = currentWeather
                
            }
        }
    }
}
