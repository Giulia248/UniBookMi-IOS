//
//  MailView.swift
//  UniBookMi-IOS
//
//  Created by giulia.floris on 07/05/24.
//


import SwiftUI

struct MailView: View {

    @State private var emailAddress = ""
    @State private var phoneNumber = ""
    @State private var message = ""

    @State private var preferredContactMethod = ContactMethod.email
    @State private var showAlertError = false

    @State private var errorMessage = ""

    enum ContactMethod {
        case email, phone
    }

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text(UniBookMiStrings.contactMethod)) {
                    Picker("", selection: $preferredContactMethod) {
                        Text("Email").tag(ContactMethod.email)
                        Text("Phone").tag(ContactMethod.phone)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    switch preferredContactMethod {
                    case .email:
                        TextField("Email Address", text: $emailAddress)
                            .textContentType(.emailAddress)
                            .disableAutocorrection(true)
                            .onChange(of: emailAddress, {
                                emailAddress = emailAddress.lowercased()
                            })
                    case .phone:
                        TextField("Phone Number", text: $phoneNumber)
                    }
                }
                Section(header: Text(UniBookMiStrings.writeYourMessage)) {
                    TextEditor(text: $message)
                }
                Button(UniBookMiStrings.send, action: {
                    if (emailAddress.isEmpty || phoneNumber.isEmpty) && message.isEmpty { // empty fields
                        errorMessage = UniBookMiStrings.fieldsError
                        showAlertError.toggle()
                        return
                    }
                    EmailController.shared.sendEmail(subject: "Contatto da \(emailAddress) \(phoneNumber)", body: "Richiesta di contatto\n\(message)", to: "giulia.floris@studenti.unimi.it", onFailure: { _ in } )
                    EmailController.shared.sendEmail(subject: "Contatto da \(emailAddress) \(phoneNumber)", body: "Richiesta di contatto\n\(message)", to: "paolo.faltaous@studenti.unimi.it", onFailure: { failed in

                        if failed { // device error
                            errorMessage = UniBookMiStrings.emailError
                            showAlertError.toggle()
                        }
                    } )
                })
                .alert("Error: \(errorMessage)", isPresented: $showAlertError) {
                    Button("OK", role: .cancel) {
                        showAlertError.toggle()
                    }
                }
            }
        }
    }
}
