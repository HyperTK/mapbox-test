//
//  MapViewWrapper.swift
//  mapbox-test
//
//  Created by 滝野駿 on 2023/04/05.
//
import SwiftUI

struct MapViewWrapper : UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> ViewController {
        return ViewController()
    }
    
    func updateUIViewController(_ uiViewController: ViewController, context: Context) {
        
    }
}
