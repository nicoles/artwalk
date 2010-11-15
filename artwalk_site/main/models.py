from django.db import models

class User(models.Model):
	email = models.EmailField(unique=True)
	artpieces = models.ManyToManyField('ArtPiece')
	
class Tags(models.Model):
	tag = models.CharField(max_length=128)	
	
class Artist(models.Model):
	name = models.CharField(max_length=256)
	tags = models.ManyToManyField(Tags)
	
class Media(models.Model):
	url = models.CharField(max_length=256)
	
class ArtPiece(models.Model):
	title = models.CharField(max_length=256)
	note = models.TextField()
	lat = models.FloatField()
	lon = models.FloatField()
	artists = models.ManyToManyField(Artist)
	tags = models.ManyToManyField(Tags)
	media = models.ManyToManyField(Media)