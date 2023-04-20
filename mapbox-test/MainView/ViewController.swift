//
//  ViewController.swift
//  mapbox-test
//
//  Created by 滝野駿 on 2023/04/05.
//

import UIKit
import MapboxMaps

public class ViewController: UIViewController {
    
    private var mapView: MapView!
    private var cameraLocationConsumer: CameraLocationConsumer!
    private lazy var toggleBearingImageButton = UIButton(frame: .zero)

    // マップスタイル
    private var style: StyleURI = .satelliteStreets {
        // プロパティの監視
        didSet {
            mapView.mapboxMap.style.uri = style
        }
    }
    
    private var showsBearingImage: Bool = false {
        didSet {
            syncPuckAndButton()
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
        
        
        setupDelegate()
        setupMainViewComponents()
        
        self.view.addSubview(mapView)

        // Setup and create button for toggling show bearing image
        setupToggleShowBearingImageButton()
        
        cameraLocationConsumer = CameraLocationConsumer(mapView: mapView)
        
        // Add user position icon to the map with location indicator layer
        mapView.location.options.puckType = .puck2D()
        
        // デリゲートがマップ イベントに関する情報を受信できるようにします
        mapView.mapboxMap.onNext(.mapLoaded) { [weak self] _ in
            guard let self = self else { return }
            // ロケーションコンシューマをマップに登録します
            // ロケーションマネージャはコンシューマへの弱参照を保持していることに注意してください。これは保持する必要があります
            self.mapView.location.addLocationConsumer(newConsumer: self.cameraLocationConsumer)
        }
    }
    
    /**
     delegate設定
     */
    private func setupDelegate() {
        mapSelectViewController.delegate = self
        mainViewComponents.delegate = self
    }
    
    private func setupMainViewComponents() {
        self.view.addSubview(mainViewComponents)
        mainViewComponents.translatesAutoresizingMaskIntoConstraints = false
        mainViewComponents.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        //mainViewComponents.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        mainViewComponents.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        mainViewComponents.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    override public func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    @objc func showHideBearingImage() {
        showsBearingImage.toggle()
    }
    
    func syncPuckAndButton() {
        // Update puck config
        let configration = Puck2DConfiguration()
        
        mapView.location.options.puckType = .puck2D()
        
        // Update button title
        let title: String = showsBearingImage ? "Hide bearing Image" : "Show bearing image"
        toggleBearingImageButton.setTitle(title, for: .normal)
    
    }
    
    private func setupToggleShowBearingImageButton() {
        // Styling
        toggleBearingImageButton.backgroundColor = .systemBlue
        toggleBearingImageButton.addTarget(self, action: #selector(showHideBearingImage), for: .touchUpInside)
        toggleBearingImageButton.setTitleColor(.white, for: .normal)
        toggleBearingImageButton.layer.cornerRadius = 4
        toggleBearingImageButton.clipsToBounds = true
        toggleBearingImageButton.contentEdgeInsets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        
        toggleBearingImageButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(toggleBearingImageButton)
        
        // Constraints
        toggleBearingImageButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20.0).isActive = true
        toggleBearingImageButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20.0).isActive = true
        toggleBearingImageButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -70.0).isActive = true
        
        syncPuckAndButton()
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


/**
 LocationConsumerに準拠したクラスを作成し、locationUpdate受信時にカメラのcenterCoordinateを更新する
 */
public class CameraLocationConsumer: LocationConsumer {
    weak var mapView: MapView?
    
    init(mapView: MapView? = nil) {
        self.mapView = mapView
    }
    
    public func locationUpdate(newLocation: Location) {
        var cameraOptions = CameraOptions(center: newLocation.coordinate, zoom: 15)
        mapView?.camera.ease(to: cameraOptions, duration: 1.3)
    }
}
