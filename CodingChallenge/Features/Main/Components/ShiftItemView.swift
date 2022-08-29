import SwiftUI
import Model

struct ShiftItemView: View {
    let startTime: Date
    let endTime: Date
    let shiftKind: ShiftKind
    let facilityTypeName: String
    
    var body: some View {
        HStack(spacing: 15) {
            VStack(spacing: 5) {
                Text(DateFormatter.changeDateFormat(format: "EEE", inputDate: startTime))
                    .font(Font.custom("HelveticaNeue-Bold", size: 10))
                    .foregroundColor(.orange)
                    .bold()
                
                Text(DateFormatter.changeDateFormat(format: "dd", inputDate: startTime))
                    .bold()
            }
            .frame(width: 60, height: 60)
            .background(Color.gray.opacity(0.05))
            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
            .shadow(color: Color.black.opacity(0.3), radius: 12, x: 0, y: 10)
            
            VStack(alignment: .leading, spacing: 10) {
                Text(facilityTypeName)
                    .font(.footnote)
                    .bold()
                
                HStack(spacing: 8) {
                    Image(systemName: "clock")
                    Text(DateFormatter.changeDateFormat(format: "HH:mm", inputDate: startTime))
                        .font(.footnote)
                    Text("-")
                    Text(DateFormatter.changeDateFormat(format: "HH:mm", inputDate: endTime))
                        .font(.footnote)
                }
            }
            
            Spacer()
            Image(systemName: shiftKind.shiftKindIconName)
        }
    }
}

struct ShiftItem_Previews: PreviewProvider {
    static var previews: some View {
        ShiftItemView(startTime: Date(), endTime: Date(), shiftKind: .day, facilityTypeName: "Skilled Nursing Facility")
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
