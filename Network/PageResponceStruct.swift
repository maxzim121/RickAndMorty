struct PageResponse: Codable {
    let info: Info
    let results: [Results]
}

struct Info: Codable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
    
    enum CodingKeys: String, CodingKey {
        case count
        case pages
        case next
        case prev
    }
}

struct Results: Codable {
    let id: Int
    let name: String
    let gender: String
    let image: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case gender
        case image
    }
}

