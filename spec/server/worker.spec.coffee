Worker = require '../../app/src/server/worker'

describe 'Worker', ->
  it 'has a queue', ->
    jobs = {}
    logger = {}
    Worker.init jobs, logger
    expect(Worker.jobs).toBeDefined()

  it 'has a logger', ->
    jobs = {}
    logger = {}
    Worker.init jobs, logger
    expect(Worker.logger).toBeDefined()

  it 'assembles and creates a new job', ->
    jobs = {}
    type = 'holicray'
    data =
      text:'Lorem ipsum dolor sit amet'
      user:
        screen_name:'ConanObrien'
        profile_image_url:'http://placehold.it/90x90'

    spyOn Worker, 'createJob'
    Worker.assembleJob type, data, jobs
    expect(Worker.createJob).toHaveBeenCalled()


  it 'processes jobs if arduino is connected', ->

  it 'checks if the arduino client is connected', ->
    identity = 'arduino'
    Worker.present.arduino = true
    present = Worker.isPresent identity
    expect(present).toBeTruthy()

  it 'identifies the arduino client', ->
    socket =
      handshake:
        headers:
          'user-agent':'node.js'
    identity = Worker.identify socket
    expect(identity).toMatch 'arduino'

  it 'identifies a browser client', ->
    socket =
      handshake:
        headers:
          'user-agent':'browser'
    identity = Worker.identify socket
    expect(identity).toMatch 'browser'


  it 'contains 6 events', ->
    eventCount = Worker.events.length
    expect(eventCount).toEqual 6

  it 'contains the correct events', ->
    events = [
      'it snow'
      'the lights on the tree blink'
      'the stars light up'
      'the discoball spin'
      'the wacky man dance'
      'the foo bar baz'
    ]

    events.forEach (event, i) ->
      expect(Worker.events).toContain event


  it 'processes an incoming tweet', ->
    tweet = {}
    spyOn Worker, 'tally'
    spyOn Worker, 'random'
    spyOn Worker, 'assembleJob'
    Worker.assign tweet
    expect(Worker.tally).toHaveBeenCalled()
    expect(Worker.random).toHaveBeenCalled()
    expect(Worker.assembleJob).toHaveBeenCalled()


  it 'randomly assigns an event', ->
    event = Worker.random()
    expect(Worker.events.indexOf(event)).toBeTruthy()


  it 'increments the event tally', ->
    Worker.init {}, {}, 10
    preTally = Worker.eventTally
    Worker.tally()
    postTally = Worker.eventTally
    expect(postTally).toEqual(preTally + 1)

  it 'saves incoming tweets', ->
    tweet =
      text:'Lorem ipsum dolor sit amet'
      user:
        screen_name:'ConanObrien'
        profile_image_url:'http://placehold.it/90x90'

    spyOn Worker, 'assembleJob'
    Worker.assign tweet
    expect(Worker.assembleJob).toHaveBeenCalled()


