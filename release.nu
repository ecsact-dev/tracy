let version = buildozer "print version" "//MODULE.bazel:%module";
let version_parts = $version | split words;
let last_index = ($version_parts | length) - 1;
let new_registry_version = ($version_parts | last | into int) + 1;
let version_parts = $version_parts | update $last_index $new_registry_version;
let new_version = $version_parts | str join ".";

print $"($version) -> ($new_version)";

buildozer $"set version ($new_version)" "//MODULE.bazel:%module";
git add MODULE.bazel;
git commit -m $"chore: update bzlmod version ($new_version)";
git push;
gh release create $"ecsact-bzlmod-($new_version)" --generate-notes;
