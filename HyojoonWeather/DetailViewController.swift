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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func btnFuture(_ sender: UIButton) {
    }
    
}
