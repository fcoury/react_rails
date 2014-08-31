# @cjsx React.DOM

ItemCheckbox = React.createClass
  handleChange: (event) ->
    @props.updateCallback
      id: @props.id
      checked: @refs.box.getDOMNode().checked

  render: ->
    <input type="checkbox" ref="box" checked={@props.checked} onChange={@handleChange} />

Main = React.createClass
  getInitialState: ->
    counter: 0
    items: [
      id: 1, description: "Todo 1", checked: false
    ]
    newItem: ""

  updateItem: (newData, callback) ->
    $.ajax
      type: "PUT"
      url: "/api/v1/todos/#{newData.id}"
      data: newData
      success: (data) ->
        items = @state.items
        for item in items
          if item.id == data.id
            item.checked = data.checked

        @setState items: items

  addItem: (event) ->
    $.ajax
      type: "POST"
      url: "/api/v1/todos"
      data: JSON.stringify({ description: @state.newItem })
      contentType: "application/json"
      dataType: "json"
      success: (data) ->
        tmp = @state.items
        tmp.push data # {id: -1, description: @state.newItem, checked: false}
        @setState
          items: tmp
          newItem: ""

  clicked: ->
    @setState counter: @state.counter + 1

  handleChange: (event) ->
    @setState newItem: event.target.value

  render: ->
    renderedItems = @state.items.map (i) =>
      <li>
        <ItemCheckbox id={i.id} checked={i.checked} updateCallback={@updateItem}/>
        {i.description}
      </li>

    <div>
      <div>
        <ul>
          {renderedItems}
        </ul>
        <input type="text" value={@state.newItem} onChange={@handleChange} />
        <button onClick={@addItem}>Add</button>
      </div>
      <span>Counter: {@state.counter}</span>
      <button onClick={@clicked}>Add</button>
    </div>

window.Main = Main
