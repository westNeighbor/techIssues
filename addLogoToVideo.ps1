# usage ./addLogoToVideo.ps1 inputVideo outVideoName
if ( 1 -eq 0 ){
    $lineNo=939
    $name=((Get-Content -Path D:/sqlite/db/girlFigures.csv -TotalCount $lineNo)[-1] -Split " ")[0] 
    $outName=(Split-Path -Path $args[0] -LeafBase)
    if ($args.count -eq 1){
        #ffmpeg.exe -i $args[0] -vf "drawtext=text='落选村花 $name':x=if(eq(mod(t\,1)\,0)\,rand(0\,(w-text_w))\,x):y=if(eq(mod(t\,3)\,0)\,rand(0\,(h-text_h))\,y):fontfile='C:/Users/mhzhao/AppData/Local/Microsoft/Windows/Fonts/Aa美人篆.ttf':fontsize=82:fontcolor=white@0.15:shadowcolor=red@0.05:shadowx=5:shadowy=5" ./watermark/${outName}_watermark.mp4 
    }
    elseif ($args.count -eq 2){
        ffmpeg.exe -i $args[0] -vf "drawtext=text='落选村花 $name':x=if(eq(mod(t\,1)\,0)\,rand(0\,(w-text_w))\,x):y=if(eq(mod(t\,3)\,0)\,rand(0\,(h-text_h))\,y):fontfile='C:/Users/mhzhao/AppData/Local/Microsoft/Windows/Fonts/Aa美人篆.ttf':fontsize=82:fontcolor=white@0.15:shadowcolor=red@0.05:shadowx=5:shadowy=5" $args[1]
    }
}
if ( 1 -eq 1 ){
    $lineNo=939
    $name=((Get-Content -Path D:/sqlite/db/girlFigures.csv -TotalCount $lineNo)[-1] -Split " ")[0] 
    foreach ($video in Get-ChildItem "./*.mp4"){
        $outName=(Split-Path -Path $video -LeafBase)
        # text size for 1280x1920
        if ( 1 -eq 1 ){
            ffmpeg.exe -i $video -vf "drawtext=text='落选村花 $name':x=if(eq(mod(t\,1)\,0)\,rand(0\,(w-text_w))\,x):y=if(eq(mod(t\,3)\,0)\,rand(0\,(h-text_h))\,y):fontfile='C:/Users/mhzhao/AppData/Local/Microsoft/Windows/Fonts/Aa美人篆.ttf':fontsize=82:fontcolor=white@0.15:shadowcolor=red@0.05:shadowx=5:shadowy=5" ./watermark/${outName}_watermark.mp4 
        }else{
        # text size for 1024x521
            ffmpeg.exe -i $video -vf "select=eq(n\,10)" -vframes 1 ${outName}_cover.png
            magick.exe ${outName}_cover.png -crop 25%x100% ${outName}_cover_cut.png
            magick.exe montage ${outName}_cover_cut-1.png ${outName}_cover_cut-2.png ${outName}_cover_cut-3.png ${outName}_cover_cut-0.png -tile 4x1 -geometry +0+0 ${outName}_cover_new.png
            ffmpeg.exe -i $video -i ${outName}_cover_new.png -filter_complex "[1]setpts=0.01/TB[im];[0][im]overlay=eof_action=pass" -c:v libx264 -crf 18 -c:a aac -strict -2 new_cover.mp4 
            ffmpeg.exe -i new_cover.mp4 -vf "drawtext=text='落选村花 $name':x=if(eq(mod(t\,3)\,0)\,rand(0\,(w-text_w))\,x):y=if(eq(mod(t\,1)\,0)\,rand(0\,(h-text_h))\,y):fontfile='C:/Users/mhzhao/AppData/Local/Microsoft/Windows/Fonts/Aa美人篆.ttf':fontsize=32:fontcolor=white@0.15:shadowcolor=red@0.05:shadowx=5:shadowy=5" -c:v libx264 -crf 18 -c:a aac -strict -2 ./watermark/${outName}_watermark.mp4 
            rm ${outName}_*.png 
            rm new_cover.mp4
        }
    }
}
