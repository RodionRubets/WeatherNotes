import SwiftUI

struct NotesListView: View {

    @StateObject var viewModel = NotesViewModel()
    @State private var showAdd = false
    
    var body: some View {
        NavigationStack {
            List(viewModel.notes) { note in
                NavigationLink(destination: NoteDetailView(note: note)) {
                    
                    VStack(alignment: .leading) {
                        Text(note.text)
                            .font(.headline)
                        Text(note.date.formatted())
                    }
                }
                .contextMenu {
                    Button(role: .destructive) {
                            viewModel.deleteSingleNote(note)
                        } label: {
                            Label("Видалити", systemImage: "trash")
                        }
                }
                
            }
            .navigationTitle(Text("Weather Notes"))
            
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    Button {
                        showAdd = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showAdd) {
                AddNoteView(viewModel: viewModel)
            }
            .alert("Error",
                   isPresented: Binding(
                    get: { viewModel.errorMasage != nil},
                    set: { _ in viewModel.errorMasage = nil})
                   
            ) {
                Button("OK", role: .cancel) {}
            } message: {
                Text(viewModel.errorMasage ?? "")
            }
            
        }
        .padding(.top, 20)
        
    }
}
