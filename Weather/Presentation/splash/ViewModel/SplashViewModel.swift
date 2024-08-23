import Combine
import CoreData

enum SplashState {
    case Start
    case Finish
}

class SplashViewModel: ObservableObject {
    var state: Observable<SplashState> = Observable(SplashState.Start)
    private let context: NSManagedObjectContext
    private var cancellables = Set<AnyCancellable>()
    @Published var weatherData: [WeatherModel] = []

    private let searchLocation: any SearchLocationUseCase
    private let current: any GetCurrentWeatherUseCase
    private let hourly: any GetHourlyWeatherUseCase
    private let daily: any GetDailyWeatherUseCase

    init(context: NSManagedObjectContext, searchLocation: any SearchLocationUseCase, current: any GetCurrentWeatherUseCase, hourly: any GetHourlyWeatherUseCase, daily: any GetDailyWeatherUseCase) {
        self.context = context
        self.searchLocation = searchLocation
        self.current = current
        self.hourly = hourly
        self.daily = daily
        fetchUnitData(context: context)
    }
    
    func fetchWeatherData() {
        let fetchRequest: NSFetchRequest<CoreDataLocation> = CoreDataLocation.fetchRequest()
        
        do {
            let locations = try context.fetch(fetchRequest)
            
            let publishers = locations.map { location in
                fetchWeather(for: location)
            }
            
            Publishers.MergeMany(publishers)
                .collect()
                .sink(receiveCompletion: { completion in
                    self.state.value = .Finish
                }, receiveValue: { weatherDataArray in
                    WeatherProvider.fillWeather(weatherDataArray)
                })
                .store(in: &cancellables)
            
        } catch {
            state.value = .Finish
        }
    }
    
    func fetchUnitData(context: NSManagedObjectContext){
        CoreDataManager.shared.fetchUnit(context: context)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished:
                    print("Successfully fetched unit data.")
                    self?.fetchWeatherData()
                case .failure(let error):
                    print("Failed to fetch unit data: \(error)")
                }
            }, receiveValue: { unitModel in
                UnitProvider.shared.unitModel = unitModel
            })
            .store(in: &cancellables)
    }
    
    private func fetchWeather(for location: CoreDataLocation) -> AnyPublisher<WeatherModel, Error> {
        let locationModel = LocationModel(fromCore: location)
        
        let currentPublisher = current.execute(locationModel)
            .mapError { $0 as Error }
        
        let hourlyPublisher = hourly.execute(locationModel)
            .mapError { $0 as Error }
        
        let dailyPublisher = daily.execute(locationModel)
            .mapError { $0 as Error }
        
        return currentPublisher
            .combineLatest(hourlyPublisher, dailyPublisher)
            .map { currentWeather, hourlyWeather, dailyWeather in
                return WeatherModel(location: locationModel, current: currentWeather, hourly: hourlyWeather, daily: dailyWeather)
            }
            .eraseToAnyPublisher()
    }
}
