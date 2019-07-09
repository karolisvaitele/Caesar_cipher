require 'sinatra'
require 'sinatra/reloader' if development?

get '/' do
    str = params.fetch :string, ""
    shift = params.fetch :shift, 0
    ciphered = caesar_cipher(str, shift.to_i)
    erb :index, locals: {ciphered: ciphered}
end

def caesar_cipher(str, shift)
    new_str = ""
    str.each_byte do |char|
        new_char = char.chr
        if char>=65 and char<=90
            if char + shift>90
                while char + shift >= 116 do 
                    char-=26
                end
                new_char = (char + shift - 90 + 64).chr
            else new_char = (char + shift).chr
            end
        elsif char>=97 and char<=122
            if char + shift>122
                while char + shift >= 148 do 
                    char-=26
                end
                new_char = (char + shift - 122 + 96).chr
            else new_char = (char + shift).chr
            end
        end
        new_str += new_char
    end
    return new_str
end