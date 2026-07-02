# 收款集成（PayPal + Airwallex）

> 站搭好但没接好收款 = 不能收钱。**收款路线已定 🅰：PayPal 起步 + Airwallex 主力**。这里装好就齐了。

## 这里放什么
- PayPal 企业账户申请记录（账号、客户 ID、商户 ID）
- Airwallex 申请记录（账号、子商户号）
- WooCommerce 收款插件配置截图
- 测试订单记录（用 sandbox 跑通）

## 两个收款工具的分工

| 工具 | 角色 | 接入方式 | 状态 |
|---|---|---|---|
| **PayPal** | 先开通、能收钱、过渡 | WP 插件 WooCommerce PayPal Payments | ⚪ 待办 |
| **Airwallex** | 主力收单、站内刷卡 | WP 插件或自定义 checkout | ⚪ 待办 |

> PayPal 偏"按钮跳转"——按钮 → PayPal 站 → 回站。转化略低，但门槛最低、最快开。
> Airwallex 可做"站内刷卡"——不跳转，体验更好。KYC 通过要花点时间。

## 申请顺序（推荐）

### 第 1 周：PayPal 企业账户
1. 准备：营业执照、对公账户（**你已开**）、法人身份证
2. 注册 paypal.cn → 选"企业账户"→ 提交资料
3. 约 2 工作日通过
4. 用对公账户打一笔 verify 款（小额，几十美元）
5. 接到 WP：装 WooCommerce PayPal Payments 插件 → 填 Client ID + Secret
6. 用 PayPal sandbox 跑个测试单

### 第 2-3 周：Airwallex
1. 注册：airwallex.com/cn → "企业开户"
2. KYC 资料：营业执照、法人、对公账户、官网（**这步就是你 WP 站占位后**）
3. 提额 / 开收单功能
4. 接到 WP：通过插件或 API

## 关键提醒
- 🔴 **PayPal 易冻结 + 21 天 hold 新号起步**——别把所有钱押它身上
- 🔴 **要签"瓷器/茶器类目"书面报价**——别只信网上笼统费率，发邮件给商务要白纸黑字
- 🟡 备用收单：起量后再考虑（UseePay、AsiaBill 都可备一个）
- 🟡 收款数据 + 报关数据要对上（票货一致）——这是合规底线

## 当前进度
- [ ] ⬜ PayPal 企业账户申请
- [ ] ⬜ PayPal 接入 WP
- [ ] ⬜ Airwallex 申请 + KYC
- [ ] ⬜ Airwallex 接入 WP
- [ ] ⬜ 跑通测试单（不发货、走完付款到账闭环）

## 来源
详细对比 + 费率见 `../../1-战略与决策/收款方案调研-2026.md`
