document.addEventListener('turbo:load', function() {
  var managementRadios = document.querySelectorAll('input[name="food[management]"]');
  var dateSelectContainer = document.querySelector('.date-select-container');

  function toggleDateSelect() {
    if (managementRadios[2].checked) {
      dateSelectContainer.style.display = 'none';
    } else {
      dateSelectContainer.style.display = 'block';
    }
  }

  // ページ読み込み時に初期状態での表示/非表示を設定
  toggleDateSelect();

  // ラジオボタンの選択状態が変更された時に表示/非表示を切り替える
  managementRadios.forEach(function(radio) {
    radio.addEventListener('click', toggleDateSelect);
  });
});