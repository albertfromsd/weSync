package com.codingdojo.dumbassassin.controllers;

import java.util.List;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.codingdojo.dumbassassin.models.Bug;
import com.codingdojo.dumbassassin.models.Feature;
import com.codingdojo.dumbassassin.models.Project;
import com.codingdojo.dumbassassin.models.Task;
import com.codingdojo.dumbassassin.models.User;
import com.codingdojo.dumbassassin.models.UserProject;
import com.codingdojo.dumbassassin.services.DAService;
import com.codingdojo.dumbassassin.validators.UserValidator;

@Controller
public class DAController {
	private final DAService service;
	private final UserValidator userValidator;
	
	public DAController(DAService service, UserValidator userValidator) {
		this.service = service;
		this.userValidator = userValidator;
	}
	
	@RequestMapping(value="/regLogin")
	public String regLogin(
			@ModelAttribute("user") User user
			) {
		
		return "da_reglogin.jsp";
	}
	
	@PostMapping(value="/register")
	public String register(
			@Valid @ModelAttribute("user") User user, 
			BindingResult result,
			RedirectAttributes redirectAttributes,
			HttpSession session) {
		
		userValidator.validate(user, result);
		if(result.hasErrors()) {
			return "da_reglogin.jsp";
		} else {
			User u = service.registerUser(user);
			session.setAttribute("user_id", u.getId());
			session.setAttribute("email", u.getEmail());
			return "redirect:/dashboard";
		}
	}
	
	@PostMapping(value="/login")
	public String loginUser(
			@RequestParam("username") String username,
			@RequestParam("password") String password,
			RedirectAttributes redirectAttributes,
			Model model,
			HttpSession session) {
		boolean validLogin = service.authenticateUser(username, password);
		if (validLogin) {
			User user = service.getUserByUsername(username);
			session.setAttribute("user", user);		
			session.setAttribute("user_id", user.getId());
			session.setAttribute("email", user.getEmail());
			return "redirect:/dashboard";
		} else {
			redirectAttributes.addFlashAttribute("error", "Username and password do not match");
			return "redirect:/regLogin";
		}
	}
	
	@GetMapping(value="/dashboard")
	public String dashboard(
			@ModelAttribute("project") Project project,
			HttpSession session,
			Model model
			) {
		Long user_id = (Long)session.getAttribute("user_id");
		User user = service.getUserById(user_id);
		model.addAttribute("user", user);
		List<Project> projects = user.getProjects();
		model.addAttribute("projects", projects);
		
		return "/da_dashboard.jsp";
	}
	
	@GetMapping(value="/newProject")
	public String newProject(
			HttpSession session,
			Model model,
			@ModelAttribute("project") Project project
			
			) {
		User user = service.getUserById((Long)session.getAttribute("user_id"));
		model.addAttribute("user", user);
		
		return "new_project.jsp";
	}
	
	@PostMapping(value="/createProject")
	public String createProject (
			HttpSession session,
			Model model,
			@Valid @ModelAttribute("project") Project project,
			BindingResult result,
			RedirectAttributes redirectAttributes
			) {
		User user = service.getUserById((Long)session.getAttribute("user_id"));
		model.addAttribute("user", user);
		
		service.saveProject(project);
		UserProject up = new UserProject();
		up.setUser(user);
		up.setProject(project);
		service.saveUserProject(up);

		redirectAttributes.addFlashAttribute("success", "Project sucessfully created!");
		return "redirect:/dashboard";
	}
	
	
	@GetMapping(value="/projects/{project_id}")
	public String projectDetails(
			@PathVariable("project_id") Long project_id,
			@ModelAttribute("feature") Feature feature,
			Model model,
			HttpSession session
			) {
		
		Project project = service.getProjectById(project_id);
		model.addAttribute("project", project);
		
		List<Feature> ascFeatures = service.getFeaturesByProjectOrderPriorityAsc(project_id);
		model.addAttribute("ascFeatures", ascFeatures);
		
		List<Feature> descFeatures = service.getFeaturesByProjectOrderPriorityDesc(project_id);
		model.addAttribute("descFeatures", descFeatures);
		
		User user = service.getUserById((Long)session.getAttribute("user_id"));
		model.addAttribute("user", user);
		
		return "details_project.jsp";
	}
	
	@PostMapping(value="projects/{project_id}/edit/projectname")
	public String editProjectName(
			@PathVariable("project_id") Long project_id,
			@RequestParam("projectname") String projectName,
			HttpSession session
			) {
		Project p = service.getProjectById(project_id);
		p.setProjectName(projectName);
		service.saveProject(p);
		
		return "redirect:/projects/" + project_id;
	}
	
