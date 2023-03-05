//
//  Beer.swift
//  Beers
//
//  Created by DeStasio Pierluigi on 04/03/23.
//

import Foundation

typealias Beers = [Beer]

struct Beer: Codable {
    public var id: Int64?
    public var name: String?
    public var tagline: String?
    public var firstBrewed: String?
    public var description: String?
    public var imageUrl: String?
    public var abv: Double?
    public var ibu: Double?
    public var targetFg: Double?
    public var targetOg: Double?
    public var ebc: Double?
    public var srm: Double?
    public var ph: Double?
    public var attenuationLevel: Double?
    public var brewersTips: String?
    public var volume: ValueUnit?
    public var boilVolume: ValueUnit?
    public var foodPairing: [String]?
    public var contributedBy: String?
    public var method: BeerMethod?
    public var ingredients: BeerIngredients?

    public init(id: Int64?, name: String?, tagline: String?, firstBrewed: String?, description: String?, imageUrl: String?, abv: Double?, ibu: Double?, targetFg: Double?, targetOg: Double?, ebc: Double?, srm: Double?, ph: Double?, attenuationLevel: Double?, brewersTips: String?, volume: ValueUnit?, boilVolume: ValueUnit?, foodPairing: [String]?, contributedBy: String?, method: BeerMethod?, ingredients: BeerIngredients?) {
        self.id = id
        self.name = name
        self.tagline = tagline
        self.firstBrewed = firstBrewed
        self.description = description
        self.imageUrl = imageUrl
        self.abv = abv
        self.ibu = ibu
        self.targetFg = targetFg
        self.targetOg = targetOg
        self.ebc = ebc
        self.srm = srm
        self.ph = ph
        self.attenuationLevel = attenuationLevel
        self.brewersTips = brewersTips
        self.volume = volume
        self.boilVolume = boilVolume
        self.foodPairing = foodPairing
        self.contributedBy = contributedBy
        self.method = method
        self.ingredients = ingredients
    }

    public enum CodingKeys: String, CodingKey, CaseIterable {
        case id
        case name
        case tagline
        case firstBrewed = "first_brewed"
        case description
        case imageUrl = "image_url"
        case abv
        case ibu
        case targetFg = "target_fg"
        case targetOg = "target_og"
        case ebc
        case srm
        case ph
        case attenuationLevel = "attenuation_level"
        case brewersTips = "brewers_tips"
        case volume
        case boilVolume = "boil_volume"
        case foodPairing = "food_pairing"
        case contributedBy = "contributed_by"
        case method
        case ingredients
    }

}
