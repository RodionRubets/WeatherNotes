import Foundation

enum NetworkError: Error, LocalizedError {

    case invalidURL
    case noInternet
    case badResponse
    case decodingError

    var errorDescription: String? {

        switch self {

        case .invalidURL:
            return "Invalid URL"

        case .noInternet:
            return "No internet connection"

        case .badResponse:
            return "Bad server response"

        case .decodingError:
            return "Failed to decode weather data"
        }
    }
}
