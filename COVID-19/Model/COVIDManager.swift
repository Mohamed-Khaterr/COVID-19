//
//  COVIDManager.swift
//  COVID-19
//
//  Created by Khater on 6/29/21.
//  Copyright © 2021 Khater. All rights reserved.
//

import Foundation

protocol CovidManaderDelegate {
    func DataDidUpdate(confirmed: Int, recovered: Int, deaths: Int, population: Int, country: String, capitalCity: String)
}

struct COVIDManager{
    
    var delegate: CovidManaderDelegate?
    
    func fetchCity(_ city: String){
        
        var stringURL = "https://covid-api.mmediagroup.fr/v1/cases?country=\(city)"
        
        if let range = stringURL.range(of: " ") {
           stringURL.removeSubrange(range)
        }
        
        
        //to convert space in url to %20
//        if let encoded = stringURL.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed),
//            let url = URL(string: encoded){
//
//        }
        
        
        if let url = URL(string: stringURL){
        
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if error != nil{
                    print(error!)
                    return
                }
                
                if let safeData = data{
                    self.parseJSON(safeData)
                }
                
                
            }.resume()
        }
    }
    
    
    func parseJSON(_ data: Data) {
        let decoder = JSONDecoder()
        
        do{
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let decodedData = try decoder.decode(CovidData.self, from: data)
            
            let country = decodedData.All.country
            let capital = decodedData.All.capitalCity
            let confirmed = decodedData.All.confirmed
            let recoverd = decodedData.All.recovered
            let death = decodedData.All.deaths
            let population = decodedData.All.population
            
            delegate?.DataDidUpdate(confirmed: confirmed, recovered: recoverd, deaths: death, population: population, country: country, capitalCity: capital)
        }catch{
            print(error)
        }
    }
}
