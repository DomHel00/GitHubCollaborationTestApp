import SwiftUI

struct ToDoListView: View {
    @StateObject var model = ItemViewModel()

    var body: some View {
        NavigationStack {
            if !model.items.isEmpty {
                List {
                    ForEach(model.items, id: \.title) { item in
                        Text(item.title)
                    }
                }
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
                Button {
                    // function - add new item
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        ToDoListView()
    }
}
