//
//  Models.swift
//  iOSDogeCoin
//
//  Created by Furkan Ademoğlu on 28.10.2022.
//

import Foundation

struct APIResponse: Codable{
    let data:[Int:DogeCoinData]
}

struct DogeCoinData:Codable{
    let id:Int
    let name:String
    let symbol:String
    let date_added:String
    let tags:[String]
    let total_supply:Float
    let quote:[String:Quote]
}

struct Quote:Codable{
    let price:Float
    let volume_24h:Float
}
