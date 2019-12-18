//
//  Constants.swift
//  ibotta
//
//  Created by Philip Starner on 11/6/19.
//  Copyright © 2019 Philip Starner. All rights reserved.
//

import Foundation
import UIKit

/** Application Constants */
struct Constants {
    enum API: String {
        //A test API endpoint
        case baseURL = "https://www.themealdb.com/api/json/v1/1/filter.php?"
    }
    
    struct AppColors {
        static let companyPink = UIColor(red: 233/255.0, green: 63/255.0, blue: 120/255.0, alpha: 1)
        static let companyGreen = UIColor(red: 46/255.0, green: 187/255.0, blue: 166/255.0, alpha: 1)
        static let backgroundColor = UIColor.init(red: 220/255.0, green: 220/255.0, blue: 220/255.0, alpha: 1)
        static let cellTextColor = UIColor(red: 74/255.0, green: 74/255.0, blue: 74/255.0, alpha: 1.0)
    }
    
}
