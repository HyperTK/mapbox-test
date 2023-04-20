//
//  AlertViewController.swift
//  mapbox-test
//
//  Created by 滝野駿 on 2023/04/17.
//

import UIKit
import PanModal

class AlertViewController: UIViewController, PanModalPresentable {
    
    private let alertViewHeight: CGFloat = 68
    
    let alertView: AlertView = {
        let alertView = AlertView()
        alertView.layer.cornerRadius = 10
        return alertView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        view.addSubview(alertView)
        alertView.translatesAutoresizingMaskIntoConstraints = false
        alertView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        alertView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        alertView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        alertView.heightAnchor.constraint(equalToConstant: alertViewHeight).isActive = true
    }
    
    // MARK: - PanModalPresentable
    var panScrollable: UIScrollView? {
        return nil
    }
    
    var shortFormHeight: PanModalHeight {
        return .contentHeight(alertViewHeight)
    }
    
    var longFormHeight: PanModalHeight {
        return shortFormHeight
    }
    
    var panModalBackgroundColor: UIColor {
        return UIColor.black.withAlphaComponent(0.1)
    }
    
    var shouldRoundTopCorners: Bool {
        return false
    }
    
    var showDragIndicator: Bool {
        return true
    }
    
    var anchorModalToLongForm: Bool {
        return false
    }
    
    var isUserInteractionEnabled: Bool {
        return true
    }
}
