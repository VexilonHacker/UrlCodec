#!/bin/bash 


output_file=""
tasks=()
mode="encode"
color_red=""
color_green=""
color_yellow=""
color_reset=""

if [[ -t 1 ]]; then
    color_red="\033[31m"
    color_green="\033[32m"
    color_yellow="\033[33m"
    color_reset="\033[0m"
fi

    case "$1" in
        -o|--output)
            output_file="$2"
            shift 2
            ;;
        -d|--decode)
            mode="decode"
            shift
            ;;
        -e|--encode)
            mode="encode"
            shift
            ;;
        -h|--help)
            echo -e "${color_yellow}Usage:${color_reset} url_encode.sh [options] [--decode] <url> [--decode <url>]..."
            echo -e "\n${color_yellow}Options:${color_reset}"
            echo -e "  ${color_green}-o, --output <file>${color_reset}   Append results (with color codes) to <file>"
            echo -e "  ${color_green}-d, --decode${color_reset}          Decode the next URL instead of encoding"
            echo -e "  ${color_green}-e, --encode${color_reset}          Encode the URL (default behavior)"
            echo -e "  ${color_green}-h, --help${color_reset}            Show this help message"
            echo -e "\n${color_yellow}Examples:${color_reset}"
            echo -e "  url_encode.sh ${color_green}-e${color_reset} ${color_red}\"http://example.com/path/to/file\"${color_reset}"
            echo -e "  url_encode.sh ${color_green}-e${color_reset} ${color_red}\"http://example.com/abc?param1=1&param2=2\"${color_reset}"
            echo -e "  url_encode.sh ${color_green}-d${color_reset} ${color_red}\"http%3A%2F%2Fexample%2Ecom%2Fabc%3Fparam1%3D1%26param2%3D2\"${color_reset}"
            echo -e "  url_encode.sh ${color_green}-e${color_reset} ${color_red}\"http://example.com/file\" ${color_green}-o${color_reset} ${color_red}encoded.txt${color_reset}"
            exit 0
            ;;
        --)
            shift
            break
            ;;
        -*)
            echo -e "${color_red}Error:${color_reset} Unknown option '$1'"
            exit 1
            ;;
        *)
            tasks+=("${mode}:::${1}")
            mode="encode"
            shift
            ;;
    esac
done

    echo -e "${color_red}Error:${color_reset} No URLs provided."
    exit 1
fi

for entry in "${tasks[@]}"; do
    this_mode="${entry%%:::*}"
    processed=""
    label=""

    if [[ "$this_mode" == "encode" ]]; then
        processed=$(perl -MURI::Escape -e 'print uri_escape($ARGV[0], q{^A-Za-z0-9})' "$url")
        label="Encoded"
    else
        processed=$(perl -MURI::Escape -e 'print uri_unescape($ARGV[0])' "$url")
        label="Decoded"
    fi

    echo -e "${color_red}Original:${color_reset} $url"
    echo -e "${color_green}${label}:${color_reset}  $processed"
    echo

    if [[ -n "$output_file" ]]; then
        {
            echo -e "${color_red}Original:${color_reset} $url"
            echo -e "${color_green}${label}:${color_reset}  $processed"
            echo
        } >> "$output_file"
    fi
done

