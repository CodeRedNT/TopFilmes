//
//  ResponseData.swift
//  Top Filmes
//
//  Created by Code Red on 12/07/19.
//  Copyright © 2019 particular. All rights reserved.
//

import Foundation

struct ResponseData : Decodable{
    var results : [Filme]? = nil
}
