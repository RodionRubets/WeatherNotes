import SwiftUI
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
        let newNoteId = UUID()
        
        let placeholderNote = Note(
            id: newNoteId,
            text: text,
            date: Date()
        )
        
        self.notes.insert(placeholderNote, at: 0)
        self.storage.saveNotes(notes: self.notes)
        
        locationManager.onLocationUpdate = { [weak self] location in
            self?.weatherService.fetchWeather(
                latitude: location.coordinate.latitude,
                longitude: location.coordinate.longitude
            ) { result in
                DispatchQueue.main.async {
                    if case .success(let weather) = result {
                        if let index = self?.notes.firstIndex(where: { $0.id == newNoteId }) {
                            self?.notes[index].temperature = weather.main.temp
                            self?.notes[index].description = weather.weather.first?.description
                            self?.notes[index].iconName = weather.weather.first?.icon
                            self?.notes[index].locationName = weather.name
                            
                            self?.storage.saveNotes(notes: self?.notes ?? [])
                        }
                    }
                }
            }
        }
        locationManager.requestLocation()
    }
    
    func deleteSingleNote(_ note: Note) {
        if let index = notes.firstIndex(where: { $0.id == note.id }) {
                notes.remove(at: index)
            storage.saveNotes(notes: notes)
        }
    }
}
