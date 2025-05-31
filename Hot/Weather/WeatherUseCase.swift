import Foundation
import Combine

protocol WeatherUseCase {
    func fetchWeather() -> AnyPublisher<WeatherModel, Error>
}
