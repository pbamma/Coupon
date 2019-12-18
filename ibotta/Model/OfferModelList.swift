//
//  OfferModels.swift
//  ibotta
//
//  Created by Philip Starner on 11/6/19.
//  Copyright © 2019 Philip Starner. All rights reserved.
//

import Foundation

/** An OfferModelList contains an array of OfferModel which is built from Offers.json */
struct OfferModelList: Codable {
    let offers: [OfferModel]?
    
    enum CodingKeys: String, CodingKey {
        case offers = "offers"
    }
    
    /** Codable constructor */
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        offers = try values.decodeIfPresent([OfferModel].self, forKey: .offers)
    }
}
