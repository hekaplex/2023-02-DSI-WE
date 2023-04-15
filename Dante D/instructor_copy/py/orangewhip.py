setup = '''
INSTALLATION INSTRUCTIONS
===================================
tested with Python 3.8-3.11 (available at http://python.org/downloads)

1. Run from the command line the following command (no tab necessary):

        pip install english_words

    There are dependencies on copy and collections libraries but in my test of Python 3.11.1 they were already bundled
    Worst case you may need to run these commands:

        pip install copy
        pip install collections

2. Navigate to the directory where you save the orangewhip.py file or drag the path into the command line to 

3. Once in the same folder as the Python file, run this command (no tab necessary):

    python orangewhip.py

Usage:
    This code has only been sucessfully tested when you have three green/oraneg letters in a Wordle guess

    1. The "guess" should include a * character for each unknown letter
    
        Example:
            guess:f*o*k

    2. The "duds" refer to the unique letters attempted that did not come up yellow/blue or green/orange
            duds:abdefgh
    
    3. The output will be a list of words from the english_words dictionary that match the inputs
            ['frock', 'flock'] is an example of two words matching the criteria
            [] indicates no words found
'''
# logic
def orange_whip(guess, dudlist):    
    import copy
    import collections
    from english_words import english_words_lower_alpha_set
    #figure out which letters to test
    alpha = {a for a in "abcdefghijklmnopqrstuvwxyz"}
    duds = {a for a in dudlist}
    choices = "".join(list(alpha - duds))
    numch = len(list(choices))
    wordslop = []
    #figure out how many substitutions of "*"
    repl = collections.Counter(guess)['*']
    #generate guess letter combinations
    for blank in range(0,repl):
        for ltr1 in choices:
            if blank == 0:
                wordslop.append(guess.replace("*",ltr1,1))
            else:
                newslop = [w.replace("*",ltr1,1) if "*" in w  else w for w in wordslop]
                wordslop += newslop  
        #check guess against known works        
        wordset = list(set(wordslop) & english_words_lower_alpha_set)
    return wordset
#main loop    
g = input("guess:")
d = input("duds:")   
print(orange_whip(g, d))