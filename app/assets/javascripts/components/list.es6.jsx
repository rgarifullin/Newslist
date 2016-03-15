class List extends React.Component {
  render () {
    let can_stats = this.props.can_stats;
    let can_add = this.props.can_add;

    let posts = this.props.newslist.map(function(post) {
      return (
        <News post={post} can_stats={can_stats} key={post.news.id} />
      );
    });

    if (typeof posts !== undefined && posts.length > 0)
    {
      return (
        <div>
          <section className="news">
            <h2>News</h2>
            {posts}
          </section>
          <Statistics data={this.props.newslist}/>
        </div>
      );
    } else {
      return (
        <section className="news">
          <h2>News</h2>
          <p>No news are available</p>
        </section>
      )
    }
  }
}
