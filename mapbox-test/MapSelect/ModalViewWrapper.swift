//
//  ModalViewWrapper.swift
//  mapbox-test
//
//  Created by 滝野駿 on 2023/04/21.
//
import SwiftUI

struct ModalViewWrapper: UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> MapSelectViewController {
        return MapSelectViewController()

    }
    
    func updateUIViewController(_ uiViewController: MapSelectViewController, context: Context) {
    }
}
