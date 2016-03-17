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

  handleSearch(search) {
    $.ajax({
      url: '/',
      dataType: 'json',
      data: {
        start_date: search.start_date,
        end_date: search.end_date,
        status: search.status,
        text: search.text,
        commit: 'Search'
      },
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
    let search = this.handleSearch.bind(this);

    let showStats;
    if (this.props.can_stats)
      showStats = <Statistics ref="stats" lastUpdate={new Date} />;

    return (
      <div ref="main">
        <Search ref="search" can_stats={can_stats} updateData={search} />
        <Feed ref="feed" newslist={this.state.newslist} can_stats={can_stats} can_add={can_add} updateData={update} />
        {showStats}
      </div>
    );
  }
}
