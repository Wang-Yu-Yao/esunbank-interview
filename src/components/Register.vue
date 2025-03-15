<template>
  <div class="register-container">
    <h1>Register</h1>
    <form @submit.prevent="register" class="register-form">
      <div class="form-group">
        <label for="userName">User Name:</label>
        <input type="text" v-model="user.userName" required />
      </div>
      <div class="form-group">
        <label for="email">Email:</label>
        <input type="email" v-model="user.email" required />
      </div>
      <div class="form-group">
        <label for="password">Password:</label>
        <input type="password" v-model="user.passwordHash" required />
      </div>
      <div class="form-group">
        <label for="coverImage">Cover Image (Optional):</label>
        <input type="file" @change="onFileChange" />
      </div>
      <button type="submit" class="register-button">Register</button>
    </form>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  name: 'UserRegister',
  data() {
    return {
      user: {
        userName: '',
        email: '',
        passwordHash: '',
      },
      coverImage: null // 可選
    };
  },
  methods: {
    onFileChange(event) {
      this.coverImage = event.target.files[0];
    },
    async register() {
      try {
        const formData = new FormData();
        formData.append('userName', this.user.userName);
        formData.append('email', this.user.email);
        formData.append('passwordHash', this.user.passwordHash);

        // 只有在 coverImage 存在時才加入 FormData
        if (this.coverImage) {
          formData.append('coverImage', this.coverImage);
        }

        await axios.post('/api/auth/register', formData, {
          headers: {
            'Content-Type': 'multipart/form-data'
          }
        });

        this.$router.push('/login');
      } catch (error) {
        console.error(error);
      }
    }
  }
};
</script>

<style scoped>
.register-container {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  height: 100vh;
  background-color: #f5f5f5;
  padding: 20px;
}

h1 {
  margin-bottom: 20px;
  color: #333;
}

.register-form {
  background-color: #fff;
  padding: 20px;
  border-radius: 10px;
  box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
  max-width: 400px;
  width: 100%;
}

.form-group {
  margin-bottom: 15px;
}

.form-group label {
  display: block;
  margin-bottom: 5px;
  color: #555;
}

.form-group input {
  width: 100%;
  padding: 10px;
  border: 1px solid #ddd;
  border-radius: 5px;
  box-sizing: border-box;
}

.register-button {
  width: 100%;
  padding: 10px;
  background-color: #007bff;
  color: #fff;
  border: none;
  border-radius: 5px;
  cursor: pointer;
  font-size: 16px;
}

.register-button:hover {
  background-color: #0056b3;
}
</style>