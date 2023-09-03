//
//  WeatherForecast16dModel.swift
//  WeatherApp
//
//  Created by Нияз Нуруллин on 31.08.2023.
//

import Foundation

//struct WeatherForecast16dModel: Codable {
//    let data: [WeatherForecast1dModel]
//
//    enum CodingKeys: String, CodingKey {
//        case data = "data"
//    }
//}
//
//struct Forecast16dJSONData: Codable {
//    let weather: WeatherModel
//    let forecastDate: String
//    let temperatureMin: Double
//    let temperatureMax: Double
//    let feelsLikeTemperatureMin: Double
//    let feelsLikeTemperatureMax: Double
//    let windVelocity: Double
//    let windDirection: String
//    let uvIndex: Double
//    let precipitation: Int
//    let cloudiness: Int
//    let humidityLevel: Int
//    let sunriseTime: Int
//    let sunsetTime: Int
//    let moonriseTime: Int
//    let moonsetTime: Int
//    let moonphase: Double
//
//    enum CodingKeys: String, CodingKey {
//        case weather = "weather"
//        case forecastDate = "valid_date"
//        case temperatureMin = "min_temp"
//        case temperatureMax = "high_temp"
//        case feelsLikeTemperatureMin = "app_min_temp"
//        case feelsLikeTemperatureMax = "app_max_temp"
//        case windVelocity = "wind_spd"
//        case windDirection = "wind_cdir"
//        case uvIndex = "uv"
//        case precipitation = "pop"
//        case cloudiness = "clouds"
//        case humidityLevel = "rh"
//        case sunriseTime = "sunrise_ts"
//        case sunsetTime = "sunset_ts"
//        case moonriseTime = "moonrise_ts"
//        case moonsetTime = "moonset_ts"
//        case moonphase = "moon_phase_lunation"
//    }
//}

/*
{
  "city_name": "Stanley",
  "country_code": "US",
  "data": [
    {
      "app_max_temp": 11.2,
      "app_min_temp": 1.4,
      "clouds": 60,
      "clouds_hi": 50,
      "clouds_low": 41,
      "clouds_mid": 53,
      "datetime": "2023-01-17",
      "dewpt": 3.2,
      "high_temp": 11.2,
      "low_temp": 2.6,
      "max_dhi": null,
      "max_temp": 11.2,
      "min_temp": 5,
      "moon_phase": 0.136447,
      "moon_phase_lunation": 0.87,
      "moonrise_ts": 1673942612,
      "moonset_ts": 1673981166,
      "ozone": 312,
      "pop": 80,
      "precip": 9.327179,
      "pres": 930.8,
      "rh": 78,
      "slp": 1007.9,
      "snow": 0,
      "snow_depth": 0,
      "sunrise_ts": 1673958539,
      "sunset_ts": 1673994029,
      "temp": 7.6,
      "ts": 1673938860,
      "uv": 1.9,
      "valid_date": "2023-01-17",
      "vis": 11.786,
      "weather": {
        "description": "Небольшой дождь",
        "code": 500,
        "icon": "r01d"
      },
      "wind_cdir": "Ю",
      "wind_cdir_full": "Южный",
      "wind_dir": 190,
      "wind_gust_spd": 7.1,
      "wind_spd": 4.3
    },
    {
      "app_max_temp": 9.1,
      "app_min_temp": -0.3,
      "clouds": 24,
      "clouds_hi": 64,
      "clouds_low": 1,
      "clouds_mid": 12,
      "datetime": "2023-01-18",
      "dewpt": 0.5,
      "high_temp": 9.1,
      "low_temp": 3.1,
      "max_dhi": null,
      "max_temp": 9.1,
      "min_temp": 2.6,
      "moon_phase": 0.0635422,
      "moon_phase_lunation": 0.9,
      "moonrise_ts": 1674033444,
      "moonset_ts": 1674070918,
      "ozone": 292.1,
      "pop": 0,
      "precip": 0,
      "pres": 935.8,
      "rh": 70,
      "slp": 1012.8,
      "snow": 0,
      "snow_depth": 0,
      "sunrise_ts": 1674044914,
      "sunset_ts": 1674080494,
      "temp": 5.6,
      "ts": 1674018060,
      "uv": 2.6,
      "valid_date": "2023-01-18",
      "vis": 24.622,
      "weather": {
        "description": "Местами облачно",
        "code": 802,
        "icon": "c02d"
      },
      "wind_cdir": "ЮЗ",
      "wind_cdir_full": "Юго-Западный",
      "wind_dir": 226,
      "wind_gust_spd": 6.9,
      "wind_spd": 3.2
    }
  ],
  "lat": 38.5,
  "lon": -78.5,
  "state_code": "VA",
  "timezone": "America/New_York"
}
 */

/*
 Field Decriptions:
 lat: Latitude (Degrees)
 lon: Longitude (Degrees)
 timezone: Local IANA Timezone
 city_name: Nearest city name
 country_code: Country abbreviation
 state_code: State abbreviation/code
 data: [
 valid_date:Local date the forecast is valid for in format YYYY-MM-DD
 ts: Forecast period start unix timestamp (UTC)
 datetime:[DEPRECATED] Forecast valid date (YYYY-MM-DD)
 wind_gust_spd: Wind gust speed (Default m/s)
 wind_spd: Wind speed (Default m/s)
 wind_dir: Wind direction (degrees)
 wind_cdir: Abbreviated wind direction
 wind_cdir_full: Verbal wind direction
 temp: Average Temperature (default Celsius)
 max_temp: Maximum Temperature - Calculated from Midnight to Midnight local time (default Celsius)
 min_temp: Minimum Temperature - Calculated from Midnight to Midnight local time (default Celsius)
 high_temp: High Temperature "Day-time High" - Calculated from 7 AM to 7 PM local time (default Celsius)
 low_temp: Low Temperature "Night-time Low" - Calculated from 7 PM to 7 AM local (default Celsius)
 app_max_temp: Apparent/"Feels Like" temperature at max_temp time (default Celsius)
 app_min_temp: Apparent/"Feels Like" temperature at min_temp time (default Celsius)
 pop: Probability of Precipitation (%)
 precip: Accumulated liquid equivalent precipitation (default mm)
 snow: Accumulated snowfall (default mm)
 snow_depth: Snow Depth (default mm)
 pres: Average pressure (mb)
 slp: Average sea level pressure (mb)
 dewpt: Average dew point (default Celsius)
 rh: Average relative humidity (%)
 weather: {
 icon:Weather icon code
 code:Weather code
 description: Text weather description
 }
 clouds_low: Low-level (~0-3km AGL) cloud coverage (%)
 clouds_mid: Mid-level (~3-5km AGL) cloud coverage (%)
 clouds_hi: High-level (>5km AGL) cloud coverage (%)
 clouds: Average total cloud coverage (%)
 vis: Visibility (default KM)
 max_dhi: [DEPRECATED] Maximum direct component of solar radiation (W/m^2)
 uv: Maximum UV Index (0-11+)
 ozone: Average Ozone (Dobson units)
 moon_phase: Moon phase illumination fraction (0-1)
 moon_phase_lunation: Moon lunation fraction (0 = New moon, 0.50 = Full Moon, 0.75 = Last quarter moon)
 moonrise_ts: Moonrise time unix timestamp (UTC)
 moonset_ts: Moonset time unix timestamp (UTC)
 sunrise_ts: Sunrise time unix timestamp (UTC)
 sunset_ts: Sunset time unix timestamp (UTC)
 ... ]
 */
