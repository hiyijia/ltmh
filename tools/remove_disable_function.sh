 #!/bin/bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

# Check if user is root
if [ $(id -u) != "0" ]; then
    echo "Error: You must be root to run this script, please use root to install ltmp"
    exit 1
fi

clear
printf "=======================================================================\n"
printf "Remove php disable functions for LTMP V0.1  ,  Written by Andy \n"
printf "=======================================================================\n"
printf "LTMP is a tool to auto-compile & install Tengine+MySQL+PHP on Linux \n"
printf "This script is a tool to remove php disable functions for ltmp \n"
printf "\n"
printf "more information please visit http://www.hhvm.biz \n"
printf "=======================================================================\n"
cur_dir=$(pwd)
        
	ver=""
	echo "Remove all php disable function please type: 1"
	echo "Only remove scandir function please type: 2"
	echo "Only remove exec function please type: 3"
	read -p "Please input 1 2 or 3:" ver
	if [ "$ver" = "" ]; then
		ver="1"
	fi

	if [ "$ver" = "1" ]; then
		echo "You will remove all php disable functions."
	elif [ "$ver" = "2" ]; then 
		echo "You will remove scandir php disable function."
	elif [ "$ver" = "3" ]; then
		echo "You will remove exec php disable_function."
	fi

	get_char()
	{
	SAVEDSTTY=`stty -g`
	stty -echo
	stty cbreak
	dd if=/dev/tty bs=1 count=1 2> /dev/null
	stty -raw
	stty echo
	stty $SAVEDSTTY
	}
	echo ""
	echo "Press any key to start...or Press Ctrl+c to cancel"
	char=`get_char`


function remove_all_disable_function()
{
	sed -i 's/disable_functions =.*/disable_functions =/g' /usr/local/php/etc/php.ini
}

function remove_scandir_function() 
{
	sed -i 's/,scandir//g' /usr/local/php/etc/php.ini
}

function remove_exec_function()
{
	sed -i 's/,exec//g' /usr/local/php/etc/php.ini
}

if [ "$ver" = "1" ]; then
	remove_all_disable_function
elif [ "$ver" = "2" ]; then 
	remove_scandir_function
elif [ "$ver" = "3" ]; then
	remove_exec_function
fi

if [ -s /etc/init.d/httpd ] && [ -s /usr/local/apache ]; then
echo "Restarting Apache......"
/etc/init.d/httpd -k restart
else
echo "Restarting php-fpm......"
/etc/init.d/php-fpm restart
fi

printf "=======================================================================\n"
printf "Remove php disable funtion completed,enjoy it!\n"
printf "=======================================================================\n"
printf "Remove php disable functions for LTMP V0.1  ,  Written by Andy \n"
printf "=======================================================================\n"
printf "LTMP is a tool to auto-compile & install Tengine+MySQL+PHP on Linux \n"
printf "This script is a tool to remove php disable functions for LTMP \n"
printf "\n"
printf "For more information please visit http://www.hhvm.biz \n"
printf "=======================================================================\n"