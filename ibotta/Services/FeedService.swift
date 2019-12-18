//
//  FeedService.swift
//  ibotta
//
//  Created by Philip Starner on 11/6/19.
//  Copyright © 2019 Philip Starner. All rights reserved.
//

import Foundation
import Alamofire

public class FeedService {
    
    /**
    Build an [OfferViewModel]? from a REST call which yeilds a MealBase

    - Parameter completion: A closure which is called with [OfferViewModel]
     
    - Returns: no return
    */
    func fetchTestMealFeed(completion: @escaping ([OfferViewModel]?) -> Void) {
        let searchString = "a=american"
        let request = APIManager.sharedInstance.getTestMealJSONData(urlString: Constants.API.baseURL.rawValue, searchString: searchString) { (result: Result<MealBase, AFError>?) in

            switch result {
            case .success(let mealBase):
                //build view model from model
                let offersViewModel = self.buildViewModel(from: mealBase)
                completion(offersViewModel)
            case .failure(let error):
                print(error.localizedDescription)
                completion(nil)
            default:
                print("Unkown request error.")
                completion(nil)
            }
        }

        print("request: " + request.debugDescription)
    }

    /**
    Return an [OfferViewModel]? from an OfferModelList

    - Returns: A populated [OfferViewModel]?
    */
    func buildViewModel(from offerModelList: OfferModelList) -> [OfferViewModel]? {
        var vmFeed = [OfferViewModel]()

        guard let offers = offerModelList.offers else {
            return nil
        }

        for offer in offers {
            let vmItem = OfferViewModel(model: offer)
            vmFeed.append(vmItem)
        }
        
        return vmFeed
    }
    
    /**
    Return an [OfferViewModel]? from an MealBase

    - Returns: A populated [OfferViewModel]?
    */
    func buildViewModel(from mealBase: MealBase) -> [OfferViewModel]? {
        var vmFeed = [OfferViewModel]()

        guard let meals = mealBase.meals else {
            return nil
        }

        for meal in meals {
            let vmItem = OfferViewModel(model: meal)
            vmFeed.append(vmItem)
        }
        
        return vmFeed
    }
    
    
    // MARK: - Mock
    
    
    /**
    A mocked means to load a json file as if it were coming from a REST call

    - Returns: A decoded [OfferViewModel]?
    */
    func fetchMockFeed( completion: @escaping ([OfferViewModel]?) -> Void) {
        DispatchQueue.global().async {
            sleep(2) // made up response time
            DispatchQueue.main.async {
                completion(self.getMockFeedData(jsonFileName: "Offers.json"))
            }
        }
    }
    
    /**
    Load an [OfferViewModel] from the application bundle via a json file
    
    - Warning: Offers.json must be part of the application bundle found in the MockData folder

    - Returns: A decoded [OfferViewModel]?
    */
    private func getMockFeedData(jsonFileName: String) -> [OfferViewModel]? {
        let offerModelList = Bundle.main.decode(OfferModelList.self, from: jsonFileName)
        
        return buildViewModel(from: offerModelList)
    }
}



