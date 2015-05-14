//
//  ViewController.swift
//  WeatherDemo
//
//  Created by Jai Verma on 13/05/15.
//  Copyright (c) 2015 Jai Verma. All rights reserved.
//

/*
{
"coord": {
"lon": 77.22,
"lat": 28.67
},
"sys": {
"message": 0.0314,
"country": "IN",
"sunrise": 1431388915,
"sunset": 1431437582
},
"weather": [
{
"id": 800,
"main": "Clear",
"description": "sky is clear",
"icon": "02n"
}
],
"base": "stations",
"main": {
"temp": 295.06,
"temp_min": 295.06,
"temp_max": 295.06,
"pressure": 993.48,
"sea_level": 1017.95,
"grnd_level": 993.48,
"humidity": 88
},
"wind": {
"speed": 1.35,
"deg": 195.005
},
"clouds": {
"all": 8
},
"dt": 1431462292,
"id": 1273294,
"name": "Delhi",
"cod": 200
}
*/


import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var cityNameTextField: UITextField!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var cityTempLabel: UILabel!
    
    
    @IBAction func getDataButtonClicked(sender: AnyObject) {
        getWeatherData("http://api.openweathermap.org/data/2.5/weather?q=\(cityNameTextField.text)")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getWeatherData("http://api.openweathermap.org/data/2.5/weather?q=delhi,india")
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getWeatherData(urlString : String) {
        let url = NSURL(string: urlString)
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {(data, response, error) in
            dispatch_async(dispatch_get_main_queue(), {
                self.setLabels(data)
            })
        }
        
        task.resume()
    }
    
    func setLabels(weatherData : NSData) {
        var jsonError : NSError?
        
        let json = NSJSONSerialization.JSONObjectWithData(weatherData, options: nil, error: &jsonError) as! NSDictionary
        
        if let name = json["name"] as? String {
            cityNameLabel.text = name
        }
        
        if let main = json["main"] as? NSDictionary {
            if let temp = main["temp"] as? Double {
                var t = temp - 273
                cityTempLabel.text = String(format: "%.1f", t)
                
            }
        }
    }

}

