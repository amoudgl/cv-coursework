function [matched_points1, matched_points2] = surfFeatures(im1, im2, n)
    points1 = detectSURFFeatures(im1);
    points2 = detectSURFFeatures(im2);
    [f1, vpnts1] = extractFeatures(im1, points1);
    [f2, vpnts2] = extractFeatures(im2, points2);
    [indexPairs, distance] = matchFeatures(f1, f2);
    [smallest4, bestIndices] = getNElements(distance, n);
    indexPairs = indexPairs(bestIndices, :);
    matched_points1 = vpnts1(indexPairs(:, 1));
    matched_points2 = vpnts2(indexPairs(:, 2));
end