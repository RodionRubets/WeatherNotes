import Foundation
import CoreLocation
import Combine

class NotesViewModel: ObservableObject {
    @Published var notes: [Note] = []
    @Published var errorMasage: String?
    
    private let weatherService = WeatherService()
    private let storage = StorageManager()
    private let locationManager = LocationManager()

}
