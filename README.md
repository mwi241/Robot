```mermaid
graph TD;
    A[布里渊光学信号模拟] --> B[数据预处理];
    B --> C[CNN 训练];
    B --> D[RNN/LSTM 训练];
    B --> E[Transformer 训练];
    C --> F[模型评估];
    D --> F;
    E --> F;
    F --> G[结果分析与讨论];
