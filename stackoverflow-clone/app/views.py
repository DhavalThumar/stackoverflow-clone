from django.shortcuts import render
from django.http import HttpRequest,HttpResponse,HttpResponseRedirect, Http404
from django.template import RequestContext
from datetime import datetime
from django.urls import reverse
from .forms import QuestionModelForm, AnswerModelForm, CommentModelForm
from django.contrib.auth.decorators import login_required
from django.shortcuts import render, get_object_or_404
from django.contrib.auth import login, authenticate
from django.contrib.auth.forms import UserCreationForm
from django.shortcuts import render, redirect
from . import models
from django.contrib.auth.models import User as UserModel

def signup(request):
    if request.method == 'POST':
        form = UserCreationForm(request.POST)
        if form.is_valid():
            form.save()
            username = form.cleaned_data.get('username')
            raw_password = form.cleaned_data.get('password1')
            user = authenticate(username=username, password=raw_password)
            login(request, user)
            return redirect('home')
    else:
        form = UserCreationForm()
    return render(request, 'app/signup.html', {'form': form})

@login_required
def postQuestion(request):
    form = QuestionModelForm(request.POST or None)
    if request.method == 'POST':
        if form.is_valid():
            queform = form.save(commit=False)
            queform.createdby = request.user
            queform.createdon = datetime.now()
            queform.updatedon = datetime.now()
            queform.save()
            addReputationPoint(request,request.user)
            return HttpResponseRedirect(reverse('viewquestion'))
            
    context = {
        "form" : form,
    }
    template = "app/question/postquestion.html"
    return render(request, template, context)

def addReputationPoint(request, usr):
    try:
        usr = models.UserProfile.objects.get(user = usr)
        usr.reputationpoint = usr.reputationpoint + 1
        usr.save()
    except:
        usr = models.UserProfile(user=usr,reputationpoint=1)
        usr.save()

@login_required
def updateQuestion(request, queid=None):
    queobj = get_object_or_404(models.Question, queid = queid)
    if(queobj.createdby == request.user):
        form = QuestionModelForm(request.POST or None, instance=queobj)
        if request.method == 'POST':
            if form.is_valid():
                queobj.que_title = request.POST['que_title']
                queobj.que_desc = request.POST['que_desc']
                queobj.que_tag = request.POST['que_tag']
                queobj.updatedon = datetime.now()
                queobj.save()
                return HttpResponseRedirect(reverse('viewquestion'))
        
        answers = getAnswers(queid)
        context = {
            "form" : form,
            "answers" : answers,
            "queid" : queid,
        }
        template = "app/question/updatequestion.html"
    else:
        answers = getAnswers(queid)
        context = {
            "answers" : answers,
            "queid" : queid,
        }
        template = "app/question/viewanswers.html"

    return render(request, template, context)

def getAnswers(queid):
    obj = get_object_or_404(models.Question, queid = queid)
    return models.Answer.objects.filter(queid=obj)

@login_required
def viewQuestion(request):
    obj = models.Question.objects.all()
    context = {
        "questions" : obj
    }
    template = "app/question/viewquestions.html"
    return render(request, template, context)

@login_required
def postAnswer(request, queid=None):
    queobj = get_object_or_404(models.Question, queid = queid)
    form = AnswerModelForm(request.POST or None, instance = queobj)
    if request.method == 'POST':
        if form.is_valid():
            obj = models.Answer(ans_desc=request.POST['ans_desc'], createdby = request.user, total_upvote = 0,
                        total_downvote = 0, queid = queobj, createdon = datetime.now(), updatedon = datetime.now())
            obj.save()
            return HttpResponseRedirect(reverse('viewquestion'))
        else:
            raise Http404
    context = {
        "form" : form,
        "queid" : queid,
    }
    template = "app/answer/postanswer.html"
    return render(request, template, context)
    
@login_required
def updateAnswer(request, queid=None, ansid=None):
    ansobj = get_object_or_404(models.Answer, ansid = ansid)
    if(ansobj.createdby == request.user):
        form = AnswerModelForm(request.POST or None, instance=ansobj)
        if request.method == 'POST':
            if form.is_valid():
                ansobj.ans_desc = request.POST['ans_desc']
                ansobj.updatedon = datetime.now()
                ansobj.save()
                return HttpResponseRedirect(reverse('viewquestion'))
            else:
                raise Http404

        cmts = getComments(ansid)
        context = {
            "form" : form,
            "queid" : queid,
            "cmts" : cmts,
            "ansid" : ansid,
        }
        template = "app/answer/updateanswer.html"
    else:
        cmts = getComments(ansid)
        context = {
            "ansobj": ansobj,
            "queid" : queid,
            "cmts" : cmts,
            "ansid" : ansid,
        }
        template = "app/answer/viewcomments.html"
    return render(request, template, context)

def getComments(ansid):
    ansobj = models.Answer.objects.get(ansid = ansid)
    cmtobj = models.CommentOnAnswer.objects.filter(ansid=ansobj)
    return cmtobj

