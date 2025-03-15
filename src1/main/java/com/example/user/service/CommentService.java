package com.example.user.service;
import com.example.user.model.Comment;
import com.example.user.repository.CommentRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CommentService {
    @Autowired
    private CommentRepository commentRepository;

    public ResponseEntity<Comment> createComment(Comment comment) {
        return ResponseEntity.ok(commentRepository.save(comment));
    }

    public List<Comment> getCommentsByPostId(int postId) {
        return commentRepository.findAllByPostID(postId);
    }
}