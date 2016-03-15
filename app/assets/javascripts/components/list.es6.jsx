class List extends React.Component {
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

    let posts;
    if (typeof this.props.newslist !== undefined && this.props.newslist.length > 0)
    {
      posts = this.props.newslist.map(function(post) {
        return (
          <News post={post} can_stats={can_stats} updateData={update} key={post.news.id} />
        );
      });
    } else {
      posts = <p>No news are available</p>;
    }

    let addNew;
    if (this.props.can_add) {
      addNew = <NewNews show={false} updateData={update} />
    }

    let showStats;
    if (this.props.can_stats)
      showStats = <Statistics data={this.props.newslist}/>;

    return (
      <div>
        <section className="news">
          <h2>News</h2>
          {posts}
          {addNew}
        </section>
        {showStats}
      </div>
    );
  }
}
