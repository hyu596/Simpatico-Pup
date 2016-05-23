#encoding: utf-8

pups = [{:pup_name => 'Chloe', :breeder_id => '1', :breed_1 => 'Cocker Spaniel', :breed_2 => 'Poodle', :breeder_responsibility => '5', :overall_health => '5', :trainability => '3', :social_behavior => '4', :energy_level => '4', :simpatico_rating => '5', :comments => 'great dog!'},
  	 	{:pup_name => 'Spot', :breeder_id => '2', :breed_1 => 'Dalmatian', :breed_2 => 'None', :breeder_responsibility => '3', :overall_health => '3', :trainability => '3', :social_behavior => '3', :energy_level => '3', :simpatico_rating => '3', :comments => 'love my dog!'},
  	 	{:pup_name => 'Gypsy', :breeder_id => '1', :breed_1 => 'Akita', :breed_2 => 'None', :breeder_responsibility => '5', :overall_health => '4', :trainability => '3', :social_behavior => '2', :energy_level => '1', :simpatico_rating => '5', :comments => 'not very playful'},
  	 	{:pup_name => 'Jenny', :breeder_id => '2', :breed_1 => 'Dalmatian', :breed_2 => 'None', :breeder_responsibility => '3', :overall_health => '4', :trainability => '5', :social_behavior => '5', :energy_level => '3', :simpatico_rating => '4', :comments => 'very well behaved!'}]
 
breeders = [{:name => 'Justin MacMillin', :city => "Porterville", :state => 'CA', :website => 'www.com', :kennel => 'happy dogs'},
			{:name => 'Alex McGourty', :city => "San Francisco", :state => 'CA', :website => 'www.com', :kennel => 'happy dogs 2'}]

