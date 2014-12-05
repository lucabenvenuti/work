function plotNormCDF(u,s,color)
    mu = u; 
    sigma = s; 
    x = (mu -  5*sigma) : (sigma / 100) : (mu + 5*sigma); 
    pdfNormal = normpdf(x, mu, sigma);
    plot(x,cumsum(pdfNormal)./max(cumsum(pdfNormal)),color)
end
