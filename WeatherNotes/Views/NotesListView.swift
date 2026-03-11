import SwiftUI

struct NotesListView: View {
    @StateObject var viewModel = NotesViewModel()
    @State private var showAdd = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.notes) { note in
                    NavigationLink(destination: NoteDetailView(note: note)) {
                        HStack(spacing: 15) {
                            VStack(alignment: .leading, spacing: 5) {
                                Text(note.text)
                                    .font(.headline)
                                    .lineLimit(1)
                                Text(note.date.formatted(.dateTime.day().month().hour().minute()))
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                            
                            Spacer()
                            
                            if let temp = note.temperature {
                                Image(systemName: note.systemIconName)
                                    .symbolRenderingMode(.multicolor)
                                    .font(.title3)
                                Text("\(Int(temp))°C")
                                    .font(.subheadline).bold()
                            } else {
                                ProgressView().scaleEffect(0.8)
                            }
                        }
                    }
                }
                .onDelete(perform: viewModel.deleteNotes)
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Weather Notes")
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                        Button { showAdd = true } label: {
                            Image(systemName: "plus")
                                .font(Font.callout.bold())
                    }
                }
            }
            .sheet(isPresented: $showAdd) {
                AddNoteView(viewModel: viewModel)
            }
        }
    }
}
