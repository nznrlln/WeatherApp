//
//  GeoModel.swift
//  WeatherApp
//
//  Created by Нияз Нуруллин on 31.08.2023.
//

import Foundation

struct GeoModel: Codable {
    let response: Response
}

struct Response: Codable {
    let geoObjectCollection: GeoObjectCollection

    enum CodingKeys: String, CodingKey {
        case geoObjectCollection = "GeoObjectCollection"
    }
}

struct GeoObjectCollection: Codable {
    let featureMember: [FeatureMember]
}

struct FeatureMember: Codable {
    let geoObject: GeoObject

    enum CodingKeys: String, CodingKey {
        case geoObject = "GeoObject"
    }
}

struct GeoObject: Codable {
    let metaDataProperty: MetaDataProperty
    let point: Point

    enum CodingKeys: String, CodingKey {
        case metaDataProperty
        case point = "Point"
    }
}

struct MetaDataProperty: Codable {
    let geocoderMetaData: GeocoderMetaData

    enum CodingKeys: String, CodingKey {
        case geocoderMetaData = "GeocoderMetaData"
    }
}

struct GeocoderMetaData: Codable {
    let adress: String

    enum CodingKeys: String, CodingKey {
        case adress = "text"
    }
}

struct Point: Codable {
    let pos: String

    enum CodingKeys: String, CodingKey {
        case pos = "pos"
    }
}

/*
 {
     "response": {
         "GeoObjectCollection": {
             "metaDataProperty": {
                 "GeocoderResponseMetaData": {
                     "boundedBy": {
                         "Envelope": {
                             "lowerCorner": "-0.250001 -0.250003",
                             "upperCorner": "0.250001 0.250003"
                         }
                     },
                     "request": "kazan",
                     "results": "1",
                     "found": "1"
                 }
             },
             "featureMember": [
                 {
                     "GeoObject": {
                         "metaDataProperty": {
                             "GeocoderMetaData": {
                                 "precision": "other",
                                 "text": "Россия, Республика Татарстан, Казань",
                                 "kind": "locality",
                                 "Address": {
                                     "country_code": "RU",
                                     "formatted": "Россия, Республика Татарстан, Казань",
                                     "Components": [
                                         {
                                             "kind": "country",
                                             "name": "Россия"
                                         },
                                         {
                                             "kind": "province",
                                             "name": "Приволжский федеральный округ"
                                         },
                                         {
                                             "kind": "province",
                                             "name": "Республика Татарстан"
                                         },
                                         {
                                             "kind": "area",
                                             "name": "городской округ Казань"
                                         },
                                         {
                                             "kind": "locality",
                                             "name": "Казань"
                                         }
                                     ]
                                 },
                                 "AddressDetails": {
                                     "Country": {
                                         "AddressLine": "Россия, Республика Татарстан, Казань",
                                         "CountryNameCode": "RU",
                                         "CountryName": "Россия",
                                         "AdministrativeArea": {
                                             "AdministrativeAreaName": "Республика Татарстан",
                                             "SubAdministrativeArea": {
                                                 "SubAdministrativeAreaName": "городской округ Казань",
                                                 "Locality": {
                                                     "LocalityName": "Казань"
                                                 }
                                             }
                                         }
                                     }
                                 }
                             }
                         },
                         "name": "Казань",
                         "description": "Республика Татарстан, Россия",
                         "boundedBy": {
                             "Envelope": {
                                 "lowerCorner": "48.82057 55.60313",
                                 "upperCorner": "49.379394 55.930791"
                             }
                         },
                         "Point": {
                             "pos": "49.106414 55.796127"
                         }
                     }
                 }
             ]
         }
     }
 }
 */
