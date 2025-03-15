<template>
  <div>
    <h1>Posts</h1>
    <div v-for="post in posts" :key="post.postID">
      <h2>{{ post.content }}</h2>
      <p>{{ post.createdAt }}</p>
      <router-link :to="`/posts/${post.postID}`">View Details</router-link>
    </div>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  data() {
    return {
      posts: []
    };
  },
  async created() {
    try {
      const response = await axios.get('/api/posts');
      this.posts = response.data;
    } catch (error) {
      console.error(error);
    }
  }
};
</script>