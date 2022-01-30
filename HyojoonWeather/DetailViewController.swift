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
    @IBOutlet var lblFeelLike: UILabel!
    @IBOutlet var lblHumidity: UILabel!
    @IBOutlet var lblTempMin: UILabel!
    @IBOutlet var lblTempMax: UILabel!
    @IBOutlet var lblPressure: UILabel!
    @IBOutlet var lblWind: UILabel!
    @IBOutlet var lblDescription: UILabel!
    @IBOutlet var imgIcon: UIImageView!
    
//    var name: String?
//    var temp: String?
//    var feelLike: String?
//    var humidity: String?
//    var tempMin: String?
//    var tempMax: String?
//    var pressure: String?
//    var wind: String?
//    var description: String?
//    var iconUrl: String?
    var currentWeather: CurrentWeather?

    override func viewDidLoad() {
        super.viewDidLoad()

//        if let data = test{
//            DispatchQueue.main.async {
//                self.lblName.text = data
//            }
//        }
    }
    

    @IBAction func btnFuture(_ sender: UIButton) {
    }
    
}
