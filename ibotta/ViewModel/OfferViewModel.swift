//
//  OfferViewModel.swift
//  ibotta
//
//  Created by Philip Starner on 11/6/19.
//  Copyright © 2019 Philip Starner. All rights reserved.
//

import Foundation

class OfferViewModel {
    let id : String?
    let url : String?
    let name : String?
    let description : String?
    let terms : String?
    let currentValueString : String?
    /** Float value calculated from currentValueString*/
    let currentValue: Float?
    /** A means for a user to favorite an item*/
    var favorite = false
    
    /** DI based constructor */
    init(model: OfferModel) {
        self.id = model.id
        self.url = model.url
        self.name = model.name
        self.description = model.description
        self.terms = model.terms
        self.currentValueString = model.currentValue
        self.currentValue = model.currentValue?.parsePrice()
    }
    
    /** Test DI based constructor with a Meal */
    init(model: Meal) {
        self.id = model.idMeal
        self.url = model.strMealThumb
        self.name = model.strMeal
        self.description = model.strMeal
        self.terms = model.strMeal
        self.currentValueString = "$1.50 Cash Back"
        self.currentValue = 1.50
    }
}
