let opts = document.querySelectorAll('.radio');
const next = document.getElementById('next');
for (let i = 0; i < opts.length; i++) {
  let opt = opts[i];
  opt.addEventListener('click', function(){
  console.log(this.id + '-title');
  hiddenRadio = document.getElementById(this.id + '-title');
  hiddenRadio.click();
  next.disabled = false;
});
}

