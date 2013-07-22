Todo1::Admin.controllers :items do
  get :index do
    @title = "Items"
    @items = Item.all
    render 'items/index'
  end

  get :new do
    @title = pat(:new_title, :model => 'item')
    @item = Item.new
    render 'items/new'
  end

  post :create do
    @item = Item.new(params[:item])
    if (@item.save rescue false)
      @title = pat(:create_title, :model => "item #{@item.id}")
      flash[:success] = pat(:create_success, :model => 'Item')
      params[:save_and_continue] ? redirect(url(:items, :index)) : redirect(url(:items, :edit, :id => @item.id))
    else
      @title = pat(:create_title, :model => 'item')
      flash.now[:error] = pat(:create_error, :model => 'item')
      render 'items/new'
    end
  end

  get :edit, :with => :id do
    @title = pat(:edit_title, :model => "item #{params[:id]}")
    @item = Item[params[:id]]
    if @item
      render 'items/edit'
    else
      flash[:warning] = pat(:create_error, :model => 'item', :id => "#{params[:id]}")
      halt 404
    end
  end

  put :update, :with => :id do
    @title = pat(:update_title, :model => "item #{params[:id]}")
    @item = Item[params[:id]]
    if @item
      if @item.modified! && @item.update(params[:item])
        flash[:success] = pat(:update_success, :model => 'Item', :id =>  "#{params[:id]}")
        params[:save_and_continue] ?
          redirect(url(:items, :index)) :
          redirect(url(:items, :edit, :id => @item.id))
      else
        flash.now[:error] = pat(:update_error, :model => 'item')
        render 'items/edit'
      end
    else
      flash[:warning] = pat(:update_warning, :model => 'item', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy, :with => :id do
    @title = "Items"
    item = Item[params[:id]]
    if item
      if item.destroy
        flash[:success] = pat(:delete_success, :model => 'Item', :id => "#{params[:id]}")
      else
        flash[:error] = pat(:delete_error, :model => 'item')
      end
      redirect url(:items, :index)
    else
      flash[:warning] = pat(:delete_warning, :model => 'item', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy_many do
    @title = "Items"
    unless params[:item_ids]
      flash[:error] = pat(:destroy_many_error, :model => 'item')
      redirect(url(:items, :index))
    end
    ids = params[:item_ids].split(',').map(&:strip).map(&:to_i)
    items = Item.where(:id => ids)
    
    if items.destroy
    
      flash[:success] = pat(:destroy_many_success, :model => 'Items', :ids => "#{ids.to_sentence}")
    end
    redirect url(:items, :index)
  end
end
