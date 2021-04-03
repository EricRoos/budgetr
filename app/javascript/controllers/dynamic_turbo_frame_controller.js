import { Controller } from "stimulus"

export default class extends Controller {
  static values = {
    frameId: String,
    src: String
  }

  load() {
    document.querySelector(`turbo-frame#${this.frameIdValue}`).setAttribute('src', this.srcValue);
  }
}
