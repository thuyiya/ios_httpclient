//
//  User.swift
//  sampleproject
//
//  Created by thuyiya on 4/18/18.
//  Copyright © 2018 thusitha. All rights reserved.
//

import Foundation

struct Movie: Decodable {
    var id: String
    var title: String
    var summary: String
}

struct MoviesResponse: Decodable {
    var movies: [Movie]
}
