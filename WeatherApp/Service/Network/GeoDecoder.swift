//
//  GeoDecoder.swift
//  WeatherApp
//
//  Created by Нияз Нуруллин on 01.09.2023.
//

import Foundation

protocol IGeoDecoder {
    func convertToCity(_ geo: GeoModel) async -> CityModel?
}

final class GeoDecoder: IGeoDecoder {

    // MARK: - IGeoDecoder
    func convertToCity(_ geo: GeoModel) async -> CityModel? {
        guard let coordinates = await getCoordinates(geo) else { return nil }
        guard let name = await getName(geo) else { return nil }

        let uid = name.city + name.country + coordinates.longitude + coordinates.latitude

        return CityModel(
            city: name.city,
            country: name.country,
            lon: coordinates.longitude,
            lat: coordinates.latitude,
            uid: uid
        )
    }

    // MARK: - Methods
    private func getCoordinates(_ geoModel: GeoModel) async -> (longitude: String, latitude: String)? {
        let featureMember = geoModel.response.geoObjectCollection.featureMember
        if !featureMember.isEmpty {
            let coordiatesArray = featureMember[0].geoObject.point.pos.components(separatedBy: " ")
            let lon = (coordiatesArray[0])
            let lat = (coordiatesArray[1])

            return (longitude: lon, latitude: lat)
        }

        return nil
    }

    private func getName(_ geoModel: GeoModel) async -> (country: String, city: String)? {
        let featureMember = geoModel.response.geoObjectCollection.featureMember
        if !featureMember.isEmpty {
            let namesArray = featureMember[0].geoObject.metaDataProperty.geocoderMetaData.adress.components(separatedBy: ", ")
            if namesArray.count >= 2 {
                let countyName = namesArray.first!
                let cityName = namesArray.last!
                return (country: countyName, city: cityName)
            }
        }

        return nil
    }
}
