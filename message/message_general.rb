def empty_staging(com, user)
  @comm = com
  @user = user
  @comm.start_with?('/status') ? empty_status : empty_general
end

def general_empty_stg
  "@#{@user} forgot to type staging name 😒"
end

def empty_general
  general_empty_stg + "\nExample: <code>#{@comm} 103</code>"
end

def empty_status
  general_empty_stg + "\nExample: <code>#{@comm} 21 51 103</code>"
end

def stg_not_exist(stg)
  general_stg = 'dilihat statusnya' if @txt.start_with?('/status')
  general_stg = 'di-done-kan' if @txt.start_with?('/done')
  "Belum pernah ada yang booking <code>staging#{stg}.vm</code>, jadi ga bisa " + general_stg + ', Kak'
end

def chat_not_found
  'Jenkins chat not found, please check @mpermperpisang'
end

def msg_block_deploy(user)
  "Please book the staging first, @#{user}"
end

def mention_admin
  'Colek Kak @mpermperpisang'
end

def send_off(bot)
  "#{bot} offline, please check @mpermperpisang"
end

def empty_branch(comm, user)
  "@#{user} forgot to type the branch 😒\nExample: <code>#{comm} master</code>"
end

def new_staging(name, staging)
  "<code>staging#{staging}.vm</code> staging baru yaa, Kak @#{name}?
Bilang ke Kak @mpermperpisang dulu yaa buat ditambahin ke daftar 😉"
end

def error_deploy(user, staging, name)
  "@#{user} did not booking <code>staging#{staging}</code> but trying to deploy into it\nFYI @#{name}"
end

def error_dev(user)
  "Sorry @#{user}, only BE or FE can request deploy to staging"
end

def error_qa(user)
  "Sorry @#{user}, you're not QA or at least you're not added in QA list yet 😬
Private message @mpermperpisang, please
Or maybe you want to try other features such like /lock, /start, /restart, /stop, /migrate, /reindex or /precompile ☺️"
end

def error_pm(user)
  "@#{user}, maap anda belum beruntung :p (kudu ama PM, APM atau admin)"
end

def msg_queue_deploy(user, staging, branch, name, queue)
  "@#{user} is deploying <code>staging#{staging}</code>
Branch: <b>#{branch.strip}</b>
Requesting by #{name}
Cap queue: #{queue}"
end

def list_deployment(list, user)
  "Sekarang aku lagi nge-deploy daftar ini ke staging, Kak @#{user}\nMohon bersabar yaa 😚\n\n#{list}"
end

def empty_deployment(user)
  "Sekarang aku lagi ngga deploy apa-apa, Kak @#{user}
Kalau deploy, ga akan antri lama loh"
end

def blocked_bot(user)
  "#{user} ngeblock botnya, please check @mpermperpisang"
end

def welcome_text(user)
  "Selamat datang, #{user}\nSilahkan ketik /help untuk tahu informasi lebih lanjut yaa"
end

def msg_queue_cap(type, stg, queue)
  bb = %w[start restart stop]

  cap = "Lock release <code>staging#{stg}</code>" if type == 'lock'
  cap = "Backburner #{type} <code>staging#{stg}</code>" if bb.include?(type)
  cap + "\nCap queue: #{queue}"
end

def msg_queue_rake(type, stg, queue)
  rake = "Database migrate <code>staging#{stg}</code>" if type == 'migrate'
  rake = "Database reindex <code>staging#{stg}</code>" if type == 'reindex'
  rake = "Asset precompile <code>staging#{stg}</code>" if type == 'precompile'
  rake + "\nRake queue: #{queue}"
end

def normalize(stg, date)
  "Date of <code>staging#{stg}</code> become <b>#{date}</b>"
end

def msg_book_staging(user, stg)
  "@#{user} is booking <code>staging#{stg}</code>"
end

def msg_still_book(stg, user)
  "You are still book <code>staging#{stg}</code>, @#{user}"
end

def msg_using_staging(user, stg, name)
  "<code>@#{user}</code> is still using <code>staging#{stg}</code>, @#{name}"
