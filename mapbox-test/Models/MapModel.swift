//
//  MapModel.swift
//  mapbox-test
//
//  Created by 滝野駿 on 2023/08/08.
//

import MapboxMaps

class MapModel: ObservableObject {
    
    @Published var mapStyle: StyleURI = .satelliteStreets
    @Published var isSetCameraCenter: Bool = false
}
