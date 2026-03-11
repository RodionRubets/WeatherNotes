import SwiftUI

@main
struct WeatherNotesApp: App {
    
    var location = LocationManager()
    
    var body: some Scene {
        WindowGroup {
            NotesListView()
                .onAppear {
                    self.location.requestLocation()
                }
        }
    }
}
