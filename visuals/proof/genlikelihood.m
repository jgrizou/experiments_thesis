function l = genlikelihood2(ratio, nSA)

l = zeros(size(ratio));
for i = 1:length(ratio)

    l(i) = ratio(i).^(ratio(i)*nSA) * (1-ratio(i)).^((1-ratio(i))*nSA);

end