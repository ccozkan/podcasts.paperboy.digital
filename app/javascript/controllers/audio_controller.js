import { Controller } from "@hotwired/stimulus";
import Plyr from "plyr";

export default class extends Controller {
  connect() {
    const player = new Plyr('#player');
  }
}
