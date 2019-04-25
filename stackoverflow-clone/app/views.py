"""
Definition of views.
"""

from django.shortcuts import render
from django.http import HttpRequest,HttpResponse,HttpResponseRedirect, Http404
from django.template import RequestContext
from datetime import datetime
from django.urls import reverse
from .forms import QuestionModelForm, AnswerModelForm
from django.contrib.auth.decorators import login_required
from django.shortcuts import render, get_object_or_404
from django.contrib.auth import login, authenticate
from django.contrib.auth.forms import UserCreationForm
from django.shortcuts import render, redirect
from . import models

def home(request):
    """Renders the home page."""
    assert isinstance(request, HttpRequest)
    return render(
        request,
        'app/index.html',
        {
            'title':'Home Page',
            'year':datetime.now().year,
        }
    )

def contact(request):
    """Renders the contact page."""
    assert isinstance(request, HttpRequest)
    return render(
        request,
        'app/contact.html',
        {
            'title':'Contact',
            'message':'Your contact page.',
            'year':datetime.now().year,
        }
    )

def about(request):
    """Renders the about page."""
    assert isinstance(request, HttpRequest)
    return render(
        request,
        'app/about.html',
        {
            'title':'About',
            'message':'Your application description page.',
            'year':datetime.now().year,
        }
    )

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

## Create your views here.
#def index(request):
#    return render(request, "app/index.html", {})
#    # return HttpResponse("Hello, world.")

#def createUser(request):
#    return HttpResponse("Create User Page")
@login_required
def postQuestion(request):
    form = QuestionModelForm(request.POST or None)
    if form.is_valid():
        obj = form.save(commit=False)
        obj.createdby = request.user
        obj.save()
        return HttpResponseRedirect(reverse('viewquestion'))
            
    context = {
        "form" : form,
    }
    template = "app/question/postquestion.html"
    return render(request, template, context)

@login_required
def updateQuestion(request, id=None):
    obj = get_object_or_404(models.Question, queid = id)
    form = QuestionModelForm(request.POST or None, instance=obj)
    if form.is_valid():
        print("POST:",request.POST)
        que = models.Question.objects.get(queid = id)
        que.que_title = request.POST['que_title']
        que.que_desc = request.POST['que_desc']
        que.que_tag = request.POST['que_tag']
        que.save()
        return HttpResponseRedirect(reverse('viewquestion'))
    
    context = {
        "form" : form,
    }
    template = "app/question/updatequestion.html"
    return render(request, template, context)

@login_required
def viewQuestion(request):
    obj = models.Question.objects.all()
    context = {
        "questions" : obj
    }
    template = "app/question/viewquestions.html"
    return render(request, template, context)

@login_required
def postAnswer(request, id=None):
    queobj = get_object_or_404(models.Question, queid = id)
    form = AnswerModelForm(request.POST or None, instance = queobj)
    if form.is_valid():
        que = models.Question.objects.get(queid=form.instance.queid)
        obj = models.Answer(ans_desc=request.POST['ans_desc'], createdby = request.user, total_upvote = 0,
                    total_downvote = 0, queid = que)
        obj.save()
        return HttpResponseRedirect(reverse('viewquestion'))
            
    context = {
        "form" : form,
    }
    template = "app/answer/postanswer.html"
    return render(request, template, context)

@login_required
def acceptAnswer(request, queid=None, ansid=None):
    if queid and ansid:
        ans = models.Answer.objects.get(ansid=ansid)
        que = models.Question.objects.get(queid=ans.queid.queid)
        if(que.queid != queid):
            raise Http404
        obj = models.AcceptAnswer(queid=que,ansid=ans,userid=request.user)
        obj.save()
        return HttpResponseRedirect(reverse('viewquestion'))
    else:
        raise Http404
    