require 'cgi'

class Payment < ApplicationRecord
	belongs_to :debitable, polymorphic: true
  belongs_to :creditable, polymorphic: true

  after_commit :update_accounts_balance
  after_update_commit :confirmed_dummy

  include AASM

  aasm column: :state do
    state :received, initial: true
    state :notified
    state :generated
    state :loaned
    state :approved
    state :completed
    
    event :notified do    	
      transitions from: :received, to: :notified, :after => :notify_user
    end
    event :feed do
    	after do
        sleep 5
        self.approve!
      end
      transitions from: :notified, to: :generated
    end    
    event :approve do
    	after do
        sleep 5
        self.debitable.device_type.eql?('pay') ? self.loan! : self.complete!
      end
      transitions from: :generated, to: :approved
    end
    event :loan do
    	#after do
      #  sleep 5
      #  self.debitable.user.send_loan(self.pid)
      #end
    	transitions from: :approved, to: :loaned
    end
    event :complete do
    	after do
        sleep 5
        debitable.user.send_confirmation
      end
      transitions from: [:approved, :loaned], to: :completed
    end
  end

  def notify_user
  	self.debitable.user.send_notification(self.pid)
  end

  def railsbank_transaction
		@railsbank = Railsbank::Client.new(
		  api: Rails.application.secrets.railsbank_url,
		  access_token: Rails.application.secrets.railsbank_api_key
		)

		ledger = @railsbank.ledgers.find(self.debitable.user.accounts.first.ledger_id)
		beneficiary = @railsbank.beneficiaries.find(self.creditable.beneficiary_id)
		
		transaction = Railsbank::Transaction.new(
			type: 'out-ledger',
	    ledger: ledger,
	    beneficiary: beneficiary ,   
	    payment_type: 'payment-type-EU-SEPA-Step2',
	    amount: self.amount
	  )

		self.reference = @railsbank.transactions.create(transaction)
	end

  def update_accounts_balance
  	self.debitable.user.accounts.each{|a| a.update_balance!(self.amount)}
  	self.creditable.accounts.each{|a| a.update_balance!(self.amount)}
  end

  def confirmed_dummy
  	 if(self.notified? && self.debitable.user.mobile_number.blank?)
	  	sleep 5	  	
	  	feed!
	  end
  end

  def status_desc
  	statuses = {
  		'received' => 'received from merchant', 
  		'notified' => 'notification sent to owner', 
  		'generated' => 'payment send to bank', 
  		'loaned' => 'loan proposal sent',
  		'approved' => 'payment approved by bank', 
  		'completed' => 'completion message sent'
  	}

  	statuses[self.state]
  end

  def progress
  	progress_h = {
  		'received' => 17, 
  		'notified' => 34, 
  		'generated' => 51,
  		'loaned' => 68, 
  		'approved' => 85, 
  		'completed' => 100
  	}
  	progress_h[self.state]
  end

  def format_message
  	CGI.unescape(self.message)
  end

  def self.pain001 
  	return Nokogiri::XML("<FndtMsg xmlns='http://fundtech.com/SCL/CommonTypes'>
		  <Msg>
		    <Pmnt>
		      <Document xmlns='urn:iso:std:iso:20022:tech:xsd:pain.001.001.03'>
		        <CstmrCdtTrfInitn>
		          <GrpHdr>
		            <MsgId>1956107176</MsgId>
		            <!--param-->
		            <CreDtTm>2016-12-19T06:19:06</CreDtTm>
		            <!--param-->
		            <NbOfTxs>1</NbOfTxs>
		            <CtrlSum>1000</CtrlSum>
		            <InitgPty>
		              <Nm>National DH Bank Plc</Nm>
		              <!--param-->
		              <Id>
		                <OrgId>
		                  <Othr>
		                    <Id>LOCALOFFICEDH1</Id>
		                    <!--param-->
		                  </Othr>
		                </OrgId>
		              </Id>
		            </InitgPty>
		          </GrpHdr>
		          <PmtInf>
		            <PmtInfId>1956107176</PmtInfId>
		            <!--param-->
		            <PmtMtd>TRF</PmtMtd>
		            <BtchBookg>false</BtchBookg>
		            <PmtTpInf>
		              <SvcLvl>
		            MAN_AUTH_SIGN_CHK
		            <Cd>SDVA</Cd>
		              </SvcLvl>
		            </PmtTpInf>
		            <ReqdExctnDt>2016-12-19</ReqdExctnDt>
		            <Dbtr>
		              <Nm>Debtor Name of Full length 35 chars</Nm>
		              <PstlAdr>
		                <TwnNm>TOWN</TwnNm>
		                <Ctry>SG</Ctry>
		                <AdrLine>Debtor Address line 1 full 35 chars</AdrLine>
		              </PstlAdr>
		              <Id>
		                <OrgId>
		                  <Othr>
		                    <Id>LOCALOFFICEDH1</Id>
		                    <!--param-->
		                  </Othr>
		                </OrgId>
		              </Id>
		            </Dbtr>
		            <DbtrAcct>
		              <Id>
		                <Othr>
		                  <Id>8888888888</Id>
		                </Othr>
		              </Id>
		              <Ccy>ILS</Ccy>
		              <!--param-->
		            </DbtrAcct>
		            <DbtrAgt>
		              <FinInstnId>
		                <BIC>DHILDHILXXX</BIC>
		              </FinInstnId>
		            </DbtrAgt>
		            <CdtTrfTxInf>
		              <PmtId>
		                <InstrId>195610717</InstrId>
		                <!--param-->
		                <EndToEndId>195610717</EndToEndId>
		                <!--param-->
		              </PmtId>
		              <Amt>
		                <InstdAmt Ccy='ILS'>979</InstdAmt>
		                <!--param-->
		              </Amt>
		              <ChrgBr>SHAR</ChrgBr>
		              <CdtrAcct>
		                <Id>
		                  <Othr>
		                    <Id>7788994411</Id>
		                    <!--param-->
		                  </Othr>
		                </Id>
		                <Ccy>ILS</Ccy>
		                <!--param-->
		              </CdtrAcct>
		              <Cdtr>
		                <Nm>Creditor Name of Full length 35 chars</Nm>
		                <PstlAdr>
		                  <TwnNm>TOWN</TwnNm>
		                  <Ctry>SG</Ctry>
		                  <AdrLine>Creditor Address line 1 full 35 chars</AdrLine>
		                </PstlAdr>
		                <Id>
		                  <OrgId>
		                    <Othr>
		                      <Id>LLL</Id>
		                    </Othr>
		                  </OrgId>
		                </Id>
		              </Cdtr>
		              <InstrForCdtrAgt>
		                <Cd>CHQB</Cd>
		                <InstrInf>/HOLDDAYS/nn</InstrInf>
		              </InstrForCdtrAgt>
		            </CdtTrfTxInf>
		          </PmtInf>
		        </CstmrCdtTrfInitn>
		      </Document>
		    </Pmnt>
		    <Extn/>
		  </Msg>
		</FndtMsg>")
  end

end
