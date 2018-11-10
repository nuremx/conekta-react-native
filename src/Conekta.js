import { NativeModules } from "react-native";

const RNConekta = NativeModules.RNConekta;

import Card from "./Card";

function required() {
  throw new Error("Public key must be provided");
}

class Conekta {
  constructor(publicKey = required()) {
    this.publicKey = publicKey; // TODO to base 64

    if (typeof RNConekta === "undefined") {
      throw new Error(
        "RNConekta is undefined, you may forgot to link the module"
      );
    }

    RNConekta.setPublicKey(publicKey);
  }

  createCard({ number, name, cvc, expMonth, expYear }) {
    console.log("CREATING CARD", number, name, cvc, expMonth, expYear);
    return new Card({
      number,
      name,
      cvc,
      expMonth,
      expYear
    });
  }
}

export default Conekta;
