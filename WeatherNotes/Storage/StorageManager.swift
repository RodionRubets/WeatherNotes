import Foundation

class StorageManager {
    
    private let key = "notes_key"
    
    func saveNotes(notes: [Note]) {
        
        let data = try? JSONEncoder().encode(notes)
        UserDefaults.standard.set(data, forKey: key)
    }
    
    func loadNotes() -> [Note] {
        guard
            let data = UserDefaults.standard.data(forKey: key),
            let notes = try? JSONDecoder().decode([Note].self, from: data)
        else { return [] }
        
        return notes
    }
}