	@PostMapping(value="/projects/{project_id}/edit/description")
	public String editProjectDescription(
			@RequestParam("description") String description,
			@PathVariable("project_id") Long project_id
			) {
		Project project = service.getProjectById(project_id);
		project.setDescription(description);
		service.saveProject(project);
		
		return "redirect:/projects/" + project_id;
	}
	
	@PostMapping(value="/projects/{project_id}/edit/shared")
	public String editProjectShared(
			@RequestParam("shared") String shared,
			@PathVariable("project_id") Long project_id
			) {
		
			Project p = service.getProjectById(project_id);
			if(shared.equals("sharedFalse")) {
				p.setShared(false);
				service.saveProject(p);
				
				return "redirect:/dashboard";
			}
			if(shared.equals("sharedTrue")) {
				p.setShared(true);
				service.saveProject(p);
				
				return "redirect:/dashboard";
			}
			
			//coming from edit/details page
			if(shared.equals("editSharedFalse")) {
				p.setShared(false);
				service.saveProject(p);
				
				return "redirect:/projects/"+project_id;
			}
			if(shared.equals("editSharedTrue")) {
				p.setShared(true);
				service.saveProject(p);
				
				return "redirect:/projects/"+project_id;
			}
		
			return "redirect:/projects/"+project_id;
	}

	@PostMapping(value="/projects/{project_id}/completion")
	public String projectCompletion(
			@PathVariable("project_id") Long project_id,
			@RequestParam("completion") String completion,
			HttpSession session
			) {
		System.out.println(completion);
		Project p = service.getProjectById(project_id);
		if(completion.equals("reopen")) {
			p.setCompleted(false);
			service.saveProject(p);
			
			return "redirect:/dashboard";
		}
		if(completion.equals("markComplete")) {
			p.setCompleted(true);
			service.saveProject(p);
			
			return "redirect:/dashboard";
		}
		
		//coming from edit/details page
		if(completion.equals("editReopen")) {
			p.setCompleted(false);
			service.saveProject(p);
			
			return "redirect:/projects/"+project_id;
		}
		if(completion.equals("editMarkComplete")) {
			p.setCompleted(true);
			service.saveProject(p);
			
			return "redirect:/projects/"+project_id;
		}
		
		return "redirect:/dashboard";
	}
	
	
	@PostMapping(value="/projects/{project_id}/createFeature")
	public String createFeature(
			@PathVariable("project_id") Long project_id,
			@Valid @ModelAttribute("feature") Feature feature,
			BindingResult result,
			HttpSession session
			) {
		
		Project project = service.getProjectById(project_id);
		feature.setProject(project);
		service.saveFeature(feature);
		
		return "redirect:/projects/" + project_id;
	}
	
	@GetMapping(value="/projects/{project_id}/delete")
	public String deleteProjectConfirmation(
			@PathVariable("project_id") Long project_id,
			Model model,
			HttpSession session
			) {
		User user = service.getUserById((Long)session.getAttribute("user_id"));
		model.addAttribute("user", user);
		Project project = service.getProjectById(project_id);
		model.addAttribute("project", project);
		
		
		return "delete_item.jsp";
	}
	
	@DeleteMapping(value="/projects/{project_id}/delete")
	public String deleteProject(
			@PathVariable("project_id") Long project_id
			) {
		Project project = service.getProjectById(project_id);
		service.deleteProject(project);
		
		return "redirect:/dashboard";
	}
	
/////////////////////////////////
/// [END] PROJECTS CONTROLLER ///
/////////////////////////////////

	
/////////////////////////////////
/// [TOP] FEATURES CONTROLLER ///
/////////////////////////////////
	@GetMapping(value="projects/{project_id}/features/{feature_id}")
	public String featureDetails(
			@PathVariable("project_id") Long project_id,
			@PathVariable("feature_id") Long feature_id,
			HttpSession session,
			Model model
			) {
		User user = service.getUserById((Long)session.getAttribute("user_id"));
		model.addAttribute("user", user);
		
		Feature feature = service.getFeatureById(feature_id);
		model.addAttribute("feature", feature);
		
		Project project = service.getProjectById(project_id);
		model.addAttribute("project", project);
		
		List<Task> tasks = service.getTasksByDateDesc(feature_id);
		session.setAttribute("tasks", tasks);
		model.addAttribute("tasks", (List<Task>)session.getAttribute("tasks"));
		
		List<Feature> ascFeatures = service.getFeaturesByProjectOrderPriorityAsc(project_id);
		model.addAttribute("ascFeatures", ascFeatures);
		
		List<Feature> descFeatures = service.getFeaturesByProjectOrderPriorityDesc(project_id);
		model.addAttribute("descFeatures", descFeatures);
		
		return "details_feature.jsp";
	}
	