end

def msg_done_staging(user, stg)
  "@#{user} has done using <code>staging#{stg}</code>"
end

def msg_deploy(user, branch)
  "@#{user} is requesting to deploy.\nBranch: <b>#{branch.strip}</b>"
end

def deployed
  "Already deployed all branch to staging\nOtsukaresamadeshita"
end

def msg_list_request(list)
  "List of deploy requests\n\n#{list}\n\n@mpermperpisang @rezaldy08"
end

def list_request_access
  'Branch is already in list. Click /list_request, please'
end

def cancel_empty(user, branch)
  "Branch <code>#{branch.strip}</code> tidak ditemukan dalam daftar request deploy
Jadi ga bisa dicancel, Kak @#{user}"
end

def msg_cancel_deploy(branch)
  "Request deploy branch <b>#{branch.strip}</b> has been cancelled"
end

def default_poin
  '0 adalah angka default, Kak'
end

def accepted_poin
  'Poin diterima. Kakak ga bisa ubah nilai yang udah diberikan yaa 😇'
end

def next_chance
  'tunggu kloter berikutnya yaa'
end

def next_poin
  'Menunggu poin selanjutnya'
end

def choose_poin
  'Pilih poin'
end

def block_poin
  'Pemberian poin hanya bisa lewat inline keyboard saja, Kak
Silahkan pilih poin di bawah ini atau klik /keyboard'
end

def not_member_market
  'Kakak belum terdaftar untuk ikut marketplace\nCoba tanya ke Kak @mpermperpisang ajah yaa'
end

def empty_edit(error)
  "There is no message to edit, please check @mpermperpisang\n#{error}"
end

def list_poin_market(poin)
  "Poin for marketplace\n======================================\n#{poin}\n
colek @ak_fahmi @Maharaniar"
end

def empty_poin
  'Belum ada orang yang memberikan poin untuk marketplace'
end

def msg_new_poin_member
  "Menampilkan poin\nSilahkan cek rame-rame di grup BBM-DANA Bot Announcements yaa\n
Kloter sudah dibuka, tunggu aba-aba dari PM/APM yaa"
end

def msg_new_poin
  "Menampilkan poin\nSilahkan cek rame-rame di grup BBM-DANA Bot Announcements yaa"
end

def done_poin(poin)
  "Yang sudah memberikan poin:\n#{poin}\n\nKalau sudah selesai, klik /show yaa, Kak"
end

def show_command
  "Ketik /show (untuk menampilkan poin) atau klik /keyboard (untuk memilih poin)
Kalau butuh bantuan, klik /help yaa
Have a nice marketplace ☺️"
end

def msg_duplicate_add_people(user, name)
  "@#{user}, kok <code>#{name}</code> didaftarin lagi sih? 😅"
end

def error_general_day
  "Format is invalid, please use only <b>mon</b>, <b>tue</b>, <b>wed</b>, <b>thu</b> or <b>fri</b>\nExample:"
end

def error_day(com)
  error_general_day + " <code>#{com} mon @username</code>"
end

def msg_weather(weather, poem)
  "Hari ini katanya sih cuacanya #{weather} loh#{poem} 🤗"
end

def msg_add_people(user, name, day)
  "Cihuy <code>@#{user}</code> nambahin #{name} buat bawa snack di hari #{day}
Catat juga di <a href='https://bit.ly/2FBKhA4'>CONFLUENCE</a> yaa"
end

def msg_edit_people(user, name, day)
  "Oi oi oi #{name} jadwal snacknya udah diganti sama <code>@#{user}</code> jadi hari #{day} yaa"
end

def error_spam(user)
  "@#{user} terdeteksi sebagai spammer"
end

def empty_people(user)
  "<code>#{user}</code> ngga ada di squad Bandung 👻"
end

def error_general_empty(com)
  "Formatnya salah, Kak\nCobain deh <code>#{com} @username1 @username2</code>"
end

def empty_snack(com, user)
  "Nice try @#{user} but useless\n" + error_general_empty(com)
end

