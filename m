Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42743CD98C5
	for <dpdk-dev@archiver.kernel.org>; Sun, 14 Jun 2026 09:23:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4A2444366C;
	Sun, 14 Jun 2026 11:23:36 +0200 (CEST)
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
 by mails.dpdk.org (Postfix) with ESMTP id 4048043660
 for <dev@dpdk.org>; Sun, 14 Jun 2026 11:23:33 +0200 (CEST)
Received: from localhost.localdomain (unknown [118.112.177.181])
 by APP-05 (Coremail) with SMTP id zQCowABXrtEQcy5qVi9yEw--.28230S3;
 Sun, 14 Jun 2026 17:23:30 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org
Subject: Re: [PATCH 19/20] drivers: add testpmd commands for private features
Date: Sun, 14 Jun 2026 17:23:03 +0800
Message-ID: <20260614092328.201826-2-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260614092328.201826-1-liujie5@linkdatatechnology.com>
References: <20260610013936.3634968-21-liujie5@linkdatatechnology.com>
 <20260614092328.201826-1-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=a
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowABXrtEQcy5qVi9yEw--.28230S3
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
 VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUOx7k0a2IF6F4UM7kC6x804xWl14x267AK
 xVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGw
 A2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2x26xkF7I0E14v26r18M28lY4IEw2II
 xxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjc
 xK6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0
 Y4vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21le4C262
 xC7I0v67AEwI8IwI1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j
 6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64
 vIr41lw4CEc2x0rVAKj4xxM4kE6I8I3I0E14AKx2xKxVC2ax8xMxAIw28IcxkI7VAKI48J
 MxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
 AFwI0_Jr0_Jr4lx4CE17CEb7AF67AKxVWUXVWUAwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
 0xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4
 v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AK
 xVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUc9YwUUUUU
X-Originating-IP: [118.112.177.181]
X-CM-SenderInfo: xolxyxrhv6zxpqngt3pdwhux5qro0w31of0z/
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Unsubscribe: <https://mails.dpdk.org/options/dev>,
 <mailto:dev-request@dpdk.org?subject=unsubscribe>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
Errors-To: dev-bounces@dpdk.org

您好，

感谢详细的审查意见。以下是我们对每条反馈的逐条回复以及 v2 计划变更。

---

### 1. strtoul() 值越界处理

重新检查了 [`sxe2_ethdev.c`](drivers/net/sxe2/sxe2_ethdev.c) 中的 devargs 解析代码后，我们确认所有解析器都已处理越界值：

- [`sxe2_parse_u8()`](drivers/net/sxe2/sxe2_ethdev.c:1074) — 检查 `val > UINT8_MAX`（第 1092 行），返回 `-ERANGE`
- [`sxe2_parse_bool()`](drivers/net/sxe2/sxe2_ethdev.c:1103) — 检查 `bool_val != 0 && bool_val != 1`（第 1121 行）
- [`sxe2_parse_fnav_stat_type()`](drivers/net/sxe2/sxe2_ethdev.c:989) — 检查是否超过 `SXE2_FNAV_STAT_ENA_ALL`（第 1007 行）
- [`sxe2_parse_sched_layer_mode()`](drivers/net/sxe2/sxe2_ethdev.c:1018) — 检查是否超过 `SXE2_TXSCH_NODE_ADJ_LVL_MAX`（第 1036 行）
- [`sxe2_parse_high_performance_mode()`](drivers/net/sxe2/sxe2_ethdev.c:1046) — 检查 `high_performance_mode != 1`（第 1064 行），覆盖零和越界值

每个函数在 `strtoul()` 前设置 `errno = 0`，之后检查 `errno != 0`，从而捕获 `ERANGE`（溢出）。之后再执行语义范围检查。v2 中我们将在每个 `strtoul()` 调用后增加显式的 `ULONG_MAX` 比较以增加防御性。

---

### 2. 从驱动库导出 testpmd 符号

**同意。** 没有上游驱动为其 testpmd 命令导出符号。v2 中将：

- 将 `sxe2_testpmd_lib.c` 的实现移至 `sxe2_testpmd.c`，通过 meson.build 中的 `testpmd_sources` 编译，与 i40e、ixgbe、mlx5、bnxt 等驱动的模式一致。
- **删除所有 14 个 `RTE_EXPORT_EXPERIMENTAL_SYMBOL` 条目。** 这些从未作为公共 API。
- 将应用状态（`g_tx_session[][]`、`g_rx_session[][]`、`g_esp_header_offset[]`、`g_sess_pool`）移至 testpmd 侧代码。
- 驱动内部函数继续通过 `drivers/net/sxe2/` 下的内部头文件访问。

