Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3E71CC6B1D
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Oct 2026 15:11:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CB30840E19;
	Wed, 14 Oct 2026 17:10:00 +0200 (CEST)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [1.95.21.2])
 by mails.dpdk.org (Postfix) with ESMTP id 91C694069F
 for <dev@dpdk.org>; Wed, 14 Oct 2026 17:09:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=dsBTJN9Enko4Cy9zDur/zCs7r89O3CzKsDzNXi+9Le0=;
 b=L6+V62+OkgpQvsIzqA1GjkDl1QgzS2ksWYsYCMTJ+BwVqI+Q3usHLxfX9SX6vq
 DNCIstpaV6HRuGWbqyuFPeh6ApoPFE/ozvWnXAAKy/F/Ts2FTExowruhNZ/3VhbH
 jTbR4mrDSOAcrKxr7+Mchn0qJmvJ6Qgjyul2IHHyen8OU=
From: Jiacheng Ye <yejiacheng4@h-partners.com>
To: dev@dpdk.org
Cc: Feifei Wang <wangfeifei40@huawei.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v2 17/26] net/hinic3: add device kvargs parameters support
Date: Wed, 14 Oct 2026 23:09:13 +0800
Message-ID: <20261014150923.838-18-yejiacheng4@h-partners.com>
X-Mailer: git-send-email 2.53.0.windows.2
In-Reply-To: <20261014150923.838-1-yejiacheng4@h-partners.com>
References: <20261010144509.2731-1-yejiacheng4@h-partners.com>
 <20261014150923.838-1-yejiacheng4@h-partners.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: As8vCgAXMEEym89qB_SFAw--.62919S19
X-Coremail-Antispam: 1Uf129KBjvJXoW3CFy3KFWUCry8XFWfKF17Wrg_yoWDtFyfpF
 W3GF9rAFyDJF47XFn5Kan7uFy5Xws7G3y2gayxtayF9rn5ZrWUA34DGrWxZFsxWrZrJa17
 Zr4jgayqk3WqqaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Uio7tUUUUU=
Sender: wff_light@vip.163.com
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiNBuDjWrPmzscnQAA3l
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

Expose the TX CI coalescing and RX compact CQE tunables through device
key/value arguments so they can be configured per deployment without
recompiling the driver.

Forward the parsed compact CQE enable flag to firmware at vport enable so
the hardware honours the rx_cqe_compact_en argument.

Signed-off-by: Jiacheng Ye <yejiacheng4@h-partners.com>
---
 doc/guides/nics/hinic3.rst               |  20 +++++
 doc/guides/rel_notes/release_26_11.rst   |   1 +
 drivers/net/hinic3/base/hinic3_nic_cfg.c |   2 +-
 drivers/net/hinic3/hinic3_ethdev.c       | 109 ++++++++++++++++++++++-
 drivers/net/hinic3/hinic3_ethdev.h       |  19 ++++
 drivers/net/hinic3/hinic3_nic_io.c       |   7 +-
 6 files changed, 151 insertions(+), 7 deletions(-)

diff --git a/doc/guides/nics/hinic3.rst b/doc/guides/nics/hinic3.rst
index bc518ce7fc..8df433bd43 100644
--- a/doc/guides/nics/hinic3.rst
+++ b/doc/guides/nics/hinic3.rst
@@ -48,6 +48,26 @@ Driver compilation and testing
 Refer to the document :doc:`build_and_test` for details.
 
 
+Runtime Configuration
+---------------------
+
+The driver can be configured at initialization via EAL device parameters.
+The following parameters are supported:
+
+- ``tx_pending_limit`` (default **2**): TX completion index coalescing
+  pending limit.
+
+- ``tx_coalescing_time`` (default **2**): TX completion index coalescing
+  time.
+
+- ``rx_cqe_compact_en`` (default **1**): enable (``1``) or disable (``0``)
+  compact CQE mode.
+
+- ``rx_cqe_coalesce_num`` (default **7**): RX CQE coalescing count.
+
+- ``rx_cqe_timer_loop`` (default **8**): RX CQE coalescing timer loop.
+
+
 Limitations or Known issues
 ---------------------------
 
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index fc5d7f74b2..9155cb2d4c 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -122,6 +122,7 @@ New Features
   * Updated RSS hash type configuration.
   * Added mailbox message counter reporting through the device private dump API.
   * Added support for the SP560 NIC.
