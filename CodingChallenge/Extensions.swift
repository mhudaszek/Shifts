import Foundation
import Model

extension DateFormatter {
    static func changeDateFormat(format: String, inputDate: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: inputDate).capitalized
    }
    
    static func todaysDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: Date())
    }
}

extension String {
    func convertToNextDate(dateFormat: String = "yyyy-MM-dd") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        let myDate = dateFormatter.date(from: self) ?? Date()
        let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: myDate) ?? Date()
        return dateFormatter.string(from: tomorrow)
    }
}

extension ShiftKind {
    var shiftKindIconName: String {
        switch self {
        case .day:
            return "sun.max"
        case .evening:
            return "moon"
        case .night:
            return "moon.fill"
        }
    }
}
