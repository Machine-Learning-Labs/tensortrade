#!/usr/bin/env bash

red=`tput setaf 1`
green=`tput setaf 2`
reset=`tput sgr0`

clear


echo "████████╗███████╗███╗   ██╗███████╗ ██████╗ ██████╗ ████████╗██████╗  █████╗ ██████╗ ███████╗";
echo "╚══██╔══╝██╔════╝████╗  ██║██╔════╝██╔═══██╗██╔══██╗╚══██╔══╝██╔══██╗██╔══██╗██╔══██╗██╔════╝";
echo "   ██║   █████╗  ██╔██╗ ██║███████╗██║   ██║██████╔╝   ██║   ██████╔╝███████║██║  ██║█████╗  ";
echo "   ██║   ██╔══╝  ██║╚██╗██║╚════██║██║   ██║██╔══██╗   ██║   ██╔══██╗██╔══██║██║  ██║██╔══╝  ";
echo "   ██║   ███████╗██║ ╚████║███████║╚██████╔╝██║  ██║   ██║   ██║  ██║██║  ██║██████╔╝███████╗";
echo "   ╚═╝   ╚══════╝╚═╝  ╚═══╝╚══════╝ ╚═════╝ ╚═╝  ╚═╝   ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═╝╚═════╝ ╚══════╝";
echo "                                                                                             ";


read -r -p "We're going to check dev environment dependencies and pull some docker images (~1 Gb). Do you want to continue? [y/N] " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])+$ ]]
then

	echo "\nCheck dependencies..."
	git --version >/dev/null 2>&1 || { echo >&2 "${red}I require git but it's not installed. ¯\_(ツ)_/¯  Aborting...${reset}"; exit 1; }
	docker --version >/dev/null 2>&1 || { echo >&2 "${red}I require docker but it's not installed. ¯\_(ツ)_/¯  Aborting...${reset}"; exit 1; }
	make --version >/dev/null 2>&1 || { echo >&2 "${red}I require make but it's not installed. ¯\_(ツ)_/¯  Aborting...${reset}"; exit 1; }
	pip --version >/dev/null 2>&1 || { echo >&2 "${red}I require pip but it's not installed. ¯\_(ツ)_/¯  Aborting...${reset}"; exit 1; }

	major=$(python -c"import sys; print(sys.version_info.major)")
	minor=$(python -c"import sys; print(sys.version_info.minor)")
  if [ $major -eq 2 ]; then
      echo >&2 "${red}I require python@3.6 but it's not installed. ¯\_(ツ)_/¯  Aborting...${reset}";
      exit 1
  elif [ $major -eq 3 ] && [ $minor -ge 6 ]; then
      echo "python version 3.6" >> /dev/null # :)
  else
      echo >&2 "${red}I require python@3.6 but it's not installed. ¯\_(ツ)_/¯  Aborting...${reset}";
      exit 1
  fi

	echo "${green}Everything ok${reset}"

	echo "\nPulling some images to speed up the work!"
	docker pull python:3.6
	echo "${green}Docker Images correctly pulled!${reset}"

	echo "${green}\n#################################################################################"
	echo "#   Congrats! your environment it's ready to develop and execute this project!  #"
	echo "#################################################################################\n${reset}"

fi