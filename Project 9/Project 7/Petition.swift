//
//  Petition.swift
//  Project 7
//
//  Created by Hyun Lee on 5/11/24.
//

import Foundation

struct Petition: Codable{
    var title: String
    var body: String
    var signatureCount: Int
}

struct Petitions: Codable{
    var results: [Petition]
}
