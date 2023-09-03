//
//  WeaherForecast24hModel.swift
//  WeatherApp
//
//  Created by Нияз Нуруллин on 31.08.2023.
//

import Foundation

//struct Forecast5dBy3hModel: Codable {
//    let data: [Forecast5dBy3hJSONData]
//
//    enum CodingKeys: String, CodingKey {
//        case data = "data"
//    }
//}
//
//struct Forecast5dBy3hJSONData: Codable {
//    let weather: WeatherCodable
//    let forecastTime: String
//    let temperature: Double
//    let feelsLikeTemperature: Double
//    let windVelocity: Double
//    let windDirection: String
//    let precipitation: Int
//    let cloudiness: Int
//    let humidityLevel: Int
//
//    enum CodingKeys: String, CodingKey {
//        case weather = "weather"
//        case forecastTime = "timestamp_local"
//        case temperature = "temp"
//        case feelsLikeTemperature = "app_temp"
//        case windVelocity = "wind_spd"
//        case windDirection = "wind_cdir"
//        case precipitation = "pop"
//        case cloudiness = "clouds"
//        case humidityLevel = "rh"
//    }
//}

/*
{
  "city_name": "Four Oaks",
  "state_code": "NC",
  "country_code": "US",
  "lat": 35.5,
  "timezone": "America/New_York",
  "data": [
    {
      "rh": 59,
      "pod": "n",
      "pres": 1005,
      "clouds": 100,
      "vis": 30,
      "wind_spd": 2.43,
      "wind_cdir_full": "Юго-Юго-Западный",
      "slp": 1012.5,
      "datetime": "2023-01-17:09",
      "ts": 1673946000,
      "snow": 0,
      "dewpt": -2.6,
      "uv": 0,
      "wind_gust_spd": 6.84,
      "wind_dir": 210,
      "ghi": 0,
      "dhi": 0,
      "precip": 0,
      "weather": {
        "description": "Облачно",
        "code": 804,
        "icon": "c04n"
      },
      "temp": 4.7,
      "app_temp": 2.6,
      "timestamp_utc": "2023-01-17T09:00:00",
      "dni": 0,
      "timestamp_local": "2023-01-17T04:00:00",
      "snow_depth": 0,
      "pop": 0,
      "ozone": 291.5,
      "clouds_hi": 100,
      "clouds_low": 0,
      "clouds_mid": 100,
      "solar_rad": 0,
      "wind_cdir": "ЮЮЗ"
    },
    {
      "rh": 64,
      "pod": "n",
      "pres": 1004.5,
      "clouds": 100,
      "vis": 26.688,
      "wind_spd": 1.81,
      "wind_cdir_full": "Юго-Юго-Западный",
      "slp": 1011.5,
      "datetime": "2023-01-17:12",
      "ts": 1673956800,
      "snow": 0,
      "dewpt": -2,
      "uv": 0,
      "wind_gust_spd": 5.92,
      "wind_dir": 210,
      "ghi": 0,
      "dhi": 0,
      "precip": 0,
      "weather": {
        "description": "Облачно",
        "code": 804,
        "icon": "c04n"
      },
      "temp": 4.1,
      "app_temp": 2.6,
      "timestamp_utc": "2023-01-17T12:00:00",
      "dni": 0,
      "timestamp_local": "2023-01-17T07:00:00",
      "snow_depth": 0,
      "pop": 0,
      "ozone": 293.5,
      "clouds_hi": 100,
      "clouds_low": 0,
      "clouds_mid": 100,
      "solar_rad": 0,
      "wind_cdir": "ЮЮЗ"
    }
  ],
  "lon": -78.5
}
 */
/*
Field Decriptions:
lat: Latitude (Degrees).
lon: Longitude (Degrees).
timezone: Local IANA Timezone.
city_name: City name.
country_code: Country abbreviation.
state_code: State abbreviation/code.
data: [
ts: Unix Timestamp at UTC time.
timestamp_local: Timestamp at local time.
timestamp_utc: Timestamp at UTC time.
datetime: [DEPRECATED] Forecast Valid hour UTC (YYYY-MM-DD:HH).
wind_gust_spd: Wind gust speed (Default m/s).
wind_spd: Wind speed (Default m/s).
wind_dir: Wind direction (degrees).
wind_cdir: Abbreviated wind direction.
wind_cdir_full: Verbal wind direction.
temp: Temperature (default Celcius).
app_temp: Apparent/"Feels Like" temperature (default Celcius).
pop: Probability of Precipitation (%).
precip: Accumulated liquid equivalent precipitation (default mm).
snow: Accumulated snowfall (default mm).
snow_depth: Snow Depth (default mm).
slp: Sea level pressure (mb).
pres: Pressure (mb).
dewpt: Dew point (default Celcius).
rh: Relative humidity (%).
clouds_low: Low-level (~0-3km AGL) cloud coverage (%).
clouds_mid: Mid-level (~3-5km AGL) cloud coverage (%).
clouds_hi: High-level (>5km AGL) cloud coverage (%).
clouds: Cloud coverage (%).
weather: {
icon:Weather icon code.
code:Weather code.
description: Text weather description.
}
pod: Part of the day (d = day / n = night).
uv: UV Index (0-11+).
dhi: Diffuse horizontal solar irradiance (W/m^2) [Clear Sky]
dni: Direct normal solar irradiance (W/m^2) [Clear Sky]
ghi: Global horizontal solar irradiance (W/m^2) [Clear Sky]
solar_rad: Estimated Solar Radiation (W/m^2).
vis: Visibility (default KM).
ozone: Average Ozone (Dobson units).
... ]
*/
