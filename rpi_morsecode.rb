require "pi_piper"

UNIT              = 0.1
DOT               = UNIT
DASH              = UNIT * 3
INTER_ELEMENT_GAP = UNIT
SHORT_GAP         = UNIT * 3
MEDIUM_GAP        = UNIT * 7

#http://en.wikipedia.org/wiki/Morse_code
character_timing = { 
  "a" => [DOT,  DASH                  ],             
  "b" => [DASH, DOT,  DOT,  DOT       ],   
  "c" => [DASH, DOT,  DASH, DOT       ],
  "d" => [DASH, DOT,  DOT             ],        
  "e" => [DOT                         ],                   
  "f" => [DOT,  DOT,  DASH, DOT       ], 
  "g" => [DASH, DASH, DOT             ],      
  "h" => [DOT,  DOT,  DOT,  DOT       ],    
  "i" => [DOT,  DOT                   ],
  "j" => [DOT,  DASH, DASH, DASH      ], 
  "k" => [DASH, DOT,  DASH            ],       
  "l" => [DOT,  DASH, DOT,  DOT       ],
  "m" => [DASH, DASH                  ],            
  "n" => [DASH, DOT                   ],             
  "o" => [DASH, DASH, DASH            ],
  "p" => [DOT,  DASH, DASH, DOT       ],  
  "q" => [DASH, DASH, DOT,  DASH      ], 
  "r" => [DOT,  DASH, DOT             ],
  "s" => [DOT,  DOT,  DOT             ],         
  "t" => [DASH                        ],                  
  "u" => [DOT,  DOT,  DASH            ],
  "v" => [DOT,  DOT,  DOT,  DASH      ],   
  "w" => [DOT,  DASH, DASH            ],       
  "x" => [DASH, DOT,  DOT,  DASH      ],
  "y" => [DASH, DOT,  DASH, DASH      ], 
  "z" => [DASH, DASH, DOT,  DOT       ],
  "0" => [DASH, DASH, DASH, DASH, DASH],  
  "1" => [DOT,  DASH, DASH, DASH, DASH],
  "2" => [DOT,  DOT,  DASH, DASH, DASH],    
  "3" => [DOT,  DOT,  DOT,  DASH, DASH],
  "4" => [DOT,  DOT,  DOT,  DOT,  DASH],     
  "5" => [DOT,  DOT,  DOT,  DOT,  DOT ],
  "6" => [DASH, DOT,  DOT,  DOT,  DOT ],      
  "7" => [DASH, DASH, DOT,  DOT,  DOT ],
  "8" => [DASH, DASH, DASH, DOT,  DOT ],    
  "9" => [DASH, DASH, DASH, DASH, DOT ]
} 

pin = PiPiper::Pin.new(:pin => 17, :direction => :out)
pin.off

loop do
  print "Enter message('#QUIT' to exit): "
  message = gets.chomp.downcase

  break if message == "#quit"

  message.each_char do |letter|
    if letter == " "
      pin.off
      sleep MEDIUM_GAP
    else
      unless character_timing[letter].nil?
        print "Coding '#{letter}'... "
        character_timing[letter].each do |timing| 
          pin.on
          sleep timing
          pin.off
          sleep INTER_ELEMENT_GAP
        end
        sleep SHORT_GAP - INTER_ELEMENT_GAP
      
        puts "Done."
      end
    end
  end

end