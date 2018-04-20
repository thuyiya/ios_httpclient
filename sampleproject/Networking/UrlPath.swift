//
//  Path.swift
//  sampleproject
//
//  Created by thuyiya on 4/19/18.
//  Copyright © 2018 thusitha. All rights reserved.
//

import Foundation

struct UrlPath {
    private var components: [String]
    
    var absolutePath: String {
        return "/" + components.joined(separator: "/")
    }
    
    init(_ path: String) {
        components = path.components(separatedBy: "/").filter({ !$0.isEmpty })
    }
    
    mutating func append(path: UrlPath) {
        components += path.components
    }
    
    func appending(path: UrlPath) -> UrlPath {
        var copy = self
        copy.append(path: path)
        return copy
    }
}
