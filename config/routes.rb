Rails.application.routes.draw do

  devise_for :users
  resources :books,only: [:index, :show, :edit, :create, :destroy, :update] do
   resources :book_comments,only: [:create, :destroy]
   resource :favorites,only: [:create, :destroy]
  end
  patch 'books/:id' => 'books#update', as: 'update_book'
  delete 'books/:id' => 'books#destroy', as: 'destroy_book'

  resources :users,only: [:index, :show, :edit, :update] do #投稿には、「新規投稿」「一覧」「詳細機能」「削除」「編集」「更新」しか使わないため
   resources :relationships, only: [:create, :destroy] do
      member do
        get 'following' => 'relationships#followings', as:'followings'#フォローされた方の情報を取得
        get 'followers' => 'relationships#followers', as:'followers'#フォローした方の情報を取得
      end
    end
  end
  patch 'users/:id' => 'users#update', as: 'update_user'

  get '/search', to: 'searches#search' #検索ボタンが押された時、Searchesコントローラーのsearchアクションが実行されるように定義しました。
  root to:"homes#top"
  get 'home/about'=>'homes#about' ,as:'about'

end
