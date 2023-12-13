export function init() {
    const data = JSON.parse(localStorage.getItem('data'))
    let years = {}
    Object.values(data).forEach(element => {
        Object.values(element).forEach((innerElement,index) => {
            if(typeof innerElement['properties'] !== 'undefined') {
             
            }
        })
    })
}