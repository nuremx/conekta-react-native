<img src="https://raw.githubusercontent.com/nuremx/conekta-react-native/master/assets/banner.jpg" align="center" alt="Conekta React Native banner" />

# Conekta React Native [![npm version](https://badge.fury.io/js/conekta-react-native.svg)](https://badge.fury.io/js/conekta-react-native)

> Conekta online payment processing platform on React Native

> **Currently iOS only**

## Installation

```bash
yarn add conekta-react-native # or npm i
```

Link the module

```bash
react-native link conekta-react-native
```

#### iOS Notes

Check that the Libraries group in Xcode have `RNConekta` and the project settings include `libRNConekta` in Linked Frameworks and Libraries. See [Manual Linking](https://facebook.github.io/react-native/docs/linking-libraries-ios).

**Important**. Since this module uses Swift, and RN projects are based in Obj-C, add an empty Swift file inside your project (no bridging header required), this will remove linked Xcode error. See related [Stack Overflow Post](https://stackoverflow.com/questions/50096025/it-gives-errors-when-using-swift-static-library-with-objective-c-project)

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
const conekta = new Conekta("key_KJysdbf6PotS2ut2");

const card = conekta.createCard({
  number: "4242424242424242",
  name: "Julian Ceballos",
  cvc: "123",
  expMonth: "10",
  expYear: "2018"
});

card
  .createToken()
  .then(data => {
    console.log("DATA", data);
  })
  .catch(error => {
    console.log("ERROR", error);
  });
```

## TODO

- [ ] Android version
- [ ] Optimization
- [ ] Testing

Please feel free to post a PR

## Licence

MIT
