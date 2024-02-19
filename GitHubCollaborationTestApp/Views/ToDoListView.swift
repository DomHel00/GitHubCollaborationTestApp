import SwiftUI

struct ToDoListView: View {
    @StateObject var model = ItemViewModel()
    
    var body: some View {
        NavigationStack {
            Group {
                if !model.items.isEmpty {
                    List {
                        ForEach(model.items, id: \.title) { item in
                            RowItemView(
                                title: item.title,
                                isComplete: item.isComplete)
                        }
                    }
                    .listStyle(.plain)
                } else {
                    VStack(spacing: 50) {
                        Image(systemName: "note.text.badge.plus")
                            .resizable()
                            .frame(width: 120, height: 100)
                            .opacity(0.3)
                        Text("Nic tu ještě nemáš")
                            .font(.largeTitle).opacity(0.3)
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink {
                        AddItemView { newItem in
                            model.updateFile(with: newItem)
                        }
                    } label: {
                        Label("Add new item", systemImage: "plus")
                    }
                    
                }
            }
            .navigationTitle("ToDo Items")
        }
        
    }
}

#Preview {
    NavigationStack {
        ToDoListView()
    }
}
