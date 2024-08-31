#!/usr/bin/zsh
inputDir='./pictures'
if [ 1 -eq 1 ]
then
    echo "adding meta info ..."
    exiftool -all= -author=mhstar -contact="tttom.jjjack@gmail.com" -copyright="All reserved by mhstar" -comment="This picture is originally produced by mhstar, if you want to use or redistribute it, please contact the author through the email tttom.jjjack@gmail.com" $inputDir/*.jpg
    exiftool -json -tagsfromfile fakeInfo.json $inputDir/*.jpg
    yes | exiftool -delete_original $inputDir
    echo "adding meta info done"
fi

# convert to jpg
if [ 1 -eq 0 ]
then
    echo "converting png to jpg ..."
    for image in $inputDir/*.png;
    do
        newName="$(basename $image | awk -F - '{print $1}')"
        convert "$image" "$inputDir/IMG_${newName}.jpg"
        rm $image
    done
    echo "converting png to jpg done" 
fi

# rename 
if [ 1 -eq 1 ]
then
    echo "rename pictures ..."
    for image in $inputDir/*.jpg;
    do
        newName="$(basename $image | awk -F - '{print $1}')"
        if [[ $newName = IMG* ]]
        then
            continue
        else
            mv "$image" "$inputDir/IMG_${newName}.jpg"
        fi
    done
    echo "rename done" 
fi


# adding watermark to jpg
if [ 1 -eq 1 ]
then
    echo "adding watermark ..."
    lineNo=918
    name=$(sed -n "$lineNo p" ../sqlite/db/girlFigures.csv | awk '{print $1}')
    echo $name
    for image in $inputDir/$dirName/*.jpg;
    do
  	    outName="$(basename $image)"
        if [ ! -d $inputDir/watermark ]; then
            echo "mkdir $inputDir/watermark"
            mkdir $inputDir/watermark
        fi
        if [ ! -d $inputDir/watermark/$name ]; then
            echo "mkdir $inputDir/watermark/$name"
            mkdir $inputDir/watermark/$name
        fi
#        convert $image -gravity SouthEast -pointsize 80 -font "/mnt/c/Users/mhzhao/AppData/Local/Microsoft/Windows/Fonts/cnFont_汉仪篆书繁.ttf" -fill "rgba(255,255,255,0.2)" -annotate +200+80 "伶仃问道" -gravity NorthWest -pointsize 80 -font "/mnt/c/Users/mhzhao/AppData/Local/Microsoft/Windows/Fonts/cnFont_汉仪篆书繁.ttf" -fill "rgba(255,255,255,0.2)" -annotate +200+80 "伶仃问道" -gravity Center -pointsize 80 -font "/mnt/c/Users/mhzhao/AppData/Local/Microsoft/Windows/Fonts/cnFont_汉仪篆书繁.ttf" -fill "rgba(255,255,255,0.05)" -annotate 0 "伶仃问道" $inputDir/watermark/$outName 
        convert $image -gravity SouthEast -pointsize 80 -font "/mnt/c/Users/mhzhao/AppData/Local/Microsoft/Windows/Fonts/Aa美人篆.ttf" -fill "rgba(255,255,255,0.8)" -annotate +200+80 "落选村花 $name" -gravity NorthWest -pointsize 80 -font "/mnt/c/Users/mhzhao/AppData/Local/Microsoft/Windows/Fonts/Aa美人篆.ttf" -fill "rgba(255,255,255,0.8)" -annotate +200+80 "落选村花 $name" -gravity Center -pointsize 80 -font "/mnt/c/Users/mhzhao/AppData/Local/Microsoft/Windows/Fonts/cnFont_汉仪篆书繁.ttf" -fill "rgba(255,255,255,0.05)" -annotate +0+180 "落选村花 $name" $inputDir/watermark/$name/$outName 
#        convert $image -gravity SouthEast -pointsize 80 -font "/mnt/c/Users/mhzhao/AppData/Local/Microsoft/Windows/Fonts/FlowerLeafDemoRegular.ttf" -fill "rgba(5,255,5,0.7)" -annotate +200+80 "obo" -gravity NorthWest -pointsize 80 -font "/mnt/c/Users/mhzhao/AppData/Local/Microsoft/Windows/Fonts/FlowerLeafDemoRegular.ttf" -fill "rgba(255,255,255,0.7)" -annotate +200+80 "obo" -gravity Center -pointsize 80 -font "/mnt/c/Users/mhzhao/AppData/Local/Microsoft/Windows/Fonts/FlowerLeafDemoRegular.ttf" -fill "rgba(255,255,255,0.05)" -annotate 0 "obo" $inputDir/watermark/$outName 
    done
    echo "adding watermark done" 
fi
