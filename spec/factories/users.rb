FactoryBot.define do
    #管理者
    factory :admin_user, class: User do
        gender{'male'}
        name {'admin'}
        email{'admin@com'}
        password{'aaaaaa'}
        admin{true}
        activated{true}
    end
    #有効化済み一般ユーザー
    factory :active_user, class: User do
        gender{'fale'}
        name {'active'}
        email{'active@com'}
        password{'bbbbbb'}
        admin{false}
        activated{true}
    end
    #有効化されていない一般ユーザー
    factory :negative_user, class: User do
        gender{'male'}
        name {'negative'}
        email{'negative@com'}
        password{'cccccc'}
        admin{false}
        activated{false}
    end

    #有効化nonアドミンモブユーザーA
    factory :Ami, class: User do
        gender{'female'}
        name {'Ami'}
        email{'ami@com'}
        password{'dddddd'}
        admin{false}
        activated{true}
    end
    #有効化nonアドミンモブユーザーB
    factory :Bob, class: User do
        gender{'male'}
        name {'Bob'}
        email{'bob@com'}
        password{'eeeeee'}
        admin{false}
        activated{true}
    end        
end