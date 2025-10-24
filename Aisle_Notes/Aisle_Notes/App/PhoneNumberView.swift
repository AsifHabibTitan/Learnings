import SwiftUI

struct Params: Encodable {
    let phoneNumber: String
    let countryCode: String
}
struct PhoneNumberView: View {
    @State private var countryCode: String = "+91"
    @State private var phoneNumber: String = "9876543212"
    @State private var isLoading = false
    @State private var errorMessage: String?
    var onSuccess: (String) -> Void
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading) {
                Text("Get OTP")
                    .padding(.bottom, 8)
                    .font(.inter500_18)
                Text("Enter Your Phone Number")
                    .padding(.bottom, 12)
                    .font(.inter800_30)
                    .bold()
                    .frame(width: UIScreen.main.bounds.width * 0.7, alignment: .leading)
                
                HStack {
                    TextField("+91", text: $countryCode)
                        .font(.inter700_18)
                        .frame(width: 60)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    TextField("Phone Number", text: $phoneNumber)
                        .frame(width: 150, alignment: .center)
                        .font(.inter700_18)
                        .keyboardType(.numberPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Spacer()
                }
                .padding(.bottom, 20)
                Button(action: submit) {
                    Text("Continue")
                        .font(.inter700_14)
                        .foregroundColor(.black)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 12)
                        .background(Color.yellow)
                        .cornerRadius(24)
                }
                .disabled(isLoading || phoneNumber.isEmpty)
                if let error = errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                }
            }
            .padding(.horizontal, 30)
            .padding(.top, 80)
        }
        .onAppear(){
            for family in UIFont.familyNames {
                print("Family: \(family)")
                for name in UIFont.fontNames(forFamilyName: family) {
                    print(" - \(name)")
                }
            }
        }
        
    }
    
    func submit() {
        isLoading = true
        errorMessage = nil
        let fullNumber = countryCode + phoneNumber
        let params: [String: Any] = ["number": fullNumber]
        APIService.shared.post(
            .login,
            body: params,
            responseType: PhoneNumberResponse.self,
        ) { result in
            DispatchQueue.main.async {
                isLoading = false
                switch result {
                case .success(_):
                    onSuccess(fullNumber)
                case .failure(let error):
                    errorMessage = error.localizedDescription
                }
            }
        }
    }

struct PhoneNumberResponse: Decodable {
    var status: Bool
}
} 

#Preview {
    PhoneNumberView(onSuccess: {message in print(message)})
}
