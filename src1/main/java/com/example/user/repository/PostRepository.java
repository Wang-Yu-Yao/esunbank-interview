package com.example.user.repository;
import com.example.user.model.Post;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;
    public interface PostRepository extends JpaRepository<Post, Integer> {
        List<Post> findAllByUserID(int userID);
}
