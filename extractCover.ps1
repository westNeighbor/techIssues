# usage ./extractFrame.ps1 inputVideo wanttedFrame outImage
if ($args.count -eq 2){
    $outName=(Split-Path -Path $args[0] -LeafBase)
    ffmpeg.exe -i $args[0] -vf "select=eq(n\,$($args[1]))" -vframes 1 "${outName}_cover$($args[1]).png"
}
elseif ($args.count -eq 3){
    ffmpeg.exe -i $args[0] -vf "select=eq(n\,$($args[1]))" -vframes 1 "$($args[2])"
}
