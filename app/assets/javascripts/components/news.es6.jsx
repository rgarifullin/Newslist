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
