# Running the API

First, create a Python virtual environment:

```bash
python -m venv env
```

Then, install the necessary dependencies:

```bash
pip install -r requirements.txt
```

Finally, to run the API in development mode, run:

```bash
fastapi dev main.py
```

For production, we will use:

```bash
fastapi run main.py
```