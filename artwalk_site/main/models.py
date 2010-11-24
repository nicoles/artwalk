from django.db import models

class User(models.Model):
	email = models.EmailField(unique=True)
	artpieces = models.ManyToManyField('ArtPiece')
	
	def __unicode__(self):
		return '%s' % self.email
	
class Tags(models.Model):
	tag = models.CharField(max_length=128)	
	
	def __unicode__(self):
		return '%s' % self.tag
	
class Artist(models.Model):
	name = models.CharField(max_length=256)
	tags = models.ManyToManyField(Tags)
	
	def __unicode__(self):
		return '%s' % self.name
	
class Media(models.Model):
	content = models.FileField(upload_to='%Y/%m/%d/%H')
	
	def __unicode__(self):
		return '%s' % self.file
	
class ArtPiece(models.Model):
	title = models.CharField(max_length=256)
	note = models.TextField()
	lat = models.FloatField()
	lon = models.FloatField()
	artists = models.ManyToManyField(Artist)
	tags = models.ManyToManyField(Tags)
	media = models.ManyToManyField(Media)
	
	def __unicode__(self):
		return '%s' % self.title