module Awspec::Helper
  module Finder
    module Iam
      def find_iam_user(id)
        users = []
        marker = nil
        loop do
          res = @iam_client.list_users(
            marker: marker
          )
          marker = res.marker
          break if res.users.empty?
          res.users.each do |user|
            users.push(user) if user.user_name == id || user.user_id == id
          end
          break unless marker
        end
        return users[0] if users.count == 1
      end

      def find_iam_group(id)
        groups = []
        marker = nil
        loop do
          res = @iam_client.list_groups(
            marker: marker
          )
          marker = res.marker
          break if res.groups.empty?
          res.groups.each do |group|
            groups.push(group) if group.group_name == id || group.group_id == id
          end
          break unless marker
        end
        return groups[0] if groups.count == 1
      end

      def select_iam_group_by_user_name(user_name)
        res = @iam_client.list_groups_for_user({
                                                 user_name: user_name
                                               })
        res.groups
      end

      def select_iam_policy_by_user_name(user_name)
        res = @iam_client.list_attached_user_policies({
                                                        user_name: user_name
                                                      })
        res.attached_policies
      end

      def select_iam_policy_by_group_name(group_name)
        res = @iam_client.list_attached_group_policies({
                                                         group_name: group_name
                                                       })
        res.attached_policies
      end
    end
  end
end
