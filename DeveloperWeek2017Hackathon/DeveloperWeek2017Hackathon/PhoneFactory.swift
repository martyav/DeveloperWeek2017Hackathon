//
//  PhoneFactory.swift
//  DeverloperWeekHackathon2017TestApp
//
//  Created by Ana Ma on 6/20/17.
//  Copyright © 2017 Ana Ma. All rights reserved.
//

import Foundation

class PhoneFactory {
    
    // MARK: - Singleton
    static let manager: PhoneFactory = PhoneFactory()
    private init() {}
    
    // MARK: - Data parsing
    func getAvailablePhoneNumberData(from data: Data) -> [Phone]? {
        
        var phones = [Phone]()
        
        do {
            let jsonData: Any = try JSONSerialization.jsonObject(with: data, options: [])
            
            guard let availableNumberData = jsonData as? [String:AnyObject],
                let availablePhoneNumbers = availableNumberData["available_phone_numbers"] as? [[String:AnyObject]] else { return nil }
            
            for numbers in availablePhoneNumbers {
                guard let phoneNumber = numbers["phone_number"] as? String,
                    let countryCode = numbers["country_code"] as? String,
                    let friendlyName = numbers["friendly_name"] as? String,
                    let isoCountry = numbers["iso_country"] as? String else { return  nil }
                
                phones.append(Phone(phoneNumber: phoneNumber, countryCode: countryCode, friendlyName: friendlyName, isoCountry: isoCountry))
                
            }
            //dump(phones) //something
        } catch {
            print("Unknown parsing error encountered: \(error)")
        }
        return phones
    }
    
    
}

