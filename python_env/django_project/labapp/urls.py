from django.urls import path
from . import views

from django.shortcuts import render
from django.http import HttpResponse

def post_vars(request):
  name = request.POST.get("name","")
  password = request.POST.get("password","")
  if name == "Jimmy" and password == "Hendrix":
    return HttpResponse("cool")
  else:
    return HttpResponse("Bad User Name")

urlpatterns = [
	path('lab7/', post_vars),
]
