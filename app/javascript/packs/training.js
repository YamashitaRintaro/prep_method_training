let opts = document.querySelectorAll('.radio');
const next = document.getElementById('next');
for (let i = 0; i < opts.length; i++) {
  let opt = opts[i];
  opt.addEventListener('click', function(){
  hiddenRadio = document.getElementById(this.id + '_title');
  hiddenRadio.click();
  next.disabled = false;
});
}

