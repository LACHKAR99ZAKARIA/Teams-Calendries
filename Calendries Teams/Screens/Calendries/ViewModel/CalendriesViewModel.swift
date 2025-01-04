class CalendriesViewModel: ObservableObject {
    @Published var pickedDate: Date = Date()
}

enum Days: String {
    case sunday = "Lundi"
    case monday = "Mardi"
    case tuesday = "Mercredi"
    case wednesday
    case thursday
    case friday
    case saturday
    
    var day: Int {
        switch self {
        case .sunday: return 0
        case .monday: return 1
        case .tuesday: return 2
        case .wednesday: return 3
        case .thursday: return 4
        case .friday: return 5
        case .saturday: return 6
        }
    }
    
    var dayName: String {
        switch self {
        case .sunday: return "L"
        case .monday: return "M"
        case .tuesday: return "M"
        case .wednesday: return "J"
        case .thursday: return "V"
        case .friday: return "S"
        case .saturday: return "D"
        }
    }
}