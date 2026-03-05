import Foundation

class WeatherService {

    private let apiKey = "4eddd0a1d505105974d7e7b9ef4641e1"

    func fetchWeather(
        latitude: Double,
        longitude: Double,
        completion: @escaping (Result<WeatherResponse, NetworkError>) -> Void
    ) {

        let urlString =
        "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=\(apiKey)&units=metric"

        guard let url = URL(string: urlString) else {
            completion(.failure(.invalidURL))
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in

            if error != nil {
                completion(.failure(.noInternet))
                return
            }

            guard let response = response as? HTTPURLResponse,
                  response.statusCode == 200 else {

                completion(.failure(.badResponse))
                return
            }

            guard let data = data else {
                completion(.failure(.badResponse))
                return
            }

            do {
                let decoded = try JSONDecoder().decode(WeatherResponse.self, from: data)
                completion(.success(decoded))

            } catch {

                completion(.failure(.decodingError))
            }

        }.resume()
    }
}
