//
//  Product.swift
//  nestedDecodeApi
//
//  Created by Mac on 15/12/22.
//

import Foundation

struct apiResponse : Decodable{
    let products : [Product]
    let total,skip,limit: Int
}
struct Product : Decodable{
    let id : Int
    let title : String
    let description : String
    let price : Int
    let discountPercentage : Double
    let stock: Int
    let brand : String
    let category : String
    let thumbnail : String
    let images : [String]
}
