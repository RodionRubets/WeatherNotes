import SwiftUI

struct AddNoteView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: NotesViewModel
    @State private var text = ""
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                TextField("Що сталось?", text: $text, axis: .vertical)
                    .lineLimit(5...10)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(12)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                    )
                
                Button {
                    let cleanedText = text.trimmingCharacters(in: .whitespacesAndNewlines)
                    viewModel.addNote(text: cleanedText)
                    dismiss()
                } label: {
                    Text("Зберегти")
                        .bold()
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? Color.gray : Color.blue)
                        .cornerRadius(12)
                }
                .disabled(text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                
                Spacer()
            }
            .padding()
            .navigationTitle("Нотатка")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Скасувати") { dismiss() }
                }
            }
        }
    }
}
