
import SwiftUI

struct ContentView: View {
    @State private var username = ""
    @State private var password = ""
    @State private var wrongUsername: Float = 0
    @State private var wrongPassword: Float = 0
    @State private var showingLoginScreen = false
    
    var body: some View {
           NavigationView {
               ZStack {
                   LinearGradient(gradient: Gradient(colors: [Color.purple, Color.blue]),
                                startPoint: .leading,
                                endPoint: .trailing)
                       .ignoresSafeArea()
                   
                   RoundedRectangle(cornerRadius: 30)
                    .fill(Color.white)
                    .frame(width: 350, height: 350)
                    .shadow(radius: 10)

                VStack {
                    Text("Login")
                        .font(.largeTitle)
                        .bold()
                        .padding()
                    
                    TextField("Username", text: $username)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)
                        .border(.red, width: CGFloat(wrongUsername))
                    
                    SecureField("Password", text: $password)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)
                        .border(.red, width: CGFloat(wrongPassword))
                    
                    Button("Login") {
                        authenticateUser(username: username, password: password)
                    }
                    .foregroundColor(.white)
                    .frame(width: 300, height: 50)
                    .background(Color.blue)
                    .cornerRadius(10)
                    
                    NavigationLink(destination: RegistrationView()) { // Corrigido
                        HStack {
                            Text("Don't have an account?")
                                .foregroundColor(.gray)
                            Text("Sign up")
                                .foregroundColor(.blue)
                        }
                    }
                    .padding(.top, 10)
                    
                    NavigationLink(destination: Text("You are logged in @\(username)"), isActive: $showingLoginScreen) {
                        EmptyView()
                    }
                }
            }
            .navigationBarHidden(true)
        }
    }
    
    func authenticateUser(username: String, password: String) {
       
        let savedUsername = UserDefaults.standard.string(forKey: "SavedUsername") ?? ""
        let savedPassword = UserDefaults.standard.string(forKey: "SavedPassword") ?? ""
        
        if username == savedUsername {
            wrongUsername = 0
            if password == savedPassword {
                wrongPassword = 0
                showingLoginScreen = true
            } else {
                wrongPassword = 2
            }
        } else {
            wrongUsername = 2
        }
    }
}
import SwiftUI

struct ConfettiPiece: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.addRect(CGRect(x: 0, y: 0, width: width, height: height))
        return path
    }
}

struct ConfettiView: View {
    @Binding var isShowing: Bool
    let colors: [Color] = [.red, .blue, .green, .yellow, .pink, .purple, .orange]
    
    var body: some View {
        GeometryReader { geometry in
            ForEach(0..<50) { index in
                ConfettiPiece()
                    .fill(colors.randomElement() ?? .blue)
                    .frame(width: 8, height: 8)
                    .position(
                        x: CGFloat.random(in: 0...geometry.size.width),
                        y: isShowing ? geometry.size.height + 100 : -100
                    )
                    .animation(
                        Animation.interpolatingSpring(stiffness: 0.3, damping: 0.3)
                            .speed(0.5)
                            .delay(Double.random(in: 0...1)),
                        value: isShowing
                    )
            }
        }
    }
}

struct RegistrationView: View {
    @State private var newUsername = ""
    @State private var newPassword = ""
    @State private var registrationSuccess = false
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.purple, Color.blue]), startPoint: .leading, endPoint: .trailing)
                .ignoresSafeArea()
            
            RoundedRectangle(cornerRadius: 30)
             .fill(Color.white)
             .frame(width: 350, height: 350)
             .shadow(radius: 10)
            
            VStack {
                Text("Sign Up")
                    .font(.largeTitle)
                    .bold()
                    .padding()
                
                TextField("New Username", text: $newUsername)
                    .padding()
                    .frame(width: 300, height: 50)
                    .background(Color.black.opacity(0.05))
                    .cornerRadius(10)
                
                SecureField("New Password", text: $newPassword)
                    .padding()
                    .frame(width: 300, height: 50)
                    .background(Color.black.opacity(0.05))
                    .cornerRadius(10)
                
                Button("Register") {
                    registerUser(username: newUsername, password: newPassword)
                }
                .foregroundColor(.white)
                .frame(width: 300, height: 50)
                .background(Color.green)
                .cornerRadius(10)
                .padding(.top, 20)
                
                if registrationSuccess {
                    Text("Registration successful!")
                        .foregroundColor(.white)
                        .padding(.top, 10)
                }
            }
        }
    }
    
    func registerUser(username: String, password: String) {
       
        UserDefaults.standard.set(username, forKey: "SavedUsername")
        UserDefaults.standard.set(password, forKey: "SavedPassword")
        registrationSuccess = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

