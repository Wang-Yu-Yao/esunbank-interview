<template>
  <div>
    <h2>Add Comment</h2>
    <form @submit.prevent="createComment">
      <div>
        <label for="content">Content:</label>
        <textarea v-model="comment.content" required></textarea>
      </div>
      <button type="submit">Add</button>
    </form>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  props: {
    postId: {
      type: Number,
      required: true
    }
  },
  data() {
    return {
      comment: {
        content: '',
        postID: this.postId,
      }
    };
  },
  methods: {
    async createComment() {
      try {
        const token = localStorage.getItem('token');
        await axios.post('/api/comments', this.comment, {
          headers: {
            Authorization: `Bearer ${token}`
          }
        });
        this.$emit('commentAdded');
      } catch (error) {
        console.error(error);
      }
    }
  }
};
</script>