import "select2";

const $tag = $("#tags_values");
if ($tag.length > 0) {
  $tag.select2({
    tags: true,
    maximumSelectionLength: 5
  });
}
