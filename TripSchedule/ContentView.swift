import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
        .onAppear {
//            TestAllStationService.testFetchAllStations()
//            TestNearestStationService.testFetchStations()
//            TestScheduleBetweenStationsService.testFetchScheduleBetweenStations()
//            TestStationScheduleService.testFetchStationSchedule()
//            TestRouteStationsService.testFetchRouteStations()
//            TestNearestCityService.testFetchNearestCity()
//            TestCarrierInfoService.testFetchCarrierInfo()
            TestCopyrightService.testCopyright()
        }
    }
}

#Preview {
    ContentView()
}
