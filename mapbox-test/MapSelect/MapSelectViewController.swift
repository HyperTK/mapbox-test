//
//  File.swift
//  mapbox-test
//
//  Created by 滝野駿 on 2023/04/11.
//

import UIKit
import PanModal
import MapboxMaps

class MapSelectViewController: UIViewController, SelectMapTypeDelegate {
    
    weak var delegate: MapTypeChangeDelegate? = nil
    
    // UIViewのマップ選択結果をdelegateで取得
    func selectMapType(type: StyleURI) {
        self.delegate?.didChangedMapType(type: type)
        print("selectMapType:\(type)")
    }
    
    private let mapSelectViewHeight: CGFloat = 300
    
    let mapSelectView: MapSelectView = {
        let mapSelectView = MapSelectView()
        mapSelectView.layer.cornerRadius = 10
        return mapSelectView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // delegate設定
        mapSelectView.delegate = self
        setupView()
    }
    
    private func setupView() {
        view.addSubview(mapSelectView)
        mapSelectView.translatesAutoresizingMaskIntoConstraints = false
        mapSelectView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        mapSelectView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        mapSelectView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        mapSelectView.heightAnchor.constraint(equalToConstant: mapSelectViewHeight).isActive = true
    }
}

extension MapSelectViewController: PanModalPresentable {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    var panScrollable: UIScrollView? {
        return nil
    }
    
    var longFormHeight: PanModalHeight {
        return .contentHeight(mapSelectViewHeight)
    }
    
    var anchorModalToLongForm: Bool {
        return false
    }
}

