package com.codingdojo.dumbassassin.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.codingdojo.dumbassassin.models.Feature;

@Repository
public interface FeatureRepo extends CrudRepository<Feature, Long>{
	List<Feature> findAll();
	
	
	// Retrieve Features by Project ID
	@Query(value="SELECT * FROM features WHERE project_id=?1 AND completed = false ORDER BY priority DESC", nativeQuery=true)
	List<Feature> findAllByCompletedOrderByPriorityDesc(Long project_id);
	
	@Query(value="SELECT * FROM features WHERE project_id=?1 AND completed = false ORDER BY priority ASC", nativeQuery=true)
	List<Feature> findAllByCompletedOrderByPriorityAsc(Long project_id);

	
	
	//Order by Priority, specific to project
	@Query(value="SELECT * FROM features WHERE project_id=?1 AND completed = false ORDER BY priority DESC", nativeQuery=true)
	List<Feature> findAllByProjectAndCompletedOrderByPriorityDesc(Long project_id);
	
	@Query(value="SELECT * FROM features WHERE project_id=?1 AND completed = false ORDER BY priority ASC", nativeQuery=true)
	List<Feature> findAllByProjectAndCompletedOrderByPriorityAsc(Long project_id);
	
	
	
	// [SEARCH] Retrieve Features by Search String
	@Query(value="SELECT * FROM features WHERE shared='1' AND feature_name LIKE CONCAT('%', :string, '%') OR description LIKE CONCAT('%', :string, '%') ORDER BY priority DESC", nativeQuery=true)
	List<Feature> findAllBySearchString(String string);
	
	@Query(value="SELECT * FROM features WHERE shared='1' AND feature_name LIKE CONCAT('%', :string, '%') OR description LIKE CONCAT('%', :string, '%') ORDER BY priority ASC", nativeQuery=true)
	List<Feature> findAllBySearchTag(String string);
	
	@Query(value="SELECT * FROM features WHERE shared='1' AND (feature_name LIKE CONCAT('%', :string, '%') OR description LIKE CONCAT('%', :string, '%') OR notes LIKE CONCAT('%', :string, '%'))", nativeQuery=true)
	List<Feature> findAllFeaturesByNameOrDescOrNotes(String string);

}
