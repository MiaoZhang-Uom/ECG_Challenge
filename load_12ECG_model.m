function model = load_12ECG_model()

        filename='model_trained.mat';
        A=load(filename);
        model=A.net;

end