+  * Added device parameters for runtime configuration.
 
 * **Updated Intel iavf driver.**
 
diff --git a/drivers/net/hinic3/base/hinic3_nic_cfg.c b/drivers/net/hinic3/base/hinic3_nic_cfg.c
index c38d49c3e1..48050d2b0e 100644
--- a/drivers/net/hinic3/base/hinic3_nic_cfg.c
+++ b/drivers/net/hinic3/base/hinic3_nic_cfg.c
@@ -457,7 +457,7 @@ hinic3_set_vport_enable(struct hinic3_hwdev *hwdev, bool enable)
 	en_state.func_id = hinic3_global_func_id(hwdev);
 	en_state.state = enable ? 1 : 0;
 	en_state.num_qps = nic_dev->num_rqs;
-	en_state.rx_compact_wqe_en = HINIC3_SUPPORT_RX_HW_COMPACT_CQE(nic_dev);
+	en_state.rx_compact_wqe_en = nic_dev->config.rx_cqe_compact_en;
 
 	err = hinic3_msg_to_mgmt_sync(hwdev, HINIC3_MOD_L2NIC,
 				      HINIC3_NIC_CMD_SET_VPORT_ENABLE,
diff --git a/drivers/net/hinic3/hinic3_ethdev.c b/drivers/net/hinic3/hinic3_ethdev.c
index ccc013462e..08f4e7443b 100644
--- a/drivers/net/hinic3/hinic3_ethdev.c
+++ b/drivers/net/hinic3/hinic3_ethdev.c
@@ -3913,10 +3913,89 @@ hinic3_func_init(struct rte_eth_dev *eth_dev)
 	return err;
 }
 
