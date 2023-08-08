//
//  MapButtonProtocol.swift
//  mapbox-test
//
//  Created by 滝野駿 on 2023/04/20.
//


/**
 Map制御ボタンに関するデリゲートメソッド
 */
protocol ShowMapStyleModalDelegate : AnyObject {
    func didTapped(didTapped: Bool)
}

protocol SetCameraCenterDelegate : AnyObject {
    func setUserLocation()
}
