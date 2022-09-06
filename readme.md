## 使用说明

1. 首先通过data_cut_save完成对原始txt数据的裁剪
2. 通过filter_w_theta_dot函数完成对角速度w及theta表示的角速度的滤波
3. 利用format_processing_before_dtw将数据整理成dtw可以直接对齐的格式，每一组示教的数据为N×M的矩阵，N为数据维度，M为数据点个数。
4. 利用dtw_alignment_plot完成dtw数据的对齐

