//
//  File.swift
//  WeatherApp
//
//  Created by Нияз Нуруллин on 01.09.2023.
//

import Foundation

struct CurrentWeatherJSONData: Codable {
    let data: [CurrentWeatherModel]

    enum CodingKeys: String, CodingKey {
        case data = "data"
    }
}

//struct CurrentWeatherModel: Codable {
//    let temperature: Double
////    let temperatureMin: Double
////    let temperatureMax: Double
//    let weather: WeatherModel
//
//    enum CodingKeys: String, CodingKey {
//        case temperature = "temp"
////        case temperatureMin
////        case temperatureMax
//        case weather = "weather"
//    }
//}
//
//struct WeatherModel: Codable {
//    let description: String
//    let iconCode: String
//
//    enum CodingKeys: String, CodingKey {
//        case description = "description"
//        case iconCode = "icon"
//    }
//}

/*
{
  "count": 1,
  "data": [
    {
      "app_temp": -105.4,
      "aqi": 24,
      "city_name": "Port-aux-Français",
      "clouds": 100,
      "country_code": "TF",
      "datetime": "2023-09-02:19",
      "dewpt": -80.4,
      "dhi": 0,
      "dni": 0,
      "elev_angle": -19.4,
      "ghi": 0,
      "gust": 3,
      "h_angle": -90,
      "lat": -78.5,
      "lon": 38.5,
      "ob_time": "2023-09-02 19:49",
      "pod": "n",
      "precip": 0,
      "pres": 597,
      "rh": 23,
      "slp": 1071.1265,
      "snow": 0,
      "solar_rad": 0,
      "sources": [
        "analysis",
        "radar",
        "satellite"
      ],
      "state_code": "03",
      "station": "G0697",
      "sunrise": "05:32",
      "sunset": "13:06",
      "temp": -70.9,
      "timezone": "Africa/Johannesburg",
      "ts": 1693684150,
      "uv": 0,
      "vis": 16,
      "weather": {
        "description": "Overcast clouds",
        "code": 804,
        "icon": "c04n"
      },
      "wind_cdir": "ENE",
      "wind_cdir_full": "east-northeast",
      "wind_dir": 59,
      "wind_spd": 3.17976
    }
  ]
}
*/
