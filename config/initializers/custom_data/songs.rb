module CustomData
  class Songs
    def self.post_data_to_db
      data.each do |json|
        json_composer = json[:composer]
        composer = Composer.find_or_create_by(name: json_composer[:name].downcase)

        json_composition = json[:composition]
        composition = Composition.find_or_create_by(name: json_composition[:name].downcase)

        json_songs = json[:songs]
        json_songs.each do |json_song|
          Song.find_or_create_by(
            composer_id: composer.id,
            composition_id: composition.id,
            title: json_song[:title],
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
            { title: "no. 1, op. 23, G minor" },
            { title: "no. 2, op. 38, F major" },
            { title: "no. 3, op. 47, A flat major" },
            { title: "no. 4, op. 52, F minor" },
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
            { title: "no. 1, op. 10, no. 1, C major" },
            { title: "no. 2, op. 10, no. 2, A minor" },
            { title: "no. 3, op. 10, no. 3, E major" },
            { title: "no. 3, op. 10, no.3, E major" },
            { title: "no. 3, op.10, no.3, E major" },
            { title: "no. 4, op. 10, no. 4, C sharp minor" },
            { title: "no. 5, op. 10, no. 5, G flat major" },
            { title: "no. 6, op. 10, no. 6, E flat minor" },
            { title: "no. 7, op. 10, no. 7, C major" },
            { title: "no. 8, op. 10, no. 8, F major" },
            { title: "no. 9, op. 10, no. 9, F minor" },
            { title: "no. 10, op. 10, no. 10, A flat major" },
            { title: "no. 11, op. 10, no. 11, E flat major" },
            { title: "no. 12, op. 10, no. 12, C minor" },
            { title: "no. 13, op. 25, no. 1, A flat major" },
            { title: "no. 14, op. 25, no. 2, F minor" },
            { title: "no. 15, op. 25, no. 3, F major" },
            { title: "no. 16, op. 25, no. 4, A minor" },
            { title: "no. 17, op. 25, no. 5, E minor" },
            { title: "no. 18, op. 25, no. 6, G sharp minor" },
            { title: "no. 19, op. 25, no. 7, C sharp minor" },
            { title: "no. 20, op. 25, no. 8, D flat major" },
            { title: "no. 20, op. 25, no. 8, D flat major" },
            { title: "no. 21, op. 25, no. 9, G flat major" },
            { title: "no. 22, op. 25, no. 10, B minor" },
            { title: "no. 23, op. 25, no. 11, A minor" },
            { title: "no. 24, op. 25, no. 12, C minor" },
            { title: "no. 25, op. posth., no. 1, F minor" },
            { title: "no. 26, op. posth., no. 2, A flat major" },
            { title: "no. 27, op. posth., no. 3, D flat major" },
          ],
        },
        {
          composer: {
            name: "Mozart",
          },
          composition: {
            name: "Concerto",
          },
          songs: [
            { title: "Two Pianos and Orchestra, k. 242, F major" },
            { title: "Two Pianos and Orchestra, k. 365, E flat major" },
            { title: "Violin and Orchestra KV.218" },
            { title: "Piano and Orchestra no. 1, k. 37, F major" },
            { title: "Piano and Orchestra no. 2, k. 39, B flat major" },
            { title: "Piano and Orchestra no. 5, k. 175, D major" },
            { title: "Piano and Orchestra no. 6, k. 238, B flat major" },
            { title: "Piano and Orchestra no. 8, k. 246, C major" },
            { title: "Piano and Orchestra no. 9, k. 271, E flat major" },
            { title: "Piano and Orchestra no. 11, k. 413, F major" },
            { title: "Piano and Orchestra no. 12, k. 414, A major" },
            { title: "Piano and Orchestra no. 13, k. 415, C major" },
            { title: "Piano and Orchestra no. 14, k. 449, E flat major" },
            { title: "Piano and Orchestra no. 15, k. 450, B flat major" },
            { title: "Piano and Orchestra no. 17, k. 453, G major" },
            { title: "Piano and Orchestra no. 18, k. 456, B flat major" },
            { title: "Piano and Orchestra no. 19, k. 459, F major" },
            { title: "Piano and Orchestra no. 20, k. 466, D minor" },
            { title: "Piano and Orchestra no. 21, k. 467, C major" },
            { title: "Piano and Orchestra no. 22, k. 482, E flat major" },
            { title: "Piano and Orchestra no. 23, k. 488, A major" },
            { title: "Piano and Orchestra no. 24, k. 491, C minor" },
            { title: "Piano and Orchestra no. 25, k. 503, C major" },
            { title: "Piano and Orchestra no. 26, k. 537, D major" },
            { title: "Piano and Orchestra no. 27, k. 595, B flat major" },
          ],
        },
        {
          composer: {
            name: "Mozart",
          },
          composition: {
            name: "Symphonie",
          },
          songs: [
            { title: "concertante k. 364" },
            { title: "no. 1, k. 16, E flat major" },
            { title: "no. 4, k. 19, D major" },
            { title: "no. 5, k. 22, B flat major" },
            { title: "no. 6, k. 43, F major" },
            { title: "no. 7, k. 45, D major" },
            { title: "no. 8, k. 48, D major" },
            { title: "no. 9, k. 73, C major" },
            { title: "no. 10, k. 74, G major" },
            { title: "no. 11, k. 84, D major" },
            { title: "no. 12, k. 110, G major" },
            { title: "no. 14, k. 114, A major" },
            { title: "no. 18, k. 130, F major" },
            { title: "no. 19, k. 132, E flat major" },
            { title: "no. 20, k. 133, D major" },
            { title: "no. 21, k. 134, A major" },
            { title: "no. 22, k. 162, C major" },
            { title: "no. 23, k. 181, D major" },
            { title: "no. 24, k. 182, B major" },
            { title: "no. 25, k. 183, G minor" },
            { title: "no. 26, k. 184, E flat major" },
            { title: "no. 27, k. 199, G major" },
            { title: "no. 28, k. 200, C major" },
            { title: "no. 29, k. 201, A major" },
            { title: "no. 30, k. 202, D major" },
            { title: "no. 31, k. 297, D major (Paris)" },
            { title: "no. 32, k. 318, G major" },
            { title: "no. 33, k. 319, B flat major" },
            { title: "no. 34, k. 338, C major" },
            { title: "no. 35, k. 385, D major (Haffner)" },
            { title: "no. 36, k. 425, C major (Linz)" },
            { title: "no. 38, k. 504, D major (Prague)" },
            { title: "no. 39, k. 543, E flat major" },
            { title: "no. 40, k. 550, G minor" },
            { title: "no. 41, k. 551, C major (Jupiter)" },
          ],
        },
      ]
    end
  end
end
