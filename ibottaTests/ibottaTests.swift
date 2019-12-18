//
//  ibottaTests.swift
//  ibottaTests
//
//  Created by Philip Starner on 11/5/19.
//  Copyright © 2019 Philip Starner. All rights reserved.
//

import XCTest

class ibottaTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testOfferViewModel() {
        let model = OfferModel(id: "110581", url: "https://product-images.ibotta.com/offer/QrsVNeBv_MI8_05GindVfQ-normal.png", name:
            "Scotch-Brite® Scrub Dots Non-Scratch Dishwand", description: "Non-Scratch variety only - 1 ct. pack", terms: "Rebate valid on Scotch-Brite® Scrub Dots Dishwand for Non-Scratch variety only, 1 ct. pack.", currentValue: "$0.752 Cash Back")
        let viewModel = OfferViewModel(model: model)
        
        XCTAssertEqual(viewModel.currentValue, 0.75, "test of OfferViewModel currentValue")
        XCTAssertEqual(viewModel.currentValueString, "$0.752 Cash Back", "test of OfferViewModel currentValueString")
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
