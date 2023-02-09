function exp_array=expand_array(node_x,node_y,gn,xTarget,yTarget,CLOSED,MAX_X,MAX_Y)
    %Function to return an expanded array
    %This function takes a node and returns the expanded list
    %of successors,with the calculated fn values.
    %The criteria being none of the successors are on the CLOSED list.
    %
    %Copyright 2009-2010 The MathWorks, Inc.
    
    %EXPANDED ARRAY FORMAT
    %--------------------------------
    %|X val |Y val ||h(n) |g(n)|f(n)|
    %--------------------------------
    
    exp_array=[];
    exp_count=1;
    c2=size(CLOSED,1);%Number of elements in CLOSED including the zeros
    for k= 1:-1:-1
        for j= 1:-1:-1
            if (k~=j || k~=0)  %排除当前节点本身
                s_x = node_x+k;
                s_y = node_y+j; % 九宫格九个点依次检查
                if( (s_x >0 && s_x <=MAX_X) && (s_y >0 && s_y <=MAX_Y))%node within array bound
                    flag=1;  % flag表示该node的可expand性                  
                    for c1=1:c2   % 把close list遍历一遍
                        if(s_x == CLOSED(c1,1) && s_y == CLOSED(c1,2))
                            flag=0;  % 如果该node在close list里，则不可扩展
                        end
                    end%End of for loop to check if a successor is on closed list.
                    % 可扩展性检查结束，开始扩展
                    if (flag == 1)
                        exp_array(exp_count,1) = s_x;
                        exp_array(exp_count,2) = s_y;
                        exp_array(exp_count,3) = distance(xTarget,yTarget,s_x,s_y);%distance between node and goal,hn
                        exp_array(exp_count,4) = gn+distance(node_x,node_y,s_x,s_y);%cost of travelling to node，gn
                        % 这里的gn是从当前节点扩展到该结点的gn和，如需实现Dijkstra，需要在主程序中对gn进行最优维护
                        exp_array(exp_count,5) = exp_array(exp_count,3)+exp_array(exp_count,4);%fn
                        exp_count=exp_count+1;
                    end%Populate the exp_array list!!!
                end% End of node within array bound
            end%End of if node is not its own successor loop
        end%End of j for loop
    end%End of k for loop    