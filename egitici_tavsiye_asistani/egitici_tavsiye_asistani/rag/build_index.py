from sentence_transformers import SentenceTransformer
import faiss
import json
import pickle

model = SentenceTransformer("sentence-transformers/paraphrase-multilingual-MiniLM-L12-v2")

def load_docs(json_path):
    with open(json_path, "r", encoding="utf-8") as f:
        data = json.load(f)
        return [f"{item['term']} - {item['definition']}" for item in data]

docs = load_docs("data/educational_terms_250_with_aliases.json")
doc_embeddings = model.encode(docs, convert_to_tensor=False)

dimension = len(doc_embeddings[0])
index = faiss.IndexFlatL2(dimension)
index.add(doc_embeddings)

faiss.write_index(index, "rag/faiss_index.index")
with open("rag/docs.pkl", "wb") as f:
    pickle.dump(docs, f)
