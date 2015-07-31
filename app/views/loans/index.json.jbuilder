json.array!(@loans) do |loan|
  json.extract! loan, :id, :user_id, :apr, :principal, :interest, :total, :original_apr, :original_interest, :submission_date, :submission_timestamp, :approved, :disbursed, :repaid, :maturity_date, :user_ip, :decline_reason
  json.url loan_url(loan, format: :json)
end
