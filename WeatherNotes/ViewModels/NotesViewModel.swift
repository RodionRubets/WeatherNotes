import Foundation
import CoreLocation
import Combine

class NotesViewModel: ObservableObject {
    @Published var notes: [Note] = []
    @Published var errorMasage: String?
    
    private let weatherService = WeatherService()
    private let storage = StorageManager()
    private let locationManager = LocationManager()

    
    init() {
        notes = storage.loadNotes()
    }
    
    func addNote(text: String) {
        locationManager.onLocationUpdate = { [weak self] location in
            self?.weatherService.fetchWeather(
                latitude: location.coordinate.latitude,
                longitude: location.coordinate.longitude
            ) { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let weather):
                        let note = Note(id: UUID(),
                                        text: text,
                                        date: Date(),
                                        temperature: weather.main.temp,
                                        description: weather.weather.first?.description ?? "",
                                        icon: weather.weather.first?.icon ?? "",
                                        locationName: weather.weather.first?.name ?? ""
                        )
                        
                        self?.notes.append(note)
                        self?.storage.saveNotes(notes: self?.notes ?? [])
                        
                    case .failure(let error):
                        self?.errorMasage = error.localizedDescription
                    }
                }
            }
               
        }
        
        locationManager.requestLocation()
    }
}
