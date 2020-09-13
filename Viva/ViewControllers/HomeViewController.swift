//
//  HomeViewController.swift
//  Viva
//
//  Created by Vivian Zhang on 9/11/20.
//  Copyright © 2020 PennAppsXXI. All rights reserved.
//

import UIKit
import Mapbox

class HomeViewController: UIViewController, MGLMapViewDelegate  {
    
    var source: MGLShapeSource!
    var timer = Timer()
    var searchButton:UIButton!
    var bounds: MGLCoordinateBounds!
    var myLongtitude: Double!
    var myLatitude: Double!
    var trackUser: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let mapView = MGLMapView(frame: view.bounds, styleURL: MGLStyle.lightStyleURL)
        mapView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        mapView.delegate = self
        mapView.tintColor = .lightGray
        
        if (trackUser == false){
            let center = CLLocationCoordinate2D(latitude: myLatitude, longitude: myLongtitude)
            // Starting point
            mapView.setCenter(center, zoomLevel: 13, direction: 0, animated: false)
            
            // Colorado’s bounds
            let northeast = CLLocationCoordinate2D(latitude: myLatitude + 2, longitude: myLongtitude + 3)
            let southwest = CLLocationCoordinate2D(latitude: myLatitude - 2, longitude: myLongtitude - 3)
            bounds = MGLCoordinateBounds(sw: southwest, ne: northeast)
        }
        
        view.addSubview(mapView)
        mapView.maximumZoomLevel = 15.5
        mapView.showsUserLocation = true
        if(trackUser){
            mapView.setUserTrackingMode(.follow, animated: true) {}
        }
        
        addButton()
    }
    
    func addButton(){
        searchButton = UIButton(frame: CGRect(x: (view.frame.width/2) - 100, y: view.frame.height - 150, width: 200, height: 50))
        searchButton.backgroundColor = .white
        searchButton.setTitle("SEARCH",for: .normal)
        searchButton.setTitleColor(UIColor(red: 59/255, green: 178/255, blue: 208/255, alpha: 1), for: .normal)
        searchButton.titleLabel?.font = UIFont(name: "AvenirNext-DemiBold",size:18)
        searchButton.layer.cornerRadius = 25
        searchButton.layer.shadowOffset = CGSize(width: 0, height: 10)
        searchButton.layer.shadowColor = UIColor.black.cgColor
        searchButton.layer.shadowRadius = 5
        searchButton.layer.shadowOpacity = 0.3
        searchButton.addTarget(self, action: #selector(searchButtonWasPressed(_:)), for: .touchUpInside)
        view.addSubview(searchButton)
        
    }
    
    @objc func searchButtonWasPressed(_ sender:UIButton){
        performSegue(withIdentifier: "searchScreen", sender: self)
    }
    
    func mapView(_ mapView: MGLMapView, didFinishLoading style: MGLStyle) {
        //URL NEEDS TO BE CHANGED TO OUR DATA
        guard let url = URL(string: "https://raw.githubusercontent.com/vivianthechic/Viva/master/vivamap.geojson") else { return }
        // Add a source to the map. https://wanderdrone.appspot.com/ generates coordinates for simulated paths.
        source = MGLShapeSource(identifier: "maps", url: url, options: nil)
        style.addSource(source)
        
        // Create a heatmap layer.
        let heatmapLayer = MGLHeatmapStyleLayer(identifier: "maps", source: source)
        
        // Adjust the color of the heatmap based on the point density.
        let colorDictionary: [NSNumber: UIColor] = [
            0.0: .clear,
            0.1: .blue,
            0.3: .cyan,
            0.5: .green,
            0.7: .yellow,
            1: .red
        ]
        heatmapLayer.heatmapColor = NSExpression(format: "mgl_interpolate:withCurveType:parameters:stops:($heatmapDensity, 'linear', nil, %@)", colorDictionary)
        
        // Heatmap weight measures how much a single data point impacts the layer's appearance.
        heatmapLayer.heatmapWeight = NSExpression(format: "mgl_interpolate:withCurveType:parameters:stops:(mag, 'linear', nil, %@)",
                                                  [0: 0,
                                                   6: 1])
        
        // Heatmap intensity multiplies the heatmap weight based on zoom level.
        heatmapLayer.heatmapIntensity = NSExpression(format: "mgl_interpolate:withCurveType:parameters:stops:($zoomLevel, 'linear', nil, %@)",
                                                     [0: 1,
                                                      10: 1])
        heatmapLayer.heatmapRadius = NSExpression(format: "mgl_interpolate:withCurveType:parameters:stops:($zoomLevel, 'linear', nil, %@)",
                                                  [1: 10,
                                                   16: 30])
        
        // The heatmap layer should be visible up to zoom level 9.
        heatmapLayer.heatmapOpacity = NSExpression(format: "mgl_step:from:stops:($zoomLevel, 0.75, %@)", [0: 0.75, 20: 0])
        style.addLayer(heatmapLayer)
        
        // Add a circle layer to represent the earthquakes at higher zoom levels.
        let circleLayer = MGLCircleStyleLayer(identifier: "circle-layer", source: source)
        
        let magnitudeDictionary: [NSNumber: UIColor] = [
            0: .white,
            0.5: .yellow,
            2.5: UIColor(red: 0.73, green: 0.23, blue: 0.25, alpha: 1.0),
            5: UIColor(red: 0.19, green: 0.30, blue: 0.80, alpha: 1.0)
        ]
        circleLayer.circleColor = NSExpression(format: "mgl_interpolate:withCurveType:parameters:stops:(mag, 'linear', nil, %@)", magnitudeDictionary)
        
        // The heatmap layer will have an opacity of 0.75 up to zoom level 9, when the opacity becomes 0.
        circleLayer.circleOpacity = NSExpression(format: "mgl_step:from:stops:($zoomLevel, 0, %@)", [0: 0, 22: 0.75])
        circleLayer.circleRadius = NSExpression(forConstantValue: 20)
        style.addLayer(circleLayer)
        
        // Create a timer that calls the `updateUrl` function every 1.5 seconds.
        //REMOVE TIMER IF NOT NEEDED
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: #selector(updateUrl), userInfo: nil, repeats: true)
        
        //}
    }
    
    func mapView(_ mapView: MGLMapView, shouldChangeFrom oldCamera: MGLMapCamera, to newCamera: MGLMapCamera) -> Bool {
        
        // Get the current camera to restore it after.
        if(trackUser == false){
            let currentCamera = mapView.camera
            
            // From the new camera obtain the center to test if it’s inside the boundaries.
            let newCameraCenter = newCamera.centerCoordinate
            
            // Set the map’s visible bounds to newCamera.
            mapView.camera = newCamera
            let newVisibleCoordinates = mapView.visibleCoordinateBounds
            
            // Revert the camera.
            mapView.camera = currentCamera
            
            // Test if the newCameraCenter and newVisibleCoordinates are inside self.bounds.
            let inside = MGLCoordinateInCoordinateBounds(newCameraCenter, self.bounds)
            let intersects = MGLCoordinateInCoordinateBounds(newVisibleCoordinates.ne, self.bounds) && MGLCoordinateInCoordinateBounds(newVisibleCoordinates.sw, self.bounds)
            
            return inside && intersects
        }
        return true
    }
    
    @objc func updateUrl() {
        // Update the icon's position by setting the `url` property on the source.
        source.url = source.url
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        // Invalidate the timer if the view will disappear.
        timer.invalidate()
        timer = Timer()
    }
}
