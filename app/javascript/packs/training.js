let opts = document.querySelectorAll('.radio');
for (let i = 0; i < opts.length; i++) {
  let opt = opts[i];
  opt.addEventListener('click', function(){
  console.log(this.id + '-title');
  hiddenRadio = document.getElementById(this.id + '-title');
  hiddenRadio.click();
});
}