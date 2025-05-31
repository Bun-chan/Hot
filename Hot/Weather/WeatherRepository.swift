import Foundation
import Combine

protocol WeatherRepository {
    func fetchWeather() -> AnyPublisher<WeatherResponse, Error>
}
