import Foundation
import Combine

class WeatherUseCaseImpl: WeatherUseCase {
    
    let weatherRepository: WeatherRepository
    
    init(weatherRepository: WeatherRepository) {
        self.weatherRepository = weatherRepository
    }
    
    func fetchWeather() -> AnyPublisher<WeatherModel, Error> {
        return weatherRepository.fetchWeather()
            .map { response in
                return WeatherModel(temperature: response.main.temp, location: response.name)
            }
            .eraseToAnyPublisher()
    }
}
