#!/usr/bin/python
# -*- coding: utf-8 -*-


from ansible.module_utils.basic import AnsibleModule

DOCUMENTATION = r'''
---
module: healthcheck
author: Pupkin V.
short_description: healthcheck of site
description:
  - healthcheck of site with or without TLS
version_added: 1.0.0
requirements:
  - requests
  - python >= 3.6
options:
  addr:
    description:
      - Address of site we want to check
      - This is a required parameter
    type: str
  tls:
    description:
      - Whether site using certificates or not
      - Default value is 'True'
    type: bool
'''

EXAMPLES = r'''
- name: Check availability of site
  healthcheck:
    addr: mysite.example
  connection: local

- name: Check availability of site without certs
  healthcheck:
    addr: mysite.example
    tls: false
  connection: local
'''

RETURN = r'''
msg:
  description: Errors if occured
  returned: always
  type: str
  sample: ""
site_status:
  description: State status
  returned: always
  type: str
  sample: Available
rc:
  description: Return code
  returned: always
  type: int
  sample: 200
'''
import requests

def status_code(addr, tls):
  if tls == True:
    url = 'https://'+str(addr)
  else:
    url = 'http://'+str(addr)

  failed = True
  site_status = ''
  msg = ''
  rc = 1
  try:
    response = requests.get(url, verify=False, allow_redirects=False, timeout=5)
    response.raise_for_status()
    site_status = " >> HTTP Ok, status code: " + str(response.status_code)
    failed = False
    msg = "HTTP Ok, status code: " + str(response.status_code)
    rc = response.status_code
  except requests.exceptions.HTTPError as err:
    site_status = " >> HTTP Error code: " + '. Response is: {content}'.format(content=err.response.content)
    msg = "HTTP Error code: "+ str(response.status_code)
    rc = response.status_code
  except requests.exceptions.ConnectionError:
    msg = 'Seems like dns lookup failed..'
  except requests.exceptions.ConnectTimeout:
    msg = 'Oops. Connection timeout occured!'
  except requests.exceptions.ReadTimeout:
    msg = 'Oops. Read timeout occured'
  return(failed, site_status, rc, msg)
    
def main():
    # Аргументы для модуля
    arguments = dict(
        addr=dict(required=True, type='str'),
        tls=dict(type='bool', default="True")
    )
    # Создаем объект - модуль
    module = AnsibleModule(
        argument_spec=arguments,
        supports_check_mode=False
    )
    # Получаем аргументы
    addr = module.params["addr"]
    tls = module.params["tls"]

    lc_return = status_code(addr, tls)
    # Если задача зафейлилась
    if lc_return[0]:
        module.fail_json(changed=False,
                         failed=lc_return[0],
                         result_str=lc_return[1],
                         rc=lc_return[2],
                         msg=lc_return[3])
    # Если задача успешно завершилась
    else:
        module.exit_json(changed=False,
                         failed=lc_return[0],
                         result_str=lc_return[1],
                         rc=lc_return[2],
                         msg=lc_return[3])

if __name__ == "__main__":
    main()
