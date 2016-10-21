disp(['The length of the longest trace is ', num2str(max(hist(hmm_train(:,1), unique(hmm_train(:,1)))))]);
disp(['The length of the shortest trace is ', num2str(min(hist(hmm_train(:,1), unique(hmm_train(:,1)))))]);
disp(['The number of different observations is ', num2str(length(unique(hmm_train(:,2))))]);
disp(' ');