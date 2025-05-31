import SwiftUI

@main
struct HotApp: App {
    var body: some Scene {
        WindowGroup {
            let repository = WeatherRepositoryImpl()
            let useCase = WeatherUseCaseImpl(weatherRepository: repository)
            let viewModel = WeatherViewModel(useCase: useCase)
            ContentView(viewModel: viewModel)
        }
    }
}
