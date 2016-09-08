class EmailsController < ApplicationController

  #displays search results NOT SURE WHERE TO DISPLAY RESULTS
  def search
    query = params[:query]
    @emails = user_gmail.inbox.emails(gm: query)
  end

# open a mail depending on what is supplied to as params eg inbox, trash junk
  def mailbox
    @emails = []
    mailbox = params[:mailbox]
    @emails = user_gmail_recent(mailbox)
    email_count = @emails.length
    # @emails = location_emails(mailbox)
  end

# open a clicked on email
  def show
    index_number = params[:id].to_i
    location = params[:mailbox]
    box = user_gmail_mailbox(location)
    @email = location_emails(box)[index_number]
  end

# links to a page to create a email
  def new
  end


# sends the email
  def create
    email_address = params[:address]
    email_subject = params[:subject]
    email_body = params[:body]

    email = user_gmail.compose do
      to      email_address
      subject email_subject
      body    email_body
    end
    email.deliver!
    redirect_to root_path
  end

# deletes the email from the inbox and moves it to the trash
  def destroy
    index_number = params[:id].to_i
    @email = inbox_emails[index_number]
    @email.delete!
    redirect_to root_path
  end
end
