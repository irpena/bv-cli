#!/bin/bash

function getVersion(){
    echo bv-cli v.0.0.2
    exit
}

B=`tput bold` 
X=`tput sgr0`
C='tput setaf ' 
i=2
er=1
c=`$C$i`
e=`$C$er`

function createRepositoryGit(){
	    echo -e $c${B}"------VALIDANDO GIT ${URLGIT}-adapter--------"$X"\n"

	if [ -n "$URLGIT" ];
	then
	    echo -e $c${B}"------CREANDO GIT--------"$X"\n"
	
		echo "# ${NAMEPROJECT}-adapter" >> README.md
		git init
		git add .
		git commit -m "first commit"
		git remote add origin  ${URLGIT}
		git push -u origin master
   		echo -e $c${B}"------TERMINO PUBLICACION EN GIT--------"$X"\n"
	fi
}

function remplace(){
    LC_ALL=C find . -type f -exec sed -i '' "s/base/$NAMEPROJECT/g" {} +
    sed -i -- "s/portMicroService/$PORTPROJECT/g" ./src/main/resources/application.properties    
    rm -rf .git
    echo -e $c${B}"------TERMINO CONSTRUCCION--------"$X"\n"

}

function createManager(){

    echo -e $c${B}"------CREANDO EL PROYECTO MANAGER--------"$X"\n"

    git clone https://github.com/bancodebogota/bv-base-mngr
    mv bv-base-mngr ${NAMEPROJECT}-mngr 
    cd ${NAMEPROJECT}-mngr
    remplace
    createRepositoryGit
}

function createAdapter(){

    echo -e $c${B}"------CREANDO EL PROYECTO ADAPTER--------"$X"\n"

    git clone https://github.com/bancodebogota/bv-base-adapter
    mv bv-base-adapter ${NAMEPROJECT}-adapter
    cd ${NAMEPROJECT}-adapter
    remplace
    createRepositoryGit
}




POSITIONAL=()
while [[ $# -gt 0 ]]
do
key="$1"

case $key in
    -v|--version)
        getVersion
    ;;
    -n|--name)
    NAMEPROJECT="$2"
    shift # past argument
    shift # past value
    ;;
    -t|--type)
    TYPEPROJECT="$2"
    shift # past argument
    shift # past value
    ;;
     -p|--port)
    PORTPROJECT="$2"
    shift # past argument
    shift # past value
    ;;
    -g|--github)
    URLGIT="$2"
    shift # past argument
    shift # past value
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
    echo NAME PROJECT     = "${NAMEPROJECT}"
    echo PORT PROJECT    = "$PORTPROJECT"
    echo TYPE PROJECT    = "$TYPEPROJECT"
	echo URL GIT    = "$URLGIT"

createProject

if [ "$TYPEPROJECT" = "manager" ]
then
    createManager
elif [ "$TYPEPROJECT" = "adapter" ]
then
    createAdapter
else
    echo -e $e"------Error Type--------"$X"\n"
fi

