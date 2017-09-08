function basarim(Answer,Target)
match = 0;
boyut = (size(Answer,1)*size(Answer,2));
for i = 1:boyut
    if (Answer(i) == Target(i))
        match = match + 1;
    end
end
percentage = (match/boyut)*100;
disp(percentage)
end