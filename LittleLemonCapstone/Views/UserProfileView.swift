//
//  UserProfileView.swift
//  LittleLemonCapstone
//
//  Created by Dan June on 2/28/25.
//

import SwiftUI

struct UserProfileView: View {
    
    enum Field: CaseIterable {
        case firstName
        case lastName
        case email
        case phoneNumber
    }
    
    @Environment(\.presentationMode) var presentation
    
    @StateObject private var viewModel = ViewModel()
    @FocusState private var isKeyboardShown: Field?
    
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var email = ""
    @State private var phoneNumber = ""
    
    @State private var orderStatuses = true
    @State private var passwordChanges = true
    @State private var specialOffers = true
    @State private var newsletter = true
    
    @State private var isLoggedOut = false
    @State private var showAlert = false
    
    var body: some View {
        NavigationStack{
            ScrollView(.vertical, showsIndicators: false){
                NavigationLink(destination: OnBoardingView(), isActive: $isLoggedOut) { }
                VStack{
                    AvatarView()
                    VStack {
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
                                    .focused($isKeyboardShown, equals: .firstName)
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
                                    .focused($isKeyboardShown, equals: .lastName)
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
                                    .focused($isKeyboardShown, equals: .email)
                                    .submitLabel(.done)
                            }
                        }
                        .autocapitalization(.none)
                        VStack(alignment: .leading) {
                            Text("Phone Number:")
                            ZStack(alignment: .leading){
                                if phoneNumber.isEmpty {
                                    Text("(000) 000-0000")
                                        .font(.cardTitle())
                                        .foregroundStyle(Color.llGreen)
                                        .padding(.leading)
                                }
                                TextField("", text: $phoneNumber)
                                    .onChange(of: phoneNumber) {
                                        if !phoneNumber.isEmpty {
                                            phoneNumber = phoneNumber.formatPhoneNumber()
                                        }
                                    }
                                    .textFieldStyle(RoundedTextFieldStyle())
                                    .keyboardType(.phonePad)
                                    .focused($isKeyboardShown, equals: .phoneNumber)
                                    .toolbar {
                                        ToolbarItem(placement: .keyboard) {
                                            Button("Done") {
                                                isKeyboardShown = nil
                                            }
                                        }
                                    }
                            }
                        }
                        .disableAutocorrection(true)
                    }
                }
                .padding(.horizontal)
                VStack(alignment: .leading) {
                    Text("Email notifications")
                        .font(.sectionTitle())
                    Toggle("Order Status", isOn: $orderStatuses)
                        .toggleStyle(CheckboxToggleStyle())
                    Toggle("Password Changes", isOn: $passwordChanges)
                        .toggleStyle(CheckboxToggleStyle())
                    Toggle("Special Offers", isOn: $specialOffers)
                        .toggleStyle(CheckboxToggleStyle())
                    Toggle("Newsletter", isOn: $newsletter)
                        .toggleStyle(CheckboxToggleStyle())
                }
                .padding()
                .font(.leadText())
                .foregroundStyle(Color.llGreen)
                .offset(x: -80)
                
                Button("Logout"){
                    UserDefaults.standard.set(false, forKey: kIsLoggedIn)
                    UserDefaults.standard.set("", forKey: kFirstName)
                    UserDefaults.standard.set("", forKey: kLastName)
                    UserDefaults.standard.set("", forKey: kEmail)
                    UserDefaults.standard.set("", forKey: kPhoneNumber)
                    UserDefaults.standard.set(false, forKey: kOrderStatuses)
                    UserDefaults.standard.set(false, forKey: kPasswordChanges)
                    UserDefaults.standard.set(false, forKey: kSpecialOffers)
                    UserDefaults.standard.set(false, forKey: kNewsletter)
                    isLoggedOut = true
                }
                .buttonStyle(ButtonYellow())
                Spacer(minLength: 20)
                HStack{
                    Button("Discard Changes"){
                        firstName = viewModel.firstName
                        lastName = viewModel.lastName
                        email = viewModel.email
                        phoneNumber = viewModel.phoneNumber
                        
                        orderStatuses = viewModel.orderStatuses
                        passwordChanges = viewModel.passwordChanges
                        specialOffers = viewModel.specialOffers
                        newsletter = viewModel.newsletter
                    }
                    .buttonStyle(ButtonAccentReverse())
                    Button("Save Changes"){
                        if viewModel.validateProfileInput(firstName: firstName, lastName: lastName, email: email, phoneNumber: phoneNumber) {
                            UserDefaults.standard.set(firstName, forKey: kFirstName)
                            UserDefaults.standard.set(lastName, forKey: kLastName)
                            UserDefaults.standard.set(email, forKey: kEmail)
                            UserDefaults.standard.set(phoneNumber, forKey: kPhoneNumber)
                            UserDefaults.standard.set(orderStatuses, forKey: kOrderStatuses)
                            UserDefaults.standard.set(passwordChanges, forKey: kPasswordChanges)
                            UserDefaults.standard.set(specialOffers, forKey: kSpecialOffers)
                            UserDefaults.standard.set(newsletter, forKey: kNewsletter)
                            showAlert = true
                        }
                    }
                    .buttonStyle(ButtonAccent())
                    .alert(isPresented: $showAlert) {
                        Alert(
                            title: Text("Success"),
                            message: Text("Your changes have been saved.")
                        )
                    }
                }
                if viewModel.errorShown {
                    withAnimation() {
                        Text(viewModel.error)
                            .foregroundStyle(Color.llSalmon)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading)
                    }
                }
            }
            .navigationTitle(Text("Personal information"))
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                firstName = viewModel.firstName
                lastName = viewModel.lastName
                email = viewModel.email
                phoneNumber = viewModel.phoneNumber
                
                orderStatuses = viewModel.orderStatuses
                passwordChanges = viewModel.passwordChanges
                specialOffers = viewModel.specialOffers
                newsletter = viewModel.newsletter
            }
        }
    }
}

#Preview {
    UserProfileView()
}