@login_required
def acceptAnswer(request, queid=None, ansid=None):
    if queid and ansid:
        ans = models.Answer.objects.get(ansid=ansid)
        que = models.Question.objects.get(queid=ans.queid.queid)
        if(int(que.queid) == int(queid)):
            if(checkappeted(request,queid,ansid)):
                obj = models.AcceptAnswer(queid=que,ansid=ans,userid=request.user,createdon = datetime.now(), updatedon = datetime.now())
                obj.save()
                return HttpResponseRedirect(reverse('viewquestion'))
            else:
                return HttpResponse("Already Accepted")
        else:
            raise Http404
    else:
        raise Http404

def checkappeted(request,queid,ansid):
    ans = models.Answer.objects.get(ansid=ansid)
    que = models.Question.objects.get(queid=ans.queid.queid)
    acceptobj = models.AcceptAnswer.objects.filter(queid=que,ansid=ans,userid=request.user)
    if acceptobj.count() == 0:
        return True
    else:
        return False

@login_required
def favouriteAnswer(request, queid=None, ansid=None):
    if queid and ansid:
        ans = models.Answer.objects.get(ansid=ansid)
        que = models.Question.objects.get(queid=ans.queid.queid)
        if(int(que.queid) == int(queid)):
            if(checkfavourite(request,queid,ansid)):
                obj = models.FavouriteAnswer(queid=que,ansid=ans,userid=request.user,createdon = datetime.now(), updatedon = datetime.now())
                obj.save()
            else:
                return HttpResponse("Already Fav")
            return HttpResponseRedirect(reverse('viewquestion'))
        else: 
            raise Http404
    else:
        raise Http404

def checkfavourite(request,queid,ansid):
    ans = models.Answer.objects.get(ansid=ansid)
    que = models.Question.objects.get(queid=ans.queid.queid)
    favobj = models.FavouriteAnswer.objects.filter(queid=que,ansid=ans,userid=request.user)
    if favobj.count() == 0:
        return True
    else:
        return False

@login_required
def upvoteAnswer(request, queid=None, ansid=None):
    if queid and ansid:
        ans = models.Answer.objects.get(ansid=ansid)
        que = models.Question.objects.get(queid=ans.queid.queid)
        if(int(que.queid) == int(queid)):
            if(checkupvote(request,queid,ansid)):
                obj = models.UpvoteAnswer(queid=que,ansid=ans,userid=request.user,createdon = datetime.now(), updatedon = datetime.now())
                obj.save()
                ans.total_upvote = ans.total_upvote + 1
                ans.updatedon = datetime.now()
                ans.save()
                usr = UserModel.objects.get(id=ans.createdby.id)
                addReputationPoint(request,usr)
                return HttpResponseRedirect(reverse('viewquestion'))
            else:
                return HttpResponse("Already Upvoted")
        else: 
            raise Http404
    else:
        raise Http404

def checkupvote(request,queid,ansid):
    ans = models.Answer.objects.get(ansid=ansid)
    que = models.Question.objects.get(queid=ans.queid.queid)
    upvoteobj = models.UpvoteAnswer.objects.filter(queid=que,ansid=ans,userid=request.user)
    if upvoteobj.count() == 0:
        return True
    else:
        return False
    
@login_required
def downvoteAnswer(request, queid=None, ansid=None):
    if queid and ansid:
        ans = models.Answer.objects.get(ansid=ansid)
        que = models.Question.objects.get(queid=ans.queid.queid)
        if(int(que.queid) == int(queid)):
            if(checkdownvote(request,queid,ansid)):
                obj = models.DownvoteAnswer(queid=que,ansid=ans,userid=request.user,createdon = datetime.now(), updatedon = datetime.now())
                obj.save()
                ans.total_downvote = ans.total_downvote + 1
                ans.updatedon = datetime.now()
                ans.save() 
                return HttpResponseRedirect(reverse('viewquestion'))
            else:
                return HttpResponse("Already Fav")
        else: 
            raise Http404
    else:
        raise Http404

def checkdownvote(request,queid,ansid):
    ans = models.Answer.objects.get(ansid=ansid)
    que = models.Question.objects.get(queid=ans.queid.queid)
    downvoteobj = models.DownvoteAnswer.objects.filter(queid=que,ansid=ans,userid=request.user)
    if downvoteobj.count() == 0:
        return True
    else:
        return False

@login_required
def postComment(request, queid=None, ansid=None):
    if queid and ansid:
        ans = models.Answer.objects.get(ansid=ansid)
        que = models.Question.objects.get(queid=ans.queid.queid)
        form = CommentModelForm(request.POST or None, instance = ans)
        if form.is_valid():
            obj = models.CommentOnAnswer(cmt_desc=request.POST['cmt_desc'], userid = request.user, queid = que, ansid = ans,
                    createdon = datetime.now(), updatedon = datetime.now())
            obj.save()
            return HttpResponseRedirect(reverse('viewquestion'))
            
        context = {
            "form" : form,
            "queid" : queid,
            "ansid" : ansid,
        }
        template = "app/comment/postcomment.html"
        return render(request, template, context)
    else:
        raise Http404


