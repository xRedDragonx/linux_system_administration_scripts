#!/usr/bin/env bash
# Важно! Для работы скрипта необходимо установить и настроить ssmtp и mpack
# путь к директории со скриншотами
dirpath=/home/$USER/screenshots
# проверяем наличие директории (если нет, то создаем). Делаем скриншот с названием по маске: ДД-ММ-ГГ_ЧЧ:ММ:СС.jpg
if [[ -d $dirpath ]]; then
        scrot '%d-%m-%Y_%H-%M-%S.jpg' -e "mv \$f $dirpath"
        screenshot=$(find "$dirpath" -name "*.jpg")
else
        mkdir -p "$dirpath"
        scrot '%d-%m-%Y_%H-%M-%S.jpg' -e "mv \$f $dirpath"
        screenshot=$(find "$dirpath" -name "*.jpg")
fi
# отправляем письмо на почту
echo "Скриншот с сервера: $HOSTNAME" > $dirpath/message_body.txt
mpack -s "Скриншот" -d $dirpath/message_body.txt $screenshot dark_strannik@mail.ru
# удаляем скриншот
rm -f $screenshot

