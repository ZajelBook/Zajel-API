class AddTranslationTables < ActiveRecord::Migration[6.1]
  def change
    reversible do |dir|
      dir.up do
        Genre.create_translation_table! name: :string
        Language.create_translation_table! name: :string

        Language::Translation.create([
                                       {
                                         language_id: 1,
                                         locale: 'en',
                                         name: 'English'
                                       },
                                       {
                                         language_id: 1,
                                         locale: 'ar',
                                         name: 'انجليزي'
                                       },

                                       {
                                         language_id: 2,
                                         locale: 'en',
                                         name: 'Arabic'
                                       },
                                       {
                                         language_id: 2,
                                         locale: 'ar',
                                         name: 'عربي'
                                       },

                                       {
                                         language_id: 3,
                                         locale: 'en',
                                         name: 'French'
                                       },
                                       {
                                         language_id: 3,
                                         locale: 'ar',
                                         name: 'فرنسي'
                                       },

                                       {
                                         language_id: 4,
                                         locale: 'en',
                                         name: 'Malay'
                                       },
                                       {
                                         language_id: 4,
                                         locale: 'ar',
                                         name: 'ماليزي'
                                       },

                                       {
                                         language_id: 5,
                                         locale: 'en',
                                         name: 'Chinese'
                                       },
                                       {
                                         language_id: 5,
                                         locale: 'ar',
                                         name: 'صيني'
                                       },

                                       {
                                         language_id: 6,
                                         locale: 'en',
                                         name: 'Hindi'
                                       },
                                       {
                                         language_id: 6,
                                         locale: 'ar',
                                         name: 'هندي'
                                       },

                                       {
                                         language_id: 7,
                                         locale: 'en',
                                         name: 'Spanish'
                                       },
                                       {
                                         language_id: 7,
                                         locale: 'ar',
                                         name: 'اسباني'
                                       },

                                       {
                                         language_id: 8,
                                         locale: 'en',
                                         name: 'Japanese'
                                       },
                                       {
                                         language_id: 8,
                                         locale: 'ar',
                                         name: 'ياباني'
                                       },

                                       {
                                         language_id: 9,
                                         locale: 'en',
                                         name: 'German'
                                       },
                                       {
                                         language_id: 9,
                                         locale: 'ar',
                                         name: 'ألماني'
                                       },

                                       {
                                         language_id: 10,
                                         locale: 'en',
                                         name: 'Korean'
                                       },
                                       {
                                         language_id: 10,
                                         locale: 'ar',
                                         name: 'كوري'
                                       },
                                     ])
        Genre::Translation.create([
                                    {
                                      genre_id: 1,
                                      locale: 'en',
                                      name: 'Adventure'
                                    },
                                    {
                                      genre_id: 1,
                                      locale: 'ar',
                                      name: 'مغامرات'
                                    },

                                    {
                                      genre_id: 2,
                                      locale: 'en',
                                      name: 'Biography'
                                    },
                                    {
                                      genre_id: 2,
                                      locale: 'ar',
                                      name: 'سير ذاتية'
                                    },

                                    {
                                      genre_id: 3,
                                      locale: 'en',
                                      name: 'Cookbook'
                                    },
                                    {
                                      genre_id: 3,
                                      locale: 'ar',
                                      name: 'كتب طبخ'
                                    },

                                    {
                                      genre_id: 4,
                                      locale: 'en',
                                      name: 'Dictionary'
                                    },
                                    {
                                      genre_id: 4,
                                      locale: 'ar',
                                      name: 'معاجم وقواميس'
                                    },

                                    {
                                      genre_id: 5,
                                      locale: 'en',
                                      name: 'Detective'
                                    },
                                    {
                                      genre_id: 5,
                                      locale: 'ar',
                                      name: 'تحقيقات'
                                    },

                                    {
                                      genre_id: 6,
                                      locale: 'en',
                                      name: 'Economics'
                                    },
                                    {
                                      genre_id: 6,
                                      locale: 'ar',
                                      name: 'اقتصاد'
                                    },

                                    {
                                      genre_id: 7,
                                      locale: 'en',
                                      name: 'Entertainment'
                                    },
                                    {
                                      genre_id: 7,
                                      locale: 'ar',
                                      name: 'تسلية'
                                    },

                                    {
                                      genre_id: 8,
                                      locale: 'en',
                                      name: 'Fantasy'
                                    },
                                    {
                                      genre_id: 8,
                                      locale: 'ar',
                                      name: 'خيال'
                                    },

                                    {
                                      genre_id: 9,
                                      locale: 'en',
                                      name: 'Finance'
                                    },
                                    {
                                      genre_id: 9,
                                      locale: 'ar',
                                      name: 'أمور مالية'
                                    },

                                    {
                                      genre_id: 10,
                                      locale: 'en',
                                      name: 'Health'
                                    },
                                    {
                                      genre_id: 10,
                                      locale: 'ar',
                                      name: 'صحة'
                                    },

                                    {
                                      genre_id: 11,
                                      locale: 'en',
                                      name: 'History'
                                    },
                                    {
                                      genre_id: 11,
                                      locale: 'ar',
                                      name: 'تاريخ'
                                    },

                                    {
                                      genre_id: 12,
                                      locale: 'en',
                                      name: 'Horror'
                                    },
                                    {
                                      genre_id: 12,
                                      locale: 'ar',
                                      name: 'رعب'
                                    },

                                    {
                                      genre_id: 13,
                                      locale: 'en',
                                      name: 'Lifestyle'
                                    },
                                    {
                                      genre_id: 13,
                                      locale: 'ar',
                                      name: 'حياة'
                                    },

                                    {
                                      genre_id: 14,
                                      locale: 'en',
                                      name: 'Mystery'
                                    },
                                    {
                                      genre_id: 14,
                                      locale: 'ar',
                                      name: 'ألغاز'
                                    },

                                    {
                                      genre_id: 15,
                                      locale: 'en',
                                      name: 'Reference'
                                    },
                                    {
                                      genre_id: 15,
                                      locale: 'ar',
                                      name: 'مراجع'
                                    },

                                    {
                                      genre_id: 16,
                                      locale: 'en',
                                      name: 'Religion'
                                    },
                                    {
                                      genre_id: 16,
                                      locale: 'ar',
                                      name: 'أديان'
                                    },

                                    {
                                      genre_id: 17,
                                      locale: 'en',
                                      name: 'Romance'
                                    },
                                    {
                                      genre_id: 17,
                                      locale: 'ar',
                                      name: 'حب'
                                    },

                                    {
                                      genre_id: 18,
                                      locale: 'en',
                                      name: 'Fiction'
                                    },
                                    {
                                      genre_id: 18,
                                      locale: 'ar',
                                      name: 'خيال علمي'
                                    },

                                    {
                                      genre_id: 19,
                                      locale: 'en',
                                      name: 'Self-help'
                                    },
                                    {
                                      genre_id: 19,
                                      locale: 'ar',
                                      name: 'تنمية بشرية'
                                    },

                                    {
                                      genre_id: 20,
                                      locale: 'en',
                                      name: 'Technology'
                                    },
                                    {
                                      genre_id: 20,
                                      locale: 'ar',
                                      name: 'تكنولوجيا'
                                    },

                                    {
                                      genre_id: 21,
                                      locale: 'en',
                                      name: 'Thriller'
                                    },
                                    {
                                      genre_id: 21,
                                      locale: 'ar',
                                      name: 'إثارة'
                                    },

                                    {
                                      genre_id: 22,
                                      locale: 'en',
                                      name: 'Western'
                                    },
                                    {
                                      genre_id: 22,
                                      locale: 'ar',
                                      name: 'غربي'
                                    },

                                    {
                                      genre_id: 23,
                                      locale: 'en',
                                      name: 'Other'
                                    },
                                    {
                                      genre_id: 23,
                                      locale: 'ar',
                                      name: 'غير ذلك'
                                    },

                                    {
                                      genre_id: 24,
                                      locale: 'en',
                                      name: 'Business'
                                    },
                                    {
                                      genre_id: 24,
                                      locale: 'ar',
                                      name: 'أعمال'
                                    },

                                    {
                                      genre_id: 25,
                                      locale: 'en',
                                      name: 'Science'
                                    },
                                    {
                                      genre_id: 25,
                                      locale: 'ar',
                                      name: 'علوم'
                                    },

                                    {
                                      genre_id: 26,
                                      locale: 'en',
                                      name: 'Languages'
                                    },
                                    {
                                      genre_id: 26,
                                      locale: 'ar',
                                      name: 'لغات'
                                    },

                                    {
                                      genre_id: 27,
                                      locale: 'en',
                                      name: 'Poetry'
                                    },
                                    {
                                      genre_id: 27,
                                      locale: 'ar',
                                      name: 'شعر'
                                    },

                                    {
                                      genre_id: 28,
                                      locale: 'en',
                                      name: 'Children'
                                    },
                                    {
                                      genre_id: 28,
                                      locale: 'ar',
                                      name: 'أطفال'
                                    },
                                  ])
      end

      dir.down do
        Genre.drop_translation_table!
        Language.drop_translation_table!
      end
    end
  end
end
