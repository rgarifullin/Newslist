class NewNews extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      showModal: false,
      author: '',
      text: ''
    };

    this.open = this.open.bind(this);
    this.close = this.close.bind(this);
  }

  close() {
    this.setState({ showModal: false, author: '', text: '' });
  }

  open() {
    this.setState({ showModal: true });
  }

  handleChange(event) {
    switch(event.target.name)
    {
      case 'author':
        this.setState({author: event.target.value });
        break;
      case 'text':
        this.setState({text: event.target.value });
        break;
    }
  }

  save() {
    $.ajax({
      url: '/news',
      method: 'POST',
      dataType: 'json',
      data: {
        news: {
          author: this.state.author,
          text: this.state.text
        }
      },
      success: function(data) {
        this.props.updateData();
        this.setState({ showModal: false, author: '', text: '' });
      }.bind(this),
      error: function(xhr, status, err) {
        console.error(status, err.toString());
      }.bind(this)
    });
  }

  render() {
    let Button = ReactBootstrap.Button;
    let Input = ReactBootstrap.Input;
    let Modal = ReactBootstrap.Modal;

    let handleChange = this.handleChange.bind(this);

    return (
      <div className="modalForm">
        <Button className="btn-success" onClick={this.open}>
          Add news
        </Button>

        <Modal show={this.state.showModal} onHide={this.close}>
          <Modal.Header closeButton>
            <Modal.Title className="text-center">Add new news</Modal.Title>
          </Modal.Header>
          <Modal.Body>
            <hr />
            <Input type="text" value={this.state.author} name="author" placeholder="Author name" onChange={handleChange} />
            <Input type="textarea" value={this.state.text} name="text" placeholder="Text of news" onChange={handleChange} />
          </Modal.Body>
          <Modal.Footer>
            <Button onClick={this.close}>Close</Button>
            <Button onClick={this.save.bind(this)} className="btn-success">Save</Button>
          </Modal.Footer>
        </Modal>
      </div>
    );
  }
}
