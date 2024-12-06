//
//  Exercise.swift
//  Care4Senior
//
//  Created by Aneesha on 16/02/24.
//

import Foundation

struct Exercise: Codable {
    let distance: [Double]
    let steps: [Int]
    let heartPoints, energyExpanded: [Double]

    enum CodingKeys: String, CodingKey {
        case distance = "Distance"
        case steps = "Steps"
        case heartPoints = "Heart Points"
        case energyExpanded = "Energy Expanded"
    }
}
