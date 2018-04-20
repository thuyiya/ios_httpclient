//
//  Config.swift
//  sampleproject
//
//  Created by thuyiya on 4/19/18.
//  Copyright © 2018 thusitha. All rights reserved.
//

import Foundation

class Config: NSObject {
    
    static let root = Bundle.main.infoDictionary!["BASE_URL_SETTINGS"]  as! String
}
