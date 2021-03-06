from django.db import models

class User(models.Model):
	email = models.EmailField(unique=True)
	artpieces = models.ManyToManyField('ArtPiece')
	ctime = models.DateTimeField(auto_now_add=True, db_index=True)
	mtime = models.DateTimeField(auto_now=True, db_index=True)
	
	def __unicode__(self):
		return '%s' % self.email
	
class Tags(models.Model):
	tag = models.CharField(max_length=128)	
	ctime = models.DateTimeField(auto_now_add=True, db_index=True)
	mtime = models.DateTimeField(auto_now=True, db_index=True)
	
	def __unicode__(self):
		return '%s' % self.tag
	
class Artist(models.Model):
	name = models.CharField(max_length=256)
	tags = models.ManyToManyField(Tags)
	ctime = models.DateTimeField(auto_now_add=True, db_index=True)
	mtime = models.DateTimeField(auto_now=True, db_index=True)
	
	def __unicode__(self):
		return '%s' % self.name
	
class Media(models.Model):
	content = models.FileField(upload_to='%Y/%m/%d/%H')
	ctime = models.DateTimeField(auto_now_add=True, db_index=True)
	mtime = models.DateTimeField(auto_now=True, db_index=True)
	
	def __unicode__(self):
		return '%s' % self.content

class ArtPiece(models.Model):
	title = models.CharField(max_length=256)
	note = models.TextField(null=True)
	latitude = models.FloatField(null=True)
	longitude = models.FloatField(null=True)
	artists = models.ManyToManyField(Artist)
	tags = models.ManyToManyField(Tags)
	media = models.ManyToManyField(Media)
	ctime = models.DateTimeField(auto_now_add=True, db_index=True)
	mtime = models.DateTimeField(auto_now=True, db_index=True)
	
	def __unicode__(self):
		return '%s at %s,%s' % (self.title, self.latitude, self.longitude)
