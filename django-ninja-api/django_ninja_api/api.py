from ninja import NinjaAPI

api = NinjaAPI()


@api.get("/")
def hello(request):
    return "The Ninja Way @ https://django-ninja.dev/"
