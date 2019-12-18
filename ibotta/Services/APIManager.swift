//
//  APIManager.swift
//  ibotta
//
//  Created by Philip Starner on 11/6/19.
//  Copyright © 2019 Philip Starner. All rights reserved.
//

import Foundation
import Alamofire

/** Singleton APIManager */
class APIManager {
    static var sharedInstance = APIManager()
    private let session = Alamofire.Session()

    private init() {}
    
    /**
    Test REST call which yeilds a MealBase

    - Parameter urlString: A url endpoint
    - Parameter searchString: An additional search query to append to urlString
    - Parameter completion: A closure which is called with [OfferViewModel]
     
    - Returns: request @discardable
    */
    @discardableResult
    public func getTestMealJSONData(urlString: String, searchString: String, completion: @escaping (Result<MealBase, AFError>?)->Void) -> Request? {
        
        let fullURLString = urlString + searchString
        guard let url = URL(string: fullURLString) else {
            completion(nil)
            return nil
        }
        
        let request = session.request(url).responseDecodable { (response: DataResponse<MealBase, AFError>) in
            print("Result: \(response.description)")
            completion(response.result)
        }
        
        return request
    }
}


