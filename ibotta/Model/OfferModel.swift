//
//  OfferModel.swift
//  ibotta
//
//  Created by Philip Starner on 11/5/19.
//  Copyright © 2019 Philip Starner. All rights reserved.
//

import Foundation

/** An OfferModel is one of several in an array found in OfferModelList which is built from Offers.json */
struct OfferModel : Codable {
	let id : String?
	let url : String?
	let name : String?
	let description : String?
	let terms : String?
	let currentValue : String?

	enum CodingKeys: String, CodingKey {
		case id = "id"
		case url = "url"
		case name = "name"
		case description = "description"
		case terms = "terms"
		case currentValue = "current_value"
	}

    /** Codable constructor */
	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(String.self, forKey: .id)
		url = try values.decodeIfPresent(String.self, forKey: .url)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		description = try values.decodeIfPresent(String.self, forKey: .description)
		terms = try values.decodeIfPresent(String.self, forKey: .terms)
		currentValue = try values.decodeIfPresent(String.self, forKey: .currentValue)
	}
    
    /** Constructor */
    init(id: String?, url: String?, name: String?, description: String?, terms: String?, currentValue: String?) {
        self.id = id
        self.url = url
        self.name = name
        self.description = description
        self.terms = terms
        self.currentValue = currentValue
    }

}
