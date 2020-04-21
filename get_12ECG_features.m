  function features = get_12ECG_features(data, header_data)


          

       % addfunction path needed
        addpath(genpath('Tools/'))

        load('HRVparams_12ECG','HRVparams')

	% read number of leads, sample frequency and gain from the header.	

	[recording,Total_time,num_leads,Fs,gain,age,sex]=extract_data_from_header(header_data);
    
    % combine two leads inorder to make sure there are enough R peak for
    % generating 5 beats features per signal
    current_lead=[];
     for i= 1:num_leads
          current_lead=[current_lead,data(i,1000:end)];  
      end

          
 
   signal=medianFilter(current_lead,Fs);
      [~, qrs_index]=pan_tompkin(signal,Fs,0);
          
             Starting_R_peak=1;     
            START=round(qrs_index(Starting_R_peak+1)-((qrs_index(Starting_R_peak+1)-qrs_index(Starting_R_peak))*2/3));
            END=round(qrs_index(Starting_R_peak+5)+(qrs_index(Starting_R_peak+6)-qrs_index(Starting_R_peak+5))*1/3);
            fivebeatsSignal=current_lead(START:END);
            
            Signal_length=length(fivebeatsSignal);
            fb = cwtfilterbank('SignalLength',Signal_length,'VoicesPerOctave', 12);
            cfs = abs(fb.wt(fivebeatsSignal(1,:)));
        
        
            im=ind2rgb(im2uint8(rescale(cfs)),jet(300));
            features=im2uint8(imresize(im,[128,128]));
      
 
  end

