<template>
  <div>
    <h1>{{ post.content }}</h1>
    <p>{{ post.createdAt }}</p>
    <CommentList :postId="post.postID" />
  </div>
</template>

<script>
import axios from 'axios';
import CommentList from './CommentList.vue';

export default {
  components: {
    CommentList
  },
  data() {
    return {
      post: {}
    };
  },
  async created() {
    try {
      const response = await axios.get(`/api/posts/${this.$route.params.postId}`);
      this.post = response.data;
    } catch (error) {
      console.error(error);
    }
  }
};
</script>