//
//  Extensions.swift
//  WeatherIconApp
//
//  Created by iosdev on 7.4.2023.
//

import Foundation

//rounds the temperature fetched from the Weather API
extension Double {
    func roundDouble() -> String {
        return String(format: "%.0f", self)
    }
}
