import SwiftUI

struct OTPParams: Encodable {
    var number: String
    var otp: String
}
struct OTPView: View {
    let phoneNumber: String
    @State private var otp: String = "1234"
    @State private var isLoading = false
    @State private var errorMessage: String?
    var onGoBack: () -> Void
    var onSuccess: (String) -> Void
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading) {
                HStack {
                    Text("\(phoneNumber)")
                        .padding(.bottom, 8)
                        .font(.inter500_18)
                    Button(action: onGoBack) {
                        Image("edit")
                            .padding(.top, -8)
                    }
                }
                
                Text("Enter The \nOTP")
                    .padding(.bottom, 12)
                    .font(.inter800_30)
                    .bold()
                    .frame(width: UIScreen.main.bounds.width * 0.7, alignment: .leading)
                
                HStack {
                    
                    
                    TextField("OTP", text: $otp)
                        .frame(width: 70, alignment: .center)
                        .font(.inter700_18)
                        .keyboardType(.numberPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                }
                .padding(.bottom, 20)
                HStack {
                    Button(action: submit2) {
                        Text("Continue")
                            .font(.inter700_14)
                            .foregroundColor(.black)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 12)
                            .background(Color.yellow)
                            .cornerRadius(24)
                    }
                    .padding(.trailing, 12)
                    .disabled(isLoading || phoneNumber.isEmpty)
                    Text("00:59")
                        .font(.inter700_14)
                }
                
                if let error = errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                }
            }
            .padding(.horizontal, 30)
            .padding(.top, 80)
        }
        
    }
    
    func submit() {
        isLoading = true
        errorMessage = nil
        let url = URL(string: "https://app.aisle.co/V1/users/verify_otp")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let params =  OTPParams(number: phoneNumber.split(separator: " ").joined(), otp: otp)
        let body = try? JSONEncoder().encode(params)
        request.httpBody = body // params?.data(using: .utf8)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                isLoading = false
                if let error = error {
                    errorMessage = error.localizedDescription
                    return
                }
                guard let data = data else {
                    errorMessage = "No data received."
                    return
                }
                if let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any] {
                    if let token = json["token"] as? String {
                        UserDefaults.standard.set(token, forKey: "authToken")
                        onSuccess(token)
                    } else if let message = json["message"] as? String {
                        errorMessage = message
                    } else {
                        errorMessage = "Response: " + String(describing: json)
                    }
                } else {
                    let raw = String(data: data, encoding: .utf8) ?? "Unknown response"
                    errorMessage = "Raw: " + raw
                }
            }
        }.resume()
    }
    struct OTPResponse: Codable {
        let token: String?
        let message: String?
    }

    func submit2() {
        isLoading = true
        errorMessage = nil

        let cleanedNumber = phoneNumber.split(separator: " ").joined()
        let params: [String: Any] = [
            "number": cleanedNumber,
            "otp": otp
        ]

        APIService.shared.post(
            .verifyOTP,
            body: params,
            headers: nil,
            responseType: OTPResponse.self
        ) { result in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success(let response):
                    if let token = response.token {
                        UserDefaults.standard.set(token, forKey: "authToken")
                        onSuccess(token)
                    } else if let message = response.message {
                        self.errorMessage = message
                    } else {
                        self.errorMessage = "Unexpected response"
                    }
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }

}

#Preview {
    OTPView(phoneNumber: "", onGoBack: {
        print("Go back")
    }) { message in
        print(message)
    }
}
