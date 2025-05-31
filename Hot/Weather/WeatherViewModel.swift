import Foundation
import Combine

class WeatherViewModel: ObservableObject {
    
    @Published var weather: WeatherModel?
    @Published var errorMessage: String?
    private var cancellables = Set<AnyCancellable>()
    private let weatherUseCase: WeatherUseCase
    
    init(useCase: WeatherUseCase) {
        self.weatherUseCase = useCase
    }
    
    func fetchWeather() {
        weatherUseCase.fetchWeather()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                print(completion)
                if case let .failure(error) = completion {
                    self?.errorMessage = error.localizedDescription
                }
            } receiveValue: { [weak self] weatherModel in
                print(weatherModel)
                self?.weather = weatherModel
            }
            .store(in: &cancellables)
        
    }
}