text = [
    {:section_title => "Mission Statement", :section_order => 1, :title => "Your dog and you", :text => 'Chances are good that there is a dog at your feet as you read this. Dogs were probably the first species to be domesticated by humans around 15,000—30,000 years ago, and since then the histories of our two species have been closely intertwined. The association between humans and dogs began as one in which dogs served various utilitarian purposes such as guarding and hunting. Today, the vast majority of our dogs fill the role of family member and companion, as opposed to serving as working dogs. But even though most dogs no longer serve a practical role in our lives, the relationship between human and dog is certainly no less deep or meaningful. Pulitzer prize-winning biologist EO Wilson popularized the concept of biophilia in his book of the same name. Wilson uses this term to describe the powerful and subconscious urge that human beings have to connect with other forms of life, and nowhere is this urge better illustrated than the desire that many people have to spend their lives with a companion dog living in their home, at their side, and sharing almost every aspect of their lives.'},
    {:section_title => "Mission Statement", :section_order => 2, :title => "Dog breeding and responsibility", :text => 'Just as the relationship between humans and dogs has changed in recent times, so has our means of producing and acquiring them.  Few dogs today are bred primarily for their working ability. And thanks to the availability of spaying and neutering and an increased awareness of the problems of dog overpopulation, responsible dog owners no longer allow their dogs to breed randomly and indiscriminately, and produce unwanted litters. Instead, what we have today is a bizarre and dysfunctional system in which many, if not most of our companion dogs are produced in one of two ways: they are either bred by breed fanciers and subsequently culled from the show ring to be sold as “pet quality” dogs, or they were bred by profit-motivated individuals or corporations which collectively produce large numbers of puppies for the companion dog market with very little accountability. In many cases, these dogs are marketed online or through puppy wholesalers, without any way for puppy seekers to evaluate whether or not the dog breeder is ethical, humane, and breeding responsibly for good health and good temperament.'},
    {:section_title => "Mission Statement", :section_order => 3, :title => "Dog breeding and health", :text => 'As a veterinarian I can assure you that good health and good temperament are to a great degree heritable, and many dogs that were bred primarily for the show ring or bred by an unaccountable profit-motivated breeder will fall short in terms of health and temperament. The fact that a young puppy is cute and sweet and irresistibly appealing is no assurance that it will grow up to be a healthy, suitable companion dog. Far too many dog lovers discover the heartbreak of investing a huge amount of time, money and emotional involvement in a puppy that turns out to have serious health or behavioral problems. And for those kind-hearted individuals who believe that everyone should adopt a shelter dog as a companion, they are in fact advocating a system in which the general public acquires dogs that are largely unknowns in terms of health and temperament,which were by definition irresponsibly bred (because responsible breeders do not allow the puppies they breed to end up in shelters), and which have been put through the tremendous physical and emotional stress of a shelter experience. Shelter adoption is a lifeline for those unfortunate dogs that find themselves in such dire circumstances, but our goal should certainly be to create a system in which we reduce the number of irresponsibly bred dogs that end up in shelters. Making spaying and neutering accessible to people is not sufficient to reduce the flood of dogs that enter shelters, as long as irresponsible dog breeders can still find a market (often online) for their irresponsibly bred puppies, and unload their excess inventory in the night drop box of their local shelter.'},
    {:section_title => "Mission Statement", :section_order => 4, :title => "Breeder Ethics", :text => 'As a society, we can and should be doing so much more, and so much better, in terms of how companion dogs are produced in this country. We can do better in terms of recognizing those responsible dog breeders who have a track record of being ethical, providing their breeder dogs with an excellent quality of life, and putting top priority on producing puppies with superior health, temperament, and early socialization. For those dog lovers who truly want to share their lives with their companion dogs, we can and should be doing better in terms of producing dogs that have better health and temperaments, who can participate more fully in their owners’ lives. We should certainly be making all dog lovers aware of the importance of knowing exactly who produced the puppy they acquire, and what that breeder’s track record is for producing puppies with good health, excellent temperament, and good early socialization. Most importantly, if we start doing a better job in terms of producing better companion dogs, the dogs themselves will benefit. Because dogs that are healthier and better companions are rewarded by leading fuller lives in which they can participate extensively in the lives and activities of their owners. If we can create a system of transparency and accountability with respect to breeders of companion dogs, the dog-loving public will produce the demand for better quality companion dogs, and everyone can come out ahead. We just have to create the metric.'},
    {:section_title => "Mission Statement", :section_order => 5, :title => "Breeding success", :text => 'Bill Gates, founder of Microsoft and global philanthropist, recently stated, “In the past year, I have been struck by how important measurement is to improving the human condition. You can achieve incredible progress if you set a clear goal and find a measure that will drive progress toward that goal.” Dog breeders have worked diligently and successfully to produce dogs specifically suited to becoming service dogs, working dogs, or herding dogs. By developing a way to measure the success of dog breeders at producing excellent companion dogs, and by giving owners the opportunity to provide feedback as to the suitability of the dogs being produced, we can move toward the goal of improving the overall health and suitability of companion dogs in this country and reduce the number of irresponsibly bred dogs that end up cast off in shelters.'},
    {:section_title => "Mission Statement", :section_order => 6, :title => "Your ideal companion dog", :text => 'The ideal companion dog has an agreeable temperament, is well-socialized, and is a pleasure to be around. People who make the effort to find this website have probably had the pleasure of knowing a dog like this--the description may bring to mind the image of a Labrador retriever, or a toy poodle. You may think of a German shepherd, a sheltie, or a dog that is some blend of these breeds. I call these exceptional dogs simpatico dogs. Simpatico is a word that means like-minded, or compatible. Simpatico dogs come in all shapes and sizes, but what sets them apart is their sound health and temperament, and their desire to be with and communicate with their human family. And because of these qualities, they are rewarded by leading full lives in which they are able to participate extensively in the lives and activities of their owners.'},
    {:section_title => "Mission Statement", :section_order => 7, :title => "Qualities of an ideal companion dog", :text => 'So how can you maximize the chance that you will find a simpatico puppy when you make the important decision to add a new canine member to your family? It is clear that good health and good temperament in dogs are, to a great degree, heritable. And although we may not all agree precisely on exactly what constitutes an “ideal temperament”, we can probably all agree that too many dogs lose their lives, lose their homes, or are relegated to a lonely life isolated in a back yard away from their human pack members because they are aggressive, excessively fearful or anxious, or have other recognized health, behavior or temperament problems. A young puppy’s future health and temperament are often harder to predict than the physical traits that far too many breeders focus on, and it’s certainly true that not all health and behavioral problems are preventable by even the most careful and conscientious breeding program. But health and behavior are to a great extent heritable, and dog breeders who are producing companion dogs should be diligent in breeding for excellent health and temperament in their puppies, as well as breeding for the physical characteristics of their breed’s standards.'},
    {:section_title => "Mission Statement", :section_order => 8, :title => "Breeder responsibility and RateMyPup", :text => 'This website represents an attempt to create a yardstick that will identify and recognize those wonderful dog breeders who are working tirelessly and responsibly, for the love of dogs, to creating simpatico puppies for other dog lovers to cherish and enjoy. It is an attempt to provide a way for the dog-loving public to identify and obtain carefully bred, optimally raised puppies that have the potential to develop into exceptional companion dogs that will enrich their lives of their human families. Equally important, it is an attempt to improve the lives of dogs--because dogs with good health, good temperaments, good socialization, and good early training have richer and more full lives than those who don\’t.'},
    {:section_title => "Mission Statement", :section_order => 9, :title => "Help us help you", :text => 'This site is a work in progress. I believe we can create a network of information and education that will benefit responsible breeders, the dog-loving public, and companion dogs alike. In the spirit of working together to achieve this goal, I welcome the input, comments and suggestions of dog lovers everywhere in order to realize it.'}
]

breeders.each do |breed|
  Breeder.create!(breed)
end

pups.each do |pup|
  Pup.create!(pup)
end

text.each do |text|
  Text.create!(text)
end