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

class News extends React.Component {
  handleClick(id, status) {
    $.ajax({
      url: '/news/' + id + '/change_status',
      method: 'PATCH',
      dataType: 'json',
      success: function(statusData) {
        $.ajax({
          url: '/',
          dataType: 'json',
          success: function(data) {
            let newState = this.props.post;
            newState.status = statusData.status;
            this.setState({post: newState});
          }.bind(this),
          error: function(xhr, status, err) {
            console.error(this.props.url, status, err.toString());
          }.bind(this)
        });
      }.bind(this),
      error: function(xhr, status, err) {
        console.error(this.props.url, status, err.toString());
      }.bind(this)
    });
  }

  render() {
    let button;
    if (this.props.can_stats) {
      let boundClick = this.handleClick.bind(this, this.props.post.news.id, this.props.post.status);
      if (this.props.post.status) {
        button = <button className="btn btn-sm btn-default" onClick={boundClick}>Unread</button>;
      } else {
        button = <button className="btn btn-sm btn-primary" onClick={boundClick}>Read</button>;
      }
    }

    return (
      <article>
        <p className="newstext">{this.props.post.news.text}</p>
        <footer className="news-footer">
          <p>{this.props.post.news.author} - </p>
          <time className="pubdate">{this.props.post.news.created_at}</time>
        </footer>
        {button}
      </article>
    )
  }
}

class Statistics extends React.Component {
  render() {
    let stats = {
      total: 0,
      total_readed: 0,
      today: 0,
      readed_today: 0,
      update: function(data) {
        const MS_PER_DAY = 86400000;

        this.total = data.length;

        this.total_readed = 0;
        for (let i = 0; i < data.length; i++) {
          if (data[i].status)
            ++this.total_readed;
        }

        today_beginning = new Date();
        today_beginning.setHours(0, 0, 0, 0);
        for (let i = 0; i < data.length; i++) {
          if (Date.parse(data[i].news.created_at) > Date.parse(today_beginning) &&
              Date.parse(data[i].news.created_at) < Date.parse(today_beginning) + MS_PER_DAY)
            ++this.today;

          if (Date.parse(data[i].status.updated_at) > Date.parse(today_beginning) &&
              Date.parse(data[i].status.updated_at) < Date.parse(today_beginning) + MS_PER_DAY)
            ++this.readed_today;
        }
      }
    };
    stats.update(this.props.data);

    return (
      <aside className="statistics">
        <h2>Statistics</h2>
        <section>
          <p>Total news: { stats.total }</p>
        </section>
        <section>
          <p>Readed news: { stats.total_readed }</p>
        </section>
        <section>
          <p>Today's news: { stats.today }</p>
        </section>
        <section>
          <p>Today's readed news: { stats.readed_today }</p>
        </section>
      </aside>
    )
  }
}
