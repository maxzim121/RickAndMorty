struct CharacterResponseStruct: Codable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let gender: String
    let origin: Origin
    let location: Location
    let image: String
}

struct Origin: Codable {
    let name: String
}

struct Location: Codable {
    let name: String
}

