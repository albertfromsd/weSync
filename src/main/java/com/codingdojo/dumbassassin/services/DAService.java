package com.codingdojo.dumbassassin.services;

import java.util.List;
import java.util.Optional;

import org.mindrot.jbcrypt.BCrypt;
import org.springframework.stereotype.Service;

import com.codingdojo.dumbassassin.models.Bug;
import com.codingdojo.dumbassassin.models.BugTag;
import com.codingdojo.dumbassassin.models.Feature;
import com.codingdojo.dumbassassin.models.FeatureTag;
import com.codingdojo.dumbassassin.models.Project;
import com.codingdojo.dumbassassin.models.ProjectTag;
import com.codingdojo.dumbassassin.models.Solution;
import com.codingdojo.dumbassassin.models.Tag;
import com.codingdojo.dumbassassin.models.Task;
import com.codingdojo.dumbassassin.models.User;
import com.codingdojo.dumbassassin.models.UserProject;
import com.codingdojo.dumbassassin.repositories.BugRepo;
import com.codingdojo.dumbassassin.repositories.BugTagRepo;
import com.codingdojo.dumbassassin.repositories.FeatureRepo;
import com.codingdojo.dumbassassin.repositories.FeatureTagRepo;
import com.codingdojo.dumbassassin.repositories.ProjectRepo;
import com.codingdojo.dumbassassin.repositories.ProjectTagRepo;
import com.codingdojo.dumbassassin.repositories.SolutionRepo;
import com.codingdojo.dumbassassin.repositories.TagRepo;
import com.codingdojo.dumbassassin.repositories.TaskRepo;
import com.codingdojo.dumbassassin.repositories.UserProjectRepo;
import com.codingdojo.dumbassassin.repositories.UserRepo;

@Service
public class DAService {
	private final UserRepo userRepo;
	private final ProjectRepo projectRepo;
	private final UserProjectRepo userProjectRepo;
	private final FeatureRepo featureRepo;
	private final TaskRepo taskRepo;
	private final BugRepo bugRepo;
	private final TagRepo tagRepo;
	private final ProjectTagRepo projectTagRepo;
	private final FeatureTagRepo featureTagRepo;
	private final BugTagRepo bugTagRepo;
	private final SolutionRepo solutionRepo;

	public DAService(
			UserRepo userRepo, 
			ProjectRepo projectRepo, 
			UserProjectRepo userProjectRepo,
			FeatureRepo featureRepo,
			TaskRepo taskRepo,
			BugRepo bugRepo,
			TagRepo tagRepo,
			ProjectTagRepo projectTagRepo,
			FeatureTagRepo featureTagRepo,
			BugTagRepo bugTagRepo,
			SolutionRepo solutionRepo
			) {
		this.userRepo = userRepo;
		this.projectRepo = projectRepo;
		this.userProjectRepo = userProjectRepo;
		this.featureRepo = featureRepo;
		this.taskRepo = taskRepo;
		this.bugRepo = bugRepo;
		this.tagRepo = tagRepo;
		this.projectTagRepo = projectTagRepo;
		this.featureTagRepo = featureTagRepo;
		this.bugTagRepo = bugTagRepo;
		this.solutionRepo = solutionRepo;
	}

	
	// [USER] service
	public User getUserById(Long user_id) {
		Optional<User> ou = userRepo.findById(user_id);
		if (ou.isPresent()) {
			return ou.get();
		} else {
			return null;
		}
	}
	public User getUserByEmail(String email) {
		return userRepo.findByEmail(email);
	}
	public User getUserByUsername(String username) {
		return userRepo.findByUsername(username);
	}
	public List<User> getUsersByProject(Long event_id) {
		Optional<Project> op = projectRepo.findById(event_id);
		if(op.isPresent()) {
			Project project = op.get();
			return project.getUsers();
		} else {
			return null;
		}
	}
	
	public User registerUser(User user) {
		String hashed = BCrypt.hashpw(user.getPassword(), BCrypt.gensalt());
		user.setPassword(hashed);
		return userRepo.save(user);
	}
	public boolean authenticateUser(String username, String password) {
		User user = userRepo.findByUsername(username); //instantiate user by email login to get/check password
		if(user==null) { // if user does not exist, log in is invalid
			return false;
		} else {
			if(BCrypt.checkpw(password,  user.getPassword())) { //checking user input password vs. hashed pw in DB
				return true;
			} else {
				return false;
			}
		}
	}
	
	
	public User saveUser(User user) {
		return userRepo.save(user);
	}
	public void deleteUser(User user) {
		userRepo.delete(user);
	}
	
	
	// [TAG] service
		public Tag getTagById(Long tag_id) {
			Optional<Tag> ot = tagRepo.findById(tag_id);
			if(ot.isPresent()) {
				return ot.get();
			} else {
				return null;
			}
		}
		
		public Tag saveTage(Tag tag) {
			return tagRepo.save(tag);
		}
		public void deleteTag(Tag tag) {
			tagRepo.delete(tag);
		}
		
	
	// [PROJECT] service
	public Project getProjectById(Long project_id) {
		Optional<Project> op = projectRepo.findById(project_id);
		if (op.isPresent()) {
			Project project = op.get();
			return project;
		} else {
			return null;
		}
	}
	
	public List<Project> getProjectsByUserId(Long user_id) {
		Optional<User> ou = userRepo.findById(user_id);
		if(ou.isPresent()) {
			User user = ou.get();
			return user.getProjects();
		} else {
			return null;
		}
	}
	
