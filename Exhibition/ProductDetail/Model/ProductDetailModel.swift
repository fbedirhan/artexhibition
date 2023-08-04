//
//  ProductDetailModel.swift
//  Exhibition
//
//  Created by Bedirhan Yıldız on 2.08.2023.
//

import Foundation

// MARK: - ProductDetailResponse
struct ProductDetailResponse: Codable {
    let elapsedMilliseconds: Int?
    let artObject: ArtObjectDetail?
}

// MARK: - ArtObject
struct ArtObjectDetail: Codable {
    let links: LinksDetail
    let id, priref, objectNumber, language: String?
    let title: String?
    let webImage: WebImage?
    let colors: [Color]?
    let principalOrFirstMaker: String?
    let colorsWithNormalization: [ColorsWithNormalization]?
    let normalizedColors, normalized32Colors: [Color]?
    let titles: [String]?
    let artObjectDescription: String?
    /*let objectTypes, objectCollection: [String]
    let plaqueDescriptionDutch, plaqueDescriptionEnglish, principalMaker: String
    let acquisition: Acquisition
    let materials: [String]
    let productionPlaces: [String]
    let dating: Dating
    let hasImage: Bool
    let historicalPersons: [String]
    let documentation: [String]
    let physicalMedium, longTitle, subTitle, scLabelLine: String
    let showImage: Bool
    let location: String*/
}

// MARK: - Acquisition
struct Acquisition: Codable {
    let method, date, creditLine: String?
}

// MARK: - Color
struct Color: Codable {
    let percentage: Int?
    let hex: String?
}

// MARK: - ColorsWithNormalization
struct ColorsWithNormalization: Codable {
    let originalHex, normalizedHex: String?
}

// MARK: - Dating
struct Dating: Codable {
    let presentingDate: String?
    let sortingDate, period, yearEarly, yearLate: Int?
}

// MARK: - Links
struct LinksDetail: Codable {
    let search: String?
}


// MARK: - WebImage
struct WebImage: Codable {
    let guid: String?
    let offsetPercentageX, offsetPercentageY, width, height: Int?
    let url: String?
}


