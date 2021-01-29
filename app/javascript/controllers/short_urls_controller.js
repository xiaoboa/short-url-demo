import { Controller } from 'stimulus'

export default class extends Controller {
    static targets = ["shortUrlList", "originUrl", "shortUrlErrors"]

    connect() { }

    onCreateSuccess(event) {
        const [_data, _status, xhr] = event.detail

        this.shortUrlListTarget.innerHTML = xhr.response + this.shortUrlListTarget.innerHTML
        this.originUrlTarget.value = ''
    }

    onCreateError(event) {
        const [_data, _status, xhr] = event.detail

        this.shortUrlErrorsTarget.innerHTML = xhr.response
    }
}
