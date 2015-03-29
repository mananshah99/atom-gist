AtomGistView = require './atom-gist-view'
Gist = require './gist'

module.exports =
  atomGistView: null

  initialize: ->
    @gist = null

  activate: (state) ->
    atom.workspaceView.command "atom-gist:toggle", => @gistFile()

  gistFile: ->
    @gist = new Gist;
    activeItem = atom.workspace.activePane.activeItem
    atom.workspaceView.statusBar?.appendLeft '<span class="gist-message">Creating gist...</span>'

    @gist.files[activeItem.getTitle()] =
     content: activeItem.getText()

    @gist.create (response) =>
      atom.confirm
          message: 'Copy gist link? '
          detailedMessage: response.html_url
          buttons:
            Yes: -> atom.clipboard.write(response.html_url)
            No: ->


        atom.workspaceView.statusBar?.find('.gist-message').remove()
