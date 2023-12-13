export function initToogleMenu () {
    const menuButton = document.querySelector('#menuToggle');
    const mainNav = document.querySelector('#navbarCollapse');
    if(menuButton && mainNav){
      menuButton.addEventListener('click',(e)=> {
        menuButton.classList.toggle('active');
        mainNav.classList.toggle('open');
      })
    }
}

export function toggleTarget(initiator){
  console.log();
}