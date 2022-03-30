import axios from 'axios';
axios.defaults.headers['X-Requested-With'] = 'XMLHttpRequest';
axios.defaults.headers['X-CSRF-TOKEN'] = document.getElementsByName('csrf-token')[0].getAttribute('content');
const record = document.querySelector('.record');
const stop = document.querySelector('.stop');
const finish = document.getElementById('finish');
const questionVoice = document.getElementById('question-voice');
const questionTitle = document.getElementById('question-title');
const voiceForm = document.getElementById('voiceform');
const point = document.getElementById('point');
const reason = document.getElementById('reason');
const example = document.getElementById('example');
const second_point = document.getElementById('second-point');

let count = 0;
stop.disabled = true;

//main block for doing the audio recording

// マイクを使用する許可をユーザーに求める
if (navigator.mediaDevices.getUserMedia) {
  console.log('getUserMedia supported.');
  const constraints = { audio: true };// メディアの種類を指定
  let chunks = [];// 録音データを保存

  let onSuccess = function(stream) {
    let mediaRecorder = new MediaRecorder(stream);
    
    record.onclick = function() {
      this.classList.add('d-none');
      stop.classList.remove('d-none');
      point.classList.add('text-dark');
      stop.textContent = '理由フェーズへ';
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
      console.log(chunks);
    }
    
    mediaRecorder.onstop = function(e) {
      const blob = new Blob(chunks, { 'type' : 'audio/ogg; codecs=opus' });
      chunks = [];
      let formData = new FormData();
      formData.append('training_id', document.querySelector('#training_id').value);
      formData.append('voice_data', blob, 'voicedata');
      if (count == 1) {
        formData.append('phase', 'point');
        stop.textContent = '具体例フェーズへ';
        point.classList.remove('text-dark');
        reason.classList.add('text-dark');
      } else if (count == 2 ){
        formData.append('phase', 'reason');
        stop.textContent = '結論フェーズへ';
        reason.classList.remove('text-dark');
        example.classList.add('text-dark');
      } else if (count == 3 ){
        formData.append('phase', 'example');
        stop.textContent = '保存する';
        example.classList.remove('text-dark');
        second_point.classList.add('text-dark');
      } else {
        formData.append('phase', 'second_point');
      }
      axios.post(document.querySelector('#voiceform').action, formData, {
        headers: {
        'content-type': 'multipart/form-data',
        }
        }).catch(error => {
        console.log(error.response)
       })

      if (count == 4) {
        count = 0;
        finish.click();
      }
    }
  }

  let onError = function(err) {
    console.log('The following error occured: ' + err);
  }

  navigator.mediaDevices.getUserMedia(constraints).then(onSuccess, onError);

} else {
   console.log('getUserMedia not supported on your browser!');
}
