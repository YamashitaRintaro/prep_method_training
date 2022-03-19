import axios from 'axios';
axios.defaults.headers['X-Requested-With'] = 'XMLHttpRequest';
axios.defaults.headers['X-CSRF-TOKEN'] = document.getElementsByName('csrf-token')[0].getAttribute('content');
const record = document.querySelector('.record');
const stop = document.querySelector('.stop');
const soundClips = document.querySelector('.sound-clips');
const questionVoice = document.getElementById('question-voice');
const voiceForm = document.getElementById('voiceform');

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
      questionVoice.play()
      mediaRecorder.start();
      console.log(mediaRecorder.state);
      console.log("recorder started");
      record.style.background = "red";
      
      stop.disabled = false;
      record.disabled = true;
    }
    
    stop.onclick = function() {
      mediaRecorder.stop();
      console.log(mediaRecorder.state);
      console.log("recorder stopped");
      record.style.background = "";
      record.style.color = "";
      // mediaRecorder.requestData();

      stop.disabled = true;
      record.disabled = false;
    }
    
    // 音声データを収集する
    mediaRecorder.ondataavailable = function(e) {
      chunks.push(e.data);
    }
    
    mediaRecorder.onstop = function(e) {
      console.log("data available after MediaRecorder.stop() called.");
      
      const clipName = 'My unnamed clip';
      const clipContainer = document.createElement('article');
      const clipLabel = document.createElement('p');
      const audio = document.createElement('audio');
      const deleteButton = document.createElement('button');
      
      clipContainer.classList.add('clip');
      audio.setAttribute('controls', '');
      deleteButton.textContent = 'Delete';
      deleteButton.className = 'delete';
      
      clipContainer.appendChild(audio);
      clipContainer.appendChild(clipLabel);
      clipContainer.appendChild(deleteButton);
      soundClips.appendChild(clipContainer);

      deleteButton.onclick = function(e) {
        let evtTgt = e.target;
        evtTgt.parentNode.parentNode.removeChild(evtTgt.parentNode);
      }
      
      const blob = new Blob(chunks, { 'type' : 'audio/ogg; codecs=opus' });
      const audioUrl = URL.createObjectURL(blob);
      audio.src = audioUrl;
      
      let formData = new FormData();
      formData.append('training_id', document.querySelector('#training_id').value);
      formData.append('voice_data', blob, 'voicedata');
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
