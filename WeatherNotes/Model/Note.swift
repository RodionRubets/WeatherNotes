import Foundation

struct Note: Identifiable, Codable {

    let id: UUID
    let text: String
    let date: Date
    var temperature: Double?
    var description: String?
    var iconName: String?
    var locationName: String?
    var didFailToLoadWeather: Bool = false
    
    var systemIconName: String {
        if didFailToLoadWeather { return "wifi.exclamationmark" }
            switch iconName {
            case "01d": return "sun.max.fill"
            case "01n": return "moon.stars.fill"
            case "02d", "02n": return "cloud.sun.fill"
            case "03d", "03n", "04d", "04n": return "cloud.fill"
            case "09d", "09n": return "cloud.heavyrain.fill"
            case "10d", "10n": return "cloud.sun.rain.fill"
            case "11d", "11n": return "cloud.bolt.fill"
            case "13d", "13n": return "snow"
            case "50d", "50n": return "cloud.fog.fill"
            default: return "cloud.sun.fill"
            }
        }
}
