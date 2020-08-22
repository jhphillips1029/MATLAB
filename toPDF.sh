#!/bin/bash

if [[ -v $1 ]]; then
	echo "Please provide file to convert.";
else
	FNAME="$1.m"
	ONAME="$1.odt"
	PDFNAME="$1.pdf"

	touch $ONAME
	echo "CODE:" >> $ONAME
	cat $FNAME >> $ONAME
	printf "\n\n\nOUTPUT:\n" >> $ONAME
	octave $FNAME >> $ONAME
	libreoffice --convert-to pdf $ONAME
	convert -density 200 $PDFNAME "images/$1-Img*.png" $PDFNAME
	
	mv $ONAME "Turn In/"
	mv $PDFNAME "Turn In/"
fi