+static int
+hinic3_nic_common_args_check_handler(const char *key, const char *val, void *opaque)
+{
+	struct hinic3_nic_common_dev_config *config = opaque;
+	char *end;
+	signed long tmp;
+
+	if (val == NULL || *val == '\0') {
+		PMD_DRV_LOG(ERR, "Key %s is missing value.", key);
+		return -EINVAL;
+	}
+
+	errno = 0;
+	tmp = strtol(val, &end, 0);
+	if (errno != 0 || *end != '\0' || tmp < 0) {
+		PMD_DRV_LOG(ERR, "%s: \"%s\" is an invalid integer.", key, val);
+		return -EINVAL;
+	}
+
+	if (strcmp(key, "tx_pending_limit") == 0) {
+		config->tx_pending_limit = tmp / HINIC3_CI_PENDING_LIMIT_UNIT;
+	} else if (strcmp(key, "tx_coalescing_time") == 0) {
+		config->tx_coalescing_time = tmp / HINIC3_CI_COALESCING_TIME_UNIT;
+	} else if (strcmp(key, "rx_cqe_compact_en") == 0) {
+		config->rx_cqe_compact_en = !!tmp;
+	} else if (strcmp(key, "rx_cqe_coalesce_num") == 0) {
+		config->rx_cqe_coalesce_num = tmp / HINIC3_CI_PENDING_LIMIT_UNIT;
+	} else if (strcmp(key, "rx_cqe_timer_loop") == 0) {
+		config->rx_cqe_timer_loop = tmp / HINIC3_CI_COALESCING_TIME_UNIT;
+	} else {
+		PMD_DRV_LOG(ERR, "Unknown parameter: %s", key);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int
+hinic3_nic_common_config_get(struct rte_pci_device *pci_dev,
+			     struct hinic3_nic_common_dev_config *config)
+{
+	int ret = 0;
+	struct rte_kvargs *kvlist;
+	struct rte_device *eal_dev = &pci_dev->device;
+
+	/* Set private param defaults. */
+	config->tx_pending_limit = HINIC3_DEFAULT_TX_CI_PENDING_LIMIT;
+	config->tx_coalescing_time = HINIC3_DEFAULT_TX_CI_COALESCING_TIME;
+	config->rx_cqe_compact_en = HINIC3_RX_CQE_COMPACT_EN;
+	config->rx_cqe_coalesce_num = HINIC3_RX_CQE_COALESCE_NUM;
+	config->rx_cqe_timer_loop = HINIC3_RX_CQE_TIMER_LOOP;
+
+	if (eal_dev->devargs == NULL)
+		return 0;
+
+	kvlist = rte_kvargs_parse(eal_dev->devargs->args, NULL);
+	if (kvlist == NULL) {
+		PMD_DRV_LOG(ERR, "nic private parameter err, the format must be '-a dev,[key]=[value]'.");
+		return -EINVAL;
+	}
+
+	ret = rte_kvargs_process(kvlist, NULL, hinic3_nic_common_args_check_handler, config);
+	if (ret)
+		ret = -rte_errno;
+
+	rte_kvargs_free(kvlist);
+
+	PMD_DRV_LOG(INFO,
+		"tx_pending_limit:%upkt, tx_coalescing_time:%uus, rx_cqe_coalesce_num:%upkt, rx_cqe_timer_loop:%uus.",
+		config->tx_pending_limit * HINIC3_CI_PENDING_LIMIT_UNIT,
+		config->tx_coalescing_time * HINIC3_CI_COALESCING_TIME_UNIT,
+		config->rx_cqe_coalesce_num * HINIC3_CI_PENDING_LIMIT_UNIT,
+		config->rx_cqe_timer_loop * HINIC3_CI_COALESCING_TIME_UNIT);
+	return ret;
+}
+
 static int
 hinic3_dev_init(struct rte_eth_dev *eth_dev)
 {
 	struct rte_pci_device *pci_dev;
+	struct hinic3_nic_dev *nic_dev = HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(eth_dev);
+	struct hinic3_nic_common_dev_config config;
+	int err = 0;
 
 	pci_dev = RTE_CLASS_TO_BUS_DEVICE(eth_dev, *pci_dev);
 
@@ -3929,10 +4008,32 @@ hinic3_dev_init(struct rte_eth_dev *eth_dev)
 	PMD_DRV_LOG(DEBUG, "Network Interface pmd driver version: %s",
 		    HINIC3_PMD_DRV_VERSION);
 
+	/*
+	 * Parse device arguments before allocating any resources so that an
+	 * invalid argument fails the probe without leaking memory. Secondary
+	 * processes re-use the primary's configuration and must not re-parse
+	 * devargs or overwrite the primary's settings.
+	 */
+	if (rte_eal_process_type() == RTE_PROC_PRIMARY) {
+		err = hinic3_nic_common_config_get(pci_dev, &config);
+		if (err < 0) {
+			PMD_DRV_LOG(ERR, "Failed to get nic device arguments: %s",
+				    strerror(rte_errno));
+			return err;
+		}
+	}
+
+	err = hinic3_func_init(eth_dev);
+	if (err)
+		return err;
+
+	if (rte_eal_process_type() == RTE_PROC_PRIMARY)
+		nic_dev->config = config;
+
 	eth_dev->rx_pkt_burst = hinic3_recv_pkts;
 	eth_dev->tx_pkt_burst = hinic3_xmit_pkts;
 
-	return hinic3_func_init(eth_dev);
+	return 0;
 }
 
 static int
@@ -3987,6 +4088,12 @@ static struct rte_pci_driver rte_hinic3_pmd = {
 
 RTE_PMD_REGISTER_PCI(net_hinic3, rte_hinic3_pmd);
 RTE_PMD_REGISTER_PCI_TABLE(net_hinic3, pci_id_hinic3_map);
+RTE_PMD_REGISTER_PARAM_STRING(net_hinic3,
+	"tx_pending_limit=<int> "
+	"tx_coalescing_time=<int> "
+	"rx_cqe_compact_en=<int> "
+	"rx_cqe_coalesce_num=<int> "
+	"rx_cqe_timer_loop=<int>");
 
 RTE_INIT(hinic3_init_log)
 {
diff --git a/drivers/net/hinic3/hinic3_ethdev.h b/drivers/net/hinic3/hinic3_ethdev.h
index 7ab9b661d5..c91a820e45 100644
--- a/drivers/net/hinic3/hinic3_ethdev.h
+++ b/drivers/net/hinic3/hinic3_ethdev.h
@@ -6,6 +6,8 @@
 #define _HINIC3_ETHDEV_H_
 
 #include <rte_ethdev.h>
+#include <rte_kvargs.h>
+#include <rte_devargs.h>
 #include <rte_ethdev_core.h>
 
 #include "hinic3_fdir.h"
@@ -60,6 +62,14 @@
 #define HINIC3_VFTA_SIZE		(4096 / HINIC3_UINT32_BIT_SIZE)
 #define HINIC3_MAX_QUEUE_NUM		256
 
+#define HINIC3_DEFAULT_TX_CI_PENDING_LIMIT	2
+#define HINIC3_DEFAULT_TX_CI_COALESCING_TIME	2
+#define HINIC3_RX_CQE_COMPACT_EN		1
+#define HINIC3_RX_CQE_TIMER_LOOP		8
+#define HINIC3_RX_CQE_COALESCE_NUM		7
+#define HINIC3_CI_PENDING_LIMIT_UNIT		8
+#define HINIC3_CI_COALESCING_TIME_UNIT		5
+
 #define HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev) \
 	((struct hinic3_nic_dev *)(dev)->data->dev_private)
 
@@ -107,6 +117,14 @@ enum nic_feature_cap {
 TAILQ_HEAD(hinic3_ethertype_filter_list, rte_flow);
 TAILQ_HEAD(hinic3_fdir_rule_filter_list, rte_flow);
 
+struct hinic3_nic_common_dev_config {
+	unsigned int tx_pending_limit; /**< TX CI coalescing parameter pending_limit. */
+	unsigned int tx_coalescing_time; /**< TX CI coalescing parameter coalescing_time. */
+	unsigned int rx_cqe_compact_en; /**< cqe mode, 0 -- separate cqe, 1 -- compact cqe. */
+	unsigned int rx_cqe_coalesce_num; /**< RX CQE parameter coalesce_num. */
+	unsigned int rx_cqe_timer_loop; /**< RX CQE parameter time_loop. */
+};
+
 enum nic_type {
 	NIC_SP620 = 0,
 	NIC_SP230 = 1,
@@ -146,6 +164,7 @@ struct hinic3_nic_dev {
 
 	uint8_t pause_set; /**< Flag of PAUSE frame setting. */
 	struct nic_pause_config nic_pause;
+	struct hinic3_nic_common_dev_config config;
 
 	struct rte_ether_addr default_addr;
 	struct rte_ether_addr *mc_list;
diff --git a/drivers/net/hinic3/hinic3_nic_io.c b/drivers/net/hinic3/hinic3_nic_io.c
index 361586868e..5b905f203e 100644
--- a/drivers/net/hinic3/hinic3_nic_io.c
+++ b/drivers/net/hinic3/hinic3_nic_io.c
@@ -538,9 +538,6 @@ hinic3_get_func_rx_buf_size(struct hinic3_nic_dev *nic_dev)
 	nic_dev->rx_buff_len = buf_size;
 }
 
-#define HINIC3_RX_CQE_TIMER_LOOP		15
-#define HINIC3_RX_CQE_COALESCE_NUM		63
-
 int
 hinic3_init_rq_cqe_ctxts(struct hinic3_nic_dev *nic_dev)
 {
@@ -569,8 +566,8 @@ hinic3_init_rq_cqe_ctxts(struct hinic3_nic_dev *nic_dev)
 			rq_ci_paddr = rxq->rq_ci_paddr >> CQE_CTX_CI_ADDR_SHIFT;
 			cqe_ctx.ci_addr_hi = upper_32_bits(rq_ci_paddr);
 			cqe_ctx.ci_addr_lo = lower_32_bits(rq_ci_paddr);
-			cqe_ctx.threshold_cqe_num = HINIC3_RX_CQE_COALESCE_NUM;
-			cqe_ctx.timer_loop = HINIC3_RX_CQE_TIMER_LOOP;
+			cqe_ctx.threshold_cqe_num = nic_dev->config.rx_cqe_coalesce_num;
+			cqe_ctx.timer_loop = nic_dev->config.rx_cqe_timer_loop;
 		} else {
 			cqe_ctx.threshold_cqe_num = 0;
 			cqe_ctx.timer_loop = 0;
-- 
2.33.0

