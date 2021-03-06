%choose the saved model
%load('test1_peak0.mat')
load('bw.mat')
%load('task1_peak2.mat')
load('task1_re.mat') 
peak=2;
match_thres=1.5;
points_world=[points_triangle1;points_triangle2;points_triangle3];
desp_world=[desp_1,desp_2,desp_3];
camera_pose_recorded=[];

for i=1:24
   try
    I_detected=imread(strcat('DSC_97',num2str(50+i),'.JPG'));
    % initialization  calculation of first pose using ransac
    % alternative: choose personally
    %BW = roipoly(I_detected);
    BW = bw_recorded{i};
    I_single=single(rgb2gray(I_detected));
    % computing sift points
    [f,d] = vl_sift(I_single,'PeakThresh',peak) ;
    for idx = 1:size(f,2)
    if  BW(int16(f(2,idx)),int16(f(1,idx)))==false
           f(1,idx)=[0];
    end
    end    
    d( :, f(1,:)==0 ) = [];
    f( :, f(1,:)==0 ) = [];  %columns
    % matching
    [matches, scores] = vl_ubcmatch(d,desp_world,match_thres);
    p_image=f(1:2,matches(1,:));
    p_world=points_world(matches(2,:),:);
    % use ransac for calculation
    confidence=0.99;
    outlier_prob=0.8;
    s=4;
    N=int16(log(1-confidence)/log(1-(1-outlier_prob)^s));
    outlier_crit=10;
    best_inlier_number=0;
    for i=4:4
        point_size=size(p_image,2);
        chosen_sample=randperm(point_size,4);
        world_sample=p_world(chosen_sample,:);
        image_sample=p_image(:,chosen_sample);
        try
            [worldOrientation2,worldLocation2,inlierIdx] = estimateWorldCameraPose(image_sample',world_sample,cameraParams,'MaxReprojectionError',100000000000000000);
            %[worldOrientation2,worldLocation2,inlierIdx] = estimateWorldCameraPose(imagePoints2,xcoor,cameraParams,'MaxReprojectionError',1000000000000000000);
            [rotationMatrix2,translationVector2] = cameraPoseToExtrinsics(worldOrientation2,worldLocation2);
            % calculate the reprojection of the 3d points
            p_image_calc = worldToImage(cameraParams,rotationMatrix2,translationVector2,p_world);
            p_image_calc = p_image_calc';
            distance=p_image-p_image_calc;
            distance=distance.^2;
            distance=sqrt(sum(distance,1));
            inlier_number=sum(distance<outlier_crit);
            if inlier_number>best_inlier_number
                best_inlier_number=inlier_number;
                best_inlierIdx=distance<outlier_crit;
                best_worldOrientation=worldOrientation2;
                best_worldLocation=worldLocation2; 
                best_rotationMatrix=rotationMatrix2;
                best_translationVector=translationVector2;
            end
        catch
            continue
        end
    end

    % calculate the inliers
    p_image_calc = worldToImage(cameraParams,best_rotationMatrix,best_translationVector,p_world);
    p_image_calc = p_image_calc';
    p_image = p_image(:,best_inlierIdx);
    p_image_calc =p_image_calc(:,best_inlierIdx);
    p_world = p_world(best_inlierIdx,:);

    % storing camera pose
    camera_pose=[best_worldOrientation,best_worldLocation'];
    para_recorded=[rotationMatrixToVector(best_rotationMatrix),best_translationVector];   
    % parameter initialization
    iter_number=100;
    update_thres=0.01;
    step=0.001;
    para=para_recorded(size(para_recorded,1),:);
    k=0;
    u=update_thres+1;
    while (k<N & u>update_thres) 

    % parameter preparation
    v=para(1:3);
    R=rotationVectorToMatrix(v);
    t=para(4:6);
    p_image_calc= worldToImage(cameraParams,R,t,p_world);
    p_image_calc=p_image_calc';
    v_skew=[0 -v(3) v(2); v(3) 0 -v(1); -v(2) v(1) 0];
    A=[2960.37845,0, 1841.68855;0,2960.37845,1235.23369;0,0,1];
    J=[];
    % energy calculation
    e=p_image_calc-p_image;
    e=sqrt(sum(e.^2,1));
    energy=sum(e);
    fprintf('energy is %d \n',energy);
    % derivation of Jacobian
    e=p_image_calc-p_image;
    e=e(:);
    % derivative of R to r
    R_mid1 = cross(v,(eye(3)-R)*[1;0;0]);
    R_skew1 =  [0 -R_mid1(3) R_mid1(2); R_mid1(3) 0 -R_mid1(1); -R_mid1(2) R_mid1(1) 0];
    dR_dv1=(v(1)*v_skew+R_skew1)*R/sum(v.^2);
    R_mid2 = cross(v,(eye(3)-R)*[0;1;0]);
    R_skew2 =  [0 -R_mid2(3) R_mid2(2); R_mid2(3) 0 -R_mid2(1); -R_mid2(2) R_mid2(1) 0];
    dR_dv2=(v(2)*v_skew+R_skew2)*R/sum(v.^2);
    R_mid3 = cross(v,(eye(3)-R)*[0;0;1]);
    R_skew3 =  [0 -R_mid3(3) R_mid3(2); R_mid3(3) 0 -R_mid3(1); -R_mid3(2) R_mid3(1) 0];
    dR_dv3=(v(3)*v_skew+R_skew3)*R/sum(v.^2);

    % derivative from back to front
    for i=1:size(p_image,2)
        M1=p_world(i,:);
         dM_dp=[dR_dv1*M1',dR_dv2*M1',dR_dv3*M1',eye(3)];
        dm_dM=A;
        x_image=A*[R*M1'+t'];
        dm_dm=[1/x_image(3),0,-x_image(1)/(x_image(3)^2);0,1/x_image(3),-x_image(2)/(x_image(3)^2)];
        J1=dm_dm*dm_dM*dM_dp;
        J=[J;J1];
    end
    change=-inv(J'*J+step*eye(6))*(J'*e);
    %change=-inv(J'*J)*(J'*e);
    para=para+change';
    v_new=para(1:3);
    R_new=rotationVectorToMatrix(v_new);
    t_new=para(4:6);
    p_image_calc= worldToImage(cameraParams,R_new,t_new,p_world);
    p_image_calc=p_image_calc';
    e_new=p_image_calc-p_image;
    e_new=sqrt(sum(e_new.^2,1));
    energy_new=sum(e_new);
    if energy_new>energy
       step=10*step;
    else
       step=step/10;
    end
    u=sqrt(sum(change.^2));
    fprintf('change size is %d \n',u);
    k=k+1;
    end
    para_recorded=[para_recorded;para];
    [best_worldOrientation,best_worldLocation]=extrinsicsToCameraPose(R_new,t_new);
    camera_pose_recorded=[camera_pose_recorded;best_worldOrientation,best_worldLocation'];
   catch
       continue
   end
   end

% visualization
imshow(I_detected);
hold on
plot(p_image(1,:), p_image(2,:), 'r*', 'LineWidth', 2, 'MarkerSize', 10);
plot(p_image_calc(1,:), p_image_calc(2,:), 'g*', 'LineWidth', 2, 'MarkerSize', 10);

