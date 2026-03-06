import SwiftUI

struct SelectionView<Item: SelectableItem>: View {
    
    let title: String
    let items: [Item]
    let onSelect: (Item) -> Void
    
    @State private var searchText = ""
    
    var filteredItems: [Item] {
        if searchText.isEmpty { return items }
        return items.filter {
            $0.name.localizedCaseInsensitiveContains(searchText)
        }
    }
    
    var body: some View {
        VStack(spacing: 16) {
            
            HStack(spacing: 8) {
                
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                
                TextField("Введите запрос", text: $searchText)
                    .textFieldStyle(.plain)
                
                if !searchText.isEmpty {
                    Button {
                        searchText = ""
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.gray)
                    }
                }
            }
            .padding(.horizontal, 8)
            .frame(height: 36)
            .background(Color(.ypGrayForSearchField))
            .cornerRadius(10)
            .padding(.horizontal, 16)
            
            if filteredItems.isEmpty {
                            VStack {
                                Spacer()
                                Text(title == "Выбор города" ? "Город не найден" : "Станция не найдена")
                                    .font(.system(size: 24, weight: .bold))
                                    .foregroundColor(.ypBlack)
                                Spacer()
                            }
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                ScrollView {
                    LazyVStack(spacing: 0) {
                        ForEach(filteredItems) { item in
                            Button {
                                onSelect(item)
                            } label: {
                                HStack {
                                    Text(item.name)
                                        .font(.system(size: 17))
                                        .foregroundStyle(Color(.ypBlack))
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .foregroundColor(.ypBlack)
                                        .imageScale(.large)
                                }
                                .padding()
                            }
                        }
                    }
                }
            }
        }
        .background(Color(.ypWhite))
        .navigationTitle(title)
        .navigationBarTitleDisplayMode(.inline)
        .toolbarRole(.editor)
    }
}
#Preview {
    SelectionView(title: "Выбор города", items: MockDataProvider.cities) { item in
    }
}




