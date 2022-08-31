import matplotlib.pyplot as plt
import matplotlib as mpl
import numpy as np
from scipy.io import loadmat


from matplotlib.patches import Patch

plt.rcParams["font.family"] = "Times New Roman"


def set_size(width, fraction=1, subplots=(1, 1), fig_height_pt=None):
    """Set figure dimensions to avoid scaling in LaTeX.

    Parameters
    ----------
    width: float or string
            Document width in points, or string of predined document type
    fraction: float, optional
            Fraction of the width which you wish the figure to occupy
    subplots: array-like, optional
            The number of rows and columns of subplots.
    Returns
    -------
    fig_dim: tuple
            Dimensions of figure in inches
    """
    if width == 'thesis':
        width_pt = 426.79135
    elif width == 'beamer':
        width_pt = 307.28987
    else:
        width_pt = width

    # Width of figure (in pts)
    fig_width_pt = width_pt * fraction
    # Convert from pt to inches
    inches_per_pt = 1 / 72.27

    # Golden ratio to set aesthetic figure height
    # https://disq.us/p/2940ij3
    golden_ratio = (5**.5 - 1) / 2

    # Figure width in inches
    fig_width_in = fig_width_pt * inches_per_pt
    # Figure height in inches

    if fig_height_pt is not None:
        fig_height_in = fig_height_pt * inches_per_pt
    else:
        fig_height_in = fig_width_in * golden_ratio * (subplots[0] / subplots[1])

    return (fig_width_in, fig_height_in)

    
def add_value_labels(ax,x,y, spacing=5):
    """Add labels to the end of each bar in a bar chart.

    Arguments:
        ax (matplotlib.axes.Axes): The matplotlib object containing the axes
            of the plot to annotate.
        spacing (int): The distance between the labels and the bars.
    """
    # For each bar: Place a label
    for rect in ax.patches:
        # Get X and Y placement of label from rect.
        y_value = rect.get_height()
        x_value = rect.get_x() + rect.get_width() / 2
        # Number of points between bar and label. Change to your liking.
        space = spacing
        # Vertical alignment for positive values
        va = 'bottom'
        
     
            
  
        # If value of bar is negative: Place label below bar
        if y_value < 0:
            # Invert space to place label below
            space *= -1
            # Vertically align label at top
            va = 'top'

        # Use Y value as label and format number with one decimal place
        label = "{:.0f}".format(y_value)

        # Create annotation
        if y_value == 100:
            ax.annotate(
            label,                      # Use `label` as label
            (x_value+0.35, y_value),         # Place label at end of the bar
            xytext=(0, space),          # Vertically shift label by `space`
            textcoords="offset points", # Interpret `xytext` as offset in points
            ha='center',                # Horizontally center label
            va=va)                      # Vertically align label differently for
        else:         
            ax.annotate(
            label,                      # Use `label` as label
            (x_value, y_value),         # Place label at end of the bar
            xytext=(0, space),          # Vertically shift label by `space`
            textcoords="offset points", # Interpret `xytext` as offset in points
            ha='center',                # Horizontally center label
            va=va)                      # Vertically align label differently for
                   






csfont = {'fontname':'Times New Roman'}

dataset_names = ["HA", "MA", "LA", "In-vivo\nwhite matter"]
parameter_names = ["d_par", "d_perp", "w_par", "w_perp", "w_mean", "worst"]
algo_names = ["sdki_rbc_off", "axdki_rbc_off", "sdki_rbc_on", "axdki_rbc_on"]

parameter_names_tex = ["$D_{\parallel}$", "$D_{\perp}$", "$W_{\parallel}$", "$W_{\perp}$", "$\overline{W}$", "Maximum"]
algo_names_plot = ["Standard DKI", "Axisymmetric DKI", "Standard DKI, RBC ON", "Axisymmetric DKI, RBC ON"]

snr_bar_colors=[
    [ \
        (0.5, 0., 0.2),
        (0.7, 0.2, 0.2),
        (0.9, 0.2, 0.2),
        (0.2, 0.2, 0.8)
    ],
    None,
    [\
        (0.0, 0.6, 1.0),
        (1.0, 0.0, 0.6),
        (0.0, 0.6, 1.0),
        (1.0, 0.0, 0.6)
    ]
]

    
   #     (0.0, 0.6, 1.0),
    #    (0.03, 0.9, 1.0),
     #   (0.65, 0.1, 0.83),
      #  (1.0, 0.0, 0.75)
    
snr_titles = [\
    dataset_names,
    parameter_names_tex,
    algo_names_plot
]

dataset_dim = 0
parameter_dim = 1
algo_dim = 2

snr_shape = (len(dataset_names), len(parameter_names), len(algo_names))
snrs = np.zeros(snr_shape)
#snrs = (100 * np.random.rand(*snr_shape)).astype(np.uint8)

data = loadmat(r"data_invivo_wm_and_synth.mat")

snrs = data["data_invivo_wm_and_synth"]
data_barplots = np.array(data["data_invivo_wm_and_synth"])



snrs[parameter_names.index("d_par")][algo_names.index("sdki_rbc_off")] = data_barplots[0,0,:]
snrs[parameter_names.index("d_par")][algo_names.index("axdki_rbc_off")] = data_barplots[0,1,:]
snrs[parameter_names.index("d_par")][algo_names.index("sdki_rbc_on")] = data_barplots[0,2,:]
snrs[parameter_names.index("d_par")][algo_names.index("axdki_rbc_on")] = data_barplots[0,3,:]

