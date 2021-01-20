# frozen_string_literal: true

RSpec.describe Tidied do
  it "has a version number" do
    expect(Tidied::VERSION).not_to be nil
  end

  context "#sort" do
    context "integers only," do
      let(:collection) { (0..9).to_a.shuffle }

      it "in ascending direction" do
        expect(Tidied.new(collection).sort(direction: :ascending))
          .to eq [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
      end

      it "in descending direction" do
        expect(Tidied.new(collection).sort(direction: :descending))
          .to eq [9, 8, 7, 6, 5, 4, 3, 2, 1, 0]
      end
    end

    context "integers with nils," do
      let(:collection) { ((0..9).to_a + [nil]).shuffle }

      it "in ascending direction with nils small" do
        expect(Tidied.new(collection).sort(direction: :ascending, nils: :small))
          .to eq [nil, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
      end

      it "in ascending direction with nils large" do
        expect(Tidied.new(collection).sort(direction: :ascending, nils: :large))
          .to eq [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, nil]
      end

      it "in descending direction with nils small" do
        expect(Tidied.new(collection).sort(direction: :descending, nils: :small))
          .to eq [9, 8, 7, 6, 5, 4, 3, 2, 1, 0, nil]
      end

      it "in descending direction with nils large" do
        expect(Tidied.new(collection).sort(direction: :descending, nils: :large))
          .to eq [nil, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0]
      end
    end

    context "booleans only," do
      let(:collection) { [true, false].shuffle }

      it "in ascending direction" do
        expect(Tidied.new(collection).sort(direction: :ascending))
          .to eq [false, true]
      end

      it "in descending direction" do
        expect(Tidied.new(collection).sort(direction: :descending))
          .to eq [true, false]
      end
    end

    context "booleans with nils," do
      let(:collection) { ([true, false] + [nil]).shuffle }

      it "in ascending direction with nils small" do
        expect(Tidied.new(collection).sort(direction: :ascending, nils: :small))
          .to eq [nil, false, true]
      end

      it "in ascending direction with nils large" do
        expect(Tidied.new(collection).sort(direction: :ascending, nils: :large))
          .to eq [false, true, nil]
      end

      it "in descending direction with nils small" do
        expect(Tidied.new(collection).sort(direction: :descending, nils: :small))
          .to eq [true, false, nil]
      end

      it "in descending direction with nils large" do
        expect(Tidied.new(collection).sort(direction: :descending, nils: :large))
          .to eq [nil, true, false]
      end
    end

    context "time objects only," do
      let(:t_2000_01_01_01_01_01) { Time.new(2000, 01, 01, 01, 01, 01) }
      let(:t_2000_01_01_01_01_02) { Time.new(2000, 01, 01, 01, 01, 02) }
      let(:t_2000_01_01_01_02_01) { Time.new(2000, 01, 01, 01, 02, 01) }
      let(:t_2000_01_01_02_01_01) { Time.new(2000, 01, 01, 02, 01, 01) }
      let(:t_2000_01_02_01_01_01) { Time.new(2000, 01, 02, 01, 01, 01) }
      let(:t_2000_02_01_01_01_01) { Time.new(2000, 02, 01, 01, 01, 01) }
      let(:t_2001_01_01_01_01_01) { Time.new(2001, 01, 01, 01, 01, 01) }
      let(:collection) { [t_2000_01_01_01_01_01, t_2000_01_01_01_01_02, t_2000_01_01_01_02_01, t_2000_01_01_02_01_01, t_2000_01_02_01_01_01, t_2000_02_01_01_01_01, t_2001_01_01_01_01_01].shuffle }

      it "in ascending direction" do
        expect(Tidied.new(collection).sort(direction: :ascending))
          .to eq [t_2000_01_01_01_01_01, t_2000_01_01_01_01_02, t_2000_01_01_01_02_01, t_2000_01_01_02_01_01, t_2000_01_02_01_01_01, t_2000_02_01_01_01_01, t_2001_01_01_01_01_01]
      end

      it "in descending direction" do
        expect(Tidied.new(collection).sort(direction: :descending))
          .to eq [t_2001_01_01_01_01_01, t_2000_02_01_01_01_01, t_2000_01_02_01_01_01, t_2000_01_01_02_01_01, t_2000_01_01_01_02_01, t_2000_01_01_01_01_02, t_2000_01_01_01_01_01]
      end
    end

    context "time objects with nils," do
      let(:t_2000_01_01_01_01_01) { Time.new(2000, 01, 01, 01, 01, 01) }
      let(:t_2000_01_01_01_01_02) { Time.new(2000, 01, 01, 01, 01, 02) }
      let(:t_2000_01_01_01_02_01) { Time.new(2000, 01, 01, 01, 02, 01) }
      let(:t_2000_01_01_02_01_01) { Time.new(2000, 01, 01, 02, 01, 01) }
      let(:t_2000_01_02_01_01_01) { Time.new(2000, 01, 02, 01, 01, 01) }
      let(:t_2000_02_01_01_01_01) { Time.new(2000, 02, 01, 01, 01, 01) }
      let(:t_2001_01_01_01_01_01) { Time.new(2001, 01, 01, 01, 01, 01) }
      let(:collection) { ([t_2000_01_01_01_01_01, t_2000_01_01_01_01_02, t_2000_01_01_01_02_01, t_2000_01_01_02_01_01, t_2000_01_02_01_01_01, t_2000_02_01_01_01_01, t_2001_01_01_01_01_01] + [nil]).shuffle }

      it "in ascending direction with nils small" do
        expect(Tidied.new(collection).sort(direction: :ascending, nils: :small))
          .to eq [nil, t_2000_01_01_01_01_01, t_2000_01_01_01_01_02, t_2000_01_01_01_02_01, t_2000_01_01_02_01_01, t_2000_01_02_01_01_01, t_2000_02_01_01_01_01, t_2001_01_01_01_01_01]
      end

      it "in ascending direction with nils large" do
        expect(Tidied.new(collection).sort(direction: :ascending, nils: :large))
          .to eq [t_2000_01_01_01_01_01, t_2000_01_01_01_01_02, t_2000_01_01_01_02_01, t_2000_01_01_02_01_01, t_2000_01_02_01_01_01, t_2000_02_01_01_01_01, t_2001_01_01_01_01_01, nil]
      end

      it "in descending direction with nils small" do
        expect(Tidied.new(collection).sort(direction: :descending, nils: :small))
          .to eq [t_2001_01_01_01_01_01, t_2000_02_01_01_01_01, t_2000_01_02_01_01_01, t_2000_01_01_02_01_01, t_2000_01_01_01_02_01, t_2000_01_01_01_01_02, t_2000_01_01_01_01_01, nil]
      end

      it "in descending direction with nils large" do
        expect(Tidied.new(collection).sort(direction: :descending, nils: :large))
          .to eq [nil, t_2001_01_01_01_01_01, t_2000_02_01_01_01_01, t_2000_01_02_01_01_01, t_2000_01_01_02_01_01, t_2000_01_01_01_02_01, t_2000_01_01_01_01_02, t_2000_01_01_01_01_01]
      end
    end

    context "date objects only," do
      let(:d_2000_01_01) { Date.new(2000, 01, 01) }
      let(:d_2000_01_02) { Date.new(2000, 01, 02) }
      let(:d_2000_02_01) { Date.new(2000, 02, 01) }
      let(:d_2001_01_01) { Date.new(2001, 01, 01) }
      let(:collection) { [d_2000_01_01, d_2000_01_02, d_2000_02_01, d_2001_01_01].shuffle }

      it "in ascending direction" do
        expect(Tidied.new(collection).sort(direction: :ascending))
          .to eq [d_2000_01_01, d_2000_01_02, d_2000_02_01, d_2001_01_01]
      end

      it "in descending direction" do
        expect(Tidied.new(collection).sort(direction: :descending))
          .to eq [d_2001_01_01, d_2000_02_01, d_2000_01_02, d_2000_01_01]
      end
    end

    context "date objects with nils," do
      let(:d_2000_01_01) { Date.new(2000, 01, 01) }
      let(:d_2000_01_02) { Date.new(2000, 01, 02) }
      let(:d_2000_02_01) { Date.new(2000, 02, 01) }
      let(:d_2001_01_01) { Date.new(2001, 01, 01) }
      let(:collection) { ([d_2000_01_01, d_2000_01_02, d_2000_02_01, d_2001_01_01] + [nil]).shuffle }

      it "in ascending direction with nils small" do
        expect(Tidied.new(collection).sort(direction: :ascending, nils: :small))
          .to eq [nil, d_2000_01_01, d_2000_01_02, d_2000_02_01, d_2001_01_01]
      end

      it "in ascending direction with nils large" do
        expect(Tidied.new(collection).sort(direction: :ascending, nils: :large))
          .to eq [d_2000_01_01, d_2000_01_02, d_2000_02_01, d_2001_01_01, nil]
      end

      it "in descending direction with nils small" do
        expect(Tidied.new(collection).sort(direction: :descending, nils: :small))
          .to eq [d_2001_01_01, d_2000_02_01, d_2000_01_02, d_2000_01_01, nil]
      end

      it "in descending direction with nils large" do
        expect(Tidied.new(collection).sort(direction: :descending, nils: :large))
          .to eq [nil, d_2001_01_01, d_2000_02_01, d_2000_01_02, d_2000_01_01]
      end
    end

    context "strings only," do
      let(:collection) { %w[a z A Z].shuffle }

      it "in ascending direction" do
        expect(Tidied.new(collection).sort(direction: :ascending))
          .to eq ['A', 'Z', 'a', 'z']
      end

      it "in descending direction" do
        expect(Tidied.new(collection).sort(direction: :descending))
          .to eq ['z', 'a', 'Z', 'A']
      end
    end

    context "strings with nils," do
      let(:collection) { (%w[a z A Z] + [nil]).shuffle }

      it "in ascending direction with nils small" do
        expect(Tidied.new(collection).sort(direction: :ascending, nils: :small))
          .to eq [nil, 'A', 'Z', 'a', 'z']
      end

      it "in ascending direction with nils large" do
        expect(Tidied.new(collection).sort(direction: :ascending, nils: :large))
          .to eq ['A', 'Z', 'a', 'z', nil]
      end

      it "in descending direction with nils small" do
        expect(Tidied.new(collection).sort(direction: :descending, nils: :small))
          .to eq ['z', 'a', 'Z', 'A', nil]
      end

      it "in descending direction with nils large" do
        expect(Tidied.new(collection).sort(direction: :descending, nils: :large))
          .to eq [nil, 'z', 'a', 'Z', 'A']
      end
    end

    context "strings case-insensitively," do
      let(:collection) { %w[a A z Z] } # original order matters, so no shuffle to ensure expecations always work

      it "in ascending direction" do
        expect(Tidied.new(collection).sort(direction: :ascending, case_sensitive: false))
          .to eq ['a', 'A', 'z', 'Z']
      end

      it "in descending direction" do
        expect(Tidied.new(collection).sort(direction: :descending, case_sensitive: false))
          .to eq ['z', 'Z', 'a', 'A']
      end
    end

    context "strings case-insensitively with nils," do
      let(:collection) { (%w[a z A Z] + [nil]) } # original order matters, so no shuffle to ensure expecations always work

      it "in ascending direction with nils small" do
        expect(Tidied.new(collection).sort(direction: :ascending, nils: :small, case_sensitive: false))
          .to eq [nil, 'a', 'A', 'z', 'Z']
      end

      it "in ascending direction with nils large" do
        expect(Tidied.new(collection).sort(direction: :ascending, nils: :large, case_sensitive: false))
          .to eq ['a', 'A', 'z', 'Z', nil]
      end

      it "in descending direction with nils small" do
        expect(Tidied.new(collection).sort(direction: :descending, nils: :small, case_sensitive: false))
          .to eq ['z', 'Z', 'a', 'A', nil]
      end

      it "in descending direction with nils large" do
        expect(Tidied.new(collection).sort(direction: :descending, nils: :large, case_sensitive: false))
          .to eq [nil, 'z', 'Z', 'a', 'A']
      end
    end

    context "flat objects only," do
      let(:obj) { Struct.new(:bool, :int) }
      def array_of_tuples_to_array_of_flat_objs(array)
        array.map { |bool, int| obj.new(bool, int) }
      end
      let(:collection) do
        array_of_tuples_to_array_of_flat_objs(
          [true, false].product([1, 2]).shuffle
        )
      end

      it "boolean attribute in ascending direction, then integer attribute in ascending direction" do
        expect(Tidied.new(collection).sort({ direction: :ascending, accessor: :bool },
                                           { direction: :ascending, accessor: :int }))
          .to eq array_of_tuples_to_array_of_flat_objs([[false, 1], [false, 2], [true, 1], [true, 2]])
      end

      it "boolean attribute in ascending direction, then integer attribute in descending direction" do
        expect(Tidied.new(collection).sort({ direction: :ascending, accessor: :bool },
                                           { direction: :descending, accessor: :int }))
          .to eq array_of_tuples_to_array_of_flat_objs([[false, 2], [false, 1], [true, 2], [true, 1]])
      end

      it "boolean attribute in descending direction, then integer attribute in ascending direction" do
        expect(Tidied.new(collection).sort({ direction: :descending, accessor: :bool },
                                           { direction: :ascending, accessor: :int }))
          .to eq array_of_tuples_to_array_of_flat_objs([[true, 1], [true, 2], [false, 1], [false, 2]])
      end

      it "boolean attribute in ascending direction, then integer attribute in descending direction" do
        expect(Tidied.new(collection).sort({ direction: :descending, accessor: :bool },
                                           { direction: :descending, accessor: :int }))
          .to eq array_of_tuples_to_array_of_flat_objs([[true, 2], [true, 1], [false, 2], [false, 1]])
      end

      it "integer attribute in ascending direction, then boolean attribute in ascending direction" do
        expect(Tidied.new(collection).sort({ direction: :ascending, accessor: :int },
                                           { direction: :ascending, accessor: :bool }))
          .to eq array_of_tuples_to_array_of_flat_objs([[false, 1], [true, 1], [false, 2], [true, 2]])
      end

      it "integer attribute in ascending direction, then boolean attribute in descending direction" do
        expect(Tidied.new(collection).sort({ direction: :ascending, accessor: :int },
                                           { direction: :descending, accessor: :bool }))
          .to eq array_of_tuples_to_array_of_flat_objs([[true, 1], [false, 1], [true, 2], [false, 2]])
      end

      it "integer attribute in descending direction, then boolean attribute in ascending direction" do
        expect(Tidied.new(collection).sort({ direction: :descending, accessor: :int },
                                           { direction: :ascending, accessor: :bool }))
          .to eq array_of_tuples_to_array_of_flat_objs([[false, 2], [true, 2], [false, 1], [true, 1]])
      end

      it "integer attribute in ascending direction, then boolean attribute in descending direction" do
        expect(Tidied.new(collection).sort({ direction: :descending, accessor: :int },
                                           { direction: :descending, accessor: :bool }))
          .to eq array_of_tuples_to_array_of_flat_objs([[true, 2], [false, 2], [true, 1], [false, 1]])
      end
    end

    context "flat objects with nils," do
      let(:obj) { Struct.new(:bool, :int) }
      def array_of_tuples_to_array_of_flat_objs(array)
        array.map { |bool, int| obj.new(bool, int) }
      end
      let(:collection) do
        array_of_tuples_to_array_of_flat_objs(
          (
            [true, false].product([1, 2]) +
            [true, false].product([nil]) +
            [nil].product([1, 2])
          ).shuffle
        )
      end

      it "boolean attribute in ascending direction with nils small, then integer attribute in ascending direction with nils small" do
        expect(Tidied.new(collection).sort({ direction: :ascending, accessor: :bool, nils: :small },
                                           { direction: :ascending, accessor: :int, nils: :small }))
          .to eq array_of_tuples_to_array_of_flat_objs([[nil, 1], [nil, 2], [false, nil], [false, 1], [false, 2], [true, nil], [true, 1], [true, 2]])
      end

      it "boolean attribute in ascending direction with nils large, then integer attribute in ascending direction with nils small" do
        expect(Tidied.new(collection).sort({ direction: :ascending, accessor: :bool, nils: :large },
                                           { direction: :ascending, accessor: :int, nils: :small }))
          .to eq array_of_tuples_to_array_of_flat_objs([[false, nil], [false, 1], [false, 2], [true, nil], [true, 1], [true, 2], [nil, 1], [nil, 2]])
      end

      it "boolean attribute in ascending direction with nils small, then integer attribute in ascending direction with nils large" do
        expect(Tidied.new(collection).sort({ direction: :ascending, accessor: :bool, nils: :small },
                                           { direction: :ascending, accessor: :int, nils: :large }))
          .to eq array_of_tuples_to_array_of_flat_objs([[nil, 1], [nil, 2], [false, 1], [false, 2], [false, nil], [true, 1], [true, 2], [true, nil]])
      end

      it "integer attribute in ascending direction with nils small, then boolean attribute in ascending direction with nils small" do
        expect(Tidied.new(collection).sort({ direction: :ascending, accessor: :int, nils: :small },
                                           { direction: :ascending, accessor: :bool, nils: :small }))
          .to eq array_of_tuples_to_array_of_flat_objs([[false, nil], [true, nil], [nil, 1], [false, 1], [true, 1], [nil, 2], [false, 2], [true, 2]])
      end

      it "integer attribute in ascending direction with nils large, then boolean attribute in ascending direction with nils small" do
        expect(Tidied.new(collection).sort({ direction: :ascending, accessor: :int, nils: :large },
                                           { direction: :ascending, accessor: :bool, nils: :small }))
          .to eq array_of_tuples_to_array_of_flat_objs([[nil, 1], [false, 1], [true, 1], [nil, 2], [false, 2], [true, 2], [false, nil], [true, nil]])
      end

      it "integer attribute in ascending direction with nils small, then boolan attribute in ascending direction with nils large" do
        expect(Tidied.new(collection).sort({ direction: :ascending, accessor: :int, nils: :small },
                                           { direction: :ascending, accessor: :bool, nils: :large }))
          .to eq array_of_tuples_to_array_of_flat_objs([[false, nil], [true, nil], [false, 1], [true, 1], [nil, 1], [false, 2], [true, 2], [nil, 2]])
      end
    end

    context "nested objects only," do
      let(:obj) { Struct.new(:bool, :assoc) }
      let(:assoc) { Struct.new(:int) }
      def array_of_tuples_to_array_of_nested_objs(array)
        array.map { |bool, int| obj.new(bool, assoc.new(int)) }
      end
      let(:collection) do
        array_of_tuples_to_array_of_nested_objs(
          [true, false].product([1, 2]).shuffle
        )
      end

      it "boolean attribute in ascending direction, then assoc.integer attribute in ascending direction" do
        expect(Tidied.new(collection).sort({ direction: :ascending, accessor: :bool },
                                           { direction: :ascending, accessor: 'assoc.int' }))
          .to eq array_of_tuples_to_array_of_nested_objs([[false, 1], [false, 2], [true, 1], [true, 2]])
      end

      it "boolean attribute in ascending direction, then assoc.integer attribute in descending direction" do
        expect(Tidied.new(collection).sort({ direction: :ascending, accessor: :bool },
                                           { direction: :descending, accessor: 'assoc.int' }))
          .to eq array_of_tuples_to_array_of_nested_objs([[false, 2], [false, 1], [true, 2], [true, 1]])
      end

      it "boolean attribute in descending direction, then assoc.integer attribute in ascending direction" do
        expect(Tidied.new(collection).sort({ direction: :descending, accessor: :bool },
                                           { direction: :ascending, accessor: 'assoc.int' }))
          .to eq array_of_tuples_to_array_of_nested_objs([[true, 1], [true, 2], [false, 1], [false, 2]])
      end

      it "boolean attribute in ascending direction, then assoc.integer attribute in descending direction" do
        expect(Tidied.new(collection).sort({ direction: :descending, accessor: :bool },
                                           { direction: :descending, accessor: 'assoc.int' }))
          .to eq array_of_tuples_to_array_of_nested_objs([[true, 2], [true, 1], [false, 2], [false, 1]])
      end

      it "assoc.integer attribute in ascending direction, then boolean attribute in ascending direction" do
        expect(Tidied.new(collection).sort({ direction: :ascending, accessor: 'assoc.int' },
                                           { direction: :ascending, accessor: :bool }))
          .to eq array_of_tuples_to_array_of_nested_objs([[false, 1], [true, 1], [false, 2], [true, 2]])
      end

      it "assoc.integer attribute in ascending direction, then boolean attribute in descending direction" do
        expect(Tidied.new(collection).sort({ direction: :ascending, accessor: 'assoc.int' },
                                           { direction: :descending, accessor: :bool }))
          .to eq array_of_tuples_to_array_of_nested_objs([[true, 1], [false, 1], [true, 2], [false, 2]])
      end

      it "assoc.integer attribute in descending direction, then boolean attribute in ascending direction" do
        expect(Tidied.new(collection).sort({ direction: :descending, accessor: 'assoc.int' },
                                           { direction: :ascending, accessor: :bool }))
          .to eq array_of_tuples_to_array_of_nested_objs([[false, 2], [true, 2], [false, 1], [true, 1]])
      end

      it "assoc.integer attribute in ascending direction, then boolean attribute in descending direction" do
        expect(Tidied.new(collection).sort({ direction: :descending, accessor: 'assoc.int' },
                                           { direction: :descending, accessor: :bool }))
          .to eq array_of_tuples_to_array_of_nested_objs([[true, 2], [false, 2], [true, 1], [false, 1]])
      end
    end

    context "nested objects with nils," do
      let(:obj) { Struct.new(:bool, :assoc) }
      let(:assoc) { Struct.new(:int) }
      def array_of_tuples_to_array_of_nested_objs(array)
        array.map { |bool, int| obj.new(bool, assoc.new(int)) }
      end
      let(:collection) do
        array_of_tuples_to_array_of_nested_objs(
          (
            [true, false].product([1, 2]) +
            [true, false].product([nil]) +
            [nil].product([1, 2])
          ).shuffle
        )
      end

      it "boolean attribute in ascending direction with nils small, then integer attribute in ascending direction with nils small" do
        expect(Tidied.new(collection).sort({ direction: :ascending, accessor: :bool, nils: :small },
                                           { direction: :ascending, accessor: 'assoc.int', nils: :small }))
          .to eq array_of_tuples_to_array_of_nested_objs([[nil, 1], [nil, 2], [false, nil], [false, 1], [false, 2], [true, nil], [true, 1], [true, 2]])
      end

      it "boolean attribute in ascending direction with nils large, then integer attribute in ascending direction with nils small" do
        expect(Tidied.new(collection).sort({ direction: :ascending, accessor: :bool, nils: :large },
                                           { direction: :ascending, accessor: 'assoc.int', nils: :small }))
          .to eq array_of_tuples_to_array_of_nested_objs([[false, nil], [false, 1], [false, 2], [true, nil], [true, 1], [true, 2], [nil, 1], [nil, 2]])
      end

      it "boolean attribute in ascending direction with nils small, then integer attribute in ascending direction with nils large" do
        expect(Tidied.new(collection).sort({ direction: :ascending, accessor: :bool, nils: :small },
                                           { direction: :ascending, accessor: 'assoc.int', nils: :large }))
          .to eq array_of_tuples_to_array_of_nested_objs([[nil, 1], [nil, 2], [false, 1], [false, 2], [false, nil], [true, 1], [true, 2], [true, nil]])
      end

      it "integer attribute in ascending direction with nils small, then boolean attribute in ascending direction with nils small" do
        expect(Tidied.new(collection).sort({ direction: :ascending, accessor: 'assoc.int', nils: :small },
                                           { direction: :ascending, accessor: :bool, nils: :small }))
          .to eq array_of_tuples_to_array_of_nested_objs([[false, nil], [true, nil], [nil, 1], [false, 1], [true, 1], [nil, 2], [false, 2], [true, 2]])
      end

      it "integer attribute in ascending direction with nils large, then boolean attribute in ascending direction with nils small" do
        expect(Tidied.new(collection).sort({ direction: :ascending, accessor: 'assoc.int', nils: :large },
                                           { direction: :ascending, accessor: :bool, nils: :small }))
          .to eq array_of_tuples_to_array_of_nested_objs([[nil, 1], [false, 1], [true, 1], [nil, 2], [false, 2], [true, 2], [false, nil], [true, nil]])
      end

      it "integer attribute in ascending direction with nils small, then boolan attribute in ascending direction with nils large" do
        expect(Tidied.new(collection).sort({ direction: :ascending, accessor: 'assoc.int', nils: :small },
                                           { direction: :ascending, accessor: :bool, nils: :large }))
          .to eq array_of_tuples_to_array_of_nested_objs([[false, nil], [true, nil], [false, 1], [true, 1], [nil, 1], [false, 2], [true, 2], [nil, 2]])
      end
    end

    context "unicode unaccented strings only," do
      let(:collection) { %w[b a á ä o ó x ö í i c].shuffle }

      it "in ascending direction with normalization" do
        expect(Tidied.new(collection).sort(direction: :ascending, normalized: true))
          .to eq ["a", "á", "ä", "b", "c", "i", "í", "o", "ó", "ö", "x"]
      end

      it "in ascending direction without normalization" do
        expect(Tidied.new(collection).sort(direction: :ascending, normalized: false))
          .to eq ["a", "b", "c", "i", "o", "x", "á", "ä", "í", "ó", "ö"]
      end

      it "in descending direction with normalization" do
        expect(Tidied.new(collection).sort(direction: :descending, normalized: true))
          .to eq ["x", "ö", "ó", "o", "í", "i", "c", "b", "ä", "á", "a"]
      end

      it "in descending direction without normalization" do
        expect(Tidied.new(collection).sort(direction: :descending, normalized: false))
          .to eq ["ö", "ó", "í", "ä", "á", "x", "o", "i", "c", "b", "a"]
      end
    end

    context "unicode mixed strings only," do
      let(:collection) { %w[AA AB ÄA ÄB].shuffle }

      it "in ascending direction with normalization" do
        expect(Tidied.new(collection).sort(direction: :ascending, normalized: true))
          .to eq ["AA", "ÄA", "AB", "ÄB"]
      end

      it "in ascending direction without normalization" do
        expect(Tidied.new(collection).sort(direction: :ascending, normalized: false))
          .to eq ["AA", "AB", "ÄA", "ÄB"]
      end

      it "in descending direction with normalization" do
        expect(Tidied.new(collection).sort(direction: :descending, normalized: true))
          .to eq ["ÄB", "AB", "ÄA", "AA"]
      end

      it "in descending direction without normalization" do
        expect(Tidied.new(collection).sort(direction: :descending, normalized: false))
          .to eq ["ÄB", "ÄA", "AB", "AA"]
      end
    end

    context "unicode word strings only," do
      let(:collection) { %w[hellö hello hellá].shuffle }

      it "in ascending direction with normalization" do
        expect(Tidied.new(collection).sort(direction: :ascending, normalized: true))
          .to eq ["hellá", "hello", "hellö"]
      end

      it "in ascending direction without normalization" do
        expect(Tidied.new(collection).sort(direction: :ascending, normalized: false))
          .to eq ["hello", "hellá", "hellö"]
      end

      it "in descending direction with normalization" do
        expect(Tidied.new(collection).sort(direction: :descending, normalized: true))
          .to eq ["hellö", "hello", "hellá"]
      end

      it "in descending direction without normalization" do
        expect(Tidied.new(collection).sort(direction: :descending, normalized: false))
          .to eq ["hellö", "hellá", "hello"]
      end
    end

    context "unicode ligature strings only," do
      let(:collection) { %w[assb aßc assd].shuffle }

      it "in ascending direction with normalization" do
        expect(Tidied.new(collection).sort(direction: :ascending, normalized: true))
          .to eq ["assb", "aßc", "assd"]
      end

      it "in ascending direction without normalization" do
        expect(Tidied.new(collection).sort(direction: :ascending, normalized: false))
          .to eq ["assb", "assd", "aßc"]
      end

      it "in descending direction with normalization" do
        expect(Tidied.new(collection).sort(direction: :descending, normalized: true))
          .to eq ["assd", "aßc", "assb"]
      end

      it "in descending direction without normalization" do
        expect(Tidied.new(collection).sort(direction: :descending, normalized: false))
          .to eq ["aßc", "assd", "assb"]
      end
    end

    context "basic alphanumeric strings only," do
      let(:collection) { %w[a10 a a20 a1b a1a a2 a0 a1].shuffle }

      it "in ascending direction with naturalization" do
        expect(Tidied.new(collection).sort(direction: :ascending, natural: true))
          .to eq ["a", "a0", "a1", "a1a", "a1b", "a2", "a10", "a20"]
      end

      it "in ascending direction without naturalization" do
        expect(Tidied.new(collection).sort(direction: :ascending, natural: false))
          .to eq ["a", "a0", "a1", "a10", "a1a", "a1b", "a2", "a20"]
      end

      it "in descending direction with naturalization" do
        expect(Tidied.new(collection).sort(direction: :descending, natural: true))
          .to eq ["a20", "a10", "a2", "a1b", "a1a", "a1", "a0", "a"]
      end

      it "in descending direction without naturalization" do
        expect(Tidied.new(collection).sort(direction: :descending, natural: false))
          .to eq ["a20", "a2", "a1b", "a1a", "a10", "a1", "a0", "a"]
      end
    end

    context "multi-alphanumeric segment strings only," do
      let(:collection) { %w[x2-g8 x8-y8 x2-y7 x2-y08].shuffle }

      it "in ascending direction with naturalization" do
        expect(Tidied.new(collection).sort(direction: :ascending, natural: true))
          .to eq ["x2-g8", "x2-y7", "x2-y08", "x8-y8"]
      end

      it "in ascending direction without naturalization" do
        expect(Tidied.new(collection).sort(direction: :ascending, natural: false))
          .to eq ["x2-g8", "x2-y08", "x2-y7", "x8-y8"]
      end

      it "in descending direction with naturalization" do
        expect(Tidied.new(collection).sort(direction: :descending, natural: true))
          .to eq ["x8-y8", "x2-y08", "x2-y7", "x2-g8"]
      end

      it "in descending direction without naturalization" do
        expect(Tidied.new(collection).sort(direction: :descending, natural: false))
          .to eq ["x8-y8", "x2-y7", "x2-y08", "x2-g8"]
      end
    end

    context "multi-numeric segment strings only," do
      let(:collection) { %w[1.2.3.2 1.2.3.10 1.2.3.1].shuffle }

      it "in ascending direction with naturalization" do
        expect(Tidied.new(collection).sort(direction: :ascending, natural: true))
          .to eq ["1.2.3.1", "1.2.3.2", "1.2.3.10"]
      end

      it "in ascending direction without naturalization" do
        expect(Tidied.new(collection).sort(direction: :ascending, natural: false))
          .to eq ["1.2.3.1", "1.2.3.10", "1.2.3.2"]
      end

      it "in descending direction with naturalization" do
        expect(Tidied.new(collection).sort(direction: :descending, natural: true))
          .to eq ["1.2.3.10", "1.2.3.2", "1.2.3.1"]
      end

      it "in descending direction without naturalization" do
        expect(Tidied.new(collection).sort(direction: :descending, natural: false))
          .to eq ["1.2.3.2", "1.2.3.10", "1.2.3.1"]
      end
    end

    context "multi mixed alphanumeric segment strings only," do
      let(:collection) { %w[a 10 a10 10a a10a a10.a a10.A 10.20a 10.20].shuffle }

      it "in ascending direction with naturalization" do
        expect(Tidied.new(collection).sort(direction: :ascending, natural: true))
          .to eq ["10", "10.20", "10.20a", "10a", "a", "a10", "a10.A", "a10.a", "a10a"]
      end

      it "in ascending direction without naturalization" do
        expect(Tidied.new(collection).sort(direction: :ascending, natural: false))
          .to eq ["10", "10.20", "10.20a", "10a", "a", "a10", "a10.A", "a10.a", "a10a"]
      end

      it "in descending direction with naturalization" do
        expect(Tidied.new(collection).sort(direction: :descending, natural: true))
          .to eq ["a10a", "a10.a", "a10.A", "a10", "a", "10a", "10.20a", "10.20", "10"]
      end

      it "in descending direction without naturalization" do
        expect(Tidied.new(collection).sort(direction: :descending, natural: false))
          .to eq  ["a10a", "a10.a", "a10.A", "a10", "a", "10a", "10.20a", "10.20", "10"]
      end
    end
  end
  end
end
