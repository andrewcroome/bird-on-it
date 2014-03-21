class ToteBagsController < ApplicationController
  respond_to :html

  # GET /tote_bags
  def index
    @tote_bags = ToteBag.decorate_collection(ToteBag.all)
    respond_with @tote_bags
  end

  # GET /tote_bags/1
  def show
    @tote_bag = ToteBag.find(params[:id]).decorate
    respond_with @tote_bag
  end

  # GET /tote_bags/new
  def new
    @tote_bag = ToteBag.new
    respond_with @tote_bag
  end

  # GET /tote_bags/1/edit
  def edit
    @tote_bag = ToteBag.find(params[:id]).decorate
    respond_with @tote_bag
  end

  # POST /tote_bags
  def create
    @tote_bag = ToteBag.new(tote_bag_params)

    if @tote_bag.save
      redirect_to @tote_bag, notice: 'Tote bag was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /tote_bags/1
  def update
    @tote_bag = ToteBag.find(params[:id])

    if @tote_bag.update(tote_bag_params)
      redirect_to @tote_bag, notice: 'Tote bag was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /tote_bags/1
  def destroy
    @tote_bag = ToteBag.find(params[:id])
    @tote_bag.destroy
    redirect_to tote_bags_url, notice: 'Tote bag was successfully destroyed.'
  end

  private

  def tote_bag_params
    params.require(:tote_bag).permit(:colour, :material, :straps)
  end
end
