class ListsController < ApplicationController
    before_action :set_list, only:[:show, :edit, :update, :destroy]
    before_action :authorize_user!, only: [:update, :destroy]

    def new
        @list = List.new 
    end

    def create
      @list = current_user.lists.build(list_params)
    
      if @list.save
        respond_to do |format|
          format.html { redirect_to lists_path, notice: 'リストが追加されました。' }
        end
      else
        respond_to do |format|
          if @list.content.blank?
            format.html { redirect_to lists_path, alert: '1文字以上入力してください' }
          elsif @list.content.length > 30
            format.html { redirect_to lists_path, alert: '30文字以内で入力してください' }
          end
        end
      end
    end

    def index
        @lists = current_user.lists
    end

    def show
    end

    def edit
    end

    def update
      if @list.update(list_params)
        respond_to do |format|
          format.html { redirect_to lists_path, notice: 'リストが更新されました。' }
        end
      else
        respond_to do |format|
          if @list.content.blank?
            format.html { redirect_to lists_path, alert: '1文字以上入力してください' }
          elsif @list.content.length > 30
            format.html { redirect_to lists_path, alert: '30文字以内で入力してください' }
          end
        end
      end
    end
    def destroy
        if @list.destroy
            flash[:notice] = "リストを削除しました"
            redirect_to lists_path
        else
            flash[:alert] = "リストの削除に失敗しました"
            render lists_path
        end
    end

    private

    def set_list
        @list = current_user.lists.find(params[:id])
    end
    
    def authorize_user!
        unless @list.user == current_user
          flash[:alert] = "あなたにはこの操作を行う権限がありません。"
          redirect_to new_session_path
        end
    end

    def list_params
        params.require(:list).permit(:content)
    end
end