	public List<Project> getProjectsByProjectNameOrDescription(String string) {
		return projectRepo.findAllByProjectNameOrDescription(string);
	}
	
	public Project saveProject(Project project) {
		return projectRepo.save(project);
	}
	public void deleteProject(Project project) {
		projectRepo.delete(project);
	}
	
	
	// [USERPROJECT] service
	public UserProject getUserProject (Long user_id, Long project_id) {
		return userProjectRepo.findUserProject(user_id, project_id);
	}
	
	public UserProject saveUserProject(UserProject userProject) {
		return userProjectRepo.save(userProject);
	}
	public void deleteUserProject(UserProject userProject) {
		userProjectRepo.delete(userProject);
	}

	
	// [PROJECTTAG] service
	public ProjectTag getProjectTag(Long project_id, Long tag_id) {
		return projectTagRepo.findProjectTag(project_id, tag_id);
	}
	
	public ProjectTag saveProjectTag(ProjectTag projectTag) {
		return projectTagRepo.save(projectTag);
	}
	public void deleteProjectTag(ProjectTag projectTag) {
		projectTagRepo.delete(projectTag);
	}

	
	
	// [FEATURE] service
	public Feature getFeatureById(Long feature_id) {
		Optional<Feature> of = featureRepo.findById(feature_id);
		if(of.isPresent()) {
			return of.get();
		} else {
			return null;
		}
	}
	public List<Feature> getFeaturesByProjectId(Long project_id) {
		Optional<Project> op = projectRepo.findById(project_id);
		if (op.isPresent()) {
			Project project = op.get();
			return project.getFeatures();
		} else {
			return null;
		}
	}
	
	public List<Feature> getFeaturesByNameOrDescriptionOrNotes(String string) {
		return this.featureRepo.findAllFeaturesByNameOrDescOrNotes(string);
	}
	
	public List<Feature> getFeaturesByProjectOrderPriorityDesc(Long project_id){
		return this.featureRepo.findAllByProjectAndCompletedOrderByPriorityDesc(project_id);
	}
	public List<Feature> getFeaturesByProjectOrderPriorityAsc(Long project_id){
		return this.featureRepo.findAllByProjectAndCompletedOrderByPriorityAsc(project_id);
	}
	
	public Feature saveFeature(Feature feature) {
		return featureRepo.save(feature);
	}
	public void deleteFeature(Feature feature) {
		featureRepo.delete(feature);
	}
	
	
	// [FEATURETAG] service
	public FeatureTag getFeatureTag(Long feature_id, Long tag_id) {
		return featureTagRepo.findFeatureTag(feature_id, tag_id);
	}
	
	public FeatureTag saveFeatureTag(FeatureTag featureTag) {
		return featureTagRepo.save(featureTag);
	}
	public void deleteFeatureTag(FeatureTag featureTag) {
		featureTagRepo.delete(featureTag);
	}
	
	// [TASK] service

	public List<Task> getTasksByDateDesc(Long feature_id) {
		return taskRepo.findAllOrderByCreatedAtDesc(feature_id);
	}
	public List<Task> getTasksByDateAsc(Long feature_id) {
		return taskRepo.findAllOrderByCreatedAtAsc(feature_id);
	}
	public List<Task> getTasksByNotesOrDescription(String string) {
		return taskRepo.findAllByNotesOrDescription(string);
	}
	
	public List<Task> getTasksByFeatureOrderByPriorityDesc(Long feature_id) {
		return taskRepo.findAllByFeatureAndCompletedOrderByPriorityDesc(feature_id);
	}
	public List<Task> getTasksByFeatureOrderByPriorityAsc(Long feature_id) {
		return taskRepo.findAllByFeatureAndCompletedOrderByPriorityAsc(feature_id);
	}
	
	public Task saveTask(Task task) {
		return taskRepo.save(task);
	}
	public void deleteTask(Task task) {
		taskRepo.delete(task);
	}
	
	
	// [BUG] service
	public Bug getBugById(Long bug_id) {
		Optional<Bug> ob = bugRepo.findById(bug_id);
		if(ob.isPresent()) {
			return ob.get();
		} else {
			return null;
		}
	}
	
	public List<Bug> getBugsByBugDescOrErrorMsgOrNotes(String string) {
		return bugRepo.findAllByBugDescOrErrorMsgOrNotes(string);
	}
	
	public Bug saveBug(Bug bug) {
		return bugRepo.save(bug);
	}
	public void deleteBug(Bug bug) {
		bugRepo.delete(bug);
	}
	
	
	
	// [BUGTAG] service
	public BugTag getBugTag(Long bug_id, Long tag_id) {
		return bugTagRepo.findBugTag(bug_id, tag_id);
	}
	
	public BugTag saveBugTag(BugTag bugTag) {
		return bugTagRepo.save(bugTag);
	}
	public void deleteBugTag(BugTag bugTag) {
		bugTagRepo.delete(bugTag);
	}
	
	
	
	// [SOLUTION] service
	public Solution getSolutionById(Long solution_id) {
		Optional<Solution> os = solutionRepo.findById(solution_id);
		if(os.isPresent()) {
			return os.get();
		} else {
			return null;
		}
	}
	
	public Solution saveSolution(Solution solution) {
		return solutionRepo.save(solution);
	}
	public void deleteSolution(Solution solution) {
		solutionRepo.delete(solution);
	}
	
	
	
	
	
	
	
	
}
