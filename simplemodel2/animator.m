history = process;
for k = 1:size(history, 1)/3-1
    pause(0.5)
    surf(history(k*3:k*3+3,:))
    drawnow
end