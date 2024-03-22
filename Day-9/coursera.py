import re

def split_paragraph(paragraph):
    pattern = r'\s+|,\s*|!\s*'
    words = re.split(pattern, paragraph)
    words = [word.strip('.?') for word in words if word] 
    return words


words = input('Please enter your text here: ')
words = split_paragraph(words)

count={}
for i in words:
    count[i] = count.get(i, 0) + 1

print(count)