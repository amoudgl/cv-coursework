function [matched_points1, matched_points2] = siftMatch(im1, im2, n) 
    I = single(im1);
    J = single(im2);

    [F1, D1] = vl_sift(I);
    [F2, D2] = vl_sift(J);

    % Where 1.5 = ratio between euclidean distance of NN2/NN1
    [matches, score] = vl_ubcmatch(D1,D2,1.5);
    [smallestElements, smallestIndices] = getNElements(score, n);
    matches = matches(:, smallestIndices);
    matched_points1 = [F1(1,matches(1,:));F1(2,matches(1,:))]';
    matched_points2 = [F2(1,matches(2,:));F2(2,matches(2,:))]';
end