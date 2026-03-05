import Foundation

struct Note: Identifiable, Codable {

    let id: UUID
    let text: String
    let date: Date
    let temperature: Double
    let description: String
    let icon: String
}
