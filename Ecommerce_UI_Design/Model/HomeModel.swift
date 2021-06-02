// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let homeModel = try? newJSONDecoder().decode(HomeModel.self, from: jsonData)

import Foundation

// MARK: - HomeModel
struct HomeModel: Codable {
    var status: Bool?
    var message: String?
    var data: HomeData?
}

// MARK: - DataClass
struct HomeData: Codable {
    var banners: [Banner]?
    var products: [Product]?
    var ad: String?
}

// MARK: - Banner
struct Banner: Codable {
    var id: Int?
    var image: String?
    var category: Category?
    var product: Product?
}

// MARK: - Category
struct Category: Codable {
    var id: Int?
    var image: String?
    var name: String?
}

// MARK: - Product
struct Product: Codable {
    var id: Int?
    var price, oldPrice: Double?
    var discount: Int?
    var image: String?
    var name, productDescription: String?
    var images: [String]?
    var inFavorites, inCart: Bool?

    enum CodingKeys: String, CodingKey {
        case id, price
        case oldPrice = "old_price"
        case discount, image, name
        case productDescription = "description"
        case images
        case inFavorites = "in_favorites"
        case inCart = "in_cart"
    }
}

