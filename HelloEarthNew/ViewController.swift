//
//  ViewController.swift
//  HelloEarthNew
//
//  Created by Akshay Ayyanchira on 5/22/18.
//  Copyright © 2018 Akshay Ayyanchira. All rights reserved.
//

import UIKit
import WhirlyGlobe

class ViewController: UIViewController, WhirlyGlobeViewControllerDelegate {

    private var theViewC: MaplyBaseViewController?
    private var globeViewC: WhirlyGlobeViewController?
    private var mapViewC: MaplyViewController?
    var labels = [MaplyScreenLabel]()
    private let doGlobe = true
    var latLongLines = [MaplyShapeGreatCircle]()
    
    var longitudes:MaplyComponentObject?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if doGlobe {
            globeViewC = WhirlyGlobeViewController()
            theViewC = globeViewC
        }
        else {
            mapViewC = MaplyViewController()
            theViewC = mapViewC
        }
        
        self.view.addSubview(theViewC!.view)
        theViewC!.view.frame = self.view.bounds
        addChildViewController(theViewC!)
        
        // we want a black background for a globe, a white background for a map.
        theViewC!.clearColor = (globeViewC != nil) ? UIColor.black : UIColor.white
        
        // and thirty fps if we can get it ­ change this to 3 if you find your app is struggling
        theViewC!.frameInterval = 2
        
        // set up the data source
        if let tileSource = MaplyMBTileSource(mbTiles: "geography-class_medres"),
            let layer = MaplyQuadImageTilesLayer(coordSystem: tileSource.coordSys, tileSource: tileSource){
            layer.handleEdges = (globeViewC != nil)
            layer.coverPoles = (globeViewC != nil)
            layer.requireElev = false
            layer.waitLoad = false
            layer.drawPriority = 0
            layer.singleLevelLoading = false
            
            globeViewC!.add(layer)
        }
        
