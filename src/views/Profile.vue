<template>
  <div class="profile-container">
    <h1>Profile</h1>
    <div class="profile-details">
      <p><strong>User Name:</strong> {{ user.userName }}</p>
      <p><strong>Email:</strong> {{ user.email }}</p>
      <p><strong>Biography:</strong> {{ user.biography }}</p>
    </div>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  name: 'UserProfile',
  data() {
    return {
      user: {}
    };
  },
  async created() {
    try {
      const token = localStorage.getItem('token');
      const response = await axios.get('/api/auth/profile', {
        headers: {
          Authorization: `Bearer ${token}`
        }
      });
      this.user = response.data;
    } catch (error) {
      console.error(error);
    }
  }
};
</script>

<style scoped>
.profile-container {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  height: 100vh;
  background-color: #f5f5f5;
  color: #333;
  font-family: Arial, sans-serif;
}

.profile-details {
  background: white;
  padding: 20px;
  border-radius: 10px;
  box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
  text-align: left;
  width: 80%;
  max-width: 500px;
}

h1 {
  margin-bottom: 20px;
}

p {
  margin: 10px 0;
}

strong {
  font-weight: bold;
}
</style>