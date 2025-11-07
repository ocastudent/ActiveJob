class SomeJob
  def perform(*args)
    # 時間のかかる処理
  end
end

SomeJob.perform_later(arg)