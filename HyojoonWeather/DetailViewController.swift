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
                self.lblTemp.text = currentWeather.temperature
                self.lblFeelsLike.text = currentWeather.feelsLike
                self.lblHumidity.text = currentWeather.humidity
                self.lblTempMin.text = currentWeather.tempMin
                self.lblTempMax.text = currentWeather.tempMax
                self.lblPressure.text = currentWeather.pressure
                self.lblWindSpeed.text = currentWeather.windSpeed
                self.lblDescription.text = currentWeather.description
                
                do {
                    let url = URL(string: currentWeather.iconUrl!)
                    let data = try Data(contentsOf: url!)
                    self.imgIcon.image = UIImage(data: data)
                } catch  {}
            }
        }
    }
    

    @IBAction func btnFuture(_ sender: UIButton) {
    }
    
}
