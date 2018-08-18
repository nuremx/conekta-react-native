import toBase64 from '../lib/toBase64'

class Card {
  constructor(
    number,
    name,
    cvc,
    expMonth,
    expYear,
    deviceFingerprint,
    baseURI,
    publicKey
  ) {
    this.resourceURI = '/tokens'

    this.number = number
    this.name = name
    this.cvc = cvc
    this.expMonth = expMonth
    this.expYear = expYear
    this.deviceFingerprint = deviceFingerprint
    this.baseURI = baseURI

    this.apiKeyBase64 = toBase64(publicKey)
  }

  JSONData() {
    return JSON.stringify({
      card: {
        name: this.name,
        number: this.number,
        cvc: this.cvc,
        exp_month: this.expMonth,
        exp_year: this.expYear,
        device_fingerprint: this.deviceFingerprint,
      },
    })
  }

  async createToken() {
    let response = await fetch(`${this.baseURI}${this.resourceURI}`, {
      method: 'POST',
      headers: {
        Authorization: `Basic ${this.apiKeyBase64}`,
        'Content-type': 'application/json',
        Accept: 'application/vnd.conekta-v0.3.0+json',
        'Conekta-Client-User-Agent':
          '{"agent":"Conekta Conekta ReactNative SDK"}',
      },
      body: this.JSONData(),
    })

    return response.json()
  }
}

export default Card
