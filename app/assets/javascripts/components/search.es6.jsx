class Search extends React.Component {
  constructor(props) {
    super(props);

    this.search = {};
  }

  handleChange(event) {
    switch(event.target.name)
    {
      case 'start_date':
        this.search.start_date = event.target.value;
        break;
      case 'end_date':
        this.search.end_date = event.target.value;
        break;
      case 'status':
        this.search.status = event.target.value;
        break;
      case 'text':
        this.search.text = event.target.value;
        break;
    }
    this.forceUpdate();

    this.props.updateData(
      {
        start_date: this.search.start_date,
        end_date: this.search.end_date,
        status: this.search.status,
        text: this.search.text
      }
    );
  }

  render() {
    let Input = ReactBootstrap.Input;
    let Button = ReactBootstrap.Button;
    let Select;
    if (this.props.can_stats)
      Select = <select className="form-control" onChange={handleChange} />

    let handleChange = this.handleChange.bind(this);

    let status;
    if (this.props.can_stats)
      status = <select className="form-control" name="status" onChange={handleChange}>
        <option value="all">All</option>
        <option value="readed">Readed</option>
        <option value="unreaded">Unreaded</option>
      </select>;

    return (
      <section className="search">
        <h3>Search</h3>
        <input className="date form-control" type="date" name="start_date" placeholder="Start date" onChange={handleChange} />
        <input className="date form-control" type="date" name="end_date" placeholder="End date" onChange={handleChange} />
        {status}
        <Input className="text" type="text" name="text" placeholder="Author or text" onChange={handleChange} />
      </section>
    );
  }
}
