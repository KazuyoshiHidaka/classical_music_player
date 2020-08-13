module CustomData
  class Songs
    def self.post_data_to_db
      data.each do |json|
        json_composer = json[:composer]
        composer = Composer.find_or_create_by(name: json_composer[:name])

        json_composition = json[:composition]
        composition = Composition.find_or_create_by(name: json_composition[:name])

        json_songs = json[:songs]
        json_songs.each do |json_song|
          Song.find_or_create_by(
            composer_id: composer.id,
            composition_id: composition.id,
            opus: json_song[:opus],
            number: json_song[:number],
            key: json_song[:key].downcase,
            alt_name: json_song[:alt_name]&.downcase
          )
        end
      end
    end

    def self.data
      [
        {
          composer: {
            name: "Chopin",
          },
          composition: {
            name: "Ballade",
          },
          songs: [
            { number: 1, opus: 23, key: "G minor" },
            { number: 2, opus: 38, key: "F major" },
            { number: 3, opus: 47, key: "A flat major" },
            { number: 4, opus: 52, key: "F minor" },
          ],
        },
        {
          composer: {
            name: "Chopin",
          },
          composition: {
            name: "Etude",
          },
          songs: [
            { opus: 10, number: 1,  key: "C major", alt_name: "Waterfall" },
            { opus: 10, number: 2,  key: "A minor" },
            { opus: 10, number: 3,  key: "E major", alt_name: "Tristesse" },
            { opus: 10, number: 4,  key: "C sharp minor" },
            { opus: 10, number: 5,  key: "G flat major", alt_name: "black keys" },
            { opus: 10, number: 6,  key: "E flat minor" },
            { opus: 10, number: 7,  key: "C major" },
            { opus: 10, number: 8,  key: "F major" },
            { opus: 10, number: 9,  key: "F minor" },
            { opus: 10, number: 10, key: "A flat major" },
            { opus: 10, number: 11, key: "E flat major" },
            { opus: 10, number: 12, key: "C minor", alt_name: "Revolutionary" },
            { opus: 25, number: 1,  key: "A flat major", alt_name: "Aeolian Harp" },
            { opus: 25, number: 2,  key: "F minor" },
            { opus: 25, number: 3,  key: "F major" },
            { opus: 25, number: 4,  key: "A minor" },
            { opus: 25, number: 5,  key: "E minor" },
            { opus: 25, number: 6,  key: "G sharp minor" },
            { opus: 25, number: 7,  key: "C sharp minor", alt_name: "Cello" },
            { opus: 25, number: 8,  key: "D flat major" },
            { opus: 25, number: 8,  key: "D flat major" },
            { opus: 25, number: 9,  key: "G flat major", alt_name: "Butterfly" },
            { opus: 25, number: 10, key: "B minor" },
            { opus: 25, number: 11, key: "A minor", alt_name: "Winter Wind" },
            { opus: 25, number: 12, key: "C minor", alt_name: "Ocean" },
            { opus: "posthumous", number: 1, key: "F minor" },
            { opus: "posthumous", number: 2, key: "A flat major" },
            { opus: "posthumous", number: 3, key: "D flat major" },
          ],
        },
      ]
    end
  end
end
