# Create your views here.
from django.shortcuts import render_to_response
from models import Media
import sys
from django.core.files.base import ContentFile


def upload(request):
	if request.method == 'POST':
		print >> sys.stderr, dir(request.FILES['file'])
		media = Media.objects.create()
		media.content.save(request.FILES['file'].name, request.FILES['file'])
		for f in request.FILES:
			print >> sys.stderr, request.FILES[f].name
		#print >> sys.stderr, request.FILES.keys()
		return render_to_response('upload.html',{'files':request.FILES})
	else:
		return render_to_response('upload.html',{})
