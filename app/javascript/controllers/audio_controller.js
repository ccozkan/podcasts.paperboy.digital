import { Controller } from "@hotwired/stimulus";
import Plyr from "plyr";

export default class extends Controller {
  static targers = ["output"]
  connect() {
    const player = new Plyr('#player');
  }

  next(event) {
      console.log('zaa');
      console.log(event);
      fetch(this.audioUrl).then(
          // console.log('heheheh')
      );
  }

  initialize() {
    console.log('asdsa');
  }

  reloadSource() {
  }
}
