import SwiftUI

struct NoteDetailView: View {
    let note: Note

    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color.blue.opacity(0.3), Color(.systemBackground)]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            ScrollView {
                VStack(spacing: 30) {
                    
                    VStack(spacing: 10) {
                        if let temp = note.temperature {
                            Image(systemName: note.systemIconName)
                                .renderingMode(.original)
                                .font(.system(size: 80))
                                .padding(.bottom, 10)
                            
                            Text(" \(Int(temp))°")
                                .font(.system(size: 90, weight: .thin, design: .rounded))
                            
                            Text(note.description?.capitalized ?? "")
                                .font(.title2.bold())
                            
                            HStack {
                                Image(systemName: "mappin.and.ellipse")
                                Text(note.locationName ?? "Unknown")
                            }
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        } else {
                            ProgressView()
                                .scaleEffect(1.5)
                                .frame(height: 200)
                        }
                    }
                    .padding(.vertical, 40)

                    VStack(alignment: .leading, spacing: 20) {
                        HStack {
                            Text("Ваші думки")
                                .font(.caption.bold())
                                .foregroundColor(.blue)
                                .textCase(.uppercase)
                            Spacer()
                            Text(note.date.formatted(date: .abbreviated, time: .shortened))
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                        
                        Text(note.text)
                            .font(.body)
                            .lineSpacing(8)
                            .foregroundColor(.primary)
                    }
                    .padding(25)
                    .background(
                        RoundedRectangle(cornerRadius: 30)
                            .fill(Color(.systemBackground))
                            .shadow(color: .black.opacity(0.05), radius: 20, x: 0, y: 10)
                    )
                    .padding(.horizontal)
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}
