import SwiftUI

struct RowItemView: View {
    let title: String
    var isComplete: Bool

    var body: some View {
        HStack {
            Image(systemName: isComplete ? "checkmark.circle" : "circle")
            Text(title)
        }
        .font(.title2)
    }
}

#Preview {
    VStack(alignment: .leading) {
        RowItemView(title: "First item", isComplete: false)
        RowItemView(title: "Done item", isComplete: true)
    }

}
