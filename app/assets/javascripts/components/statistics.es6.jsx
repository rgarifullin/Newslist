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
      <aside className="statistics" ref="stats_aside">
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
