//
//  WebError.swift
//  sampleproject
//
//  Created by thuyiya on 4/19/18.
//  Copyright © 2018 thusitha. All rights reserved.
//

import Foundation

public enum NetworkError<CustomError>: Error {
    case noInternetConnection
    case custom(CustomError)
    case unauthorized
    case other
}
