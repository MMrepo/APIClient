//
//  ViewController.swift
//  APIClient
//
//  Created by Mateusz Małek on 07.02.2016.
//  Copyright © 2016 Mateusz Małek. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func getWeatherForLondonPressed(sender: AnyObject) {
        
        APIClient.getWeatherFromCityNamed("London").then {[weak self] (weather) in
            self?.setWeather(weather)
        }.error { (error) -> Void in
                print("error: \(error.message())")
        }
    }
    @IBAction func getWeatherForCityIDPressed(sender: AnyObject) {
        
        APIClient.getWeatherFromCityWithID("2172797").then {[weak self] (weather) in
            self?.setWeather(weather)
        }.error { (error) -> Void in
                print("error: \(error.message())")
        }
    }
    
    private func setWeather(weather:Weather) {
        mainLabel.text = weather.main
        descriptionLabel.text = weather.description
        if let temp = weather.temp {
            tempLabel.text = "\(temp  - 273.15)"
        }
    }
}

