import UIKit
import NMAKit
class VC2: UIViewController,NMAMapViewDelegate {
    @IBOutlet weak var mapView: NMAMapView!
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        let geoCordinate = NMAGeoCoordinates(latitude: 29.582032, longitude: -95.099224)
        mapView.set(geoCenter: geoCordinate, animation: .none)
        self.mapView.copyrightLogoPosition = NMALayoutPosition.bottomLeft
        mapView.mapPPI = .low
        mapView.zoomLevel = 13
        mapView.delegate = self
        routeCaluculation()
    }
    
    //MARK: -  route Calculation
    func routeCaluculation(){
        //Routing Manager
        let routeManager = NMARouteManager.shared()
        routeManager.delegate = self
        //Intermediate Location
        var viaPoints = [NMAGeoCoordinates]()
        viaPoints.append(NMAGeoCoordinates(latitude: 29.581826, longitude: -95.098966))
        viaPoints.append(NMAGeoCoordinates(latitude: 29.560397, longitude: -95.089982))
        //CustomizeRouting Mode
        let modeOfRouting = NMARoutingMode(routingType: .fastest, transportMode: .car, routingOptions: 0)
        
        //Request for routing  by routing manager
        routeManager.calculateRoute(stops: viaPoints, mode: modeOfRouting!)
        
    }
}

//MARK: - NMARouteManagerDelegate To get the routing result
extension VC2: NMARouteManagerDelegate{
    func routeManagerDidCalculate(_ routeManager: NMARouteManager, routes: [NMARoute]?, error: NMARouteManagerError, violatedOptions: [NSNumber]?) {
        guard (routes?.count)! > 0 else{
            print(error)
            return
        }
        let routesData = routes![0]
        let mapRoute = NMAMapRoute(route: routesData)
        mapView.add(mapRoute)
    }
}
