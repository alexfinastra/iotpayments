class Payment < ApplicationRecord
	belongs_to :debitable, polymorphic: true
  belongs_to :creditable, polymorphic: true

  after_commit :update_accounts_balance

  def update_accounts_balance
  	self.debitable.user.accounts.each{|a| a.update_balance!(self.amount)}
  	self.creditable.accounts.each{|a| a.update_balance!(self.amount)}
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