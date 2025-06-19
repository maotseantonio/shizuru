{lib}: let
  escapeString = s: let
    escaped = builtins.replaceStrings ["\\" "\""] ["\\\\" "\\\""] s;
  in
    "\"" + escaped + "\"";

  toKDLNode = name: value:
    if lib.isAttrs value
    then let
      keys = builtins.attrNames value;
      childrenText = lib.concatStringsSep "\n" (lib.map (
          childKey: let
            childVal = value.${childKey};
          in
            if lib.isString childVal
            then "${childKey} " + escapeString childVal
            else if lib.isAttrs childVal
            then toKDLNode childKey childVal
            else if lib.isBool childVal
            then
              "${childKey} "
              + (
                if childVal
                then "true"
                else "false"
              )
            else if lib.isList childVal
            then
              if childKey == "match"
              then lib.concatStringsSep "\n" (lib.map (m: "match " + escapeString m) childVal)
              else toKDLNode childKey (lib.listToAttrs (lib.genAttrs (lib.range 0 (builtins.length childVal - 1)) (i: childVal.${i})))
            else "${childKey} " + escapeString (toString childVal)
        )
        keys);
    in "${name} {\n${lib.concatStringsSep "\n" (lib.map (line: "  " + line) (lib.filter (l: l != "") (lib.splitString "\n" childrenText)))}\n}"
    else if lib.isList value
    then
      if name == "spawn-at-startup"
      then
        lib.concatStringsSep "\n" (lib.map (
            args:
              "spawn-at-startup " + lib.concatStringsSep " " (lib.map escapeString args)
          )
          value)
      else "${name} {\n" + lib.concatStringsSep "\n" (lib.map (item: "  " + escapeString item) value) + "\n}"
    else if lib.isString value
    then "${name} " + escapeString value
    else "${name}";

  toKDL = configAttrs: let
    rootKeys = builtins.attrNames configAttrs;
    parts = lib.map (key: toKDLNode key (configAttrs.${key})) rootKeys;
  in
    lib.concatStringsSep "\n\n" parts;
in {
  toKDL = toKDL;
}
