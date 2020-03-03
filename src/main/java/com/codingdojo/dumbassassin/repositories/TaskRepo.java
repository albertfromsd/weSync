package com.codingdojo.dumbassassin.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.codingdojo.dumbassassin.models.Feature;
import com.codingdojo.dumbassassin.models.Task;

@Repository
public interface TaskRepo extends CrudRepository<Task, Long>{
	List<Task> findAll();
	
	
	// [PRIORITY] Order Tasks by priority
	@Query(value="SELECT * FROM tasks WHERE (feature_id=?1 AND completed = false) ORDER BY priority DESC", nativeQuery=true)
	List<Task> findAllByFeatureAndCompletedOrderByPriorityDesc(Long feature_id);
	
	@Query(value="SELECT * FROM tasks WHERE (feature_id=?1 AND completed = false) ORDER BY priority ASC", nativeQuery=true)
	List<Task> findAllByFeatureAndCompletedOrderByPriorityAsc(Long feature_id);
	
	
	// [ACTIVITY LOG] Retrieve Tasks by Feature ID
	@Query(value="SELECT * FROM tasks WHERE feature_id=?1 ORDER BY created_at DESC", nativeQuery=true)
	List<Task> findAllOrderByCreatedAtDesc(Long feature_id);
	
	@Query(value="SELECT * FROM tasks WHERE feature_id=?1 ORDER BY created_at ASC", nativeQuery=true)
	List<Task> findAllOrderByCreatedAtAsc(Long feature_id);

	
	@Query(value="SELECT * FROM tasks WHERE shared=true AND (notes LIKE CONCAT('%', :string, '%') OR description LIKE CONCAT('%', :string, '%'))", nativeQuery=true)
	List<Task> findAllByNotesOrDescription(String string);
	
}
