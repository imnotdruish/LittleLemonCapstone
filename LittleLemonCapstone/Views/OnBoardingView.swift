//
//  OnBoardingView.swift
//  LittleLemonCapstone
//
//  Created by Dan June on 2/28/25.
//

import SwiftUI

struct OnBoardingView: View {
    
    @StateObject private var viewModel = ViewModel()
    
    @State var firstName = ""
    @State var lastName = ""
    @State var email = ""
    @State var phoneNumber = ""
    
    @State var contentOffset: CGSize = .zero
    @State var isLoggedIn = false
    @State var isKeyboardVisible = false
    
    var body: some View {
        
        NavigationStack{
            ScrollView(.vertical, showsIndicators: false){
                VStack {
                    HeaderView()
                    HeroView()
                    VStack(alignment: .leading){
                        NavigationLink(destination: Home(), isActive: $isLoggedIn) {}
                        Text("First Name: *")
                            .font(.leadText())
                        TextField("Enter first name", text: $firstName)
                            .frame(width: .none, height: 50)
                        Text("Last Name: *")
                            .font(.leadText())
                        TextField("Enter last name", text: $lastName)
                            .frame(width: .none, height: 50)
                        Text("Email Address: *")
                            .font(.leadText())
                        TextField("Enter email", text: $email)
                            .font(.leadText())
                            .frame(width: .none, height: 50)
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                    }
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .disableAutocorrection(true)
                    .padding()
                    
                    if viewModel.errorShown {
                        withAnimation() {
                            Text(viewModel.error)
                                .foregroundStyle(Color.llSalmon)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.leading)
                        }
                    }
                    Button("Register"){
                        if viewModel.validateProfileInput(firstName: firstName, lastName: lastName, email: email, phoneNumber: phoneNumber) {
                            UserDefaults.standard.set(firstName, forKey: kFirstName)
                            UserDefaults.standard.set(lastName, forKey: kLastName)
                            UserDefaults.standard.set(email, forKey: kEmail)
                            UserDefaults.standard.set(phoneNumber, forKey: kPhoneNumber)
                            UserDefaults.standard.set(true, forKey: kIsLoggedIn)
                            UserDefaults.standard.set(true, forKey: kOrderStatuses)
                            UserDefaults.standard.set(true, forKey: kPasswordChanges)
                            UserDefaults.standard.set(true, forKey: kSpecialOffers)
                            UserDefaults.standard.set(true, forKey: kNewsletter)
                            firstName = ""
                            lastName = ""
                            email = ""
                            isLoggedIn = true
                            
                        }
                    }
                    .buttonStyle(ButtonYellow())
                }
                .offset(y: contentOffset.height)
                .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)) { notification in
                    withAnimation {
                        let keyboardRect = notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
                        let keyboardHeight = keyboardRect.height
                        self.isKeyboardVisible = true
                        self.contentOffset = CGSize(width: 0, height: -keyboardHeight / 2 + 50)
                    }
                }
                .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)) { notification in
                    withAnimation {
                        self.isKeyboardVisible = false
                        self.contentOffset = .zero
                    }
                }
            }
            .onAppear {
                if UserDefaults.standard.bool(forKey: "kIsLoggedIn") {
                    isLoggedIn = true
                }
            }
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    OnBoardingView()
}
