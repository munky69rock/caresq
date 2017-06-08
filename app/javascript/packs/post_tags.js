const Choices = require('../../../node_modules/choices.js/assets/scripts/dist/choices');
const choices = new Choices('#tags_values', {
  removeItemButton: true,
  maxItemCount: 3,
  noResultsText: '一致するタグがありません',
  placeholderValue: 'タグを選択',
  maxItemText: function(maxItemCount) {
    return maxItemCount + 'つまで選択できます';
  }
});
