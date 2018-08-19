import { NativeModules } from 'react-native'

const RCTConekta = NativeModules.Conekta

class Card {
  constructor({ number, name, cvc, expMonth, expYear }) {
    this.number = number
    this.name = name
    this.cvc = cvc
    this.expMonth = expMonth
    this.expYear = expYear
  }

  createToken() {
    const { number, name, cvc, expMonth, expYear } = this

    return new Promise((resolve, reject) => {
      RCTConekta.createToken(
        number,
        name,
        cvc,
        expMonth,
        expYear,
        (error, stringResponse) => {
          if (error) return reject(error)
          try {
            const jsonResponse = JSON.parse(stringResponse)

            if (jsonResponse.object === 'error') {
              return reject(jsonResponse)
            }

            resolve(jsonResponse)
          } catch (error) {
            reject(error)
          }
        }
      )
    })
  }
}
export default Card
