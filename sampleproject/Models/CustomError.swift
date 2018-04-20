//
//  CustomError.swift
//  sampleproject
//
//  Created by thuyiya on 4/19/18.
//  Copyright © 2018 thusitha. All rights reserved.
//

import Foundation

struct CustomError: Error, Decodable {
    var message: String
}
