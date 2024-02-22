import SwiftUI

struct ContentMenuButtonView: View {
    let title: String
    let isTapped: Bool
    var action: () -> Void

    var body: some View {
        Button {
            action()
        } label: {
            HStack {
                Text(title)
                Image(systemName: isTapped ? "checkmark" : "")
            }
        }
    }
}

#Preview {
    ContentMenuButtonView(title: SortTitle.name.rawValue, isTapped: true, action: { }) 
}

