import SwiftUI
import Kingfisher

struct RouteCard: View {
    
    let route: Route
    
    var body: some View {
        VStack{
            HStack(alignment: .top, spacing: 0) {
                KFImage(URL(string: route.carrier.logoURL ?? ""))
                    .placeholder {
                        ProgressView() 
                            .frame(width: 38, height: 38)
                    }
                    .resizable()
                    .frame(width: 38, height: 38)
                VStack(alignment: .leading, spacing: 0) {
                    Text(route.carrier.name)
                        .font(.system(size: 17, weight: .regular))
                        .foregroundStyle(.black)
                    
                    Text(route.isTransfer ? "С пересадкой в Костроме" : "")
                        .font(.system(size: 12, weight: .regular))
                        .foregroundStyle(Color.ypRed)
                }
                .padding(.top, 1)
                .padding(.leading, 8)
                
                Spacer()
                
                Text(route.day)
                    .font(.system(size: 12, weight: .regular))
                    .foregroundStyle(.black)
                    .padding(.trailing, 7)
                
            }
            .padding([.leading, .vertical], 14)
            .frame(maxWidth: .infinity)
            
            
            HStack(spacing: 4) {
                Text(route.departureTime)
                    .font(.system(size: 17, weight: .regular))
                    .foregroundStyle(.black)
                Rectangle()
                    .frame(width: .infinity, height: 1)
                    .foregroundStyle(Color.ypGray)
                Text(route.duration)
                    .font(.system(size: 12, weight: .regular))
                    .padding(.horizontal, 1)
                    .foregroundStyle(.black)
                Rectangle()
                    .frame(width: .infinity, height: 1)
                    .foregroundStyle(Color.ypGray)
                Text(route.arrivalTime)
                    .font(.system(size: 17, weight: .regular))
                    .foregroundStyle(.black)
            }
            .padding(14)
        }
        .background(Color.ypLightGray)
        .cornerRadius(24)
    }
}

