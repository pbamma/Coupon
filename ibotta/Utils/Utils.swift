//
//  Utils.swift
//  ibotta
//
//  Created by Philip Starner on 11/6/19.
//  Copyright © 2019 Philip Starner. All rights reserved.
//

import Foundation
import UIKit

extension String {
    
    /**
    This extension returns a *price* Float for a given `string`.
    
    - Warning: The first char of the string must be a `$` and there must be a space following the price.
    
    Usage:
        var value = "$1.75 Cash Back"
        print("\(value.parsePrice())") // 1.75

    - Returns: A Float to two decimal places.
    */
    public func parsePrice() -> Float? {
        //separate on space
        let splitter = self.split(separator: " ")
         
        if splitter.count > 0 {
            var dollarString = splitter[0]
            //remove dollar
            if let firstChar = dollarString.first {
                if firstChar == "$" {
                    dollarString.removeFirst()
                }
            }
            if let dollarFloat = Float(dollarString) {
                return (dollarFloat*100).rounded()/100
            }
            
        }
        
        return nil
    }
}


extension Bundle {
    /**
    A means to read *.json* files from the application bundle by name
    
    - Warning: The first char of the string must be a `$` and there must be a space following the price.
    
    Usage:
        var value = "$1.75 Cash Back"
        print("\(value.parsePrice())") // 1.75

    - Returns: A Float to two decimal places.
    */
    func decode<T: Decodable>(_ type: T.Type, from file: String, dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .deferredToDate, keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle.")
        }

        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle.")
        }

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = dateDecodingStrategy
        decoder.keyDecodingStrategy = keyDecodingStrategy

        do {
            return try decoder.decode(T.self, from: data)
        } catch DecodingError.keyNotFound(let key, let context) {
            fatalError("Failed to decode \(file) from bundle due to missing key '\(key.stringValue)' not found – \(context.debugDescription)")
        } catch DecodingError.typeMismatch(_, let context) {
            fatalError("Failed to decode \(file) from bundle due to type mismatch – \(context.debugDescription)")
        } catch DecodingError.valueNotFound(let type, let context) {
            fatalError("Failed to decode \(file) from bundle due to missing \(type) value – \(context.debugDescription)")
        } catch DecodingError.dataCorrupted(_) {
            fatalError("Failed to decode \(file) from bundle because it appears to be invalid JSON")
        } catch {
            fatalError("Failed to decode \(file) from bundle: \(error.localizedDescription)")
        }
    }
}
