function rst_boxplot(varargin)

% routine to make box plots specifying several parameters for display
%
% FORMAT rst_boxplot(data,linewidth,boxcolors,boxfillcolors)
%
% INPUT data a matrix of data to plot using box plot
%       optional:
%       linewidth the thickness of box and wisker lines
%       boxcolors a RGB matrix (n*3) of box colors
%       boxfillcolors a RGB matrix (n*3) of box colors or []
%
% Cyril Pernet 02-April-2014

data = varargin{1};
linewidth = 3;
tmp = jet; boxcolors = tmp(1:floor(64/size(data,2)):64,:); clear tmp
boxfillcolors = flipud(boxcolors);

if nargin > 1; linewidth = varargin{2}; end
if nargin > 2; boxcolors = varargin{3}; end
if nargin > 3; boxfillcolors = flipud(varargin{4}); end
 
% plot
boxplot(data, ...
    'boxstyle','outline', ...
    'whisker',1.5, ...
    'positions',[1:1:size(data,2)], ...
    'widths',0.2,...
    'colors',boxcolors);
    
% set the median
h = findobj(gca,'Tag','Median');
for j=1:length(h)
    set(h(j),'Color','k','LineWidth',2)
end

% lines
a = findall(gca,'type','line');
set(a, 'linewidth',linewidth);

% box color
if ~isempty(boxfillcolors)
    h = findobj(gca,'Tag','Box');
    for j=length(h):-1:1
        patch(get(h(j),'XData'),get(h(j),'YData'),boxfillcolors(j,:),'FaceAlpha',.4);
    end
end

% outline
grid on; set(gca,'LineWidth',2,'FontSize',12,'Layer','Top')



