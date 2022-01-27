//
//  ViewController.swift
//  HyojoonWeather
//
//  Created by HL on 2022/01/27.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var tvListView: UITableView!
    
    let cities: [String] = [
        "공주", "광주", "구미", "군산", "대구",
        "대전", "목포", "부산", "서산", "서울",
        "속초", "수원", "순천", "울산", "익산",
        "전주", "제주", "천안", "청주", "춘천",
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tvListView.dequeueReusableCell(withIdentifier: "type1", for: indexPath) as! Type1
        cell.lblText.text = "\(cities[indexPath.row])"
        return cell
    }
}

