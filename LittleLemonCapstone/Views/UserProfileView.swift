//
//  UserProfileView.swift
//  LittleLemonCapstone
//
//  Created by Dan June on 2/28/25.
//

import SwiftUI

struct UserProfileView: View {
        
    @StateObject private var viewModel = ViewModel()

    @Environment(\.presentationMode) var presentation
    
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
        ScrollView(.vertical, showsIndicators: false){
            NavigationLink(destination: OnBoardingView(), isActive: $isLoggedOut) { }
            VStack(spacing: 5){
                VStack(alignment: .leading) {
                    Text("Avatar")
                        .font(.leadText())
                        .padding(.leading)
                    HStack(spacing: 0) {
                        Image("Profile")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                            .padding(.trailing)
                        Button("Change"){}
                            .buttonStyle(ButtonAccentReverse())
                        Button("Remove"){}
                            .buttonStyle(ButtonAccent())
                        Spacer()
                    }
                    VStack(alignment: .leading) {
                        Text("First Name:")
                        TextField("", text: $firstName)
                            .textFieldStyle(RoundedTextFieldStyle())
                    }
                    VStack(alignment: .leading) {
                        Text("Last Name:")
                        TextField("Last Name", text: $lastName)
                            .textFieldStyle(RoundedTextFieldStyle())
                    }
                    VStack(alignment: .leading) {
                        Text("Email:")
                        TextField("Email", text: $email)
                            .textFieldStyle(RoundedTextFieldStyle())
                    }
                    .autocapitalization(.none)
                    VStack(alignment: .leading) {
                        Text("Phone Number:")
                        TextField("Phone Number", text: $phoneNumber)
                            .onChange(of: phoneNumber) {
                               if !phoneNumber.isEmpty {
                                   phoneNumber = phoneNumber.formatPhoneNumber()
                                }
                             }
                            .textFieldStyle(RoundedTextFieldStyle())
                    }
                    .disableAutocorrection(true)
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
        .navigationTitle(Text("Personal information"))
        .navigationBarTitleDisplayMode(.inline)

    }
}

#Preview {
    UserProfileView()
}
