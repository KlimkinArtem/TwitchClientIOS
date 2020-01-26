import Foundation

struct StreamsData: Decodable{
    let data: [Streams]
}
struct Streams: Decodable{
    let userName: String
    let thumbnailUrl: String
    let userId: String
    let title: String
    let viewerCount: Int
}


//"id": "26007351216",
//"user_id": "7236692",
//"user_name": "BillyBob",
//"game_id": "29307",
//"type": "live",
//"title": "[Punday Monday] Necromancer - Dan's First Character - Maps - !build",
//"viewer_count": 5723,
//"started_at": "2017-08-14T15:45:17Z",
//"language": "en",
//"thumbnail_url": "https://static-cdn.jtvnw.net/previews-ttv/live_user_dansgaming-{width}x{height}.jpg"
