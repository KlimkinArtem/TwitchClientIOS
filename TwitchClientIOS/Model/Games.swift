import Foundation

struct GamesData: Decodable{
    let data: [Games]
}
struct Games: Decodable{
    let id: String
    let name: String
    let boxArtUrl: String
}
