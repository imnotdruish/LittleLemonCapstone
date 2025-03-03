//
//  OnBoardingView.swift
//  LittleLemonCapstone
//
//  Created by Dan June on 2/28/25.
//

import SwiftUI

struct OnBoardingView: View {
    
    enum Field: Int, CaseIterable {
        case firstName
        case lastName
        case email
    }

    @StateObject private var viewModel = ViewModel()
    @FocusState private var isFocused: Field?

    
    @State var firstName = ""
    @State var lastName = ""
    @State var email = ""
    @State var phoneNumber = ""
    
//    @State var contentOffset: CGSize = .zero
    @State var isLoggedIn = false
//    @State var isKeyboardVisible = false
    
    var body: some View {
        
        NavigationStack{
            ScrollView(.vertical, showsIndicators: false){
                VStack {
                    HeaderView()
                    HeroView()
                    VStack(alignment: .leading){
                        NavigationLink(destination: Home(), isActive: $isLoggedIn) {}
                        VStack(alignment: .leading) {
                            Text("First Name:")
                            ZStack(alignment: .leading){
                                if firstName.isEmpty {
                                    Text("Enter First Name")
                                        .font(.cardTitle())
                                        .foregroundStyle(Color.llGreen)
                                        .padding(.leading)
                                }
                                TextField("", text: $firstName)
                                    .textFieldStyle(RoundedTextFieldStyle())
                                    .focused($isFocused, equals: .firstName)
                                    .submitLabel(.done)
                            }
                        }
                        VStack(alignment: .leading) {
                            Text("Last Name:")
                            ZStack(alignment: .leading){
                                if lastName.isEmpty {
                                    Text("Enter Last Name")
                                        .font(.cardTitle())
                                        .foregroundStyle(Color.llGreen)
                                        .padding(.leading)
                                }
                                TextField("", text: $lastName)
                                    .textFieldStyle(RoundedTextFieldStyle())
                                    .focused($isFocused, equals: .lastName)
                                    .submitLabel(.done)
                            }
                        }
                        VStack(alignment: .leading) {
                            Text("Email:")
                            ZStack(alignment: .leading){
                                if email.isEmpty {
                                    Text("Enter Email Address")
                                        .font(.cardTitle())
                                        .foregroundStyle(Color.llGreen)
                                        .padding(.leading)
                                }
                                TextField("", text: $email)
                                    .textFieldStyle(RoundedTextFieldStyle())
                                    .keyboardType(.emailAddress)
                                    .focused($isFocused, equals: .email)
                                    .submitLabel(.done)
                             }
                        }
                        .disableAutocorrection(true)
                        
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
                        .padding(.vertical)
                    }
                    .padding()
//                    .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)) { notification in
//                        withAnimation {
//                            self.isKeyboardVisible = true
//                        }
//                    }
//                    .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)) { notification in
//                        withAnimation {
//                            self.isKeyboardVisible = false
//                        }
//                    }
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
}
#Preview {
    OnBoardingView()
}
