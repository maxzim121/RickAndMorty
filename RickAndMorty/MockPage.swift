let mockResults = [Results(id: 1, name: "Rick", gender: "Male", image: "https://rickandmortyapi.com/api/character/avatar/821.jpeg"), Results(id: 2, name: "Morty", gender: "Male", image: "https://rickandmortyapi.com/api/character/avatar/822.jpeg"), Results(id: 3, name: "Java", gender: "Female", image: "https://rickandmortyapi.com/api/character/avatar/822.jpeg")]
let mockData = PageResponse(info: Info(next: nil, prev: nil), results: mockResults)
let mockCharacter = CharacterResponseStruct(
    id: 1,
    name: "Rick",
    status: "Dead",
    species: "Human",
    gender: "Male",
    origin: Origin(name: "Earth"),
    location: Location(name: "Earth"),
    image: "https://rickandmortyapi.com/api/character/avatar/2.jpeg"
)
