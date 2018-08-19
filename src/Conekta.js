import { NativeModules } from 'react-native'

const RCTConekta = NativeModules.Conekta

import Card from './Card'

function required() {
  throw new Error('Public key must be provided')
}

class Conekta {
  constructor(publicKey = required()) {
    this.publicKey = publicKey // TODO to base 64
    RCTConekta.setPublicKey(publicKey)
  }

  createCard({ number, name, cvc, expMonth, expYear }) {
    return new Card({
      number,
      name,
      cvc,
      expMonth,
      expYear,
    })
  }
}

export default Conekta
