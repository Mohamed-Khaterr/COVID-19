//
//  ViewController.swift
//  COVID-19
//
//  Created by Khater on 6/27/21.
//  Copyright © 2021 Khater. All rights reserved.
//

import UIKit

class ViewController: UIViewController{
   
    

    @IBOutlet weak var searchTextField: UITextField!
    
    
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var confirmedLabel: UILabel!
    @IBOutlet weak var recoveredLabel: UILabel!
    @IBOutlet weak var deathLabel: UILabel!
    @IBOutlet weak var populationLabel: UILabel!
    
    var covidManager = COVIDManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchTextField.delegate = self
        covidManager.delegate = self
    }

    @IBAction func locationPressed(_ sender: UIButton) {
    }

    
}


//MARK: - CovidManagerDelegate
extension ViewController: CovidManaderDelegate{
    
    func DataDidUpdate(confirmed: Int, recovered: Int, deaths: Int, population: Int, country: String, capitalCity: String) {
        DispatchQueue.main.async {
            self.countryLabel.text = country
            self.cityLabel.text = capitalCity
            self.confirmedLabel.text = "\(confirmed)"
            self.recoveredLabel.text = "\(recovered)"
            self.deathLabel.text = "\(deaths)"
            self.populationLabel.text = "\(population)"
        }
        
    }
}


//MARK: - UITextFieldDelegate

extension ViewController: UITextFieldDelegate {
    
    @IBAction func searchPressed(_ sender: UIButton) {
        searchTextField.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if searchTextField.text == ""{
            searchTextField.placeholder = "Type Country"
            return false
        }else{
            searchTextField.placeholder = "Search Country"
            return true
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if let city = searchTextField.text {
            covidManager.fetchCity(city)
        }
    }
    
    
}
