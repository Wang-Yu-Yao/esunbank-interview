package com.example.user.service;
import com.example.user.model.Post;
import com.example.user.repository.PostRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class PostService {
    @Autowired
    private PostRepository postRepository;

    public ResponseEntity<Post> createPost(Post post) {
        return ResponseEntity.ok(postRepository.save(post));
    }

    public List<Post> getAllPosts() {
        return postRepository.findAll();
    }

    public ResponseEntity<Post> updatePost(int postId, Post postDetails) {
        Post post = postRepository.findById(postId).orElseThrow(() -> new RuntimeException("Post not found"));
        post.setContent(postDetails.getContent());
        post.setImage(postDetails.getImage());
        return ResponseEntity.ok(postRepository.save(post));
    }

    public ResponseEntity<?> deletePost(int postId) {
        postRepository.deleteById(postId);
        return ResponseEntity.ok().build();
    }
}
