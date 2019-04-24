"""
Definition of views.
"""

from django.shortcuts import render
from django.http import HttpRequest,HttpResponse,HttpResponseRedirect
from django.template import RequestContext
from datetime import datetime
from django.urls import reverse
from .forms import QuestionModelForm
from django.contrib.auth import login, authenticate
from django.contrib.auth.forms import UserCreationForm
from django.shortcuts import render, redirect

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

def createQuestion(request):
    form = QuestionModelForm(request.POST or None)
    print("++++++++++++++++++++++++++++++++++++++++++++++")
    print("request:",request.method)
    if(request.method == "POST"):
        print("request.POST:",request.POST)
    print("form:",form)
    if form.is_valid():
        print("here")
        obj = form.save(commit=False)
        obj.createdby = request.user
        obj.save()
        return HttpResponseRedirect(reverse('about'))
            
    context = {
        "form" : form,
    }
    template = "app/createquestion.html"
    return render(request, template, context)
