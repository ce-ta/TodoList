class ListsController < ApplicationController
    before_action :set_list, only:[:show, :edit, :update, :destroy]
    before_action :authorize_user!, only: [:update, :destroy]

    def new
        @list = List.new 
    end

    def create
        @list = current_user.lists.build(list_params)

        if  @list.content.blank? || !@list.valid?
            flash[:alert] ="リストの作成に失敗しました"
            render :new

        else
            @list.save
            flash[:notice] = "リストを作成しました"
            redirect_to lists_path
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
        if  @list.content.blank? || !@list.valid?
            flash[:alert] = "リストの更新に失敗しました"
            render edit_list_path
        else
          @list.update(list_params)
          flash[:notice] = "リストを更新しました"
          redirect_to lists_path
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
