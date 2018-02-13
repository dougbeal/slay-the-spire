#!/bin/bash
this=$( cd $(dirname ${BASH_SOURCE[0]}); pwd -P )

POSITIONAL=()
while [[ $# -gt 0 ]]; do
    key="$1"

    case $key in
        -i|--input)
            input_file_name="$2"
            shift # past argument
            shift # past value
            ;;
        -o|--output)
            output_file_name="$2"
            shift # past argument
            shift # past value
            ;;
        -e|--encode)
            encode_mode=true
            shift # past argument
            #shift # past value
            ;;
        --default)
            DEFAULT=YES
            shift # past argument
            ;;
        *)    # unknown option
            POSITIONAL+=("$1") # save it in an array for later
            shift # past argument
            ;;
    esac
done
set -- "${POSITIONAL[@]}" # restore positional parameters

input_file_name=${input_file_name:-"/dev/stdin"}
output_file_name=${output_file_name:-"/dev/stdout"}
(
    if [ "$encode_mode" = true ]; then
        echo "Will encode $input_file_name [json] to $output_file_name [xor+base64]." 
    else
        echo "Will decode $input_file_name [base64+xor] to $output_file_name [json]." 
    fi
    
    #echo input  = "${input_file_name}"
    #echo output = "${output_file_name}"
    #echo DEFAULT         = "${DEFAULT}"
) > /dev/stderr

if [ "$encode_mode" = true ]; then
    python3 "$this/encode.py" < "$input_file_name" > "$output_file_name"
else
    python3 "$this/decode.py" < "$input_file_name" > "$output_file_name"
fi




