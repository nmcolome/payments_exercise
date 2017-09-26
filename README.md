# Payments Exercise

Add in the ability to create payments for a given loan using a JSON API call. You should store the payment date and amount. Expose the outstanding balance for a given loan in the JSON vended for `LoansController#show` and `LoansController#index`. The outstanding balance should be calculated as the `funded_amount` minus all of the payment amounts.

A payment should not be able to be created that exceeds the outstanding balance of a loan. You should return validation errors if a payment can not be created. Expose endpoints for seeing all payments for a given loan as well as seeing an individual payment.

## Stack
Ruby 2.2.3 and Rails 4.2.4

## Setup
Clone this repository

Make sure you have Ruby 2.2.3 and Rails 4.2.4 installed.

If you don’t have ruby, you can download it with: `rvm install ruby-2.2.3`

If you don’t have rails, you can download it with: `sudo gem install rails`

Change into the directory with `cd payments_exercise`

Run `bundle install` - If this fails, and you have the correct ruby and rails versions, run `bundle update`

Run `rake db:{create,migrate,seed}`


## Endpoints
The following endpoints are available. All endpoints will return the data response as JSON.

* `GET /loans` - returns all loans stored in the database.
  It returns an array of objects, each object has: 
  * id: loan identification number
  * funded_amount: approved amount for the loan (in USD and 1 decimal place).
  * outstanding_balance: it is the funded_amount minus all payments made to that loan (in USD and 1 decimal place).
  * created_at: date and time of creation.
  * updated_at: update date and time, if there hasn't been any updates it will match the created_at date.

* `GET /loans/:id` - returns the loan that matches that specific `:id`.
  It returns an object with:
  * id: loan identification number
  * funded_amount: approved amount for the loan (in USD and 1 decimal place).
  * outstanding_balance: it is the funded_amount minus all payments made to that loan (in USD and 1 decimal place).
  * created_at: date and time of creation.
  * updated_at: update date and time, if there hasn't been any updates it will match the created_at date.

* `GET /loans/:id/payments` - returns all payments related to a specific loan. It returns an array of objects, each object has: 
  * id: payment identification number
  * loand_id: loan identification number
  * payment_amount: payment amount for the loan (in USD and 1 decimal place).
  * payment_date: date of payment.
  * created_at: date and time of creation.
  * updated_at: update date and time, if there hasn't been any updates it will match the created_at date.

* `GET /loans/:id/payments/:id` - returns a specific payment for a specific loan. It returns an object with:
  * id: payment identification number
  * loand_id: loan identification number
  * payment_amount: payment amount for the loan (in USD and 1 decimal place).
  * payment_date: date of payment.
  * created_at: date and time of creation.
  * updated_at: update date and time, if there hasn't been any updates it will match the created_at date.

* `POST /loans/:id/payments` - endpoint to create payments for a given loan.