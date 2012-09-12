# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# rake db:drop && rake db:create && rake db:migrate && rake db:seed
Genre.create! :name => "Children's Music", :abbr => "kids"
Genre.create! :name => "Old Time", :abbr => "geezer"

album = ProductType.create! :name => 'album', :price => 20.00
video = ProductType.create! :name => 'video', :price => 25.00
book = ProductType.create! :name => 'book', :price => 15.00

user = User.create! :name => 'admin', :email => 'jessenaiman@gmail.com', :password => 'abc123', :password_confirmation => 'abc123'
puts 'New user created: ' << user.name
user.add_role :admin

kathy = Artist.create! :name=> "Kathy Reid-Naiman", :content => '<p>
	Kathy Reid-Naiman is a full time children&#39;s performer, and a member of <a href="http://www.mits.on.ca/">Mariposa in the Schools</a>, an organization dedicated to bringing quality musical experiences to school children in Ontario. She is also a member of the <a href="http://www.cmnonline.org/">Children&#39;s Music Network</a>. Her children&#39;s recordings; Tickles &amp; Tunes, More Tickles &amp; Tunes, Say Hello to the Morning, A Smooth Road to London Town, On My Way to Dreamland and Reaching For the Stars!&nbsp;have become very popular with pre-school teachers and families with toddler&#39;s &amp; young children. She has been teaching classes for young children 6 months to 6 years old and their caregivers since 1982 in libraries in Ontario. She is currently running classes in&nbsp;<a href="http://www.library.aurora.on.ca/page/children/programs/preschoolers"> Aurora,</a>&nbsp; and&nbsp; <a href="http://www.uxlib.com/modules/kid_teen/kids/kprog.html">Uxbridge</a>.</p>
<br />
<p>
	&nbsp;</p>
<p>
	Kathy has presented workshops for the American Library Association, the Ontario Library Association, the Southern Ontario Libraries Services, Frontier College, the National Association for the Education of the Young Child, the California Association for the Education of the Young Child and the Children&rsquo;s Music Network&rsquo;s national gatherings.</p>
<p>
	&nbsp;</p>
<p>
	Kathy is very active as a folk-musician. She plays with Arnie Naiman as <a href="http://www.merriweather.ca/artist.aspx?ID=18">Ragged but Right</a> and she is the fiddler for The Toronto Women&#39;s Sword Team.</p>
<p>
	She has performed at Mariposa, Winnipeg, Northern Lights festivals and The International Sword Gathering in Scarborough, England and has been on staff at <a href="http://www.cdss.org/">Pinewoods Music and Dance Camp</a> in Massachusetts and Ogontz Camp in New Hampshire and <a href="http://www.mgl.ca/%7Ejhcole/thewoods/thewoods.html">The Woods</a> music and dance camp in Muskoka.&nbsp;She plays guitar, fiddle, Appalachian dulcimer, autoharp and banjo uke.</p>
<br />
<p>
	<a href="http://www.merriweather.ca/artist.aspx?ID=18">Ragged But Right</a> has released a brand new cd of mostly old time singing duets. The cd is called <a href="http://www.merriweather.ca/albums.aspx?ID=37">&quot;Down Harmony Road&quot;</a> and is available at Elderly Instruments, County Sales, CD Baby in the U.S.A. and directly from us Merriweather Records and Paypal in Canada.</p>
<br />
<p>
	Visit Ragged But Right<a href="http://www.myspace.com/raggedbutright"> Myspace</a></p>
<p>
	Visit <a href="http://merriweather.ca/Home.aspx?ID=5">Kathy&#39;s Class</a> page&nbsp;</p>
<p>
	Visit Kathy&#39;s <a href="http://www.merriweather.ca/Template.aspx?ID=62">Workshop</a> page</p>'

kathy_band = Band.create! :name=>'Kathy Reid-Naiman', :self_titled=>true

puts 'artist created'


Post.create! :title => 'Here we go', :content => '<p>
	It&rsquo;s here!</p>
<p>
	<a href="http://merriweather.ca/albums.aspx?ID=55">Here We Go Zodeo</a></p>
<p>
	Singing games and playparties for children of all ages</p>
<p>
	by</p>
<p>
	<a href="http://merriweather.ca/artist.aspx?ID=1">Kathy Reid-Naiman </a>&nbsp;and &nbsp;<a href="http://merriweather.ca/artist.aspx?ID=26">Hannah Naiman</a></p>
<p>
	Here We Go Zodeo by veteran children&rsquo;s musician Kathy Reid-Naiman and her daughter Hannah Naiman is a delightful collection of singing games and dances for children of all ages. The tracks are full dance length so they can be easily used in the classroom when a live musician is not available. Many of these are traditional games that were sung without any musical accompaniment so once the song is learned they can be danced anywhere, anytime!</p>'

puts 'post created'

tickles = Product.create! :name=>'Tickles and Tunes', :band_id => kathy_band.id, :content => "A wonderful collection of songs, tickles, knee bounces, and singing games, for the very young child, particularly those aged 6 months to 6 years old. It was produced by Ken Whiteley, the same man who produced Raffi, Fred Penner, and many, many other great children's recording artists. Kathy plays Appalachian Dulcimer, Guitar, Banjo, Fiddle and Autoharp, and Ken accompanies her on 20 other instruments.", :gemm => "M9701CD", :band_id => 1, :genre_id => 1, :product_type_id => album.id

puts 'Starting songs seed'
song1 = Song.create! :name=>'Don_Valley_Ramble', :mp3 => '/uploads/song/mp3/1/5_Strings_Attached_With_No_Backing-Don_Valley_Ramble.mp3', :product_id => tickles.id
song2 = Song.create! :name=>'Paquet_d_epingles', :mp3 => '/uploads/song/mp3/2/_-_Paquet_d_epingles.mp3', :product_id => tickles.id
song3 = Song.create! :name=>'Elkorn_Ridge.mp3', :mp3 => '/uploads/song/mp3/3/5_Strings_Attached_With_No_Backing-Elkorn_Ridge.mp3', :product_id => tickles.id
