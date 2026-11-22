1. clone project

2. buat docker file

3. build docker file 

## 🔧 build docker file  dan jalankan

```
docker build -t mern-notes-app .

docker run --rm -p 5000:5000 \
  -e MONGO_URI="mongodb://host.docker.internal:27017/notes" \
  -e JWT_SECRET="ganti-dengan-secret-kuat" \
  mern-notes-app

```