snrs[parameter_names.index("d_perp")][algo_names.index("sdki_rbc_off")] = data_barplots[1,0,:]
snrs[parameter_names.index("d_perp")][algo_names.index("axdki_rbc_off")] = data_barplots[1,1,:]
snrs[parameter_names.index("d_perp")][algo_names.index("sdki_rbc_on")] = data_barplots[1,2,:]
snrs[parameter_names.index("d_perp")][algo_names.index("axdki_rbc_on")] = data_barplots[1,3,:]

snrs[parameter_names.index("w_par")][algo_names.index("sdki_rbc_off")] = data_barplots[2,0,:]
snrs[parameter_names.index("w_par")][algo_names.index("axdki_rbc_off")] = data_barplots[2,1,:]
snrs[parameter_names.index("w_par")][algo_names.index("sdki_rbc_on")] = data_barplots[2,2,:]
snrs[parameter_names.index("w_par")][algo_names.index("axdki_rbc_on")] = data_barplots[2,3,:]

snrs[parameter_names.index("w_perp")][algo_names.index("sdki_rbc_off")] = data_barplots[3,0,:]
snrs[parameter_names.index("w_perp")][algo_names.index("axdki_rbc_off")] = data_barplots[3,1,:]
snrs[parameter_names.index("w_perp")][algo_names.index("sdki_rbc_on")] = data_barplots[3,2,:]
snrs[parameter_names.index("w_perp")][algo_names.index("axdki_rbc_on")] = data_barplots[3,3,:]

snrs[parameter_names.index("w_mean")][algo_names.index("sdki_rbc_off")] = data_barplots[4,0,:]
snrs[parameter_names.index("w_mean")][algo_names.index("axdki_rbc_off")] = data_barplots[4,1,:]
snrs[parameter_names.index("w_mean")][algo_names.index("sdki_rbc_on")] = data_barplots[4,2,:]
snrs[parameter_names.index("w_mean")][algo_names.index("axdki_rbc_on")] = data_barplots[4,3,:]

snrs[parameter_names.index("worst")][algo_names.index("sdki_rbc_off")] = data_barplots[5,0,:]
snrs[parameter_names.index("worst")][algo_names.index("axdki_rbc_off")] = data_barplots[5,1,:]
snrs[parameter_names.index("worst")][algo_names.index("sdki_rbc_on")] = data_barplots[5,2,:]
snrs[parameter_names.index("worst")][algo_names.index("axdki_rbc_on")] = data_barplots[5,3,:]


print(snrs.shape)


col_dim = parameter_dim
row_dim = dataset_dim
single_plot_dim = algo_dim



col_titles = snr_titles[col_dim]
row_titles = snr_titles[row_dim]
xticklabels = snr_titles[single_plot_dim]
xlabel = ""
xlabel = ""
ylabel = "SNR"
bar_colors = snr_bar_colors[single_plot_dim]

snrs = np.transpose(snrs, (row_dim, col_dim, single_plot_dim))
nrows = snrs.shape[1]
ncols = snrs.shape[0]
             


width = 447.0
height = 280

fig, axes = plt.subplots(nrows=nrows, ncols=ncols,
                         figsize=set_size(width, fraction=1.5, fig_height_pt=height*1.3),
                         sharey=True, sharex=True)



print(snrs[0,:,0]) #parameter, algo, tissue

bar_args = {}
if bar_colors is not None:
    bar_args["color"] = bar_colors
    bar_args["linewidth"] = 4


for y in range(nrows):
    for x in range(ncols):
        ax = axes[y][x]
        snr_values = snrs[x,:,y]

             
        bars = ax.bar(xticklabels, snr_values.tolist(), **bar_args)
        

        bars[2].set(hatch="///")
        bars[3].set(hatch="///")
        add_value_labels(ax,x,y)

        
        
        ax.set_xticks([])
        ax.set_xticklabels([])
        ax.set_ylim([0, 260])
        
        if x == 0:
            ax.set_ylabel("SNR")
        if y == 0:
            ax.set_title(col_titles[x], fontsize=16)
        if y == nrows-1:
            ax.set_xlabel("")
            
            
mpl.rcParams['hatch.linewidth'] = 1.0



pad = 0
for ax, row in zip(axes[:,0], row_titles):
    ax.annotate(row, xy=(-0.05, 0.5), xytext=(-ax.yaxis.labelpad - pad -10, 0),
                xycoords=ax.yaxis.label, textcoords='offset points',
                size=16, ha='right', va='center', rotation=0)


if bar_colors is not None:
    legend_elements = []
    for bar_name, bar_color in zip(xticklabels, bar_colors):
        if bar_name == algo_names_plot[2]:
            legend_elements.append(Patch(facecolor=bar_color, edgecolor='black',
                         label=bar_name, hatch ="///"))
        elif bar_name == algo_names_plot[3]:
            legend_elements.append(Patch(facecolor=bar_color, edgecolor='black',
                         label=bar_name, hatch ="///"))
        else:
                legend_elements.append(Patch(facecolor=bar_color, edgecolor='black',
                         label=bar_name))


legend_elements_alt = [
    legend_elements[0], legend_elements[2], legend_elements[1], legend_elements[3]
    ]


legend = fig.legend(handles=legend_elements_alt, fontsize=10, ncol=2, loc='upper center', bbox_to_anchor=(0.51, 1.05), fancybox=True, bbox_transform=fig.transFigure)

#fig.legend(handles=legend_elements, bbox_to_anchor=(0.8, 1.02), ncol=len(bar_colors), fontsize=9)

fig.subplots_adjust(wspace=0.07, hspace=0.07)
#plt.tight_layout()
plt.show()


fig.savefig('invivo_wm_and_synth.png', dpi=1200, pad_inches = 0, bbox_inches = 'tight')
fig.savefig('invivo_wm_and_synth.svg', dpi=1200, bbox_inches = 'tight', pad_inches = 0)