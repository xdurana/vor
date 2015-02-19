if light
   figure;
   hold on;
   plot(Dt, 'g');
   hold on;
   plot(D, 'y');
   hold on;
   plot(P, 'r');
   hold on;
   plot(M, 'm');
   hold on;
   plot(Cf, 'b');
   legend('target', 'VN', 'PC', 'MF', 'CF');
end