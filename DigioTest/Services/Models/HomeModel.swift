import Foundation

// MARK: - HomeScreenModel
struct HomeScreenModel: Codable, Equatable {
    let spotlight: [Spotlight]
    let products: [Product]
    let cash: Cash
}

// MARK: - Cash
struct Cash: Codable, Equatable {
    let title: String
    let bannerURL: String
    let description: String
}

// MARK: - Product
struct Product: Codable, Equatable {
    let name: String
    let imageURL: String
    let description: String
}

// MARK: - Spotlight
struct Spotlight: Codable, Equatable {
    let name: String
    let bannerURL: String
    let description: String
}
