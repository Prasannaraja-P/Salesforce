import { LightningElement } from "lwc";

export default class FindGreatestNumber extends LightningElement {
  numberOne;
  numberTwo;
  numberThree;
  greatestNumber = null;

  handleInputChange(event) {
    const { name, value } = event.target;
    if (name === "number1") {
      this.numberOne = value;
    } else if (name === "number2") {
      this.numberTwo = value;
    } else if (name === "number3") {
      this.numberThree = value;
    }
  }

  handleClick() {
    let numberArray = [this.numberOne, this.numberTwo, this.numberThree];

    //Math.max() method returns the number with the highest value
    this.greatestNumber = Math.max(...numberArray);

    //Resetting values
    this.numberOne = null;
    this.numberTwo = null;
    this.numberThree = null;
  }
}
