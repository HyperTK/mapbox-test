//
//  MapSelectView.swift
//  mapbox-test
//
//  Created by 滝野駿 on 2023/04/17.
//

import UIKit
import MapboxMaps

/**
 PanModal内のView
 マップの種別を選択する
 */
class MapSelectView: UIView {
    
    weak var delegate: SelectMapTypeDelegate? = nil
    
    // 初期化
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //private lazy var styleToggle = UISegmentedControl(items: Style.allCases.map(\.name))
    private var style: Style = .satelliteStreets 
    // Map種別を定義したenum
    private enum Style: Int, CaseIterable {
        var name: String {
            switch self {
            case .satelliteStreets:
                return "Satellite"
            case .light:
                return "Light"
            case .outdoors:
                return "Outdoors"
            }
        }
        
        var uri: StyleURI {
            switch self {
            case .satelliteStreets:
                return .satelliteStreets
            case .light:
                return .light
            case .outdoors:
                return .outdoors
            }
        }
        // 以下がenumで定義したcase
        case satelliteStreets
        case light
        case outdoors
    }
    
    let styleToggle: UISegmentedControl = {
        let styleToggle = UISegmentedControl(items: Style.allCases.map(\.name))
        styleToggle.backgroundColor = .black
        styleToggle.selectedSegmentIndex = 0
        return styleToggle
    }()
    

    
    private func setupView() {
        backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        lauoutStyleToggle()
    }
    
    
    private func lauoutStyleToggle() {
        styleToggle.addTarget(self, action: #selector(switchStyle(sender:)), for: .valueChanged)
        addSubview(styleToggle)
        styleToggle.translatesAutoresizingMaskIntoConstraints = false
        styleToggle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 14).isActive = true
        styleToggle.topAnchor.constraint(equalTo: topAnchor, constant: 60).isActive = true
        styleToggle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -14).isActive = true
    }
    
    @objc func switchStyle(sender: UISegmentedControl) {
        style = Style(rawValue: sender.selectedSegmentIndex) ?? .satelliteStreets
        self.delegate?.selectMapType(type: style.uri)
        print(style)
    }
}
