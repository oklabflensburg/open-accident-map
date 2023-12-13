import * as Mapfunctions from './MapFunctions.js'
import * as Navigation from './Navigation.js'
import * as Filters from './FilterFunctions.js'

Navigation.initToogleMenu();

const togglers = document.querySelectorAll('.toggler')
if (togglers.length) {
    togglers.forEach(el => {
        el.addEventListener('click', () => {
            const target = document.querySelector('#' + el.dataset.toggleTarget);
            if (target.classList.contains('open')) {
                target.classList.remove('open')
            } else {
                target.classList.add('open')
            }
        })
    })
}

Filters.init()
