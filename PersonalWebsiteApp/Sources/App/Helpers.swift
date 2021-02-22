import Foundation
import Leaf

// Both structs are codable because I want to make use of fileio and just parse the entries
// and addresses from from a JSON file and load them into Leaf (once I figure it out)
struct WebsiteEntry: Codable {
    let title: String
    let body: String
}

extension WebsiteEntry: LeafDataRepresentable {
    var leafData: LeafData {
        .dictionary([
            "title": title,
            "body": body,
        ])
    }
}

struct CryptocurrencyAddress: Codable {
    // Can add var id = UUID() to conform to Identifiable
    let symbol: String
    let address: String
}

extension CryptocurrencyAddress: LeafDataRepresentable {
    var leafData: LeafData {
        .dictionary([
            // "id": .string(id.uuidString),
            "symbol": symbol,
            "address": address,
        ])
    }
}
