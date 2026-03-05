import Foundation
import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate {

    private let manager = CLLocationManager()

    var onLocationUpdate: ((CLLocation) -> Void)?

    override init() {
        super.init()
        manager.delegate = self
    }

    func requestLocation() {

        manager.requestWhenInUseAuthorization()
        manager.requestLocation()
    }

    func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation]) {

        guard let location = locations.first else { return }
        onLocationUpdate?(location)
    }

    func locationManager(_ manager: CLLocationManager,
                         didFailWithError error: Error) {

        print("Location error:", error.localizedDescription)
    }
}
