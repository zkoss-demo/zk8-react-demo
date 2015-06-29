/** ReactVM.java.

	Purpose:
		
	Description:
		
	History:
		10:15:57 AM Jun 23, 2015, Created by chunfu

Copyright (C) 2015 Potix Corporation. All Rights Reserved.
 */
package org.zkoss.blog.example;

import java.util.Collection;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.Map;

import org.zkoss.bind.BindUtils;
import org.zkoss.bind.annotation.BindingParam;
import org.zkoss.bind.annotation.Command;
import org.zkoss.bind.annotation.GlobalCommand;
import org.zkoss.bind.annotation.Init;
import org.zkoss.bind.annotation.NotifyChange;
import org.zkoss.bind.annotation.NotifyCommand;
import org.zkoss.bind.annotation.ToClientCommand;
import org.zkoss.bind.annotation.ToServerCommand;
import org.zkoss.zk.ui.Executions;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.EventQueue;
import org.zkoss.zk.ui.event.EventQueues;

/**
 * @author chunfu
 */
@NotifyCommand(value="doCommentsChange", onChange="_vm_.comments")
@ToClientCommand({"doAddComment", "doCommentsChange"})
@ToServerCommand({"doAddComment"})
public class ReactVM {

	private Collection<Comment> comments;
	private EventQueue<Event> commentQueue =  EventQueues.lookup("comment", EventQueues.APPLICATION, true);
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Init
	public void init() {
		comments = new LinkedList<Comment>();
		commentQueue.subscribe(new EventListener() {
			public void onEvent(Event event) throws Exception {
				if ("onAddComment".equals(event.getName())) {
					Map<String, Object> param = new HashMap<String, Object>();
					param.put("comment", event.getData());
					//trigger all instances to update comments
					BindUtils.postGlobalCommand(null, null, "refreshComments", param);
				}
			}
		});
	}
	
	@GlobalCommand
	@NotifyChange("comments")
	public void refreshComments(@BindingParam("comment") Comment comment) {
		//sync comments with other instances
		if (!comments.contains(comment))
			comments.add(comment);
	}
	
	@Command
	@NotifyChange("comments")
	public void doAddComment(@BindingParam("author") String author, @BindingParam("text") String text) {
		Comment c = new Comment(author, text);
		comments.add(c);
		commentQueue.publish(new Event("onAddComment", null, c));
	}
	
	public Collection<Comment> getComments() {
		return comments;
	}
	
	private class Comment {
		private String author;
		private String text;
		
		public Comment(String author, String text) {
			this.author = author;
			this.text = text;
		}

		public String getAuthor() {
			return author;
		}

		public void setAuthor(String author) {
			this.author = author;
		}

		public String getText() {
			return text;
		}

		public void setText(String content) {
			this.text = content;
		}
		
		public String toString() {
			return author + ", " + text;
		}
	}
}
