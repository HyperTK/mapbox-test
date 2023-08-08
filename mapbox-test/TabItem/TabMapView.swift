//
//  TabMapView.swift
//  mapbox-test
//
//  Created by 滝野駿 on 2023/04/21.
//

import SwiftUI
import PanModal
import MapboxMaps

/**
 MapViewの設定
 */
struct TabMapView: View {
    @State var isModal: Bool = false
    @State private var selectedValue = 0
    @ObservedObject var mapModel = MapModel()
    
    // Map種別を定義したenum
    private enum Style: Int, CaseIterable {
        // 以下がenumで定義したcase
        case satelliteStreets
        case light
        case outdoors
        
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
    }
    
    var body: some View {
        ZStack {
            MapViewWrapper(mapModel: mapModel)
            HStack(alignment: .lastTextBaseline) {
                
                Spacer()
                VStack{
                    Button(action: {
                        isModal = true
                    }){
                        Image(systemName: "square.3.layers.3d")
                            .frame(width: 50, height: 50)
                            .imageScale(.large)
                            .background(Color.green)
                            .foregroundColor(.white)
                            .clipShape(Circle())
                    }
                    .sheet(isPresented: $isModal, content: {
                        Picker(selection: $selectedValue, label: Text("")) {
                            ForEach(Style.allCases, id: \.self){ item in
                                Text(item.name).tag(item.rawValue)
                            }
                        }
                        .onChange(of: selectedValue, perform: { tag in
                            let style = Style(rawValue: tag) ?? .light
                            mapModel.mapStyle = style.uri
                            print("\(style)")
                        })
                        .pickerStyle(.segmented)
                        .padding()
                        .presentationDetents([.medium])
                        Text("[\(selectedValue)]")
                        Spacer()
                    })
                    Button(action: {
                        
                    }){
                        Image(systemName: "location.fill")
                            .frame(width: 50, height: 50)
                            .imageScale(.large)
                            .background(Color.green)
                            .foregroundColor(.white)
                            .clipShape(Circle())
                    }
                    Spacer()
                }
                .padding(.trailing, 14)
                .padding(.top, 200)
            }
        }
        
    }
}

struct TabMapView_Previews: PreviewProvider {
    static var previews: some View {
        TabMapView()
    }
}
