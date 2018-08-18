# Conekta React Native

## Installation

```bash
yarn add conekta-react-native # or npm i
```

That's it, **no linking required**

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

- [ ] Parameters validation
- [ ] Testing
- [ ] Ensure with the Conekta team that this is a correct implementation

Please feel free to post a PR to help

## Licence

MIT
&copy; 2018 Nure
