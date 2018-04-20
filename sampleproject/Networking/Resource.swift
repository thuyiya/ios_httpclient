//
//  Resource.swift
//  sampleproject
//
//  Created by thuyiya on 4/19/18.
//  Copyright © 2018 thusitha. All rights reserved.
//

import Foundation

public struct Resource<A, CustomError> {
    let path: UrlPath
    let method: RequestMethod
    var headers: HTTPHeaders
    var params: JSON
    let parse: (Data) -> A?
    let parseError: (Data) -> CustomError?
    
    init(path: String,
         method: RequestMethod = .get,
         params: JSON = [:],
         headers: HTTPHeaders = [:],
         parse: @escaping (Data) -> A?,
         parseError: @escaping (Data) -> CustomError?) {
        
        self.path = UrlPath(path)
        self.method = method
        self.params = params
        self.headers = headers
        self.parse = parse
        self.parseError = parseError
    }
}

extension Resource where A: Decodable, CustomError: Decodable {
    init(jsonDecoder: JSONDecoder,
         path: String,
         method: RequestMethod = .get,
         params: JSON = [:],
         headers: HTTPHeaders = [:]) {
        
        var newHeaders = headers
        newHeaders["Accept"] = "application/json"
        newHeaders["Content-Type"] = "application/json"
        
        self.path = UrlPath(path)
        self.method = method
        self.params = params
        self.headers = newHeaders
        self.parse = {
            try? jsonDecoder.decode(A.self, from: $0)
        }
        self.parseError = {
            try? jsonDecoder.decode(CustomError.self, from: $0)
        }
    }
}

