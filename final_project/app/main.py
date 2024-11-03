from fastapi import FastAPI

from proper import fibonacci_proper
from fallback import fibonacci_fallback

app = FastAPI()

@app.get("/fibonacci/{number}")
async def read_fibonacci(number: int):

    try:
        result = fibonacci_proper(number)
    except Exception as e:
        result = fibonacci_fallback(number)
        
    return ({"number": number, "fibonacci": result})
