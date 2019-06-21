//
//  Model.swift
//  KinoAfisha
//
//  Created by Adakhanau on 19/06/2019.
//  Copyright © 2019 Adakhan. All rights reserved.
//

import Foundation

struct KinoAfishaModel: Decodable {
    var result: [Result]?
}

struct Result: Decodable {
    var name: String?
    var image: String?
    var vote: String?
    var countries: String?
    var premier_ua: String?
    var age_limit: String!
}
