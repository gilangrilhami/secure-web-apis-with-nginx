from fastapi import FastAPI

app = FastAPI()


@app.get("/")
async def root():
    return {"message": "The Fast Way @ https://fastapi.tiangolo.com/"}
