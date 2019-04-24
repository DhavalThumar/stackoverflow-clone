# -*- coding: utf-8 -*-
# Generated by Django 1.11.20 on 2019-04-24 12:37
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='Answer',
            fields=[
                ('ansid', models.AutoField(primary_key=True, serialize=False)),
                ('ans_desc', models.TextField(blank=True, null=True)),
                ('total_upvote', models.IntegerField(blank=True, null=True)),
                ('total_downvote', models.IntegerField(blank=True, null=True)),
                ('createdon', models.DateTimeField(blank=True, null=True)),
                ('updatedon', models.DateTimeField(blank=True, null=True)),
            ],
            options={
                'db_table': 'answer',
                'managed': False,
            },
        ),
        migrations.CreateModel(
            name='Question',
            fields=[
                ('queid', models.AutoField(primary_key=True, serialize=False)),
                ('que_title', models.CharField(blank=True, max_length=200, null=True)),
                ('que_desc', models.TextField(blank=True, null=True)),
                ('que_tag', models.CharField(blank=True, max_length=45, null=True)),
                ('createdon', models.DateTimeField(blank=True, null=True)),
                ('updatedon', models.DateTimeField(blank=True, null=True)),
            ],
            options={
                'db_table': 'question',
                'managed': False,
            },
        ),
        migrations.CreateModel(
            name='User',
            fields=[
                ('userid', models.AutoField(primary_key=True, serialize=False)),
                ('username', models.CharField(blank=True, max_length=45, null=True)),
                ('password', models.CharField(blank=True, max_length=45, null=True)),
                ('reputationpoint', models.IntegerField(blank=True, null=True)),
                ('createdon', models.DateTimeField(blank=True, null=True)),
                ('updatedon', models.DateTimeField(blank=True, null=True)),
            ],
            options={
                'db_table': 'user',
                'managed': False,
            },
        ),
    ]