def msg_delete_people(user)
  "ByBy #{user}"
end

def msg_reminder_schedule(day, user)
  "Jadwal kamu kan hari #{day}, Sayang\n#{user} lupa yaa? 😤"
end

def msg_done_spam(user, name)
  "<code>#{name}</code> udah bawa 🐍 kok\n@#{user} ngga usah nge-spam deh"
end

def msg_holiday_spam(user, name)
  "<code>#{name}</code> lagi libur bawa 🐍 tau\n@#{user} ngga usah nge-spam deh"
end

def msg_done_people(user)
  "Yeay dapat cemilan dari #{user}.\nSelamat menggendutkan diri, kawan-kawan\n😈"
end

def see_schedule
  'Lihat jadwal snack'
end

def msg_holiday_all
  'Selamat hari libur berjamaah yaa, Kak'
end

def msg_reminder_people(day, name, user)
  "Ayoyo ojo lali. Daftar yang belum bawa hari #{day}
#{name}

*yang merasa belum diwajibkan untuk membawa snake, abaikan saja pesan ini\nby : <code>@#{user}</code>"
end

def msg_invalid_squad(squad, user)
  "<code>#{squad.upcase.strip}</code> squad apa tuch, Kak @#{user}?
Aku cuma tau squad <b>WTB</b>, <b>DANA</b>, <b>ART</b>, <b>CORE</b> (Apps) dan <b>DISCO</b>"
end

def holiday_schedule
  "Libur telah tiba\nHatiku gembira ⛱🏖🏝"
end

def empty_schedule
  "Yeay banyak cemilan.\nSelamat menggendutkan diri, kawan-kawan\n😈"
end

def msg_cancel_people(user)
  "#{user} ndak jadi bawa 🐍"
end

def msg_holiday_people(user)
  "<code>#{user}</code> izin libur dulu yaa"
end

def msg_normal_snack
  "Snack sudah kembali sesuai jadwal di <a href='https://bit.ly/2FBKhA4'>CONFLUENCE</a> yaa"
end

def msg_change_people(user, name, day)
  "Haeyo #{name}, sekarang jadwalnya jadi hari #{day}
<code>@#{user}</code> ubah juga di <a href='https://bit.ly/2FBKhA4'>CONFLUENCE</a> yaa"
end

def private_message(user)
  "Tolong japri aku dulu yaa, Kak #{user} buat tau list Hi5nya"
end

def by_user(user)
  "\n\nBy: <code>@#{user}</code>"
end

def choosing_squad(user)
  "Pilih squadnya yaa, Kak @#{user}"
end

def msg_invalid_hi5
  "Tapi kalau maksud Kakak buat nambahin anggota ke daftar HI5, formatnya salah, Kak
Squad Bandung yang ada saat ini: <b>WTB</b>, <b>DANA</b>, <b>ART</b>, <b>CORE</b> (Apps) dan <b>DISCO</b>
Contoh buat nambahin username ke daftar HI5\n\n<code>/hi5 dana @username1 @username2</code>

🐾 Kalau ada perubahan squad di Bandung tolong kasih tau @mpermperpisang yaa"
end

def list_hi5(squad, count)
  "Hi5 squad <b>#{squad.upcase}</b>\nKalo daftar ini ga update, mohon kasih tau <code>@mpermperpisang</code> yaa
Jumlah: #{count} orang"
end

def empty_member(squad, user)
  "Stok anggota squad #{squad.upcase} lagi kosong, Kak @#{user}"
end

def msg_delete_hi5(squad, name)
  "Berhasil menghapus #{name} di squad #{squad.upcase.strip}"
end

def msg_add_hi5(squad, name)
  "Berhasil menambahkan #{name} di squad #{squad.upcase.strip}"
end

def msg_edit_hi5(squad, name)
  "Berhasil mengubah #{name} di squad #{squad.upcase.strip}"
end

def list_schedule(day, name, count)
  "Jadwal snack #{day}:\n<code>#{name}</code>\nJumlah: #{count} orang"
end

def telegram_error
  'Telegram stuff, dont worry'
end
