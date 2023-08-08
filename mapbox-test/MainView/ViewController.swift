//
//  ViewController.swift
//  mapbox-test
//
//  Created by 滝野駿 on 2023/04/05.
//

import SwiftUI
import MapboxMaps

public class ViewController: UIViewController {
    
    private var mapView: MapView!
    private var cameraLocationConsumer: CameraLocationConsumer!

    // マップスタイル
    private var style: StyleURI = .satelliteStreets {
        // プロパティの監視
        didSet {
            mapView.mapboxMap.style.uri = style
        }
    }
    
    var mapStyle: StyleURI = .satelliteStreets {
        didSet {
            mapView.mapboxMap.style.uri = mapStyle
        }
    }
    
    // マップスタイル選択View
    let mapSelectViewController: MapSelectViewController = {
        let mapSelectViewController = MapSelectViewController()
        return mapSelectViewController
    }()
    // マップ上のコンポーネント
    let mainViewComponents: MainViewComponents = {
        let mainViewComponents = MainViewComponents()
        return mainViewComponents
    }()
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        // Info.plistから取得
        let accessToken = Bundle.main.object(forInfoDictionaryKey: "MBXAccessToken") as! String
        let myResourceOptions = ResourceOptions(accessToken: accessToken)
        let myMapInitOptions = MapInitOptions(resourceOptions: myResourceOptions,
                                              styleURI: style)
        mapView = MapView(frame: view.bounds, mapInitOptions:  myMapInitOptions)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        // delegateを設定する
        setupDelegate()
        self.view.addSubview(mapView)
        setupMainViewComponents()
        
        cameraLocationConsumer = CameraLocationConsumer(mapView: mapView)
        
        // 現在地を示すアイコンの設定
        mapView.location.options.puckType = .puck2D(.makeDefault(showBearing: true))
        mapView.location.options.puckBearingSource = .heading

        // デリゲートがマップ イベントに関する情報を受信できるようにします
        mapView.mapboxMap.onNext(event: .mapLoaded) { [weak self] _ in
            guard let self = self else { return }
            if let currentLocation = self.mapView.location.latestLocation {
                let cameraOptions = CameraOptions(center: currentLocation.coordinate, zoom: 15)
                self.mapView.mapboxMap.setCamera(to: cameraOptions)
                //self.mapView.camera.fly(to: cameraOptions, duration: 2.0)
            }
            //self.mapView.location.addLocationConsumer(newConsumer: self.cameraLocationConsumer)
        }
    }
    
    override public func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    /**
     delegate設定
     */
    private func setupDelegate() {
        mapSelectViewController.delegate = self
        mainViewComponents.showMapStyleModalDelegate = self
        mainViewComponents.setCameraCenterDelegate = self
    }
    
    /**
     Map上のコンポーネントをViewに追加
     */
    private func setupMainViewComponents() {
        self.view.addSubview(mainViewComponents)
        mainViewComponents.translatesAutoresizingMaskIntoConstraints = false
        mainViewComponents.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        mainViewComponents.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        mainViewComponents.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        mainViewComponents.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}

/**
 マップスタイル変更を処理するdelegate
 */
extension ViewController: MapTypeChangeDelegate {
    func didChangedMapType(type: StyleURI) {
        style = type
        print("didChangedMapType:\(type)")
    }
}

/**
 マップ制御に関するdelegate
 */
extension ViewController : ShowMapStyleModalDelegate {
    func didTapped(didTapped: Bool) {
        presentPanModal(mapSelectViewController)
    }
}

extension ViewController : SetCameraCenterDelegate {
    func setUserLocation() {
        if let currentLocation = self.mapView.location.latestLocation {
            let cameraOptions = CameraOptions(center: currentLocation.coordinate, zoom: 15)
            self.mapView.camera.fly(to: cameraOptions, duration: 2.0)
        }
    }
}

/**
 LocationConsumerに準拠したクラスを作成し、locationUpdate受信時にカメラのcenterCoordinateを更新する
 */
public class CameraLocationConsumer: LocationConsumer {
    weak var mapView: MapView?
    
    init(mapView: MapView? = nil) {
        self.mapView = mapView
    }
    
    public func locationUpdate(newLocation: Location) {
        let cameraOptions = CameraOptions(center: newLocation.coordinate, zoom: 15)
        mapView?.camera.ease(to: cameraOptions, duration: 1.3)
    }
}
