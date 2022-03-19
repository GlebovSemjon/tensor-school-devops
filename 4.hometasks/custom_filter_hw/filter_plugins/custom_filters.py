#!/usr/bin/python

import re
from ansible.errors import (
    AnsibleFilterTypeError
)

def conversion_mac(input_mac):
    '''
        conversion mac addr
    '''
    reg = r'^[A-Fa-f0-9]+$'
    input_str = str(input_mac).upper()
    if not len(input_str) == 12:
        raise AnsibleFilterTypeError("Sline length is too long, "
                                     "string contains %s characters" % len(input_str))
    if not re.match(reg, input_str):
        raise AnsibleFilterTypeError("string contains invalid characters")

    return (f"{input_str[0:2]}:{input_str[2:4]}:{input_str[4:6]}:{input_str[6:8]}:{input_str[8:10]}:{input_str[10:12]}")

class FilterModule(object):
    def filters(self):
        return {
            'conversion_mac': conversion_mac
        }
