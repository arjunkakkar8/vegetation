history = process;
for k = 1:size(history, 1)/20-1
    pause(1)
    surf(history(k*20:k*20+20,:))
    drawnow
end