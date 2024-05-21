# Running the API

First, create a Python virtual environment:

```bash
python -m venv env
```

Then, install the necessary dependencies:

```bash
pip install -r requirements.txt
```

Finally, using `manage.py` to run the API:

```bash
python manage.py runserver
```

Or, if you feeling a bit fancy, use `uvicorn` to run the API:

```bash
uvicorn django_ninja_api.asgi:application --reload
```