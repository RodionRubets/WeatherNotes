import SwiftUI

struct NoteDetailView: View {
    
    let note: Note

    var body: some View {
        VStack(spacing: 20) {
            Text(note.text).font(.title).bold().multilineTextAlignment(.center).padding()
            Text(note.date.formatted(date: .long, time: .shortened)).foregroundColor(.secondary)
            
            Divider()
            
            HStack(spacing: 20) {
                Image(systemName: note.systemIconName)
                .symbolRenderingMode(.palette)
                .font(.title)
                
                VStack(alignment: .leading) {
                    Text("\(Int(note.temperature))°C").font(.system(size: 40, weight: .bold))
                    Text(note.description.capitalized).font(.title3).foregroundColor(.secondary)
                    Text(note.locationName).font(.callout)
                }
            }
            Spacer()
        }
        .navigationTitle("Деталі")
        .navigationBarTitleDisplayMode(.inline)
    }
}
