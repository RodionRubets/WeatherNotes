import SwiftUI

struct NoteDetailView: View {
    
    let note: Note

    var body: some View {
        VStack(spacing: 20) {
            Text(note.text).font(.title).bold().multilineTextAlignment(.center).padding()
            Text(note.date.formatted(date: .long, time: .shortened)).foregroundColor(.secondary)
            
            Divider()
            
            HStack(spacing: 20) {
                AsyncImage(url: URL(string: "https://openweathermap.org/img/wn/\(note.icon)@4x.png")) { image in
                    image.resizable()
                } placeholder: { ProgressView() }
                .frame(width: 100, height: 100)
                
                VStack(alignment: .leading) {
                    Text("\(Int(note.temperature))°C").font(.system(size: 40, weight: .bold))
                    Text(note.description.capitalized).font(.title3).foregroundColor(.secondary)
                    Text(note.locationName).font(.subheadline).foregroundColor(.gray)
                }
            }
            Spacer()
        }
        .navigationTitle("Деталі")
        .navigationBarTitleDisplayMode(.inline)
    }
}
