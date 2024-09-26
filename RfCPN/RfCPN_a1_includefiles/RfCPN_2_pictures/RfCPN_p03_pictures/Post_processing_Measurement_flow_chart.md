```mermaid
graph LR
    subgraph Group6[通り芯測定]
        direction TB
        F1([開始]) --> F2{両外削}
        F2 -->|Yes| F3[測定]
        F2 -->|No| F4
        F3 --> F4([終了])
    end
```
