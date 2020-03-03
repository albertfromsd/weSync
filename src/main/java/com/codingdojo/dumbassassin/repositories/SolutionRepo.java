package com.codingdojo.dumbassassin.repositories;

import java.util.List;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.codingdojo.dumbassassin.models.Solution;

@Repository
public interface SolutionRepo extends CrudRepository<Solution, Long>{
	List<Solution> findAll();

}
