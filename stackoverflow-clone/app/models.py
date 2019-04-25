from django.db import models
from django.contrib.auth.models import User
from django.conf import settings

# Create your models here.
class UserProfile(models.Model):  
    user = models.OneToOneField(User)
    reputationpoint = models.IntegerField(blank=True, null=True)
    
class Question(models.Model):
    queid = models.AutoField(primary_key=True)
    que_title = models.CharField(max_length=200, blank=True, null=True)
    que_desc = models.TextField(blank=True, null=True)
    que_tag = models.CharField(max_length=45, blank=True, null=True)
    createdon = models.DateTimeField(blank=True, null=True)
    updatedon = models.DateTimeField(blank=True, null=True)
    createdby = models.ForeignKey(settings.AUTH_USER_MODEL, models.DO_NOTHING, db_column='createdby', blank=True, null=True)

    class Meta:
        managed = False
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
        managed = False
        db_table = 'answer'

