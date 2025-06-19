{
  lib,
  pkgs,
  config,
  inputs,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (lib.strings) concatStrings;
in {
  hj.rum.programs.starship = {
    enable = true;

    settings = {
      format = lib.concatStrings [
        "$hostname"
        "$directory"
        "$localip"
        "$shlvl"
        "$singularity"
        "$kubernetes"
        "$vcsh"
        "$hg_branch"
        "$docker_context"
        "$package"
        "$custom"
        "$sudo"
        "$fill"
        "$git_branch"
        "$git_status"
        "$git_commit"
        "$cmd_duration"
        "$jobs"
        "$battery"
        "$time"
        "$status"
        "$os"
        "$container"
        "$shell"
        "$line_break"
        "$character"
      ];

      add_newline = true;

      hostname = {
        format = "[ $ssh_symbol$hostname ](bold bg:#24273a fg:#E8E3E3)";
        disabled = false;
      };

      directory = {
        format = "[ $path ]($style)[   ](bg:#8caaee fg:#24273a)";
        style = "bg:#24273a fg:#E8E3E3 bold";
      };

      cmd_duration = {
        format = "[ $duration ]($style)[ 󱑂  ](bg:#ca9ee6 fg:#24273a)";
      };

      character = {
        success_symbol = "[ •   ](#8caaee bold)";
        error_symbol = "[ •  󰅙 ](#e78284 bold)";
      };

      git_branch = {
        format = "[ $branch ]($style) [  ](bg:#81C19B fg:#24273a)";
        style = "bg:#24273a fg:#E8E3E3";
        symbol = " ";
      };
      git_status = {
        format = "[ $all_status$ahead_behind ]($style) [  ](bg:#8caaee fg:#24273a)";
        style = "bg:#24273a fg:#E8E3E3";
        conflicted = "=";
      };

      battery = {
        format = "[ $symbol$percentage ](bold fg:#a6e3a1)";
        full_symbol = "󰁹 ";
        charging_symbol = "󰂄 ";
        discharging_symbol = "󰂃 ";
        display = [
          {
            threshold = 10;
            style = "bold fg:#e78284";
          }
          {
            threshold = 30;
            style = "bold fg:#ef9f76";
          }
          {
            threshold = 100;
            style = "bold fg:#a6e3a1";
          }
        ];
      };

      aws = {
        format = "[$symbol]($style)";
        symbol = " ";
        style = "bold yellow";
      };

      python = {
        format = "[$symbol]($style)";
        symbol = " ";
        style = "bold yellow";
      };

      nodejs = {
        format = "[$symbol]($style)";
        symbol = " ";
        style = "bold green";
      };

      c.disabled = true;
      cmake.disabled = true;
      haskell.disabled = true;
      ruby.disabled = true;
      rust.disabled = true;
      perl.disabled = true;
      package.disabled = true;
      lua.disabled = true;
      java.disabled = true;
      golang.disabled = true;
    };
  };
}
