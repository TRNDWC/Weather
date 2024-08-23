enum ItemWeatherStatus: Int {
    case sunny = 0
    case mainlySunny = 1
    case partlyCloudy = 2
    case cloudy = 3
    case foggy = 45
    case rimeFog = 48
    case lightDrizzle = 51
    case drizzle = 53
    case heavyDrizzle = 55
    case lightFreezingDrizzle = 56
    case freezingDrizzle = 57
    case lightRain = 61
    case rain = 63
    case heavyRain = 65
    case lightFreezingRain = 66
    case freezingRain = 67
    case lightSnow = 71
    case snow = 73
    case heavySnow = 75
    case snowGrains = 77
    case lightShowers = 80
    case showers = 81
    case heavyShowers = 82
    case lightSnowShowers = 85
    case snowShowers = 86
    case thunderstorm = 95
    case thunderstormWithSlightHail = 96
    case thunderstormWithHeavyHail = 99

    var description: String {
        switch self {
        case .sunny: return "Sunny"
        case .mainlySunny: return "Mainly Sunny"
        case .partlyCloudy: return "Partly Cloudy"
        case .cloudy: return "Cloudy"
        case .foggy: return "Foggy"
        case .rimeFog: return "Rime Fog"
        case .lightDrizzle: return "Light Drizzle"
        case .drizzle: return "Drizzle"
        case .heavyDrizzle: return "Heavy Drizzle"
        case .lightFreezingDrizzle: return "Light Freezing Drizzle"
        case .freezingDrizzle: return "Freezing Drizzle"
        case .lightRain: return "Light Rain"
        case .rain: return "Rain"
        case .heavyRain: return "Heavy Rain"
        case .lightFreezingRain: return "Light Freezing Rain"
        case .freezingRain: return "Freezing Rain"
        case .lightSnow: return "Light Snow"
        case .snow: return "Snow"
        case .heavySnow: return "Heavy Snow"
        case .snowGrains: return "Snow Grains"
        case .lightShowers: return "Light Showers"
        case .showers: return "Showers"
        case .heavyShowers: return "Heavy Showers"
        case .lightSnowShowers: return "Light Snow Showers"
        case .snowShowers: return "Snow Showers"
        case .thunderstorm: return "Thunderstorm"
        case .thunderstormWithSlightHail:
            return "Thunderstorm with Hail"
        case .thunderstormWithHeavyHail:
            return "Thunderstorm with Hail"
        }
    }

    var imageName: String {
        switch self {
        case .sunny, .mainlySunny: return "sunny"
        case .partlyCloudy: return "partly_cloudy"
        case .cloudy: return "cloudy"
        case .foggy, .rimeFog: return "fog"
        case .lightDrizzle, .drizzle, .heavyDrizzle, .lightFreezingDrizzle, .freezingDrizzle, .lightShowers, .showers, .heavyShowers: return "drizzle"
        case .lightRain, .rain, .heavyRain, .lightFreezingRain, .freezingRain: return "rain"
        case .lightSnow, .snow, .heavySnow, .snowGrains, .lightSnowShowers, .snowShowers: return "snow"
        case .thunderstorm, .thunderstormWithHeavyHail, .thunderstormWithSlightHail: return "thunder"
        }
    }
}

enum MainWeatherStatus: Int {
    case sunny = 0
    case mainlySunny = 1
    case partlyCloudy = 2
    case cloudy = 3
    case foggy = 45
    case rimeFog = 48
    case lightDrizzle = 51
    case drizzle = 53
    case heavyDrizzle = 55
    case lightFreezingDrizzle = 56
    case freezingDrizzle = 57
    case lightRain = 61
    case rain = 63
    case heavyRain = 65
    case lightFreezingRain = 66
    case freezingRain = 67
    case lightSnow = 71
    case snow = 73
    case heavySnow = 75
    case snowGrains = 77
    case lightShowers = 80
    case showers = 81
    case heavyShowers = 82
    case lightSnowShowers = 85
    case snowShowers = 86
    case thunderstorm = 95
    case thunderstormWithSlightHail = 96
    case thunderstormWithHeavyHail = 99

    var description: String {
        switch self {
        case .sunny: return "Sunny"
        case .mainlySunny: return "Mainly Sunny"
        case .partlyCloudy: return "Partly Cloudy"
        case .cloudy: return "Cloudy"
        case .foggy: return "Foggy"
        case .rimeFog: return "Rime Fog"
        case .lightDrizzle: return "Light Drizzle"
        case .drizzle: return "Drizzle"
        case .heavyDrizzle: return "Heavy Drizzle"
        case .lightFreezingDrizzle: return "Light Freezing Drizzle"
        case .freezingDrizzle: return "Freezing Drizzle"
        case .lightRain: return "Light Rain"
        case .rain: return "Rain"
        case .heavyRain: return "Heavy Rain"
        case .lightFreezingRain: return "Light Freezing Rain"
        case .freezingRain: return "Freezing Rain"
        case .lightSnow: return "Light Snow"
        case .snow: return "Snow"
        case .heavySnow: return "Heavy Snow"
        case .snowGrains: return "Snow Grains"
        case .lightShowers: return "Light Showers"
        case .showers: return "Showers"
        case .heavyShowers: return "Heavy Showers"
        case .lightSnowShowers: return "Light Snow Showers"
        case .snowShowers: return "Snow Showers"
        case .thunderstorm: return "Thunderstorm"
        case .thunderstormWithSlightHail:
            return "Thunderstorm with Hail"
        case .thunderstormWithHeavyHail:
            return "Thunderstorm with Hail"
        }
    }

    var imageName: String {
        switch self {
        case .sunny, .mainlySunny: return "sunny_1"
        case .partlyCloudy: return "partly_cloudy_1"
        case .cloudy: return "cloudy_1"
        case .foggy, .rimeFog: return "fog_1"
        case .lightDrizzle, .drizzle, .heavyDrizzle, .lightFreezingDrizzle, .freezingDrizzle, .lightShowers, .showers, .heavyShowers: return "drizzle_1"
        case .lightRain, .rain, .heavyRain, .lightFreezingRain, .freezingRain: return "rain_1"
        case .lightSnow, .snow, .heavySnow, .snowGrains, .lightSnowShowers, .snowShowers: return "snow_1"
        case .thunderstorm, .thunderstormWithHeavyHail, .thunderstormWithSlightHail: return "thunderstorm_1"
        }
    }
}

