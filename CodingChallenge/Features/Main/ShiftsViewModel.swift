import Foundation
import UIKit
import NetworkService
import Model

class MainViewModel: ObservableObject {
    @Published var allShifts = [Shift]()
    @Published var isLoading = false
    @Published var selectedShift: Shift?
    
    private let service: ShiftsService
    private var lastShiftDate: String?
    
    init(service: ShiftsService) {
        self.service = service
    }
    
    func fetchMoreShifts() {
        guard let lastShiftDate = lastShiftDate else { return }
        fetchShifts(shiftStart: lastShiftDate.convertToNextDate())
    }
    
    func fetchShifts(responseType: ResponseType = .week, shiftStart: String? = nil, address: String? = nil) {
        isLoading = true
        Task { @MainActor in
            do {
                let shiftResponse = try await service.fetchShifts(ShiftsService.FetchRequest(responseType: responseType, shiftStart: shiftStart ?? DateFormatter.todaysDate(), address: address ?? "Dallas, TX"))
                lastShiftDate = shiftResponse.last?.date
                allShifts = allShifts + shiftResponse.flatMap { $0.shifts }
            } catch {
                print("Fetching failed with: \(error)")
            }
            
            isLoading = false
        }
    }
}
