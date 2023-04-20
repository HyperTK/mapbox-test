//
//  MapSelectProtocol.swift
//  mapbox-test
//
//  Created by 滝野駿 on 2023/04/12.
//

import MapboxMaps

/**
 デリゲートメソッド
 */
/**
 MapTypeの変更をViewControllerへ伝える
 */
protocol MapTypeChangeDelegate : AnyObject {
    func didChangedMapType(type: StyleURI)
}

/**
 MapTypeを選択した結果を取得する
 */
protocol SelectMapTypeDelegate : AnyObject {
    func selectMapType(type: StyleURI)
}
