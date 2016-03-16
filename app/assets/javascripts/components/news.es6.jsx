class News extends React.Component {
  handleClick(id, status) {
    $.ajax({
      url: '/news/' + id + '/change_status',
      method: 'PATCH',
      dataType: 'json',
      success: function(statusData) {
        let newState = this.props.post;
        newState.status = statusData.status;
        this.props.updateData();
      }.bind(this),
      error: function(xhr, status, err) {
        console.error(this.props.url, status, err.toString());
      }.bind(this)
    });
  }

  formatDate(date) {
    let parsed = new Date(date).toString().split(" ");

    let monthDay = parsed.slice(1, 3).join(" ");
    let year = parsed.slice(3, 4).join(" ");
    let time = parsed.slice(4, 5).join().substring(0, 5);

    return monthDay + ", " + year + " " + time;
  }

  render() {
    let button;
    if (this.props.can_stats) {
      let boundClick = this.handleClick.bind(this, this.props.post.news.id, this.props.post.status);
      if (this.props.post.status) {
        button = <button ref="read"className="btn btn-sm btn-default" onClick={boundClick}>Unread</button>;
      } else {
        button = <button ref="read" className="btn btn-sm btn-primary" onClick={boundClick}>Read</button>;
      }
    }

    return (
      <article>
        <p ref="text" className="newstext">{this.props.post.news.text}</p>
        <footer className="news-footer">
          <p ref="author">{this.props.post.news.author} - </p>
          <time ref="pubtime" className="pubdate">{this.formatDate(this.props.post.news.created_at)}</time>
        </footer>
        {button}
      </article>
    )
  }
}
