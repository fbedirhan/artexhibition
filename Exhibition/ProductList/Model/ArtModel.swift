//
//  ArtModel.swift
//  Exhibition
//
//  Created by Bedirhan Yıldız on 2.08.2023.
//

import Foundation

// MARK: - ProductListResponse
struct ProductListResponse: Codable {
    let elapsedMilliseconds, count: Int
    let artObjects: [ArtObject]
}

// MARK: - ArtObject
struct ArtObject: Codable {
    let links: Links
    let id, objectNumber, title: String
    let hasImage: Bool
    let principalOrFirstMaker, longTitle: String
    let showImage, permitDownload: Bool
    let webImage, headerImage: Image
    let productionPlaces: [String]
}

// MARK: - Image
struct Image: Codable {
    let guid: String
    let offsetPercentageX, offsetPercentageY, width, height: Int
    let url: String
}

// MARK: - Links
struct Links: Codable {
    let web: String
}
