//
//  OfferSpec.swift
//  ibottaTests
//
//  Created by Philip Starner on 12/16/19.
//  Copyright © 2019 Philip Starner. All rights reserved.
//

import Quick
import Nimble

class OfferSpec: QuickSpec {
    override func spec() {
        var model: OfferModel!
        var vmodel: OfferViewModel!
        
        describe("The 'OfferViewModel'") {
            context("after being parsed from an OfferModel") {
                afterEach {
                    model = nil
                }
                
                if let path = Bundle(for: type(of: self)).path(forResource: "Offer", ofType: "json") {
                    do {
                        let data = try Data(contentsOf: URL(fileURLWithPath: path))
                        let decoder = JSONDecoder()
                        model = try decoder.decode(OfferModel.self, from: data)
                        vmodel = OfferViewModel(model: model)
                    } catch {
                        fail("Problem parsing JSON")
                    }
                }
            
                it("Can parse the correct currentValueString") {
                    expect(vmodel.currentValueString).to(equal("$0.75 Cash Back"))
                }
                it("Can parse the correct currentValue") {
                    expect(vmodel.currentValue).to(equal(0.75))
                }
            }
        }
    }
}
