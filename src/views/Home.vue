<template>
  <div class="page-container">
    <h1 id="title1">玉山部落格</h1>
    <nav>
      <ul>
        <li><router-link to="/login">登入</router-link></li>
        <li><router-link to="/register">註冊</router-link></li>
        <li><router-link to="/profile">個人檔案</router-link></li>
        <li><router-link to="/comments">發文</router-link></li>
      </ul>
    </nav>
    <main>
      <div v-if="user" class="welcome">
        <h2>Welcome, {{ user.userName }}</h2>
        <p>Email: {{ user.email }}</p>
        <button @click="logout">Logout</button>
      </div>
      <div v-else class="login-prompt">
        <p>Please <router-link to="/login">login</router-link> to post and comment.</p>
      </div>

      <div v-if="user" class="create-post">
        <h2>Create a Post</h2>
        <form @submit.prevent="createPost">
          <div>
            <label for="title">Title:</label>
            <input type="text" v-model="newPost.title" required />
          </div>
          <div>
            <label for="content">Content:</label>
            <textarea v-model="newPost.content" required></textarea>
          </div>
          <button type="submit">Post</button>
        </form>
      </div>

      <div class="post-list">
        <h2>Posts</h2>
        <div v-for="post in posts" :key="post.id" class="post">
          <h3>{{ post.title }}</h3>
          <p>{{ post.content }}</p>
          <div class="comments">
            <h4>Comments</h4>
            <div v-for="comment in post.comments" :key="comment.id" class="comment">
              <p>{{ comment.content }}</p>
              <p><small>by {{ comment.userName }}</small></p>
            </div>
            <div v-if="user" class="add-comment">
              <form @submit.prevent="addComment(post.id)">
                <input type="text" v-model="newComment[post.id]" placeholder="Add a comment" required />
                <button type="submit">Comment</button>
              </form>
            </div>
          </div>
        </div>
      </div>
    </main>
    <footer>
      <hr>
      <a class="a-about" href="">玉山部落格首頁</a>.
      <a class="a-back" href="#">back to top</a>
    </footer>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  name: 'HomePage',
  data() {
    return {
      user: null,
      posts: [],
      newPost: {
        title: '',
        content: ''
      },
      newComment: {}
    };
  },
  async created() {
    try {
      const token = localStorage.getItem('token');
      if (token) {
        const response = await axios.get('/api/auth/profile', {
          headers: {
            Authorization: `Bearer ${token}`
          }
        });
        this.user = response.data;
      }
      this.fetchPosts();
    } catch (error) {
      console.error(error);
    }
  },
  methods: {
    async fetchPosts() {
      try {
        const response = await axios.get('/api/posts');
        this.posts = response.data;
      } catch (error) {
        console.error(error);
      }
    },
    async createPost() {
      try {
        const token = localStorage.getItem('token');
        const response = await axios.post('/api/posts', this.newPost, {
          headers: {
            Authorization: `Bearer ${token}`
          }
        });
        this.posts.push(response.data);
        this.newPost.title = '';
        this.newPost.content = '';
      } catch (error) {
        console.error(error);
      }
    },
    async addComment(postId) {
      try {
        const token = localStorage.getItem('token');
        const response = await axios.post(`/api/posts/${postId}/comments`, {
          content: this.newComment[postId]
        }, {
          headers: {
            Authorization: `Bearer ${token}`
          }
        });
        const post = this.posts.find(post => post.id === postId);
        post.comments.push(response.data);
        this.$set(this.newComment, postId, '');
      } catch (error) {
        console.error(error);
      }
    },
    logout() {
      localStorage.removeItem('token');
      this.user = null;
      this.$router.push('/login');
    }
  }
};
</script>

<style scoped>
@import '../assets/玉山部落格.css';

/* Page container styling */
.page-container {
  max-width: 800px;
  margin: 0 auto;
  padding: 20px;
  background-color: #f9f9f9;
  box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

/* Header styling */
#title1 {
  text-align: center;
  font-size: 2.5em;
  color: #333;
}

/* Navigation styling */
nav ul {
  list-style: none;
  padding: 0;
  display: flex;
  justify-content: center;
  margin-bottom: 20px;
}

nav li {
  margin: 0 15px;
}

nav a {
  text-decoration: none;
  color: #007bff;
  font-weight: bold;
}

nav a:hover {
  text-decoration: underline;
}

/* Main content styling */
main {
  text-align: center;
}

.welcome, .login-prompt {
  margin-bottom: 20px;
}

.create-post, .post-list {
  margin-top: 20px;
  text-align: left;
}

.create-post form div, .add-comment form {
  margin-bottom: 10px;
}

.create-post label, .add-comment input {
  display: block;
  margin-bottom: 5px;
}

.create-post input, .create-post textarea, .add-comment input {
  width: 100%;
  padding: 10px;
  border: 1px solid #ddd;
  border-radius: 5px;
}

.create-post button, .add-comment button {
  background-color: #007bff;
  color: white;
  border: none;
  padding: 10px 20px;
  border-radius: 5px;
  cursor: pointer;
}

.create-post button:hover, .add-comment button:hover {
  background-color: #0056b3;
}

/* Post styling */
.post {
  border: 1px solid #ddd;
  padding: 20px;
  margin-bottom: 20px;
  border-radius: 5px;
  background-color: white;
}

.post h3 {
  margin-top: 0;
}

.comments {
  margin-top: 20px;
}

.comment {
  border-top: 1px solid #ddd;
  padding-top: 10px;
  margin-top: 10px;
}

.comment p {
  margin: 0;
}

/* Footer styling */
footer {
  text-align: center;
  margin-top: 40px;
  padding-top: 20px;
  border-top: 1px solid #ddd;
}

footer a {
  color: #007bff;
  text-decoration: none;
}

footer a:hover {
  text-decoration: underline;
}
</style>