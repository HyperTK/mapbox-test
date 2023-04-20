//
//  MainView.swift
//  mapbox-test
//
//  Created by 滝野駿 on 2023/04/19.
//

import UIKit
import PanModal
import MapboxMaps

class MainViewComponents: UIView {
    
    weak var delegate: ShowMapStyleModalDelegate? = nil
        
    // 初期化
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // マップ選択ボタン
    let mapStyleButton: UIButton = {
        let mapStyleButton = UIButton()
        var config = UIButton.Configuration.filled()
        config.cornerStyle = .capsule
        config.buttonSize = .large
        config.image = UIImage(systemName: "square.3.layers.3d", withConfiguration: UIImage.SymbolConfiguration(scale: .large))
        config.imagePadding = 8.0
        mapStyleButton.configuration = config
        mapStyleButton.clipsToBounds = true
        return mapStyleButton
    }()
    
    // ロケーションセットボタン
    let myLocationButton: UIButton = {
        let myLocationButton = UIButton()
        var config = UIButton.Configuration.filled()
        config.cornerStyle = .capsule
        config.buttonSize = .large
        config.image = UIImage(systemName: "location.fill", withConfiguration: UIImage.SymbolConfiguration(scale: .large))
        myLocationButton.configuration = config
        
        return myLocationButton
    }()
    
    /**
     Map選択ボタン設定
     */
    private func setupMapStyleButton() {
        mapStyleButton.addTarget(self, action: #selector(showMapSelectView), for: .touchUpInside)
        addSubview(mapStyleButton)
        mapStyleButton.translatesAutoresizingMaskIntoConstraints = false
        mapStyleButton.topAnchor.constraint(equalTo: topAnchor, constant: 60.0).isActive = true
        mapStyleButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10.0).isActive = true
    }
    
    /**
     MyLocationボタン設定
     */
    private func setupMyLocationButton() {
        addSubview(myLocationButton)
        myLocationButton.translatesAutoresizingMaskIntoConstraints = false
        myLocationButton.topAnchor.constraint(equalTo: topAnchor, constant: 120.0).isActive = true
        myLocationButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10.0).isActive = true
    }
    
    @objc func showMapSelectView() {
        print("showMapSelectView")
        self.delegate?.didTapped(didTapped: true)
        //presentPanModal(mapSelectViewController)
    }
    
    private func setupView() {
        setupMapStyleButton()
        setupMyLocationButton()
    }
}
