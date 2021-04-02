//
//  BruteForceButton.swift
//  Navigation
//
//  Created by Konstantin Pimbursky on 01.04.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

protocol BruteForceDelegate: class {
    func passwordTransfer(password: String) -> Void
    func startActivityIndicator() -> Void
}

class BruteForceButton: UIButton {
    
    private var password: String = ""
    private let dispatchQueue = DispatchQueue(label: "Background", qos: .background, attributes: .concurrent)
    var delegate: BruteForceDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.setTitle("Подобрать пароль", for: .normal)
        self.setTitleColor(.link, for: .normal)
        self.addTarget(self, action: #selector(bruteForceStart), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func bruteForceStart() {
        dispatchQueue.async { [weak self] in
            if let self = self {
                self.delegate?.startActivityIndicator()
                let ALLOWED_CHARACTERS:   [String] = String().printable.map { String($0) }

                // Will strangely ends at 0000 instead of ~~~
                while !LoginChecker.shared.checkLoginPassword(login: nil, password: self.password) { // Increase MAXIMUM_PASSWORD_SIZE value for more
                    self.password = self.generateBruteForce(self.password, fromArray: ALLOWED_CHARACTERS)
                    // Your stuff here
                    print(self.password)
                    // Your stuff here
                }
                self.delegate?.passwordTransfer(password: self.password)
            }
        }
    }
    
    private func indexOf(character: Character, _ array: [String]) -> Int {
        return array.firstIndex(of: String(character))!
    }

    private func characterAt(index: Int, _ array: [String]) -> Character {
        return index < array.count ? Character(array[index])
                                   : Character("")
    }

    private func generateBruteForce(_ string: String, fromArray array: [String]) -> String {
        var str: String = string

        if str.count <= 0 {
            str.append(characterAt(index: 0, array))
        }
        else {
            str.replace(at: str.count - 1,
                        with: characterAt(index: (indexOf(character: str.last!, array) + 1) % array.count, array))

            if indexOf(character: str.last!, array) == 0 {
                str = String(generateBruteForce(String(str.dropLast()), fromArray: array)) + String(str.last!)
            }
        }

        return str
    }
}

extension String {
    var digits:      String { return "0123456789" }
    var lowercase:   String { return "abcdefghijklmnopqrstuvwxyz" }
    var uppercase:   String { return "ABCDEFGHIJKLMNOPQRSTUVWXYZ" }
    var punctuation: String { return "!\"#$%&'()*+,-./:;<=>?@[\\]^_`{|}~" }
    var letters:     String { return lowercase + uppercase }
    var printable:   String { return digits + letters + punctuation }

    mutating func replace(at index: Int, with character: Character) {
        var stringArray = Array(self)
        stringArray[index] = character
        self = String(stringArray)
    }
}
