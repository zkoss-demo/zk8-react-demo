zk.afterMount(function () {
var zkbinder = zkbind.$('$content');

//react-bootstrap variables
var ButtonInput = ReactBootstrap.ButtonInput,
	Input = ReactBootstrap.Input,
	Panel = ReactBootstrap.Panel,
	Row = ReactBootstrap.Row,
	Col = ReactBootstrap.Col,
	ListGroupItem = ReactBootstrap.ListGroupItem,
	ListGroup = ReactBootstrap.ListGroup,
	Label = ReactBootstrap.Label,
	Well = ReactBootstrap.Well,
	PageHeader = ReactBootstrap.PageHeader;

var CommentBox = React.createClass({
  loadCommentsFromServer: function() {
		var self = this;
		//once comments change, doCommentsChange will be invoked with comments as arguments
		zkbinder.after('doCommentsChange', function (evt) {
			self.setState({data: evt});
		});
    
  },
  handleCommentSubmit: function(comment) {
    var comments = this.state.data;
    comments.push(comment);
    this.setState({data: comments}, function() {
    	//invoke doAddComment to update comments
    	zkbinder.command('doAddComment', comment);
    });
  },
  getInitialState: function() {
    return {data: []};
  },
  componentDidMount: function() {
    this.loadCommentsFromServer();
  },
  render: function() {
    return (
    	<div className="container">
        	<PageHeader>ZK8 Discussion Channel</PageHeader>
			<Panel bsStyle='info'>
				<CommentList data={this.state.data} />
		        <CommentForm onCommentSubmit={this.handleCommentSubmit} />
			</Panel>
		</div>
    );
  }
});

var CommentList = React.createClass({
  render: function() {
    var commentNodes = this.props.data.map(function(comment, index) {
      return (
        <Comment author={comment.author} key={index} index={index}>
          {comment.text}
        </Comment>
      );
    });
    return (
	  	<ListGroup>
	  		{commentNodes}
	  	</ListGroup>
    );
  }
});

var Comment = React.createClass({
	  render: function() {
	    var rawMarkup = marked(this.props.children.toString(), {sanitize: true});
	    var style = this.props.index % 2 == 0 ? 'info' : 'success';
	    return (
	      <ListGroupItem bsStyle={style}>
	        <h3>
		      {this.props.author}:  
	        </h3>
	        <Well>
	        	<span dangerouslySetInnerHTML={{__html: rawMarkup}} />
	        </Well>
	      </ListGroupItem>
	    );
	  }
});

var CommentForm = React.createClass({
	  getInitialState: function() {
		  return { disabled: true, author: null };
	  },
	  handleSubmit: function(e) {
	    e.preventDefault();
	    var author = this.state.author || this.refs.author.getValue().trim();
	    var text = this.refs.text.getValue().trim();
	    
	    this.props.onCommentSubmit({author: author, text: text});
	    //this.refs.author.getInputDOMNode().value = ''; //hide author input forever
	    this.refs.text.getInputDOMNode().value = '';
	    this.setState({disabled: true, author: author});
	  },
	  handleChange: function() {
		  var authorLen = this.state.author ? this.state.author.length : this.refs.author.getValue().trim().length;
		  var textLen = this.refs.text.getValue().trim().length;
		  if (authorLen > 0 && textLen > 0)
			  this.setState({disabled: false});
		  else
			  this.setState({disabled: true});
	  },
	  isAuthorExist: function() {
		  return this.state.author ? null : 
			  (<Input type="text" placeholder="Your name" ref="author" onChange={this.handleChange} />); 
	  },
	  render: function() {
	    return (
    		<form onSubmit={this.handleSubmit}>
    	      {this.isAuthorExist()}
    	      <Row>
    	      	<Col md={11}>
    	      		<Input type="text" placeholder="Say something..." ref="text" onChange={this.handleChange} />
    	      	</Col>
    	      	<Col md={1}>
    	      		<ButtonInput type="submit" value="Post" bsStyle="primary" bsSize="medium" disabled={this.state.disabled} />
    	      	</Col>
    	      </Row>
    	    </form>
	    );
	  }
});

React.render(
  <CommentBox />,
  document.getElementById('content')
);

});