import SwiftUI

struct RowItemView: View {
    let item: ToDoItem
    var action: () -> Void
    
    var body: some View {
        HStack(alignment: .top) {
            Button {
                action()
            } label: {
                item.symbol
            }
            VStack(alignment: .leading) {
                HStack{
                    if let prioritySymbol = item.priority.symbol {
                        Text(prioritySymbol)
                            .foregroundStyle(.red)
                    }
                    Text(item.title)
                }
                Text("\(item.finishDate.dateFormat())")
                    .font(.callout)
                    .opacity(0.6)
            }
        }
        .font(.title2)
    }
}

#Preview {
    RowItemView(item: ToDoItem.mock, action: { })
}
