import Foundation

public struct ShiftDataRespone: Codable {
    public let data: [ShiftRespone]
}

public struct ShiftRespone: Codable {
    public var date: String
    public var shifts: [Shift]
}

public enum ShiftKind: String {
    case day = "Day Shift"
    case evening = "Evening Shift"
    case night = "Night Shift"
}

public struct Shift: Codable {
    public let shift_id: Int
    public let start_time: Date
    public let end_time: Date
    public let normalized_start_date_time: String
    public let normalized_end_date_time: String
    public let timezone: String
    public let premium_rate: Bool
    public let covid: Bool
    public let shift_kind: String
    public let within_distance: Int?
    public let facility_type: FacilityType
    public let skill: Skill
    public let localized_specialty: LocalizedSpecialty
    
    public var shiftKind: ShiftKind {
        return ShiftKind(rawValue: shift_kind) ?? .day
    }
    
    public init(shift_id: Int, start_time: Date, end_time: Date, normalized_start_date_time: String, normalized_end_date_time: String, timezone: String, premium_rate: Bool, covid: Bool, shift_kind: String, within_distance: Int?, facility_type: FacilityType, skill: Skill, localized_specialty: LocalizedSpecialty) {
        self.shift_id = shift_id
        self.start_time = start_time
        self.end_time = end_time
        self.normalized_start_date_time = normalized_start_date_time
        self.normalized_end_date_time = normalized_end_date_time
        self.timezone = timezone
        self.premium_rate = premium_rate
        self.covid = covid
        self.shift_kind = shift_kind
        self.within_distance = within_distance
        self.facility_type = facility_type
        self.skill = skill
        self.localized_specialty = localized_specialty
    }
}

extension Shift: Identifiable, Hashable {
    public var id: String {
        return UUID().uuidString
    }
    
    public func hash(into hasher: inout Hasher) {
        return hasher.combine(id)
    }
    
    public static func == (lhs: Shift, rhs: Shift) -> Bool {
        return lhs.id == rhs.id
    }
}

public struct FacilityType: Codable {
    public let id: Int
    public let name: String
    public let color: String
}

public struct Skill: Codable {
    public let id: Int
    public let name: String
    public let color: String
}

public struct LocalizedSpecialty: Codable {
    public let id: Int
    public let specialty_id: Int
    public let state_id: Int
    public let name: String
    public let abbreviation: String
    public let specialty: Specialty
}

public struct Specialty: Codable {
    public let id: Int
    public let name: String
    public let color: String
    public let abbreviation: String
}
