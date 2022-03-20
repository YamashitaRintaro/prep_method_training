import axios from 'axios';
axios.defaults.headers['X-Requested-With'] = 'XMLHttpRequest';
axios.defaults.headers['X-CSRF-TOKEN'] = document.getElementsByName('csrf-token')[0].getAttribute('content');
const record = document.querySelector('.record');
const stop = document.querySelector('.stop');
const finish = document.querySelector('.finish');
const questionVoice = document.getElementById('question-voice');
const voiceForm = document.getElementById('voiceform');
let count = 0;

stop.disabled = true;

//main block for doing the audio recording

// マイクを使用する許可をユーザーに求める
if (navigator.mediaDevices.getUserMedia) {
  console.log('getUserMedia supported.');
  // メディアの種類を指定
  const constraints = { audio: true };
  let chunks = [];

  let onSuccess = function(stream) {
    const mediaRecorder = new MediaRecorder(stream);
    
    record.onclick = function() {
      this.classList.add('d-none');
      stop.classList.remove('d-none');
      questionVoice.play();
      mediaRecorder.start();
      console.log(mediaRecorder.state);
      console.log("recorder started");
      stop.disabled = false;
    }

    mediaRecorder.onstart = function() {
      count++;
      console.log(count);
    }
    
    stop.onclick = function() {
      mediaRecorder.stop();
      console.log(mediaRecorder.state);
      console.log("recorder stopped");
      if (count < 5) {
        mediaRecorder.start();
        console.log("次のフェーズへ");
        console.log(mediaRecorder.state);
      } else {
        console.log("現在フェーズ3です");
      }
    }
    
    // 音声データを収集する
    mediaRecorder.ondataavailable = function(e) {
      chunks.push(e.data);
    }
    
    mediaRecorder.onstop = function(e) {
      console.log("data available after MediaRecorder.stop() called.");
      const blob = new Blob(chunks, { 'type' : 'audio/ogg; codecs=opus' });
      let formData = new FormData();
      formData.append('training_id', document.querySelector('#training_id').value);
      formData.append('voice_data', blob, 'voicedata');
      if (count == 1) {
        formData.append('phase', 'point');
      } else if (count == 2 ){
        formData.append('phase', 'reason');
      } else if (count == 3 ){
        formData.append('phase', 'example');
      } else {
        formData.append('phase', 'second_point');
        count = 0;
        stop.disabled = true;
        stop.classList.add('d-none');
        finish.classList.remove('d-none');
      }
      axios.post(document.querySelector('#voiceform').action, formData, {
        headers: {
        'content-type': 'multipart/form-data',
        }
        }).catch(error => {
        console.log(error.response)
       })
    }
  }

  let onError = function(err) {
    console.log('The following error occured: ' + err);
  }

  navigator.mediaDevices.getUserMedia(constraints).then(onSuccess, onError);

} else {
   console.log('getUserMedia not supported on your browser!');
}

window.onresize();
