class ContractsController < ApplicationController
  before_action :set_contract, only: [:show, :edit, :update, :destroy, :payconfirm]
  #protect_from_forgery with: :null_session
  skip_before_action :verify_authenticity_token

  # GET /contracts
  # GET /contracts.json
  def index
    @contracts = Contract.all
  end

  # GET /contracts/1
  # GET /contracts/1.json
  def show
    puts "The show must go on"
  end

  # GET /contracts/new
  def new
    @contract = Contract.new
  end

  # GET /contracts/1/edit
  def edit
  end

  # POST /contracts
  # POST /contracts.json
  def create
    @contract = Contract.new(contract_params)

    respond_to do |format|
      if @contract.save
        format.html { redirect_to @contract, notice: 'Contract was successfully created.' }
        format.json { render :show, status: :created, location: @contract }
      else
        format.html { render :new }
        format.json { render json: @contract.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /contracts/1
  # PATCH/PUT /contracts/1.json
  def update
    respond_to do |format|
      if @contract.update(contract_params)
        format.html { redirect_to @contract, notice: 'Contract was successfully updated.' }
        format.json { render :show, status: :ok, location: @contract }
      else
        format.html { render :edit }
        format.json { render json: @contract.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contracts/1
  # DELETE /contracts/1.json
  def destroy
    @contract.destroy
    respond_to do |format|
      format.html { redirect_to contracts_url, notice: 'Contract was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def ecommerce
    puts "ecommerce payment with finastra id"
    create_contract('pay', '17147,00', "GBP", SecureRandom.hex.to_s)  
    redirect_to :action => "payconfirm", :id => @contract.id
  end

  def payconfirm
  end

  def iotbutton
    puts "IoTPaY button pressed"
    create_contract('iotbutton', '1.00', "GBP", SecureRandom.hex.to_s)  
    render xml:  "<?xml version='1.0' encoding='UTF-8'?><Response> <Message>The Robots are coming! Head to the hills! Wot do u call it? IoTPaY</Message></Response>"   
  end

  def sns_confirm
    puts "okay #{JSON.parse request.raw_post}"
    create_contract('iotbutton', '1.00', "GBP", SecureRandom.hex.to_s)
    render xml:  "<?xml version='1.0' encoding='UTF-8'?><Response> <Message>The Robots are coming! Head to the hills! Wot do u call it? IoTPaY</Message></Response>"   
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contract
      @contract = Contract.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def contract_params
      params.fetch(:contract, {})
    end

    def create_contract(device_type, amount, currency, ref)
      user = User.where.not(mobile_number: nil).first
      device = user.devices.where(device_type: device_type).first
      @contract = Contract.create!({            
              contract_type: device_type,
              device: device,
              description: "Contract for #{device.name} of #{device.device_type} type, signed at #{Time.now.to_s(:long)}",
              ethereum_reference: ref,
              amount: amount,
              currency: currency,
              lifecycle: 0 
            })
    end
end
