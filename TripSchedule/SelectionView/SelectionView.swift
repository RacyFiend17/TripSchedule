import SwiftUI

struct SelectionView<Item: SelectableItem>: View {
    
    let title: String
    let onSelect: (Item) -> Void
    
    @State private var viewModel: SelectionViewModel<Item>
    
    init(title: String, viewModel: SelectionViewModel<Item>, onSelect: @escaping (Item) -> Void) {
        self.title = title
        self._viewModel = State(wrappedValue: viewModel)
        self.onSelect = onSelect
    }
    
    var body: some View {
        VStack(spacing: 16) {
            
            HStack(spacing: 8) {
                
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                
                TextField("Введите запрос", text: $viewModel.searchText)
                    .textFieldStyle(.plain)
                
                if !viewModel.searchText.isEmpty {
                    Button {
                        viewModel.searchText = ""
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
            
            if viewModel.isLoading {
                ProgressView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else if viewModel.filteredItems.isEmpty {
                VStack {
                    Spacer()
                    Text(title.contains("город") ? "Город не найден" : "Станция не найдена")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.ypBlack)
                    Spacer()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                ScrollView {
                    LazyVStack(spacing: 0) {
                        ForEach(viewModel.filteredItems) { item in
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
        .task {
            await viewModel.loadItems()
        }
    }
}


