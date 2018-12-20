FROM mattrayner/lamp:latest-1604-php5
MAINTAINER ESSch <ESSchtolts@yandex.ru>

RUN cd /app/ && ( \
  wget https://www.1c-bitrix.ru/download/small_business_encode.tar.gz \
  && tar -xf small_business_encode.tar.gz \
  && sed -i '5i   php_value short_open_tag 1' .htaccess \
  && chmod -R 0777 . \
  && sed -i 's/#php_value display_errors 1/php_value display_errors 1/' .htaccess \
  && sed -i '5i php_value opcache.revalidate_freq 0' .htaccess \
  && sed -i 's/#php_flag default_charset UTF-8/php_flag default_charset UTF-8/' .htaccess \
) && cd ..;

EXPOSE 80 3306
CMD ["/run.sh"] 
