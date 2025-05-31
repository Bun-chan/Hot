import SwiftUI
import Combine

struct ContentView: View {
    @StateObject var viewModel: WeatherViewModel
    var body: some View {
        VStack {
            if let weather = viewModel.weather {
                let temp = String(format: "%.1f", weather.temperature)
                Text("\(weather.location) \(temp)ºC")
            }
        }
        .onAppear {
            viewModel.fetchWeather()
        }
        .padding()
    }
}

#Preview {
    let dummyUseCase = DummyWeatherUseCase()
    let viewModel = WeatherViewModel(useCase: dummyUseCase)
    ContentView(viewModel: viewModel)
}
class DummyWeatherUseCase: WeatherUseCase {
    func fetchWeather() -> AnyPublisher<WeatherModel, Error> {
        let mock = WeatherModel(temperature: 21.5, location: "Tocumwal")
        return Just(mock)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
