function static_cam
    set pic_path $argv[1]

    if test -z "$pic_path"
        echo "Usage: static_cam <path_to_image>"
        return 1
    end

    if not test -f "$pic_path"
        echo "Error: File '$pic_path' not found."
        return 1
    end

    ffmpeg -re -loop 1 -i "$pic_path" -f v4l2 -vcodec rawvideo -pix_fmt yuv420p /dev/video10
end

