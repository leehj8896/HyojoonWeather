//
//  FutureViewController.swift
//  HyojoonWeather
//
//  Created by HL on 2022/01/28.
//

import UIKit

class FutureViewController: UIViewController {
    
    @IBOutlet var imgChart: UIImageView!
    
    let apiKey: String = "7c6559b7c41b7c70eda1c6f85e1f8fbb"
    let baseUrl: String = "https://api.openweathermap.org/data/2.5/forecast"
    
    var currentWeather: CurrentWeather?
    var futureData: Array<CurrentWeather?> = []
    
    func drawChart() {
        UIGraphicsBeginImageContext(imgChart.frame.size)
//        print("size: \(imgChart.frame.size)")
        let context = UIGraphicsGetCurrentContext()!
        
        context.setLineWidth(4.0)
        context.setStrokeColor(UIColor.gray.cgColor)
        
        let h: CGFloat = imgChart.frame.size.height
        let w: CGFloat = imgChart.frame.size.width
        
        // outside
        context.addLines(between: [CGPoint(x: 0, y: 0), CGPoint(x: 0, y: h)])
        context.addLines(between: [CGPoint(x: 0, y: 0), CGPoint(x: w, y: 0)])
        context.addLines(between: [CGPoint(x: w, y: h), CGPoint(x: w, y: 0)])
        context.addLines(between: [CGPoint(x: w, y: h), CGPoint(x: 0, y: h)])
        
        context.strokePath()
        
        context.setLineWidth(3.0)

        let gap = Float(w) / Float(futureData.count + 2)
        
        var prev: CGPoint?
        var curr: CGPoint?
        
        // 최저기온
        context.setStrokeColor(UIColor.red.cgColor)

        // 시작지점 설정
        if let tempMin = self.futureData[0]?.tempMin {
            let x = Float(0) * gap
            let y = Float(h) - (Float(tempMin)! + 30) * Float(h) / 100
            prev = CGPoint(x: CGFloat(x), y: CGFloat(y))
            curr = CGPoint(x: CGFloat(x), y: CGFloat(y))
        }
        
        // 그리기
        for i in 0 ... futureData.count-1 {
            if let tempMin = self.futureData[i]?.tempMin {
                let x = Float(i) * gap
                let y = Float(h) - (Float(tempMin)! + 30) * Float(h) / 100
                curr = CGPoint(x: CGFloat(x), y: CGFloat(y))
                context.addLines(between: [prev!, curr!])
                prev = curr
            }
        }
        context.strokePath()
        
        
        // 최고기온
        context.setLineWidth(2.0)
        context.setStrokeColor(UIColor.blue.cgColor)

        // 시작지점 설정
        if let tempMax = self.futureData[0]?.tempMax {
            let x = Float(0) * gap
            let y = Float(h) - (Float(tempMax)! + 30) * Float(h) / 100
            prev = CGPoint(x: CGFloat(x), y: CGFloat(y))
            curr = CGPoint(x: CGFloat(x), y: CGFloat(y))
        }
        
        // 그리기
        for i in 0 ... futureData.count-1 {
            if let tempMax = self.futureData[i]?.tempMax {
                let x = Float(i) * gap
                let y = Float(h) - (Float(tempMax)! + 30) * Float(h) / 100
                curr = CGPoint(x: CGFloat(x), y: CGFloat(y))
                context.addLines(between: [prev!, curr!])
                prev = curr
            }
        }
        context.strokePath()
        
        // 습도
        context.setLineWidth(1.0)
        context.setStrokeColor(UIColor.black.cgColor)

        // 시작지점 설정
        if let humidity = self.futureData[0]?.humidity {
            let x = Float(0) * gap
            let y = Float(h) - Float(humidity)! * Float(h) / 100
            prev = CGPoint(x: CGFloat(x), y: CGFloat(y))
            curr = CGPoint(x: CGFloat(x), y: CGFloat(y))
        }
        
        // 그리기
        for i in 0 ... futureData.count-1 {
            if let humidity = self.futureData[i]?.humidity {
                let x = Float(i) * gap
                let y = Float(h) - Float(humidity)! * Float(h) / 100
                curr = CGPoint(x: CGFloat(x), y: CGFloat(y))
                context.addLines(between: [prev!, curr!])
                prev = curr
            }
        }
        context.strokePath()
        
        imgChart.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    }

    func getData(){
        
        futureData.append(self.currentWeather)
        
        if let currentWeather = self.currentWeather {
            let cityId = currentWeather.cityId!
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
                            self.futureData.append(currentWeather)
                            
                        }
                        
                        DispatchQueue.main.async {
                            self.drawChart()
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
