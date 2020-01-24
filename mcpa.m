scatterProb = input('Enter a scattering probability between 0 and 0.99: ');
scatterType = input('Select 0 for basic scattering or 1 for cool scattering: ');
numParticles = input('Enter a number of electrons between 1 and 7: ');

colours = ['b','g','r','c','m','y','k'];
particle(1:numParticles,1:2) = 0; %Position, velocity, acceleration
particle(1:numParticles,3) = 1;

f1 = figure(1); %Position
movegui(f1,'west')

f2 = figure(2);
movegui(f2,'east')

position = zeros(numParticles,2);
velocity = zeros(numParticles,2);

allVelocity = zeros(numParticles,1000);
driftVelocity = zeros(1,1000);

for time = 1:1000
    allVelocity(:,time) = particle(:,2);
    if(time==1)
        position(:,1) = particle(:,1);
        velocity(:,1) = particle(:,2);
        driftVelocity(time) = mean(allVelocity(:,time));
    else
        position(:,1) = position(:,2);
        velocity(:,1) = velocity(:,2);
        driftVelocity(time) = mean(mean(allVelocity(:,1:time)));
    end
    particle(:,1) = particle(:,1) + particle(:,2);
    particle(:,2) = particle(:,2) + particle(:,3);
    position(:,2) = particle(:,1);
    velocity(:,2) = particle(:,2);
    for i = 1:numParticles
        scatter = rand;
        if(scatter <= scatterProb)
            if(scatterType==0)
                particle(i,2) = 0;
            else
                bounce = rand;
                particle(i,2) = -particle(i,2)*bounce;
            end
        end
    end
    if(time~=1)
        if(time==2)
            for i = 1:numParticles
                if(i==1)
                    figure(1)
                    plot([time-1,time],position(i,:),colours(i))
                    xlabel('Time')
                    ylabel('Position')
                    title('Electron Position')
                    hold on
                    figure(2)
                    plot([time-1,time],velocity(i,:),colours(i))
                    xlabel('Time')
                    ylabel('Velocity')
                    title(['Electron Velocity (Drift Velocity = ',num2str(driftVelocity(time)),')'])
                    hold on
                else
                    figure(1)
                    plot([time-1,time],position(i,:),colours(i))
                    figure(2)
                    plot([time-1,time],velocity(i,:),colours(i))
                end
            end
        else
            for i = 1:numParticles
                figure(1)
                plot([time-1,time],position(i,:),colours(i))
                figure(2)
                plot([time-1,time],velocity(i,:),colours(i))
                title(['Electron Velocity (Drift Velocity = ',num2str(driftVelocity(time)),')'])
            end
        end
    end
end
        