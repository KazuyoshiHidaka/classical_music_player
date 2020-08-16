require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe "#sidebar_collapse_id" do
    subject do
      helper.sidebar_collapse_id(**attributes)
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
            is_expected.to eq "sidebarCollapseComposer#{parent_id}"
          end
        end

        context "parent_idとchild_idに値を与えた場合" do
          include_context "parent_idとchild_id"

          it "期待する文字列が返る" do
            is_expected.to eq "sidebarCollapseComposer#{parent_id}Composition#{child_id}"
          end
        end
      end

      context "is_parent_composition: trueの場合" do
        before { attributes.merge!(is_parent_composition: true) }

        context "parent_idのみに値を与えた場合" do
          include_context "parent_idのみ"

          it "期待する文字列が返る" do
            is_expected.to eq "sidebarCollapseComposition#{parent_id}"
          end
        end

        context "parent_idとchild_idに値を与えた場合" do
          include_context "parent_idとchild_id"

          it "期待する文字列が返る" do
            is_expected.to eq "sidebarCollapseComposition#{parent_id}Composer#{child_id}"
          end
        end
      end
    end
  end
end
