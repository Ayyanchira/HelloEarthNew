//
//  ViewController.swift
//  HelloEarthNew
//
//  Created by Akshay Ayyanchira on 5/22/18.
//  Copyright © 2018 Akshay Ayyanchira. All rights reserved.
//

import UIKit
import WhirlyGlobe

class ViewController: UIViewController {

    private var theViewC: MaplyBaseViewController?
    private var globeViewC: WhirlyGlobeViewController?
    private var mapViewC: MaplyViewController?
    var labels = [MaplyScreenLabel]()
    private let doGlobe = true
    
    
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
        
        drawLabel()
        addspheres()
        addcircles1()
    }

    
    func drawLine(){
        let cordinate3d = MaplyCoordinate3d(x: 35.306938, y: -80.724113, z: 2)
      //  MaplyShapeLinear(coords: <#T##UnsafeMutablePointer<MaplyCoordinate3d>!#>, numCoords: <#T##Int32#>)
       //let simpleLine = MaplyShapeLinear(coords: cordinate3d, numCoords: 2)
    }
    
    
    func drawLabel() {
        let labelOne = MaplyScreenLabel()
    
        labelOne.text = "Hello"
        labelOne.color = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        labels.append(labelOne)
        labelOne.loc = MaplyCoordinate(x: 35.306938, y: -80.724113)
        let description = [
            kMaplyTextColor: UIColor.red,
            kMaplyBackgroundColor: UIColor.white,
            //kMaplyFont: UIFont(name:"Times New Roman", size: 10),
            kMaplyLabelHeight: 2
            ] as [String : Any]
        //let component = globeViewC?.addLabels(labels, desc: description, mode: MaplyThreadAny)
        //globeViewC?.addLabels([labelOne], desc: description)
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
    
    
    private func addcircles1()
    {
        let capitals = [MaplyCoordinateMakeWithDegrees(-77.036667, 38.895111),
                        MaplyCoordinateMakeWithDegrees(120.966667, 14.583333)]
        
        
        // convert capitals into spheres. Let's do it functional!
        let line = capitals.map { capital -> MaplyShapeGreatCircle in
            let greatCircle = MaplyShapeGreatCircle()
            greatCircle.startPt =  MaplyCoordinateMakeWithDegrees(-77.036667, 38.895111)
            greatCircle.endPt = MaplyCoordinateMakeWithDegrees(120.966667, 14.583333)
            greatCircle.lineWidth = 5.0
            greatCircle.height = 0.00
            
            // greatCircle.selectable = true;
            return greatCircle
        }
        
        self.theViewC?.addShapes(line, desc: [
            kMaplyColor: UIColor(red: 0.75, green: 0.0, blue: 0.0, alpha: 0.75)])
        
    }
    

    
}

