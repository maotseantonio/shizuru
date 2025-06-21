#!/usr/bin/env bash

# Description:
#   Wraps a Home-Manager-style Nix module with a toggleable enable option.
#   Correctly uses curly braces `{}` instead of parentheses or lists.
#
# Usage:
#   ./wrap-hm-module.sh path/to/module.nix

file="$1"

if [[ -z "$file" ]]; then
  echo "❌ Usage: $0 ~/shizuru/modules/system/common/programs/foot.nix"
  exit 1
fi

if [[ ! -f "$file" ]]; then
  echo "❌ File not found: $file"
  exit 1
fi

modname="$(basename "$file" .nix)"
namespace="modules.terminal.${modname}"
tmpfile=$(mktemp)

# Header with enable option
cat <<EOF > "$tmpfile"
{ lib, config, pkgs, inputs, ... }:
let
  cfg = config.${namespace};
in {
  options.${namespace}.enable = lib.mkEnableOption "Enable ${modname} module";

  config = lib.mkIf cfg.enable {
EOF

# Indent the original module contents
sed 's/^/    /' "$file" >> "$tmpfile"

# Closing config block
cat <<EOF >> "$tmpfile"
  };
}
EOF

# Replace original file
cp "$tmpfile" "$file"
rm "$tmpfile"

echo "✅ Wrapped module with enable toggle: $file"
echo "🔧 Enable with: ${namespace}.enable = true;"
