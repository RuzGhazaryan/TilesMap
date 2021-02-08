//
//  MapViewController.swift
//  TilesMap
//
//  Created by Ruzanna Ghazaryan on 2/7/21.
//

import UIKit
import Mapbox

class MapViewController: UIViewController {
    private var mapView: MGLMapView!
    private var farm: Farm
    private var tilePath: String?
    
    init(farm: Farm, tilePath: String?) {
        self.farm = farm
        self.tilePath = tilePath
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupMap()
    }
    
    private func setupMap(){
        mapView = MGLMapView(frame: view.bounds)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        if let lat = farm.latitude, let long = farm.longitude {
            mapView.setCenter(CLLocationCoordinate2D(latitude: lat, longitude: long), zoomLevel: 12, animated: false)
        }
        mapView.delegate = self
        view.addSubview(mapView)
    }
    
    private func drawFarmPolyline() {
        guard let data = farm.geometry?.data(using: .utf8) else { return }
        guard let style = self.mapView.style else { return }
        guard let shapeFromGeoJSON = try? MGLShape(data: data, encoding: String.Encoding.utf8.rawValue) else {
            fatalError("Could not generate MGLShape")
        }
        
        let source = MGLShapeSource(identifier: "polyline", shape: shapeFromGeoJSON, options: nil)
        style.addSource(source)
        
        let layer = MGLLineStyleLayer(identifier: "polyline", source: source)
        layer.lineJoin = NSExpression(forConstantValue: "round")
        layer.lineCap = NSExpression(forConstantValue: "round")
        layer.lineColor = NSExpression(forConstantValue: UIColor.systemBlue)
        layer.lineWidth = NSExpression(format: "mgl_interpolate:withCurveType:parameters:stops:($zoomLevel, 'linear', nil, %@)",
                                       [14: 2, 18: 20])
        style.addLayer(layer)
    }
}

extension  MapViewController: MGLMapViewDelegate {
    func mapView(_ mapView: MGLMapView, didFinishLoading style: MGLStyle) {
        drawFarmPolyline()
        let source = MGLRasterTileSource(identifier: "", tileURLTemplates: [tilePath ?? ""], options: [
            .minimumZoomLevel: 2,
            .maximumZoomLevel: 21,
            .tileSize: 256,
        ])
        let rasterLayer = MGLRasterStyleLayer(identifier: "", source: source)
        style.addSource(source)
        style.addLayer(rasterLayer)
    }
}
