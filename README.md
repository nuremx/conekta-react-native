<img src="https://raw.githubusercontent.com/nuremx/conekta-react-native/master/assets/banner.jpg" align="center" alt="Conekta React Native banner" />

# Conekta React Native [![npm version](https://badge.fury.io/js/conekta-react-native.svg)](https://badge.fury.io/js/conekta-react-native)

> **Currently iOS only**

## Installation

```bash
yarn add conekta-react-native # or npm i
```

```bash
react-native link conekta-react-native
```

## Usage

With async/await:

```javascript
const conekta = new Conekta('key_KJysdbf6PotS2ut2')

const card = conekta.createCard({
  number: '4242424242424242',
  name: 'Julian Ceballos',
  cvc: '123',
  expMonth: '10',
  expYear: '2018',
})

try {
  const data = await card.createToken()
  console.log('DATA', data)
} catch (error) {
  console.log('ERROR', error)
}
```

Or if you prefer promises:

```javascript
const conekta = new Conekta('key_KJysdbf6PotS2ut2')

const card = conekta.createCard({
  number: '4242424242424242',
  name: 'Julian Ceballos',
  cvc: '123',
  expMonth: '10',
  expYear: '2018',
})

card
  .createToken()
  .then((data) => {
    console.log('DATA', data)
  })
  .catch((error) => {
    console.log('ERROR', error)
  })
```

## TODO

- [ ] Android version
- [ ] Optimization
- [ ] Testing

Please feel free to post a PR to help

## Licence

MIT
&copy; 2018 Nure