        // start up over Madrid, center of the old-world
        if let globeViewC = globeViewC {
            globeViewC.height = 0.8
            globeViewC.animate(toPosition: MaplyCoordinateMakeWithDegrees(-3.6704803, 40.5023056), time: 1.0)
        }
        else if let mapViewC = mapViewC {
            mapViewC.height = 1.0
            mapViewC.animate(toPosition: MaplyCoordinateMakeWithDegrees(-3.6704803, 40.5023056), time: 1.0)
        }
        //WhirlyGlobeViewControllerSimpleAnimationDelegate = self
        
        
        drawLabel()
        addspheres()
//        addcircles1()
        drawLatLong()
        //anotherCircle()
    }

    
    func drawLine(){
        let cordinate3d = MaplyCoordinate3d(x: 35.306938, y: -80.724113, z: 2)
      //  MaplyShapeLinear(coords: <#T##UnsafeMutablePointer<MaplyCoordinate3d>!#>, numCoords: <#T##Int32#>)
       //let simpleLine = MaplyShapeLinear(coords: cordinate3d, numCoords: 2)
    }
    
    func globeViewController(_ viewC: WhirlyGlobeViewController!, didMove corners: UnsafeMutablePointer<MaplyCoordinate>!) {
        print("Map moved")    }
    
    func drawLabel() {
        let labelOne = MaplyScreenLabel()
        labelOne.text = "Hello"
        labelOne.color = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        labels.append(labelOne)
        labelOne.loc = MaplyCoordinate(x: 35.306938, y: -80.724113)
        globeViewC!.addScreenLabels(labels, desc: [
            kMaplyFont: UIFont.boldSystemFont(ofSize: 18.0),
            kMaplyTextOutlineColor: UIColor.black,
            kMaplyTextOutlineSize: 2.0,
            kMaplyColor: UIColor.white
            ])
    }
    
    private func addspheres()
    {
        let capitals = [MaplyCoordinateMakeWithDegrees(-77.036667, 38.895111),
                        MaplyCoordinateMakeWithDegrees(120.966667, 14.583333),
                        MaplyCoordinateMakeWithDegrees(55.75, 37.616667),
                        MaplyCoordinateMakeWithDegrees(-0.1275, 51.507222),
                        MaplyCoordinateMakeWithDegrees(-66.916667, 10.5),
                        MaplyCoordinateMakeWithDegrees(139.6917, 35.689506),
                        MaplyCoordinateMakeWithDegrees(166.666667, -77.85),
                        MaplyCoordinateMakeWithDegrees(-58.383333, -34.6),
                        MaplyCoordinateMakeWithDegrees(-74.075833, 4.598056),
                        MaplyCoordinateMakeWithDegrees(-79.516667, 8.983333)]
        
        
        
        // convert capitals into spheres. Let's do it functional!
        let spheres = capitals.map { capital -> MaplyShapeSphere in
            let sphere = MaplyShapeSphere()
            sphere.center = capital
            sphere.radius = 0.01
            return sphere
        }
        
        self.theViewC?.addShapes(spheres, desc: [
            kMaplyColor: UIColor(red: 0.75, green: 0.0, blue: 0.0, alpha: 0.75)])
    }
    
    func drawLatLong(){
        drawLong()
        drawLat()
        longitudes = theViewC?.addShapes(latLongLines, desc: [
            kMaplyColor : UIColor.blue])
    }
    
    func drawLat(){
//        for y in 1...36{
//
//            let latfirstHalfCircle = MaplyShapeGreatCircle()
//            latfirstHalfCircle.startPt = MaplyCoordinateMakeWithDegrees(0, Float(y*10))
//            latfirstHalfCircle.endPt = MaplyCoordinateMakeWithDegrees(179,Float(y*10))
//            latfirstHalfCircle.lineWidth = 4.0
//            latfirstHalfCircle.height = 0.008
//            latLongLines.append(latfirstHalfCircle)
//
//            let latSecondHalfCircle = MaplyShapeGreatCircle()
//            latSecondHalfCircle.startPt = MaplyCoordinateMakeWithDegrees(-179, Float(y*10))
//            latSecondHalfCircle.endPt = MaplyCoordinateMakeWithDegrees(-1,Float(y*10))
//            latSecondHalfCircle.lineWidth = 4.0
//            latSecondHalfCircle.height = 0.008
//            latLongLines.append(latSecondHalfCircle)
//        }
        for y in stride(from: -8.5, to: 8.5, by: 0.5){
            for x in 1...36{
                let latLongCircle = MaplyShapeGreatCircle()
                latLongCircle.startPt = MaplyCoordinateMakeWithDegrees(Float(x*10), Float(y*10))
                latLongCircle.endPt = MaplyCoordinateMakeWithDegrees(Float((x+1)*10),Float(y*10))
                latLongCircle.lineWidth = 2.0
                latLongCircle.height = 0.006
                latLongLines.append(latLongCircle)
            }
        }
    }
    
    
    func drawLong(){
        for x in 1...36{
            let latLongCircle = MaplyShapeGreatCircle()
            latLongCircle.startPt = MaplyCoordinateMakeWithDegrees(Float(x*10), 85)
            latLongCircle.endPt = MaplyCoordinateMakeWithDegrees(Float(x*10),-85)
            latLongCircle.lineWidth = 2.0
            latLongCircle.height = 0.006
            latLongLines.append(latLongCircle)
        }
        
    }
    
    private func addcircles1()
    {
        let capitals = [MaplyCoordinateMakeWithDegrees(0, 80),
                        MaplyCoordinateMakeWithDegrees(120.966667, 14.583333)]
        
        
        // convert capitals into spheres. Let's do it functional!
        let line = capitals.map { capital -> MaplyShapeGreatCircle in
            let greatCircle = MaplyShapeGreatCircle()
            greatCircle.startPt =  MaplyCoordinateMakeWithDegrees(0, 80)
            greatCircle.endPt = MaplyCoordinateMakeWithDegrees(179, 80)
            greatCircle.lineWidth = 5.0
            greatCircle.height = 0.008
            
            // greatCircle.selectable = true;
            return greatCircle
        }
        
        self.theViewC?.addShapes(line, desc: [
            kMaplyColor: UIColor(red: 0.75, green: 0.0, blue: 0.60, alpha: 0.50)])
        
    }
    
    
    func anotherCircle(){
        let latCircle = MaplyShapeCircle()
        latCircle.center = MaplyCoordinateMake(0, 0)
        latCircle.radius = 0.5
        latCircle.height = 0.08
        var mapshapeArray = [MaplyShapeCircle]()
        mapshapeArray.append(latCircle)
        theViewC?.addShapes(mapshapeArray, desc: [
            kMaplyColor: UIColor(red: 0.75, green: 0.0, blue: 0.60, alpha: 0.50)])
    }
    

    
}

