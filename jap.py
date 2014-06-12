#!/usr/bin/env python

import mimetypes

from bottle import Bottle, run
from bottle import request, response, get, post
from bottle import static_file, redirect, HTTPResponse
from bottle import mako_view as view
import sys
try:
    from pymongo import MongoClient
except ImportError:
    print "You must have 'pymongo' installed to run this app. (pip install pymongo)"
    sys.exit(1)

app = Bottle()

client = MongoClient()
flashcards = client.japanese.cards

PAGE_SIZE = 50

@app.get(['/', '/list', '/list/:page#\d+#'])
@view('form.mako')
def list(page=0):
    """ List flashcards. """
    page = int(page)
    prev_page = None
    next_page = None
    if page > 0:
        prev_page = page - 1
    if flashcards.count() > (page + 1) * PAGE_SIZE:
        next_page = page + 1
    cards = (flashcards.find().skip(page * PAGE_SIZE).limit(PAGE_SIZE))
    return { 'cards': cards,
             'prev_page': prev_page,
             'next_page': next_page }

@app.post('/create')
def create():
    """ Save new message. """
    if not (request.POST.get('category') and request.POST.get('chapter') and request.POST.get('english') and request.POST.get('kana') and request.POST.get('kanji') and request.POST.get('romanji')):
        redirect('/')
    flashcards.insert({
        'category': request.POST['category'],
        'chapter': int(request.POST['chapter']),
        'english': request.POST['english'],
        'kana': request.POST['kana'],
        'kanji': request.POST['kanji'],
        'romanji': request.POST['romanji']
    })
    redirect('/')

@app.get('/static/:filename#.+#')
def get_static_file(filename):
    """ Send static files from ./static folder. """
    return static_file(filename, root='./static')

run(app, host='localhost', port=8080, debug=True)

