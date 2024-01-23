document.addEventListener('DOMContentLoaded', function(){
  const postForm = document.getElementById('new_icon');
  const previewList = document.getElementById('previews');
  if (!postForm) return null;

  const fileField = document.querySelector('input[type="file"][name="user[icon]"]');
  fileField.addEventListener('change', function(e){

  const alreadyPreview = document.querySelector('.preview');
  if (alreadyPreview) {
    alreadyPreview.remove();
  };
  
  const file = e.target.files[0];
  const blob = window.URL.createObjectURL(file);

  const defaultImage = document.getElementById('preview');
  if (defaultImage) {
    defaultImage.style.display = 'none';
  }

  const previewWrapper = document.createElement('div');
  previewWrapper.setAttribute('class', 'preview', 'rounded-full');
  const previewImage = document.createElement('img');
  previewImage.setAttribute('class', 'preview-image rounded-full');
  previewImage.setAttribute('src', blob);
  previewWrapper.appendChild(previewImage);
  previewList.appendChild(previewWrapper);
  });
});