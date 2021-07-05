//
//  APIResponse.swift
//  PryanikiTest
//
//  Created by Alexander Bonney on 7/5/21.
//

import Foundation

struct APIResponse: Codable {
    var data: [DataObject]
    var view: [String]
}

struct DataObject: Codable {
    var name: String
    var data: DataOfTheObject
}

struct DataOfTheObject: Codable {
    var url: String?
    var text: String?
    var selectedId: Int?
    var variants: [Variant]?
}

struct Variant: Codable, Identifiable {
    var id: Int
    var text: String
}
