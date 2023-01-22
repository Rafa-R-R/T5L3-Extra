#!/bin/bash
#ALUMNO: Rafa Rodríguez Real

arabic=( 1000 500 100 50 10 5 1 );
roman=( "M" "D" "C" "L" "X" "V" "I" );

read -p "Indique un número entero positivo, o un número romano a convertir (entre 1 y 1999): " numero;

cadena="$numero";


arabicRegExp='^[0-1]?[0-9]{0,3}$';
romanRegExp='^M{0,1}(CM|CD|D?C{0,3})(XC|XL|L?X{0,3})(IX|IV|V?I{0,3})$';

if [[ $cadena =~ $arabicRegExp ]] #Si hace match, se pasa a romano
then
    echo "$cadena es un: Número arábigo";

    resultado="";

    cociente=$((numero/1000)); #Unidades de millar
    resto=$((numero%1000)); #El resto son centenas


    if [ $cociente -gt 0 ]
        then 
        resultado+="M";
    fi

    cociente=$((resto / 100)); #Centenas
    resto=$((resto % 100)); #El resto son decenas

    if [ $cociente -gt 0 ]
        then

            if [ $cociente -lt 4 ]
                then
                    for (( c=1; c<=$cociente ; c++))
                    do
                        resultado+="C";
                    done
            fi

            if [ $cociente -eq 4 ]
                then
                    resultado+="CD";
            fi

            if [ $cociente -eq 5 ]
                then 
                    resultado+="D";
            fi

            if [ $cociente -ge 6 ] && [ $cociente -lt 9 ]
                then
                    resultado+="D"

                    for (( c=6; c<=$cociente ; c++))
                    do
                        resultado+="C";
                    done
            fi

            if [ $cociente -eq 9 ]
                then
                    resultado+="CM";
            fi

    fi

    cociente=$((resto / 10)); #Decenas
    resto=$((resto % 10)); #El resto son unidades

    if [ $cociente -gt 0 ]
        then

            if [ $cociente -lt 4 ]
                then
                    for (( c=1; c<=$cociente ; c++))
                    do
                        resultado+="X";
                    done
            fi

            if [ $cociente -eq 4 ]
                then
                    resultado+="XL";
            fi

            if [ $cociente -eq 5 ]
                then 
                    resultado+="L";
            fi

            if [ $cociente -ge 6 ] && [ $cociente -lt 9 ]
                then
                    resultado+="L";

                    for (( c=6; c<=$cociente ; c++))
                    do
                        resultado+="X";
                    done
            fi

            if [ $cociente -eq 9 ]
                then
                    resultado+="XC";
            fi

    fi


    if [ $resto -gt 0 ]
        then

            echo "ENTRA GT 0"

            if [ $resto -lt 4 ]
                then
                    for (( c=1; c<=$resto; c++))
                    do
                        resultado+="I";
                    done
            fi

            if [ $resto -eq 4 ]
                then
                    resultado+="IV";
            fi

            if [ $resto -eq 5 ]
                then 
                    resultado+="V";
            fi

            if [ $resto -ge 6 ] && [ $resto -lt 9 ]
                then
                    resultado+="V";

                    for (( c=6; c<=$resto; c++))
                    do
                        echo "entra I"
                        resultado+="I";
                    done
            fi

            if [ $resto -eq 9 ]
                then
                    resultado+="IX";
            fi

    fi

    echo "$numero en números romanos es $resultado";

fi

if [[ $cadena =~ $romanRegExp ]] #Si hace match, se pasa a arábigo
then
    echo "$cadena es un: Número romano";

    len=${#cadena};
    len_roman=${#roman[@]}; # len roman y len arabic son iguales
    copia_reverse="";
    result=0;
    previo=0;

        for (( i=$len; i>=0; i-- ))
        do
            copia_reverse="$copia_reverse${cadena:$i:1}" #le doy la vuelta a la cadena romana
        done

        for (( j=0; j<$len; j++)) #Para cada letra
        do
            #extraigo la letra i de la copia
            letra=${copia_reverse[@]:$j:1}

            pos=0;
            #busco la letra en el array de romanos, para obtener su índice en dicho array
            for ((k=0 ; k<$len_roman; k++))
            do

                if [ $letra == ${roman[k]} ]
                then
                    pos=$k;
                fi
            done

            #saco su valor del array de arabigos
            valor=${arabic[pos]}

            if [ $valor -ge $previo ] # si el valor es mayor o igual al previamente obtenido
            then
                result=$(( result + valor )); #sumo el valor al resultado final
                
            else
                #si no, lo resto ->   
                #ej IX -> reverse(IX) = XI 
                # valor X = 10 -> se suma
                # valor I es > que valor de X, por lo que se resta el valor de I al total.
                result=$(( result - valor ));

            fi

        done

    echo "$numero en números arábigos es $result";

fi

if  ! [[ $cadena =~ $romanRegExp ]] && ! [[ $cadena =~ $arabicRegExp ]]
then
    echo "$numero no es un valor aceptado para convertir.";
fi
