//
//  BasicViewController.swift
//  mapbox-test
//
//  Created by 滝野駿 on 2023/04/24.
//


import UIKit
import SwiftUI
import PanModal

class BasicViewController<Content: View>: UIViewController {
    
    let modalContent: Content
    let displayPanModal: Binding<Bool>
    
    init(modalContent: Content, displayPanModal: Binding<Bool>) {
        self.modalContent = modalContent
        self.displayPanModal = displayPanModal
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let hostingController = UIHostingController(rootView: modalContent)
        addChild(hostingController)
        view.addSubview(hostingController.view)
        hostingController.didMove(toParent: self)
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        hostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        hostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        hostingController.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        hostingController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}

extension BasicViewController: PanModalPresentable {
    
    var panScrollable: UIScrollView? {
        return nil
    }
    
    var shortFormHeight: PanModalHeight {
        return .contentHeight(200)
    }
    
    var longFormHeight: PanModalHeight {
        return .maxHeightWithTopInset(40)
    }
    
    var anchorModalToLongForm: Bool {
        return false
    }
    
    func shouldRoundTopCorners() -> Bool {
        return true
    }
    
    func panModalWillDismiss() {
        displayPanModal.wrappedValue = false
    }
    
}
