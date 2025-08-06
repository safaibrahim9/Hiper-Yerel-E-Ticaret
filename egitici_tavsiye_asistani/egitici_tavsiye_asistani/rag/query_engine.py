from transformers import pipeline
import pickle
import faiss
import numpy as np
from sentence_transformers import SentenceTransformer

# 🔹 Çok dilli cümle gömme modeli (context retrieval için)
embedding_model = SentenceTransformer("sentence-transformers/paraphrase-multilingual-MiniLM-L12-v2")

# 🔹 Türkçe QA modeli (BERT tabanlı)
qa_pipeline = pipeline(
    "question-answering",
    model="savasy/bert-base-turkish-squad",
    tokenizer="savasy/bert-base-turkish-squad"
)

# 🔹 FAISS index ve döküman yükleme
index = faiss.read_index("rag/faiss_index.index")
with open("rag/docs.pkl", "rb") as f:
    docs = pickle.load(f)

# 🔹 Kullanıcının sorgusuna göre en benzer belgeleri getir
def retrieve_top_docs(user_query, top_k=3):
    query_vec = embedding_model.encode([user_query])[0]
    query_vec = np.array(query_vec).astype('float32')
    D, I = index.search(np.array([query_vec]), top_k)
    return [docs[i] for i in I[0]]

# 🔹 Son yanıtı üret
def generate_response(user_input):
    top_docs = retrieve_top_docs(user_input)
    context = " ".join(top_docs)

    result = qa_pipeline({
        "question": user_input,
        "context": context
    })

    return result["answer"]
