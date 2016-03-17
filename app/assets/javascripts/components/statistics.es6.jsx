class Statistics extends React.Component {
  constructor(props) {
    super(props);
    this.state = {};
    this.state.lastUpdate = props.lastUpdate;

    this.getData();
  }

  componentWillReceiveProps() {
    this.getData();
  }

  getData() {
    $.ajax({
      url: '/',
      dataType: 'json',
      success: function(data) {
        this.setState({ data: data.newslist }, function() {
          this.calculate(data.newslist);
        });
      }.bind(this),
      error: function(xhr, status, err) {
        console.error(this.props.url, status, err.toString());
      }.bind(this)
    });
  }

  calculate(data) {
    const MS_PER_DAY = 86400000;

    this.setState({ total: data.length });

    this.setState({ total_readed: 0 });
    for (let i = 0; i < data.length; i++) {
      if (data[i].status)
        this.setState(function(prevState) {
          return { total_readed: prevState.total_readed + 1 };
        });
    }

    today_beginning = new Date();
    today_beginning.setHours(0, 0, 0, 0);

    this.setState({ today: 0, readed_today: 0 });

    for (let i = 0; i < data.length; i++) {
      if (Date.parse(data[i].news.created_at) > Date.parse(today_beginning) &&
          Date.parse(data[i].news.created_at) < Date.parse(today_beginning) + MS_PER_DAY)
        this.setState(function(prevState) {
          return { today: prevState.today + 1 };
        });

      if (Date.parse(data[i].status.updated_at) > Date.parse(today_beginning) &&
          Date.parse(data[i].status.updated_at) < Date.parse(today_beginning) + MS_PER_DAY)
        this.setState(function(prevState) {
          return { readed_today: prevState.readed_today + 1 };
        });
    }
  }

  render() {
    return (
      <aside className="statistics" ref="stats_aside">
        <h2>Statistics</h2>
        <section>
          <p>Total news: { this.state.total }</p>
        </section>
        <section>
          <p>Readed news: { this.state.total_readed }</p>
        </section>
        <section>
          <p>Today's news: { this.state.today }</p>
        </section>
        <section>
          <p>Today's readed news: { this.state.readed_today }</p>
        </section>
      </aside>
    )
  }
}
