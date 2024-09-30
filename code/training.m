%training all the images with para L
function feature = training(L)
    feature = zeros(1, 2 ^ (3 * L));
    %extract faces one by one
    for temp1 = 1: 33
        temp_road = "source/Faces/" + string(temp1) + ".bmp";%road to the image
        temp_face = imread(temp_road);
        temp_feat = extract(temp_face, L);
        feature = feature + temp_feat;%record the feat
    end
    feature = feature / 33;
end