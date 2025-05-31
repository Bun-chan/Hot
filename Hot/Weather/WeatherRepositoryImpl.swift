import Foundation
import Combine
// https://home.openweathermap.org
class WeatherRepositoryImpl: WeatherRepository {
    
    let apiKey = "64fa7c155297c9d55ffefd5ff2d22edf"

    func fetchWeather() -> AnyPublisher<WeatherResponse, Error> {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=Yokohama&units=metric&appid=\(apiKey)") else {
            return Fail(error: APIError.failedCreatingUrl)
                .eraseToAnyPublisher()
        }
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse,
                      200..<300 ~= httpResponse.statusCode else {
                    print(response)
                    throw APIError.httpResponseError
                }
                if let jsonString = String(data: data, encoding: .utf8) {
                    print("Raw JSON response:\n\(jsonString)")
                }
                return data
            }
            .decode(type: WeatherResponse.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}

enum APIError: Error {
    case failedCreatingUrl
    case httpResponseError
}
