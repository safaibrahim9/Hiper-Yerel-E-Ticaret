from rag.query_engine import generate_response

if __name__ == "__main__":
    while True:
        user_input = input("Soru: ")
        if user_input.lower() in ['çık', 'exit', 'quit']:
            break
        print("Yanıt:", generate_response(user_input))
