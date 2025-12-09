#!/usr/bin/env bash
#(C)2019-2022 Pim Snel - https://github.com/mipmip/RUNME.sh
CMDS=();DESC=();NARGS=$#;ARG1=$1;make_command(){ CMDS+=($1);DESC+=("$2");};usage(){ printf "\nUsage: %s [command]\n\nCommands:\n" $0;line="              ";for((i=0;i<=$(( ${#CMDS[*]} -1));i++));do printf "  %s %s ${DESC[$i]}\n" ${CMDS[$i]} "${line:${#CMDS[$i]}}";done;echo;};runme(){ if test $NARGS -eq 1;then eval "$ARG1"||usage;else usage;fi;}

##### PLACE YOUR COMMANDS BELOW #####


make_command "buildrun" "Build and run the module set in \$MODULE"
buildrun(){
  if [ -z "${MODULE}" ]; then
    echo "Error: MODULE environment variable is not set."
    echo "Please set MODULE to a valid nixos module name."
    return 1
  fi

  nix flake update && nom build .#nixosConfigurations.${MODULE}.config.system.build.vm
  ./result/bin/run-nixos-vm
}
make_command "listmods" "list available mods"
listmods(){
  nix flake show --json | jq -r '.nixosConfigurations | keys | to_entries[] | .value'
}

##### PLACE YOUR COMMANDS ABOVE #####

runme
