class @MongoCollection
  @_collection: undefined

  @find: (selector = {}, options = {}) ->
    @_collection.find(selector, options)

  @where: (selector = {}, options = {}) ->
    @find(selector, options).fetch()

  @all: (options = {}) ->
    @where({}, options)

  @first: (selector = {}, options = {}) ->
    @_collection.findOne(selector, options)

  @count: (selector = {}, options = {}) ->
    @find(selector, options).count()

  @insert: (doc, before_attrs = {}) ->
    @before_insert(doc, before_attrs)
    _id = @_collection.insert(doc)
    return _id

  @update: (selector = {}, modifier, before_attrs = {}) ->
    @before_update(modifier, before_attrs)
    @_collection.update(selector, modifier)

  @upsert: (selector = {}, modifier, before_update_attrs = {}, before_insert_attrs = {}) ->
    if @count(selector)
      @update(selector, modifier, before_update_attrs)
    else
      doc = modifier.$set or {}
      @insert(doc, before_insert_attrs)

  @batchInsert: (docs = []) ->
    @_collection.batchInsert(docs)

  @remove: (selector = {}) ->
    @_collection.remove(selector)

  @before_insert: (doc, before_attrs) ->
    # Always add createdAt and updatedAt
    doc.createdAt = moment().tz('America/New_York').format()
    doc.updatedAt = moment().tz('America/New_York').format()

    # Add any additional attrs
    _.extend(doc, before_attrs)

  @before_update: (modifier, before_attrs) ->
    modifier.$set = modifier.$set or {}

    # Always update updatedAt
    modifier.$set.updatedAt = moment().tz('America/New_York').format()

    # Add any additional attrs
    _.extend(modifier.$set, before_attrs)