from django.db import models
from django.contrib.auth.models import User
from django.conf import settings

# Create your models here.
class UserProfile(models.Model):  
    user = models.OneToOneField(User)
    reputationpoint = models.IntegerField(blank=True, null=True)

    class Meta:
        managed = True
        db_table = 'userprofile'
    
class Question(models.Model):
    queid = models.AutoField(primary_key=True)
    que_title = models.CharField(max_length=200, blank=True, null=True)
    que_desc = models.TextField(blank=True, null=True)
    que_tag = models.CharField(max_length=45, blank=True, null=True)
    createdon = models.DateTimeField(blank=True, null=True)
    updatedon = models.DateTimeField(blank=True, null=True)
    createdby = models.ForeignKey(settings.AUTH_USER_MODEL, models.DO_NOTHING, db_column='createdby', blank=True, null=True)

    class Meta:
        managed = True
        db_table = 'question'
        
class Answer(models.Model):
    ansid = models.AutoField(primary_key=True)
    ans_desc = models.TextField(blank=True, null=True)
    total_upvote = models.IntegerField(blank=True, null=True)
    total_downvote = models.IntegerField(blank=True, null=True)
    createdon = models.DateTimeField(blank=True, null=True)
    updatedon = models.DateTimeField(blank=True, null=True)
    createdby = models.ForeignKey(settings.AUTH_USER_MODEL,models.DO_NOTHING, db_column='createdby', blank=True, null=True)
    queid = models.ForeignKey('Question', models.DO_NOTHING, db_column='queid', blank=True, null=True)

    class Meta:
        managed = True
        db_table = 'answer'

class AcceptAnswer(models.Model):
    acceptedansid = models.AutoField(primary_key=True)
    queid = models.ForeignKey('Question', models.DO_NOTHING, db_column='queid', blank=True, null=True)
    ansid = models.ForeignKey('Answer', models.DO_NOTHING, db_column='ansid', blank=True, null=True)
    userid = models.ForeignKey(settings.AUTH_USER_MODEL,models.DO_NOTHING, db_column='userid', blank=True, null=True)

    class Meta:
        managed = True
        db_table = 'acceptedanswer'

class FavouriteAnswer(models.Model):
    favid = models.AutoField(primary_key=True)
    queid = models.ForeignKey('Question', models.DO_NOTHING, db_column='queid', blank=True, null=True)
    ansid = models.ForeignKey('Answer', models.DO_NOTHING, db_column='ansid', blank=True, null=True)
    userid = models.ForeignKey(settings.AUTH_USER_MODEL,models.DO_NOTHING, db_column='userid', blank=True, null=True)

    class Meta:
        managed = True
        db_table = 'favouriteanswer'

class UpvoteAnswer(models.Model):
    upvoteid = models.AutoField(primary_key=True)
    queid = models.ForeignKey('Question', models.DO_NOTHING, db_column='queid', blank=True, null=True)
    ansid = models.ForeignKey('Answer', models.DO_NOTHING, db_column='ansid', blank=True, null=True)
    userid = models.ForeignKey(settings.AUTH_USER_MODEL,models.DO_NOTHING, db_column='userid', blank=True, null=True)

    class Meta:
        managed = True
        db_table = 'upvoteanswer'

class DownvoteAnswer(models.Model):
    upvoteid = models.AutoField(primary_key=True)
    queid = models.ForeignKey('Question', models.DO_NOTHING, db_column='queid', blank=True, null=True)
    ansid = models.ForeignKey('Answer', models.DO_NOTHING, db_column='ansid', blank=True, null=True)
    userid = models.ForeignKey(settings.AUTH_USER_MODEL,models.DO_NOTHING, db_column='userid', blank=True, null=True)

    class Meta:
        managed = True
        db_table = 'downvoteanswer'
