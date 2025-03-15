<template>
  <div>
    <h1>Create Post</h1>
    <form @submit.prevent="createPost">
      <div>
        <label for="content">Content:</label>
        <textarea v-model="post.content" required></textarea>
      </div>
      <button type="submit">Create</button>
    </form>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  data() {
    return {
      post: {
        content: '',
      }
    };
  },
  methods: {
    async createPost() {
      try {
        const token = localStorage.getItem('token');
        await axios.post('/api/posts', this.post, {
          headers: {
            Authorization: `Bearer ${token}`
          }
        });
        this.$router.push('/');
      } catch (error) {
        console.error(error);
      }
    }
  }
};
</script>