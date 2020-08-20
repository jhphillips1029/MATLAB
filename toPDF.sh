#!/bin/bash

if [[ -v $1 ]]; then
	echo "Please provide file to convert.";
else
	FNAME="$1.m"
	ONAME="$1.odt"

	touch $ONAME
	echo "CODE:" >> $ONAME
	cat $FNAME >> $ONAME
	printf "\n\n\nOUTPUT:\n" >> $ONAME
	octave $FNAME >> $ONAME
	libreoffice --convert-to pdf $ONAME
fi
