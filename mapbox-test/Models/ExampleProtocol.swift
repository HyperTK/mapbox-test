//
//  ExampleProtocol.swift
//  mapbox-test
//
//  Created by 滝野駿 on 2023/04/05.
//

import Foundation
import MapboxMaps

public protocol ExampleProtocol: AnyObject {
    func resourceOptions() -> ResourceOptions
    func finish()
}

extension ExampleProtocol where Self: UIViewController {
    // Presents an alert with a given title.
    public func showAlert(with title: String) {
        let alertController = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
}
