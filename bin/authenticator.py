#!/usr/local/bin/python3

import logging

class LoggerWriter(object):
    def __init__(self, writer):
        self._writer = writer
        self._msg = ''

    def write(self, message):
        self._msg = self._msg + message
        while '\n' in self._msg:
            pos = self._msg.find('\n')
            self._writer(self._msg[:pos])
            self._msg = self._msg[pos+1:]

    def flush(self):
        if self._msg != '':
            self._writer(self._msg)
            self._msg = ''

import sys
logging.basicConfig(level=logging.INFO, filename='/tmp/trigger.log', filemode='w', format='%(name)s - %(levelname)s - %(message)s')
log = logging.getLogger('default')
sys.stdout = LoggerWriter(log.debug)
sys.stderr = LoggerWriter(log.warning)

log.info('STARTUP');

from pyppeteer import launch
import asyncio
import keyring

async def main():
    username = sys.argv[2]

    try:
        log.info('Getting password from keyring')
        password = keyring.get_password('aada', username)
    except Exception as e:
        log.info('Failed getting password from Keyring {}'.format(e))
        raise

    browser = await launch(headless=False,
                           args=['--incognito', '--no-sandbox', '--disable-setuid-sandbox','--disable-dev-shm-usage'])
    log.info('devicelogin page')
    page = await browser.newPage()
    await page.goto('https://microsoft.com/devicelogin',
                    waitUntil='networkidle0')
    await page.waitForSelector('input[name="otc"]:not(.moveOffScreen)')
    await page.focus('input[name="otc"]')
    await page.keyboard.type(sys.argv[1])
    await page.keyboard.press('Enter')
    await page.waitForSelector('input[name="loginfmt"]:not(.moveOffScreen)')
    await asyncio.sleep(0.5)
    await page.focus('input[name="loginfmt"]')
    log.info('username')
    await page.keyboard.type(username)
    await page.click('input[type=submit]')
    await page.waitForSelector('input[name="passwd"]:not(.moveOffScreen)')
    await page.focus('input[name="passwd"]')
    log.info('passwd')
    await asyncio.sleep(1.0)
    await page.keyboard.type(password)
    await page.click('input[type=submit]')
    log.info('submitted')
    await asyncio.sleep(1.0)
    await page.waitForSelector('#message')
    await browser.close()

asyncio.get_event_loop().run_until_complete(main())

