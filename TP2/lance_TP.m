T_e=1/nu_e;
%
if question<=2
    B_for=1;
else
    B_for=300;
end
%
if B_for>1
    h_bar = waitbar(0,'Moyennage sur plusieurs realisations');
end
%
for b=1:B_for
    %
    if B_for>1
        waitbar(b/B_for,h_bar);
    end
    %
    % generation de x
    %================
    if question==1
        x=zeros(1,N);
        x(1+floor(N/2))=2; %2V
    elseif question==2
        x=zeros(1,N);
        x(1:floor(N/2))=2; %2V
    else
        x=2*randn(1,N);
    end
    %
    % caracteristiques du filtre
    load load_tau tau
    %load load_tau2 tau
    %
    % convolution x avec h
    A=[T_e+tau -tau];
    B=T_e;
    %
    y=filter(B,A,x);
    %
    % ajout du bruit eletronique
    pas_de_quantification=20/2^16;
    sigma_b=pas_de_quantification;
    y=y+sigma_b*randn(size(y));
    y=round(y/pas_de_quantification)*pas_de_quantification;
    %
    vec_t=0:(N-1);
    vec_t=vec_t*T_e;
    %
    if b==1
        figure(question);clf
    end
    if question==1
        subplot(1,2,1)
        plot(vec_t*1000,x)
        grid on
        xlabel('n.T_e [ms]')
        ylabel('[V]')
        title('signal d''entree x')
        set(gca,'fontsize',14);
        subplot(1,2,2)
        plot(vec_t*1000,y)
        title('signal de sortie y')
        xlabel('n.T_e [ms]')
        ylabel('[V]')
        set(gca,'fontsize',14);
        grid on
    elseif question==2
        subplot(2,2,1)
        plot(vec_t*1000,x)
        grid on
        xlabel('n.T_e [ms]')
        ylabel('[V]')
        title('signal d''entree x')
        set(gca,'fontsize',14);
        %
        subplot(2,2,2)
        plot(vec_t*1000,y)
        title('signal de sortie y')
        xlabel('n.T_e [ms]')
        ylabel('[V]')
        set(gca,'fontsize',14);
        grid on
        %
        derivee_de_y=(y(2:N)-y(1:(N-1)))/T_e;
        subplot(2,1,2)
        plot(vec_t(1:end-1)*1000,derivee_de_y)
        title('derivee (numerique) de y')
        xlabel('n T_e (temps) [ms]')
        ylabel('[V]')
        set(gca,'fontsize',14);
        grid on
    else
        X=fft(x);
        Y=fft(y);
        %
        if b==1
            DSP_x=abs(X).^2/N;
            DSP_y=abs(Y).^2/N;
        else
            DSP_x=DSP_x+abs(X).^2/N;
            DSP_y=DSP_y+abs(Y).^2/N;
        end
        %
        vec_freq=0:(N-1);
        vec_freq=vec_freq/N*nu_e;
        %
        subplot(2,2,1)
        semilogx(vec_freq(2:end/2),10*log10(DSP_x(2:end/2)/b))
        if b==1
            ylim=get(gca,'ylim');
        else
            set(gca,'ylim',ylim)
        end
        xlabel('frequence (Hz)')
        ylabel('[dB]')
        title('Densite spectrale de l''entree x')
        set(gca,'fontsize',14);
        grid on
        set(gca,'xlim',[vec_freq(2) vec_freq(end/2)])
        %
        subplot(2,2,3)
        semilogx(vec_freq(2:end/2),10*log10(DSP_y(2:end/2)/b))
        xlabel('frequence (Hz)')
        ylabel('[dB]')
        title('Densite spectrale de la sortie y')
        set(gca,'fontsize',14);
        grid on
        set(gca,'xlim',[vec_freq(2) vec_freq(end/2)])
        %
        if question==4
            xx=[x zeros(size(x))];
            yy=[y zeros(size(y))];
            XX=fft(xx);
            YY=fft(yy);
            vec_tau=0:(length(x)-1);
            vec_tau=vec_tau*T_e;
            if b==1
                DSP_XY=Y.*conj(X);
                DSP_XXYY=YY.*conj(XX);
            else
                DSP_XY=DSP_XY+Y.*conj(X);
                DSP_XXYY=DSP_XXYY+YY.*conj(XX);
            end
            C=real(ifft(DSP_XY));
            CC=real(ifft(DSP_XXYY));
            subplot(2,2,2)
            plot(vec_tau*1000,C/b)
            xlabel('retard \tau [ms]')
            ylabel('[V]')
            title('Intercorrelation entre x et y (sans zeropadding)')
            set(gca,'fontsize',14);
            grid on
            %
            subplot(2,2,4)
            plot(vec_tau*1000,CC(1:end/2)/b)
            xlabel('retard \tau [ms]')
            ylabel('[V]')
            title('Intercorrelation entre x et y (avec zeropadding)')
            set(gca,'fontsize',14);
            grid on
            %
        end
        %
        drawnow
    end
end
%
if B_for>1
    close(h_bar);
end