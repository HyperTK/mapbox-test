//
//  MapSelectModal.swift
//  mapbox-test
//
//  Created by 滝野駿 on 2023/04/21.
//

import SwiftUI
import PanModal

struct MapSelectModal: View {
    var body: some View {
        Text("Hello, PanModal!")
    }
}

extension View {
    func presentModal<Content: View>(displayPanModal: Binding<Bool>, @ViewBuilder content: @escaping () -> Content) -> some View {
        self.onChange(of: displayPanModal.wrappedValue) { value in
            let topMostController = self.topMostController()
            if (value && !topMostController.isPanModalPresented) {
                DispatchQueue.main.async {
                    topMostController.presentPanModal(BasicViewController(modalContent: content(), displayPanModal: displayPanModal))
                }
            }
        }
    }
    
    func topMostController() -> UIViewController {
        var topController: UIViewController = UIApplication.shared.windows.filter {$0.isKeyWindow}.first!.rootViewController!
        while (topController.presentedViewController != nil) {
            topController = topController.presentedViewController!
        }
        return topController
    }
}
