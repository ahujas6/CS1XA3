from django.shortcuts import render
from django.http import HttpResponse

def post_vars(request):
  name = request.POST.get("name","")
  password = request.POST.get("password","")
  if name == "Jimmy" and password == "Hendrix":
    return HttpResponse("Cool")
  else:
    return HttpResponse("Bad User Name")
  

