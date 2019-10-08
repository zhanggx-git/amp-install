#$1 input the Project Name
AMP_PROJECT_NAME=xxx

#set env of the all dc in the project
set_timezone(){
	AMP_DCS=`oc get dc -n $AMP_PROJECT_NAME | grep -v NAME | awk '{print $1}'`

	for item in $AMP_DCS; 
	do 
		echo "##setenv-timezone dc/${item}"
		oc set env dc/${item} -n $AMP_PROJECT_NAME TZ=Asia/Shanghai
	done 
}


if [ -n "$1" ]; then
    AMP_PROJECT_NAME=$1
    set_timezone
else
    echo "##Error:Please input the Project Name!"
fi

