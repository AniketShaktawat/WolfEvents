require 'rails_helper'

RSpec.describe EventsController, type: :controller do
  # index action
  describe 'GET #index' do
  it 'populates an array of events' do
    event = create(:event) # Assuming you have a factory for events
    get :index
    expect(assigns(:events)).to eq([event])
  end

  it 'renders the :index template' do
    get :index
    expect(response).to render_template :index
  end
end

# testing show action
describe 'GET #show' do
  it 'assigns the requested event to @event' do
    event = create(:event)
    get :show, params: { id: event }
    expect(assigns(:event)).to eq(event)
  end

  it 'renders the :show template' do
    event = create(:event)
    get :show, params: { id: event }
    expect(response).to render_template :show
  end
end

#testing new action 
describe 'GET #new' do
  it 'assigns a new Event to @event' do
    get :new
    expect(assigns(:event)).to be_a_new(Event)
  end

  it 'renders the :new template' do
    get :new
    expect(response).to render_template :new
  end
end

#testing create action 
# spec/controllers/events_controller_spec.rb
describe 'POST #create' do
  context 'with valid attributes' do
    it 'saves the new event in the database' do
      room = create(:room) # Create a room before creating an event
      event_attributes = attributes_for(:event).merge(room_id: room.id) # Merge room_id into event attributes

      expect {
        post :create, params: { event: event_attributes }
      }.to change(Event, :count).by(1)
    end

    it 'redirects to the events#index' do
      room = create(:room)
      event_attributes = attributes_for(:event).merge(room_id: room.id)

      post :create, params: { event: event_attributes }
      expect(response).to redirect_to events_path
    end
  end



end

#testing update action
# spec/controllers/events_controller_spec.rb
describe 'PATCH #update' do
  before :each do
    @event = create(:event)
  end

  context 'with invalid attributes' do
    it 'does not update the event' do
      patch :update, params: { id: @event, event: attributes_for(:event, name: nil) }
      @event.reload
      expect(@event.name).not_to be_nil
    end

    it 're-renders the :edit template' do
      patch :update, params: { id: @event, event: attributes_for(:event, name: nil) }
      expect(response).to render_template :edit
    end
  end



end

#testing destroy action 
describe 'DELETE #destroy' do
  before :each do
    @event = create(:event)
  end

  it 'deletes the event from the database' do
    expect {
      delete :destroy, params: { id: @event }
    }.to change(Event, :count).by(-1)
  end

  it 'redirects to events#index' do
    delete :destroy, params: { id: @event }
    expect(response).to redirect_to events_path
  end
end

end
