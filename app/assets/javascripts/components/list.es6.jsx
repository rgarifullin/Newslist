class List extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      newslist: this.props.newslist
    };
  }

  handleUpdateData() {
    $.ajax({
      url: '/',
      dataType: 'json',
      success: function(data) {
        this.setState({newslist: data.newslist});
      }.bind(this),
      error: function(xhr, status, err) {
        console.error(this.props.url, status, err.toString());
      }.bind(this)
    });
  }

  render () {
    let can_stats = this.props.can_stats;
    let can_add = this.props.can_add;
    let update = this.handleUpdateData.bind(this);

    let addNew;
    if (this.props.can_add) {
      addNew = <NewNews show={false} updateData={update} />
    }

    let showStats;
    if (this.props.can_stats)
      showStats = <Statistics data={this.state.newslist}/>;

    return (
      <div>
        <Feed newslist={this.state.newslist} can_stats={can_stats} can_add={can_add} updateData={update} />
        {showStats}
      </div>
    );
  }
}
