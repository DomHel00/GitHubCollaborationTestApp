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
                    .font(.title2)
                    .padding()
            }
            
            VStack(alignment: .leading, spacing: 5) {
                Text(item.title)
                    .font(.title2.bold())
                
                HStack() {
                    Text(item.priority.title)
                        .padding(.horizontal)
                        .background(RoundedRectangle(cornerRadius: 8).fill(item.priority.color))
                    
                    Text("\(item.finishDate.dateFormat())")
                        .opacity(0.6)
                }
                .font(.callout)
            }
        }
    }
}

#Preview {
    RowItemView(item: ToDoItem.mock, action: { })
}
