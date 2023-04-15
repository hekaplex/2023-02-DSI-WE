from bs4 import BeautifulSoup
import requests

class Souper():
    
    def __init__(
        self
        , url
        , bsParser='html.parser'
        , header = { 'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:55.0) Gecko/20100101 Firefox/55.0',
        }
        ):
        self.url = url
        self.bsParser = bsParser
        self.header = header
    
    def scoop(self):  
        def status_check(r):
            rtn = str()
            if r.status_code==200:
                rtn = "Success!"
            else:
                rtn = "Failed!"
            return rtn
        def encoding_check(r):
            return (r.encoding)
        def decode_content(r,encoding):
            return (r.content.decode(encoding)) 
        response = requests.get(self.url, headers = self.header)
        enc = encoding_check(response)
        contents = decode_content(response,enc)        
        stat = status_check(response)
        #print(response)
        try:
            print("Scooping {0} with encoding: {1}:{2}".format(
                self.url
                ,enc
                ,stat
                ))
            
            soup = BeautifulSoup(contents,self.bsParser)
        except Exception as err:
            print(err.with_traceback())
        return soup
    