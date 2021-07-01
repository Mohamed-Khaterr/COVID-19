//
//  COVIDData.swift
//  COVID-19
//
//  Created by Khater on 6/29/21.
//  Copyright © 2021 Khater. All rights reserved.
//

import Foundation

struct CovidData: Codable {
    let All: All
}
struct All: Codable {
    let confirmed, recovered, deaths, population: Int
    let country: String
    let capitalCity: String
}

