class Feed extends React.Component {
  handleChange() {
    this.props.updateData();
  }

  render () {
    let can_stats = this.props.can_stats;
    let can_add = this.props.can_add;
    let update = this.handleChange.bind(this);

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

    return (
      <section className="news">
        <h2>News</h2>
        {posts}
        {addNew}
      </section>
    );
  }
}
