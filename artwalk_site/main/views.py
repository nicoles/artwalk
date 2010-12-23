# Create your views here.
from django.shortcuts import render_to_response
from models import Media, ArtPiece
import sys
from django.core.files.base import ContentFile


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
			piece.lat = request.POST['latitude']
			piece.lon = request.POST['longitude']
			
		if 'title' in request.POST:
			piece.title = request.POST['title']

		piece.save()

		print >> sys.stderr, piece

		return render_to_response('upload.html',{'files':request.FILES})
	else:
		return render_to_response('upload.html',{})
