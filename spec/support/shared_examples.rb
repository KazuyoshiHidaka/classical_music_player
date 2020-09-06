module CustomSharedExamples
  module Request
    RSpec.shared_examples "HTTP200を返す" do
      it { expect(response).to have_http_status 200 }
    end
  end

  module Model
    shared_examples '有効になる' do
      it { is_expected.to be true }
    end

    shared_examples '無効になる' do
      it { is_expected.to be false }
    end
  end
end
