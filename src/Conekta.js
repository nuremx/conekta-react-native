import uuid from 'react-native-uuid'

import Card from './Card'

const baseURI = 'https://api.conekta.io'

class Conekta {
  constructor(publicKey) {
    this.publicKey = publicKey

    this.deviceFingerprint = uuid.v4().replace(/-/g, '')
    // TODO this.registerDevice()
  }

  createCard({ number, name, cvc, expMonth, expYear }) {
    const deviceFingerprint = this.deviceFingerprint
    const publicKey = this.publicKey

    return new Card(
      number,
      name,
      cvc,
      expMonth,
      expYear,
      deviceFingerprint,
      baseURI,
      publicKey
    )
  }
}

export default Conekta
