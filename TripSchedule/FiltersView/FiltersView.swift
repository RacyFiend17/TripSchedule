import SwiftUI

struct FiltersView: View {
    
    @State var viewModel: CarriersViewModel
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            
            VStack(alignment: .leading, spacing: 16) {
                Text("Время отправления")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.ypBlack)
                
                ForEach(TimeFilter.allCases) { time in
                    HStack {
                        toggle(title: time.title, value: time)
                    }
                }
            }
            
            VStack(alignment: .leading, spacing: 0) {
                Text("Показывать варианты с пересадками")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.ypBlack)
                    .padding(.bottom, 16)
                
                radioButton(title: "Да", value: .yesTransfer)
                radioButton(title: "Нет", value: .noTransfer)
            }
            
            Spacer()
            
            Button {
                dismiss()
            } label: {
                Text("Применить")
                    .font(.system(size: 17, weight: .bold))
                    .frame(maxWidth: .infinity)
                    .frame(height: 60)
                    .foregroundStyle(Color(.white))
                    .background(Color.ypBlue)
                    .cornerRadius(16)
            }
        }
        .padding([.leading, .trailing, .top], 16)
        .padding(.bottom, 24)
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarRole(.editor)
        .background(Color(.ypWhite))
    }
    
//    Для удобства делаю и кнопку и текст возможной для тапа, чтобы пользователь не нажимал именно на кружок
    private func radioButton(title: String, value: TransferFilter) -> some View {
        Button {
            viewModel.transferFilter = value
        } label: {
            HStack {
                Text(title)
                    .foregroundColor(.ypBlack)
                    .font(.system(size: 17, weight: .regular))

                Spacer()

                Image(systemName: viewModel.transferFilter == value ? "largecircle.fill.circle" : "circle")
                    .resizable()
                    .foregroundColor(.ypBlack)
                    .frame(width: 24, height: 24)
            }
            .frame(maxWidth: .infinity)
            .contentShape(Rectangle())
        }
        .frame(height: 60)
        .buttonStyle(.plain)
    }
    
    private func toggle(title: String, value: TimeFilter) -> some View {
        Button {
            if viewModel.selectedTimes.contains(value) {
                viewModel.selectedTimes.remove(value)
            } else {
                viewModel.selectedTimes.insert(value)
            }
        } label: {
            HStack {
                Text(title)
                    .foregroundColor(.ypBlack)
                    .font(.system(size: 17, weight: .regular))

                Spacer()

                Image(systemName: viewModel.selectedTimes.contains(value) ? "checkmark.square.fill" : "square")
                    .resizable()
                    .foregroundColor(.ypBlack)
                    .frame(width: 24, height: 24)
            }
            .frame(maxWidth: .infinity)
            .contentShape(Rectangle())
        }
        .frame(height: 60)
        .buttonStyle(.plain)
    }
}

