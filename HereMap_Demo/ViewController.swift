import UIKit
import NMAKit
class ViewController: UIViewController,NMAMapViewDelegate {

    @IBOutlet weak var mapView: NMAMapView!
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        let geoCordinate = NMAGeoCoordinates(latitude: 29.582032, longitude: -95.099224)
        mapView.set(geoCenter: geoCordinate, animation: .none)
        self.mapView.copyrightLogoPosition = NMALayoutPosition.bottomLeft
        // To control the size of text
        mapView.mapPPI = .low
        // To set the resolution
        mapView.useHighResolutionMap = true
        //Seeting up camera zooming
        mapView.zoomLevel = 13
//        mapView.mapScheme = NMAMapSchemeReducedNight
        mapView.delegate = self
        mapView.gestureDelegate = self
        mapView.positionIndicator.isVisible = true
    }
}

//MARK: - TNMAMapViewap Gesture Delegation
extension ViewController: NMAMapGestureDelegate{
    func mapViewDidReceiveTap(_ mapView: NMAMapView, at location: CGPoint) {
        let lat = mapView.geoCoordinates(from: location)?.latitude
        let long = mapView.geoCoordinates(from: location)?.longitude
        print(lat!)
        print(long!)
        let marker = NMAMapMarker(geoCoordinates: NMAGeoCoordinates(latitude: lat!, longitude: long!), image: UIImage(named: "MARKER"))
        mapView.add(marker)
    }
}