	@PostMapping(value="projects/{project_id}/features/{feature_id}/editFeature")
	public String editFeatureName(
			@PathVariable("project_id") Long project_id,
			@PathVariable("feature_id") Long feature_id,
			@RequestParam("featureName") String featureName,
			@RequestParam("description") String description,
			@RequestParam("notes") String notes,
			@RequestParam("subjectFiles") String subjectFiles,
			@RequestParam("priority") Integer priority,
			HttpSession session,
			Model model,
			RedirectAttributes redirectAttributes
			) {
		Feature f = service.getFeatureById(feature_id);
		if(featureName.length()==0 || featureName == null) {
			featureName = " ";
		}
		f.setFeatureName(featureName);
		
		if(description.length()==0 || description == null) {
			description = " ";
		}
		f.setDescription(description);
		
		if(notes.length()==0 || notes == null) {
			notes = " ";
		}
		f.setNotes(notes);
		
		if(subjectFiles.length()==0 || subjectFiles == null) {
			subjectFiles = " ";
		}
		f.setSubjectFiles(subjectFiles);
		
		if(priority == null) {
			priority = (Integer) 0;
		}
		f.setPriority(priority);
		
		service.saveFeature(f);
		
		redirectAttributes.addFlashAttribute("success", "Feature was successfully edited");
		return "redirect:/projects/"+project_id+"/features/" + feature_id;
	}
	
	@PostMapping(value="/projects/{project_id}/features/{feature_id}/completion")
	public String featureCompletion(
			@PathVariable("project_id") Long project_id,
			@PathVariable("feature_id") Long feature_id,
			@RequestParam("completion") String completion,
			HttpSession session
			) {
		Feature f = service.getFeatureById(feature_id);
		if(completion.equals("reopen")) {
			f.setCompleted(false);
			service.saveFeature(f);
			
			return "redirect:/dashboard";
		}
		if(completion.equals("markComplete")) {
			f.setCompleted(true);
			service.saveFeature(f);
			
			return "redirect:/dashboard";
		}
		
		//coming from edit/details page
		if(completion.equals("editReopen")) {
			f.setCompleted(false);
			service.saveFeature(f);
			
			return "redirect:/projects/"+project_id+"/features/"+feature_id;
		}
		if(completion.equals("editMarkComplete")) {
			f.setCompleted(true);
			service.saveFeature(f);
			
			return "redirect:/projects/"+project_id+"/features/"+feature_id;
		}
		
		return "redirect:/dashboard";
	}
	
	
	@DeleteMapping(value="/projects/{project_id}/features/{feature_id}")
	public String deleteFeature(
			@PathVariable("project_id") Long project_id,
			@PathVariable("feature_id") Long feature_id
			) {
		Feature feature = service.getFeatureById(feature_id);
		service.deleteFeature(feature);
		
		return "redirect:/projects/"+project_id;
	}
	
/////////////////////////////
/// [TOP] TASK CONTROLLER ///
/////////////////////////////
	
	@PostMapping(value="/projects/{project_id}/features/{feature_id}/createtask")
	public String createTask(
			@PathVariable("project_id") Long project_id,
			@PathVariable("feature_id") Long feature_id,
			@RequestParam("description") String description,
			@RequestParam("notes") String notes,
//			@RequestParam("priority") Integer priority,
			@RequestParam("subjectFiles") String subjectFiles,
			Model model,
			HttpSession session,
			RedirectAttributes redirectAttributes
			) {
		System.out.println("create task enetered");
		Task t = new Task();
		Feature f = service.getFeatureById(feature_id);
		t.setFeature(f);
		
		if(description.length()==0 || description == null) {
			redirectAttributes.addFlashAttribute("descError", "Description is the only required field");
			return "redirect:/projects/"+project_id+"/features/"+feature_id;
		}
		t.setDescription(description);
		
		if(notes.length()==0  || notes == null) {
			notes =" ";
		}
		t.setNotes(notes);
		
		if(subjectFiles.length()==0 || subjectFiles == null) {
			subjectFiles = " ";
		}
		t.setSubjectFiles(subjectFiles);
		
//		if(priority == null) {
//			priority = 1;
//		}
//		t.setPriority(priority);
		
		service.saveTask(t);
		
		return "redirect:/projects/" + project_id +"/features/"+feature_id;
	}
	
////////////////////////////
/// [TOP] BUG CONTROLLER ///
////////////////////////////
	
