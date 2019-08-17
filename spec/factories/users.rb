FactoryBot.define do
    #管理者
    factory :admin_user, class: User do
        name {'admin'}
        email{'admin@com'}
        password{'aaaaaa'}
        admin{true}
        activated{true}
    end
    #有効化済み一般ユーザー
    factory :active_user, class: User do
        name {'active'}
        email{'active@com'}
        password{'bbbbbb'}
        admin{false}
        activated{true}
    end
    #有効化されていない一般ユーザー
    factory :negative_user, class: User do
        name {'negative'}
        email{'negative@com'}
        password{'cccccc'}
        admin{false}
        activated{false}
    end
end