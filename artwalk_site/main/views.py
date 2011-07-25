from django.http import (
    HttpResponse,
    HttpResponseNotFound,
    HttpResponsePermanentRedirect,
)
from django.shortcuts import render_to_response, get_object_or_404
from django.core.files.base import ContentFile

import Image

import settings

from models import Media, Artist, ArtPiece
import json
import cStringIO
import sys


def upload(request):
	media = []
	if request.method == 'POST':
		for f in request.FILES:
			medium = Media.objects.create()
			medium.content.save(request.FILES[f].name, request.FILES[f])
			media.append(medium)

		piece = ArtPiece.objects.create()
		if media:
			piece.media = media

		if 'latitude' in request.POST and 'longitude' in request.POST:
			piece.latitude = request.POST['latitude']
			piece.longitude = request.POST['longitude']
			
		if 'title' in request.POST:
			piece.title = request.POST['title']
		
		if 'artist' in request.POST:
			artist = Artist.objects.create()
			artist.name = request.POST['artist']
			artist.save()		
			piece.artists.add(artist)	

		piece.save()

		return render_to_response('upload.html',{'files':request.FILES})
	else:
		return render_to_response('upload.html',{})

def update_art_piece(request, id):
	art_piece = get_object_or_404(ArtPiece, pk=int(id))
	media = []
	if request.method == 'POST':
		for f in request.FILES:
			medium = Media.objects.create()
			medium.content.save(request.FILES[f].name, request.FILES[f])
			media.append(medium)

		for medium in media:
			art_piece.media.add(medium) 

		for attr in ['title', 'latitude']:
			if not getattr(art_piece, attr, None) and attr in request.POST:
				setattr(art_piece, attr, request.POST[attr])
				
				if attr == 'latitude':
					art_piece.setattr(art_piece, 'longitude', request.POST['longitude'])
				
		if 'artist' in request.POST:
			artists = Artist.objects.filter(name=request.POST['artist'])
			if artists:
				for artist in artists:
					art_piece.artists.add(artist)
			else:
				art_piece.artists.create(name=request.POST['artist'])

		art_piece.save()
		
		return render_to_response('upload.html',{})
	else:
		return render_to_response('upload.html',{})
		
def recent(request):
	art_pieces = ArtPiece.objects.order_by('-mtime', '-id')[:10]

	if request.GET.get('mode') == 'json':
		response = []
		for art_piece in art_pieces:
			media = [
				{
					'full': medium.content.url,
					'thumb': settings.WWW_URL + 'resize/%s/thumb/' % medium.id
				}
				for medium in art_piece.media.all()
			]
			artists = [ { 'name': artist.name } for artist in art_piece.artists.all() ]
			response.append( {
				'id': art_piece.id,
				'title': art_piece.title,
				'latitude': art_piece.latitude,
				'longitude': art_piece.longitude,
				'media': media,
				'artists': artists
			})

		return HttpResponse(json.dumps(response, sort_keys=True, indent=4), mimetype='application/json')
	else:
		return render_to_response('recent.html', {'art_pieces': art_pieces})

def art_piece(request, id):
	art_piece = get_object_or_404(ArtPiece, pk=int(id))
	if request.GET.get('mode') == 'json':
		media = [
			{
				'url': medium.content.url,
				'thumb': settings.WWW_URL + 'resize/%s/thumb/' % medium.id
			}
			for medium in art_piece.media.all()
		]
		artists = [ { 'name': artist.name } for artist in art_piece.artists.all() ]
		response = {
			'id': art_piece.id,
			'title': art_piece.title,
			'latitude': art_piece.latitude,
			'longitude': art_piece.longitude,
			'media': media,
			'artists': artists
		}
		return HttpResponse(json.dumps(response, sort_keys=True, indent=4), mimetype='application/json')
	else:
		return render_to_response('art_piece.html', {'art_piece': art_piece})
		
def resize(request, medium_id, size):
	sizes = {
		'full': None
		'thumb': (100, 60)
	}
	
	if size not in sizes:
		return HttpResponseNotFound

	medium = get_object_or_404(Media, pk=int(medium_id))
	
	if size == 'full':
		return HttpResponsePermanentRedirect(medium.content.url)
	else:
		output = cStringIO.StringIO()
		im = Image.open(medium.content.open())
	    im.thumbnail(sizes[size])
		im.save(output)
		return HttpResponse(output.getvalue(), mimetype='image/jpeg')
		
	
