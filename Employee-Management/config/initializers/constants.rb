# FIXME_KD: why have we defined MONTH, we have already Date::MONTHNAMES constant defined in rails.
# Comment:- Removed from code as of no use

# FIXME_KD: Always extract out these configuration settings into yml files and then Load contants from the file
# Fixed in oauth.yml

# FIXME_KD: always add these kind of formats in yml files, and then merge into the constants \
# e.g. Date::DATE_FORMATS.merge(I18n.t('date.formats'))
# Comment:- Need to discuss
Date::DATE_FORMATS[:normal_format] = "%d/%m/%Y"
Date::DATE_FORMATS[:string_format] = "%d %b %Y"
Date::DATE_FORMATS[:string_month] = '%B'

EMAIL_VALIDATOR_REGEX = /\A\w+([\.\-]?\w+)*@\w+([\.\-]?\w+)*(\.\w{2,3})+\Z/