	@PostMapping(value="/projects/{project_id}/features/{feature_id}/createbug")
	public String createBug(
			@PathVariable("project_id") Long project_id,
			@PathVariable("feature_id") Long feature_id,
			@RequestParam("bugDesc") String bugDesc,
			@RequestParam("notes") String notes,
			@RequestParam("errorMsg") String errorMsg,
			Model model,
			HttpSession session,
			RedirectAttributes redirectAttributes
			) {
		Bug b = new Bug();
		Feature f = service.getFeatureById(feature_id);
		b.setFeature(f);
		
		if(bugDesc.length()==0 || bugDesc == null) {
			redirectAttributes.addFlashAttribute("descError", "Description is required");
			return "redirect:/projects/"+project_id+"/features/"+feature_id;
		}
		b.setBugDesc(bugDesc);
		
		if(notes.length()==0  || notes == null) {
			notes =" ";
		}
		b.setNotes(notes);
		
		if(errorMsg.length()==0 || errorMsg == null) {
			errorMsg = " ";
		}
		b.setErrorMsg(errorMsg);
		
		service.saveBug(b);
		
		return "redirect:/projects/" + project_id +"/features/"+feature_id;
	}

///////////////////////////////
/// [TOP] SEARCH CONTROLLER ///
///////////////////////////////
	@GetMapping(value="/search")
	public String searchForm(
			HttpSession session,
			Model model
			) {
		User user = service.getUserById((Long)session.getAttribute("user_id"));
		model.addAttribute("user", user);
		
		List<Project> srcProjects = (List<Project>)session.getAttribute("srcProjects");
		model.addAttribute("srcProjects", srcProjects);
		
		List<Feature> srcFeatures = (List<Feature>)session.getAttribute("srcFeatures");
		model.addAttribute("srcFeatures", srcFeatures);
		
		List<Task> srcTasks = (List<Task>)session.getAttribute("srcTasks");
		model.addAttribute("srcTasks", srcTasks);
		
		List<Bug> srcBugs = (List<Bug>)session.getAttribute("srcBugs");
		model.addAttribute("srcBugs", srcBugs);
		
		return "search.jsp";
	}
	
	@PostMapping(value="/search")
	public String searchResults(
			@RequestParam("search") String string,
			HttpSession session,
			Model model
			) {
		
		List<Project> srcProjects = service.getProjectsByProjectNameOrDescription(string);
		session.setAttribute("srcProjects", srcProjects);

		
		List<Feature> srcFeatures = service.getFeaturesByNameOrDescriptionOrNotes(string);
		session.setAttribute("srcFeatures", srcFeatures);
		
		List<Task> srcTasks = service.getTasksByNotesOrDescription(string);
		session.setAttribute("srcTasks", srcTasks);
		
		List<Bug> srcBugs = service.getBugsByBugDescOrErrorMsgOrNotes(string);
		session.setAttribute("srcBugs", srcBugs);
		
		
		return "redirect:/search";
	}
	
	
	
//////////////////////////////////
/// [TOP] UNIVERSAL CONTROLLER ///
//////////////////////////////////

	@GetMapping(value="/logout")
	public String logout (HttpSession session) {
		session.invalidate();
		return "redirect:/regLogin";
	}
	
	@GetMapping(value="/checkGetData/{feature_id}")
	public String checkGetData(
			@PathVariable("feature_id") Long feature_id,
			HttpSession session,
			Model model
			) {
		List<Task> tasks = service.getTasksByDateAsc(feature_id);
		session.setAttribute("tasks", tasks);
		model.addAttribute("tasks", (List<Task>)session.getAttribute("tasks"));
		for (Task t: tasks) {
			System.out.println(t.getDescription()+": "+t.getCreatedAt());
		}
		return "redirect:/dashboard";
	}
	
	@GetMapping(value="/checkGetData/{project_id}")
	public String checkPostData(
			@PathVariable("project_id") Long project_id,
			HttpSession session,
			Model model
			) {
		System.out.println("Checking get data");
		
		List<Feature> ascFeatures = service.getFeaturesByProjectOrderPriorityAsc(project_id);
		System.out.println(ascFeatures);
		
		List<Feature> descFeatures = service.getFeaturesByProjectOrderPriorityDesc(project_id);
		System.out.println(descFeatures);
//		
//		List<Project> srcProjects = service.getProjectsByProjectNameOrDescription("albert");
//		System.out.println("srcProjects: "+srcProjects);
//		for(Project p: srcProjects) {
//			System.out.println(p.getProjectName());
//		}
//	
//		List<Feature> srcFeatures = service.getFeaturesByNameOrDescriptionOrNotes("123");
//		System.out.println("srcFeatures: "+srcFeatures);
//		for (Feature f: srcFeatures) {
//			System.out.println("Feature Name: "+f.getFeatureName());
//			System.out.println("Shared status: "+f.getShared());
//		}
//		
//		List<Task> srcTasks = service.getTasksByNotesOrDescription("123");
//		System.out.println("srcTasks: "+srcTasks);
//		for (Task t: srcTasks) {
//			System.out.println(t.getDescription());
//		}
//		
//		List<Bug> srcBugs = service.getBugsByBugDescOrErrorMsgOrNotes("123");
//		System.out.println("srcBugs: "+srcBugs);
//		for (Bug b: srcBugs) {
//			System.out.println(b.getBugDesc());
//		}

		return "redirect:/regLogin";
	}
	
	
}
