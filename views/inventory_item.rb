<h1>This is a <%= @item[:type] %> </h1>
<div class="item_description">
  <p><%= @item[:detail] %></p>
  <a 
    class="btn btn-secondary" 
    role="button" 
    href="/rooms/<%= @room_id%>/items/<%= @item[:id] %>/take">
    Drop
  </a>
</div>