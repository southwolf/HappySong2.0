namespace :update do
  desc "热门更新"
  task update_hot: :environment do
    # 每周更新热门朗读
    records = Record.find_by_sql("SELECT a.* FROM records as a join views as b on a.id = b.view_record_id
                        WHERE (b.`created_at` BETWEEN '#{Time.now - 1.day}' AND '#{Time.now}')
                        GROUP BY(a.id) ORDER BY count(b.num) DESC Limit 10")
    Record.where(:is_hot => true ).each do |record|
      record.update(:is_hot => false)
    end
    records.each do |record|
        record.update(:is_hot => true)
      end
    puts "success"
  end

end
