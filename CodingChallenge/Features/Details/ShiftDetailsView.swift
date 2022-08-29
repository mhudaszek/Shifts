import SwiftUI
import Model

struct ShiftDetailsView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    let startTime: Date
    let endTime: Date
    let isPremiumRate: Bool
    let facilityTypeName: String
    let shiftKind: ShiftKind
    let skillName: String
    let isCovid: Bool
    let localizedSpecialtyName: String
    
    var body: some View {
        NavigationView {
            List {
                VStack {
                    HStack {
                        Spacer()
                        Image("shiftIcon")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 150, height: 150, alignment: .center)
                        Spacer()
                    }
                    
                    VStack(spacing: 10) {
                        Text(facilityTypeName)
                            .font(.title3)
                            .bold()
                        
                        HStack(spacing: 5) {
                            Image(systemName: "calendar")
                            Text(DateFormatter.changeDateFormat(format: "dd-MM-yyyy", inputDate: startTime))
                                .font(.footnote)
                                .bold()
                        }
                        
                        HStack(spacing: 5) {
                            Image(systemName: "clock")
                            Text(DateFormatter.changeDateFormat(format: "HH:mm", inputDate: startTime))
                                .font(.footnote)
                                .bold()
                            Text("-")
                                .bold()
                            Text(DateFormatter.changeDateFormat(format: "HH:mm", inputDate: endTime))
                                .font(.footnote)
                                .bold()
                        }
                    }
                    .padding(.bottom, 15)
                }
                
                if isPremiumRate {
                    HStack {
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                        Text("Premium Pay")
                    }
                }
                
                HStack {
                    Image(systemName: shiftKind.shiftKindIconName)
                    Text(shiftKind.rawValue)
                }
                
                HStack {
                    Image(systemName: "book")
                    Text(skillName)
                }
                
                HStack {
                    Image(systemName: "allergens")
                    Text(isCovid ? "Covid" : "No Covid")
                }
                
                HStack {
                    Image(systemName: "cross.case.fill")
                    Text(localizedSpecialtyName)
                }
            }
            .navigationBarItems(trailing: Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "xmark")
                    .foregroundColor(Color("customWhite"))
            })
        }
    }
}

struct ShiftDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ShiftDetailsView(startTime: Date(), endTime: Date(), isPremiumRate: true, facilityTypeName: "Skilled Nursing Facility", shiftKind: .night, skillName: "Long Term Care", isCovid: true, localizedSpecialtyName: "Licensed Vocational Nurse")
    }
}