---

### 3. 与标准 testpmd 功能重复的命令

**三个命令都同意删除。**

- **"sxe2 flow rule dump"** → 我们将实现 `rte_flow_dev_dump` op。之后标准命令 `flow dump <port_id> all` 即可正常工作。私有命令将被删除。
- **"sxe2 udp_tunnel_port add|rm"** → 该命令调用 `rte_eth_dev_udp_tunnel_port_add/rm`，已由 `port config <port_id> udp_tunnel_port add|rm` 暴露。私有命令是冗余的，将被删除。
- **"sxe2 show stats"** → 我们将审查 xstats 并补充缺失的计数器；用户改用 `show port xstats <port_id>`。私有命令将被删除。

---

### 4. IPsec SA 管理套件

**同意。** 我们将：

- 从 testpmd 扩展中删除 9 个子命令的 ipsec SA 管理命令。
- 文档中说明 `examples/ipsec-secgw` 是使用此驱动验证 inline crypto 的支持方式，与其他 inline-crypto PMD 一致。
- 如果将来需要 testpmd 中的交互式 SA 管理，我们将提议作为通用的 testpmd 命令基于 `rte_security` 实现，使所有驱动受益。

---

### 5. 私有 devargs

所有 7 个 devargs 的文档已添加到 [`doc/guides/nics/sxe2.rst`](doc/guides/nics/sxe2.rst)（Runtime Configuration 章节），同时添加了 `RTE_PMD_REGISTER_PARAM_STRING` 以保证可发现性。以下是保留每个 devargs 的理由：

**flow-duplicate-pattern** — 控制硬件 switch engine 是否接受重复的 flow rule。这不会改变 `rte_flow` 语义；它配置了一个硬件特定的能力。switch engine 支持两种模式：(a) 拒绝重复规则用于错误检测，(b) 通过 per-rule 元数据标志允许重复。默认值（1 = 允许）确保标准行为。目前没有标准 API 用于控制 switch 级别的重复规则行为。

**fnav-stat-type** — 在初始化时选择硬件计数器资源配置（仅包计数 / 仅字节计数 / 两者）。这是一个静态硬件配置决策，而非运行时开关。目前没有标准 API 用于选择计数器资源分配模式。

**drv-sw-stats** — 某些包类型上硬件计数器可能存在不准确性。此参数启用 Rx 数据路径中的软件累计路径作为 workaround。per-packet 软件分类的开销使得通过 devarg 控制而非始终开启是合理的。计数器通过 xstats 暴露（`rx_sw_unicast_packets` 等）。

**sched-layer-mode** — 不同硬件 SKU 支持不同的最大调度层级数（0-3）。该参数在初始化时限制层级深度。`rte_tm` API 目前没有在配置前查询最大调度深度的接口。

**high-performance-mode** — Tx 绕过硬件调度器以获得更低延迟。不适合作为默认值，因为 TM 功能对许多用户很重要。现已记录完整的性能权衡说明。

**rx-low-latency** — Rx 中断调节调优。类似 devarg 在其他驱动中也存在（例如 mlx5 的 `rxqs_min_bth`）。

**function-flow-direct** — 控制 flow rule 的 PF/VF 重定向范围。`rte_flow` 没有针对此功能的 per-rule 标志。

---

### v2 计划变更

1. devarg 解析器中 `strtoul()` 后增加防御性 `ULONG_MAX` 检查
2. testpmd 命令移出驱动库；删除 14 个 `RTE_EXPORT_EXPERIMENTAL_SYMBOL`
3. 实现 `rte_flow_dev_dump` op；删除 "sxe2 flow rule dump" 命令
4. 删除 "sxe2 udp_tunnel_port add|rm" 命令（冗余）
5. 完善 xstats 覆盖；删除 "sxe2 show stats" 命令
6. 删除 ipsec SA 管理 testpmd 命令
7. 保留 7 个 devargs，在 sxe2.rst 中提供完整文档和理由
8. 为所有 devargs 添加 `RTE_PMD_REGISTER_PARAM_STRING`

我们将尽快发送 v2。如有其他问题请告知。

谢谢，
[署名]

