#!/bin/bash

set -e

source="$(dirname "$(readlink -f -- "$0")")"
phh="$source/patches/phh"
personal="$source/patches/personal"
extras="$source/patches/extras"
misc="$source/patches/misc"

printf "\n #### APPLYING PHH PATCHES ####\n";
sleep 1.0;
for path in $(cd $phh; echo *); do
	tree="$(tr _ / <<<$path | sed -e 's;platform/;;g')"
	printf "\n| $path #####\n";
	[ "$tree" == build ] && tree=build/make
    [ "$tree" == vendor/hardware/overlay ] && tree=vendor/hardware_overlay
    [ "$tree" == treble/app ] && tree=treble_app
	pushd $tree

	for patch in $phh/$path/*.patch; do
		# Check if patch is already applied
		if patch -f -p1 --dry-run -R < $patch > /dev/null; then
            printf "### ALREDY APPLIED: $patch \n";
			continue
		fi

		if git apply --check $patch; then
			git am $patch
		elif patch -f -p1 --dry-run < $patch > /dev/null; then
			#This will fail
			git am $patch || true
			patch -f -p1 < $patch
			git add -u
			git am --continue
		else
			printf "### FAILED APPLYING: $patch \n"
		fi
	done

	popd
done

printf "\n### APPLYING PERSONAL PATCHES ####\n";
sleep 1.0;
for path_personal in $(cd $personal; echo *); do
	tree="$(tr _ / <<<$path_personal | sed -e 's;platform/;;g')"
	printf "\n| $path_personal ###\n";
	[ "$tree" == build ] && tree=build/make
    [ "$tree" == vendor/hardware/overlay ] && tree=vendor/hardware_overlay
    [ "$tree" == treble/app ] && tree=treble_app
	pushd $tree

	for patch in $personal/$path_personal/*.patch; do
		# Check if patch is already applied
		if patch -f -p1 --dry-run -R < $patch > /dev/null; then
            printf "### ALREDY APPLIED: $patch \n";
			continue
		fi

		if git apply --check $patch; then
			git am $patch
		elif patch -f -p1 --dry-run < $patch > /dev/null; then
			#This will fail
			git am $patch || true
			patch -f -p1 < $patch
			git add -u
			git am --continue
		else
			printf "### FAILED APPLYING: $patch \n"
		fi
	done

	popd
done

printf "\n### APPLYING EXTRAS PATCHES ####\n";
sleep 1.0;
for path_extras in $(cd $extras; echo *); do
	tree="$(tr _ / <<<$path_extras | sed -e 's;platform/;;g')"
	printf "\n| $path_extras ###\n";
	[ "$tree" == build ] && tree=build/make
    [ "$tree" == vendor/hardware/overlay ] && tree=vendor/hardware_overlay
    [ "$tree" == treble/app ] && tree=treble_app
	pushd $tree

	for patch in $extras/$path_extras/*.patch; do
		# Check if patch is already applied
		if patch -f -p1 --dry-run -R < $patch > /dev/null; then
            printf "### ALREDY APPLIED: $patch \n";
			continue
		fi

		if git apply --check $patch; then
			git am $patch
		elif patch -f -p1 --dry-run < $patch > /dev/null; then
			#This will fail
			git am $patch || true
			patch -f -p1 < $patch
			git add -u
			git am --continue
		else
			printf "### FAILED APPLYING: $patch \n"
		fi
	done

	popd
done

printf "\n### APPLYING MISC PATCHES ####\n";
sleep 1.0;
for path_misc in $(cd $misc; echo *); do
	tree="$(tr _ / <<<$path_misc | sed -e 's;platform/;;g')"
	printf "\n| $path_misc ###\n";
	[ "$tree" == build ] && tree=build/make
    [ "$tree" == vendor/hardware/overlay ] && tree=vendor/hardware_overlay
    [ "$tree" == treble/app ] && tree=treble_app
	pushd $tree

	for patch in $misc/$path_misc/*.patch; do
		# Check if patch is already applied
		if patch -f -p1 --dry-run -R < $patch > /dev/null; then
            printf "### ALREDY APPLIED: $patch \n";
			continue
		fi

		if git apply --check $patch; then
			git am $patch
		elif patch -f -p1 --dry-run < $patch > /dev/null; then
			#This will fail
			git am $patch || true
			patch -f -p1 < $patch
			git add -u
			git am --continue
		else
			printf "### FAILED APPLYING: $patch \n"
		fi
	done

	popd
done

