AppConfig = require 'shared/services/app_config.coffee'
Records   = require 'shared/services/records.coffee'
EventBus  = require 'shared/services/event_bus.coffee'

{ applyLoadingFunction } = require 'shared/helpers/apply.coffee'

$controller = ($rootScope, $timeout) ->
  EventBus.broadcast $rootScope, 'currentComponent', { titleKey: 'explore_page.header', page: 'explorePage'}

  @groupIds = []
  @resultsCount = 0
  @perPage = AppConfig.pageSize.exploreGroups
  @canLoadMoreGroups = true
  @query = ""
  $timeout -> document.querySelector('#search-field').focus()

  @groups = =>
    grs = Records.groups.find(@groupIds)
    for index, g of grs
      if g and  g.fullName == 'Asamblea General'
        asam = g
        grs.splice(index,1)
    if asam
      grs.unshift asam
    grs


  @handleSearchResults = (response) =>
    Records.groups.getExploreResultsCount(@query).then (data) =>
      @resultsCount = data.count
    @groupIds = @groupIds.concat _.pluck(response.groups, 'id')
    @canLoadMoreGroups = (response.groups || []).length == @perPage

  # changing the search term
  @search = =>
    @groupIds = []
    Records.groups.fetchExploreGroups(@query, per: @perPage).then(@handleSearchResults)
  applyLoadingFunction(@, 'search')
  @search()

  # clicking 'show more'
  @loadMore = =>
    Records.groups.fetchExploreGroups(@query, from: @groupIds.length, per: @perPage).then(@handleSearchResults)


  @groupCover = (group) ->
    { 'background-image': "url(#{group.coverUrl('small')})" }

  @groupDescription = (group) ->
    _.trunc group.description, 100 if group.description

  @showMessage = ->
    !@searching &&
    @query &&
    @groups().length > 0

  @searchResultsMessage = ->
    if @groups().length == 1
      'explore_page.single_search_result'
    else
      'explore_page.multiple_search_results'

  @noResultsFound = ->
    !@searching && (@groups().length < @perPage || !@canLoadMoreGroups)

  return

$controller.$inject = ['$rootScope', '$timeout']
angular.module('loomioApp').controller 'ExplorePageController', $controller
