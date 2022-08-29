import SwiftUI

struct MainView: View {
    @StateObject var viewModel: MainViewModel
    
    var body: some View {
        ZStack {
            NavigationView {
                List(Array(viewModel.allShifts.enumerated()), id: \.offset) { index, shift in
                    VStack {
                        ShiftItemView(startTime: shift.start_time, endTime: shift.end_time, shiftKind: shift.shiftKind, facilityTypeName: shift.facility_type.name)
                            .padding(.vertical)
                            .onTapGesture {
                                viewModel.selectedShift = shift
                            }
                            .onAppear {
                                if index == viewModel.allShifts.count - 1 {
                                    viewModel.fetchMoreShifts()
                                }
                            }
                    }
                }
                .navigationTitle("Shifts")
                .sheet(item: $viewModel.selectedShift, content: { shift in
                    ShiftDetailsView(startTime: shift.start_time, endTime: shift.end_time, isPremiumRate: shift.premium_rate, facilityTypeName: shift.facility_type.name, shiftKind: shift.shiftKind, skillName: shift.skill.name, isCovid: shift.covid, localizedSpecialtyName: shift.localized_specialty.name)
                })
                .onAppear {
                    Task { @MainActor in
                        viewModel.fetchShifts()
                    }
                }
            }
            
            if viewModel.isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .black))
                    .scaleEffect(2)
            }
        }
    }
}

struct ShiftsView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(viewModel: MainViewModel(service: .live()))
    }
}
