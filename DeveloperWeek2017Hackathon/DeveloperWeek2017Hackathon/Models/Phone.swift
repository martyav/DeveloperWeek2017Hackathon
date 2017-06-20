//
//  Phone.swift
//  DeverloperWeekHackathon2017TestApp
//
//  Created by Ana Ma on 6/20/17.
//  Copyright © 2017 Ana Ma. All rights reserved.
//

import Foundation

class Phone {
    var phoneNumber: String
    var countryCode: String
    var friendlyName: String
    var isoCountry: String
    
    init (phoneNumber: String, countryCode: String, friendlyName: String, isoCountry: String) {
        self.phoneNumber = phoneNumber
        self.countryCode = countryCode
        self.friendlyName = friendlyName
        self.isoCountry = isoCountry
    }
}
