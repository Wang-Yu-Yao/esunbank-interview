import { createRouter, createWebHistory } from 'vue-router';
import HomePage from './views/Home.vue';
import LoginPage from './components/Login.vue';
import Register from './components/Register.vue';
import PostDetail from './components/PostDetail.vue';
import CreatePost from './components/CreatePost.vue';
import Profile from './views/Profile.vue';

const routes = [
    {
        path: '/',
        name: 'home',
        component: HomePage
    },
    {
        path: '/login',
        name: 'login',
        component: LoginPage
    },
    {
        path: '/register',
        name: 'register',
        component: Register
    },
    {
        path: '/posts/:postId',
        name: 'post-detail',
        component: PostDetail
    },
    {
        path: '/create-post',
        name: 'create-post',
        component: CreatePost
    },
    {
        path: '/profile',
        name: 'profile',
        component: Profile
    }
];

const router = createRouter({
    history: createWebHistory(),
    routes
});

export default router;