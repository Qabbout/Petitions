//
//  Petition.swift
//  Petitions
//
//  Created by Abdulrahman on 10/4/21.
//

import Foundation

struct Petition: Codable {
    var title: String
    var body: String
    var signatureCount: Int
}
