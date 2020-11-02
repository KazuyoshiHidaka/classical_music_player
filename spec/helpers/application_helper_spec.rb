require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe "#app_title" do
    subject do
      helper.app_title(page_title: page_title)
    end

    context "page_titleを与えなかった場合" do
      it "APP_NAMEを返す" do
        expect(helper.app_title).to eq ENV.fetch('APP_NAME')
      end
    end

    context "page_titleにnilを与えた場合" do
      let(:page_title) { nil }

      it "APP_NAMEを返す" do
        is_expected.to eq ENV.fetch('APP_NAME')
      end
    end

    context "page_titleに空文字を与えた場合" do
      let(:page_title) { '' }

      it "APP_NAMEを返す" do
        is_expected.to eq ENV.fetch('APP_NAME')
      end
    end

    context "page_titleに文字を与えた場合" do
      let(:page_title) { 'page_title' }

      it "'与えた文字 - APP_NAME'を返す" do
        is_expected.to eq "#{page_title} - #{ENV.fetch('APP_NAME')}"
      end
    end
  end

  describe "#all_songs_list_collapse_id" do
    subject do
      helper.all_songs_list_collapse_id(**attributes)
    end

    describe "エラーチェック" do
      let(:attributes) do
        {
          parent_id: 1,
        }
      end

      context "parent_idを与えなかった場合" do
        before { attributes.delete(:parent_id) }

        it "ArgumentErrorが発生する" do
          expect { subject }.to raise_error ArgumentError, "missing keyword: :parent_id"
        end
      end

      context "parent_idにnilを与えた場合" do
        before { attributes.merge!(parent_id: nil) }

        it "ArgumentErrorが発生する" do
          expect { subject }.to(
            raise_error(
              ArgumentError,
              "parent_id: parent(composerまたはcomposition) のidを与えてください"
            )
          )
        end
      end

      context "is_parent_composer: nil, is_parent_composition: nil を与えた場合" do
        before do
          attributes.merge!(is_parent_composer: nil, is_parent_composition: nil)
        end

        it "ArgumentErrorが発生する" do
          expect { subject }.to(
            raise_error(
              ArgumentError,
              "is_parent_composerとis_parent_compositionは、どちらか1つだけをtrueにしてください"
            )
          )
        end
      end

      context "is_parent_composer: true, is_parent_composition: true を与えた場合" do
        before do
          attributes.merge!(is_parent_composer: true, is_parent_composition: true)
        end

        it "ArgumentErrorが発生する" do
          expect { subject }.to(
            raise_error(
              ArgumentError,
              "is_parent_composerとis_parent_compositionは、どちらか1つだけをtrueにしてください"
            )
          )
        end
      end
    end

    describe "返り値テスト" do
      let(:attributes) do
        {
          parent_id: parent_id,
        }
      end

      shared_context "parent_idのみ" do
        let(:parent_id) { 1 }
      end

      shared_context "parent_idとchild_id" do
        before { attributes.merge!(child_id: child_id) }

        let(:parent_id) { 1 }
        let(:child_id) { 1 }
      end

      context "is_parent_composer: trueの場合" do
        before { attributes.merge!(is_parent_composer: true) }

        context "parent_idのみに値を与えた場合" do
          include_context "parent_idのみ"

          it "期待する文字列が返る" do
            is_expected.to eq "allSongsListCollapseComposer#{parent_id}"
          end
        end

        context "parent_idとchild_idに値を与えた場合" do
          include_context "parent_idとchild_id"

          it "期待する文字列が返る" do
            is_expected.to eq "allSongsListCollapseComposer#{parent_id}Composition#{child_id}"
          end
        end
      end

      context "is_parent_composition: trueの場合" do
        before { attributes.merge!(is_parent_composition: true) }

        context "parent_idのみに値を与えた場合" do
          include_context "parent_idのみ"

          it "期待する文字列が返る" do
            is_expected.to eq "allSongsListCollapseComposition#{parent_id}"
          end
        end

        context "parent_idとchild_idに値を与えた場合" do
          include_context "parent_idとchild_id"

          it "期待する文字列が返る" do
            is_expected.to eq "allSongsListCollapseComposition#{parent_id}Composer#{child_id}"
          end
        end
      end
    end
  end

  describe "#bs_class_for_flash" do
    subject { helper.bs_class_for_flash(type: type) }

    context "引数typeを与えなかった場合" do
      it "ArgumentErrorが発生する" do
        expect { helper.bs_class_for_flash }.to raise_error ArgumentError
      end
    end

    context "nilを与えた場合" do
      let(:type) { nil }

      it "nilを返す" do
        is_expected.to be nil
      end
    end

    context "'alert'を与えた場合" do
      let(:type) { 'alert' }

      it "'danger'を返す" do
        is_expected.to eq 'danger'
      end
    end

    context "'notice'を与えた場合" do
      let(:type) { 'notice' }

      it "'info'を返す" do
        is_expected.to eq 'info'
      end
    end

    context "alertやnotice以外の文字列を与えた場合" do
      let(:type) { 'success' }

      it "与えた文字列をそのまま返す" do
        is_expected.to eq type
      end
    end
  end
end
