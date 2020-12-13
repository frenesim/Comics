import { Controller } from "stimulus"

export default class extends Controller {
  static values = { url: String }

  toggleFavorite() {
    fetch(this.urlValue)
    .then(r => r.text())
    .then(data => this.element.innerHTML = data)
  }
}
