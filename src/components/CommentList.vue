<template>
  <div class="comments-container">
    <h2>Comments</h2>
    <div v-for="comment in comments" :key="comment.commentID" class="comment">
      <p class="comment-content">{{ comment.content }}</p>
      <p class="comment-date">{{ new Date(comment.createdAt).toLocaleString() }}</p>
    </div>
    <CreateComment :postId="postId" />
  </div>
</template>

<script>
import axios from 'axios';
import CreateComment from './CreateComment.vue';

export default {
  components: {
    CreateComment
  },
  props: {
    postId: {
      type: Number,
      required: true
    }
  },
  data() {
    return {
      comments: []
    };
  },
  async created() {
    try {
      const response = await axios.get(`/api/comments/${this.postId}`);
      this.comments = response.data;
    } catch (error) {
      console.error(error);
    }
  }
};
</script>

<style scoped>
.comments-container {
  max-width: 800px;
  margin: 0 auto;
  padding: 20px;
  text-align: center;
  background-color: #f9f9f9;
  border-radius: 8px;
  box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

h2 {
  font-size: 24px;
  margin-bottom: 20px;
  color: #333;
}

.comment {
  background-color: #fff;
  border: 1px solid #ddd;
  border-radius: 4px;
  padding: 15px;
  margin-bottom: 10px;
  text-align: left;
}

.comment-content {
  font-size: 16px;
  margin: 0;
  color: #555;
}

.comment-date {
  font-size: 14px;
  color: #999;
  margin-top: 5px;
  text-align: right;
}
</style>