import SwiftUI

struct AddNoteView: View {
    
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: NotesViewModel
    @State private var text = ""
    
    var body: some View {
        NavigationView {
                Form {
                    TextField("Що сталось?", text: $text)
                    Button("Зберегти") {
                        viewModel.addNote(text: text)
                        dismiss()
                    }
                }
        }
        .padding()
        .toolbar {
            ToolbarItem(placement: .bottomBar) {
                Button("Закрити", role: .destructive) {
                    dismiss()
                }
            }
        }
    }
}
