Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B0E60A2628
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Nov 2026 16:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=vip.163.com header.i=@vip.163.com header.a=rsa-sha256 header.s=s110527 header.b=W/Jro12E
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BA1CB40E01;
	Fri, 20 Nov 2026 17:35:43 +0100 (CET)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [1.95.21.2])
 by mails.dpdk.org (Postfix) with ESMTPS id DE8B64069D
 for <dev@dpdk.org>; Fri, 20 Nov 2026 17:35:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=Qn74NoLhrbRxbakMtgFFTUtH0NnLbIwVO7IqRxK5LKY=;
 b=W/Jro12EMihjFp5/ObFkdJRYhK4YI6Qf/HylINCs/tlSUGYsUszLn8ouLxeJta
 9NDPEyt69D5vwpbsC5qaf5H6Co3SqgOnFg4s4ubRgRpHGKk8Jc9pWwQampIs42gI
 LghdqPGvkKNTFJ0CGZ8Izuiv2mPpZj09c9KEozWA9RBXM=
From: Jiacheng Ye <yejiacheng4@h-partners.com>
To: dev@dpdk.org
Cc: Feifei Wang <wangfeifei40@huawei.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v8 21/28] net/hinic3: add device kvargs parameters support
Date: Sat, 21 Nov 2026 00:34:46 +0800
Message-ID: <20261120163454.1159-22-yejiacheng4@h-partners.com>
X-Mailer: git-send-email 2.53.0.windows.2
In-Reply-To: <20261120163454.1159-1-yejiacheng4@h-partners.com>
References: <20261117155711.1048-1-yejiacheng4@h-partners.com>
 <20261120163454.1159-1-yejiacheng4@h-partners.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Ac8vCgCHL5q7dgBrCNqsBQ--.46998S23
X-Coremail-Antispam: 1Uf129KBjvJXoW3CF1DJF1fGF47Ar4rWFyrXrb_yoWkXFWUpF
 W3GF9rAFyDJrsrXFn0ka1xCa4Yqws3J3y2vayxJayFkr1rZrW8A3yDKrWavFsxGrZrA3W7
 Zr40gayqk3Z0q3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07URMKZUUUUU=
Sender: wff_light@vip.163.com
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiNwSps2sAdsQRWQAA34
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Expose the TX completion coalescing (tx_pending_limit,
tx_coalescing_time) and RX CQE coalescing (rx_cqe_coalesce_num,
rx_cqe_timer_loop) tunables through device kvargs, so they can be set per
deployment without recompiling the driver, and program them into the
hardware contexts.

The defaults are 2/2 and 7/5, down from the previous hardcoded 3/16 and
63/15.

The two RX CQE coalescing parameters take effect only with HW compact
CQE; they are ignored with SW compact and split CQE.

Signed-off-by: Jiacheng Ye <yejiacheng4@h-partners.com>
---
 doc/guides/nics/hinic3.rst             |  23 +++++
 doc/guides/rel_notes/release_26_11.rst |   1 +
 drivers/net/hinic3/hinic3_ethdev.c     | 125 ++++++++++++++++++++++++-
 drivers/net/hinic3/hinic3_ethdev.h     |  17 ++++
 drivers/net/hinic3/hinic3_nic_io.c     |  14 +--
 5 files changed, 169 insertions(+), 11 deletions(-)

diff --git a/doc/guides/nics/hinic3.rst b/doc/guides/nics/hinic3.rst
index bc518ce7fc..cb2d696a94 100644
--- a/doc/guides/nics/hinic3.rst
+++ b/doc/guides/nics/hinic3.rst
@@ -48,6 +48,29 @@ Driver compilation and testing
 Refer to the document :doc:`build_and_test` for details.
 
 
+Runtime Configuration
+---------------------
+
+The driver can be configured at initialization via EAL device parameters.
+The following parameters are supported:
+
+``tx_pending_limit`` (default ``2``)
+   Tx completion coalescing pending limit, in units of 8
+   packets.
+
+``tx_coalescing_time`` (default ``2``)
+   Tx completion coalescing time, in microseconds.
+
+``rx_cqe_coalesce_num`` (default ``7``)
+   Rx CQE coalescing count, in units of 8 packets.
+
+``rx_cqe_timer_loop`` (default ``5``)
+   Rx CQE coalescing timer, in microseconds.
+
+The two coalescing parameters above apply only to the HW compact CQE
+mode; they are ignored with the SW compact and split CQE modes.
+
+
 Limitations or Known issues
 ---------------------------
 
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 941746268b..10ba88a529 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -175,6 +175,7 @@ New Features
     limit to 2048 entries on the STN tile.
   * Added mailbox message counter reporting through the device private dump API.
   * Added support for the SP560 NIC.
+  * Added device parameters for runtime configuration.
 
 * **Updated Intel iavf driver.**
 
diff --git a/drivers/net/hinic3/hinic3_ethdev.c b/drivers/net/hinic3/hinic3_ethdev.c
index cc2b3b1cd0..f9968fe89f 100644
--- a/drivers/net/hinic3/hinic3_ethdev.c
+++ b/drivers/net/hinic3/hinic3_ethdev.c
@@ -4055,10 +4055,107 @@ hinic3_func_init(struct rte_eth_dev *eth_dev)
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
+	tmp = strtol(val, &end, 10);
+	if (errno != 0 || *end != '\0' || tmp < 0) {
+		PMD_DRV_LOG(ERR, "%s: \"%s\" is an invalid integer.", key, val);
+		return -EINVAL;
+	}
+
+	if (strcmp(key, "tx_pending_limit") == 0) {
+		if (tmp > UINT8_MAX)
+			goto out_of_range;
+		config->tx_pending_limit = tmp;
+	} else if (strcmp(key, "tx_coalescing_time") == 0) {
+		if (tmp > UINT8_MAX)
+			goto out_of_range;
+		config->tx_coalescing_time = tmp;
+	} else if (strcmp(key, "rx_cqe_coalesce_num") == 0) {
+		if (tmp > UINT8_MAX)
+			goto out_of_range;
+		config->rx_cqe_coalesce_num = tmp;
+	} else if (strcmp(key, "rx_cqe_timer_loop") == 0) {
+		if (tmp > UINT8_MAX)
+			goto out_of_range;
+		config->rx_cqe_timer_loop = tmp;
+	} else {
+		PMD_DRV_LOG(ERR, "Unknown parameter: %s", key);
+		return -EINVAL;
+	}
+
+	return 0;
+
+out_of_range:
+	PMD_DRV_LOG(ERR, "%s: value exceeds the maximum allowed value.", key);
+	return -EINVAL;
+}
+
+static const char *const hinic3_nic_common_valid_args[] = {
+	"tx_pending_limit",
+	"tx_coalescing_time",
+	"rx_cqe_coalesce_num",
+	"rx_cqe_timer_loop",
+	NULL
+};
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
+	config->rx_cqe_coalesce_num = HINIC3_RX_CQE_COALESCE_NUM;
+	config->rx_cqe_timer_loop = HINIC3_RX_CQE_TIMER_LOOP;
+
+	if (eal_dev->devargs == NULL || eal_dev->devargs->args == NULL)
+		return 0;
+
+	kvlist = rte_kvargs_parse(eal_dev->devargs->args,
+				  hinic3_nic_common_valid_args);
+	if (kvlist == NULL) {
+		PMD_DRV_LOG(ERR, "nic private parameter err, the format must be '-a dev,[key]=[value]'.");
+		return -EINVAL;
+	}
+
+	ret = rte_kvargs_process(kvlist, NULL, hinic3_nic_common_args_check_handler, config);
+	if (ret < 0)
+		ret = -EINVAL;
+
+	rte_kvargs_free(kvlist);
+
+	PMD_DRV_LOG(INFO, "tx_pending_limit:%upkt, tx_coalescing_time:%uus, "
+		"rx_cqe_coalesce_num:%upkt, rx_cqe_timer_loop:%uus.",
+		config->tx_pending_limit * HINIC3_COALESCING_UNIT_PKTS,
+		config->tx_coalescing_time,
+		config->rx_cqe_coalesce_num * HINIC3_COALESCING_UNIT_PKTS,
+		config->rx_cqe_timer_loop);
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
 
@@ -4071,11 +4168,32 @@ hinic3_dev_init(struct rte_eth_dev *eth_dev)
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
+			PMD_DRV_LOG(ERR, "Failed to get nic device arguments.");
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
 	eth_dev->tx_pkt_prepare = hinic3_prep_pkts;
 
-	return hinic3_func_init(eth_dev);
+	return 0;
 }
 
 static int
@@ -4130,6 +4248,11 @@ static struct rte_pci_driver rte_hinic3_pmd = {
 
 RTE_PMD_REGISTER_PCI(net_hinic3, rte_hinic3_pmd);
 RTE_PMD_REGISTER_PCI_TABLE(net_hinic3, pci_id_hinic3_map);
+RTE_PMD_REGISTER_PARAM_STRING(net_hinic3,
+	"tx_pending_limit=<int> "
+	"tx_coalescing_time=<int> "
+	"rx_cqe_coalesce_num=<int> "
+	"rx_cqe_timer_loop=<int>");
 
 RTE_INIT(hinic3_init_log)
 {
diff --git a/drivers/net/hinic3/hinic3_ethdev.h b/drivers/net/hinic3/hinic3_ethdev.h
index e4f1a5b51c..f8d146f3bc 100644
--- a/drivers/net/hinic3/hinic3_ethdev.h
+++ b/drivers/net/hinic3/hinic3_ethdev.h
@@ -6,6 +6,8 @@
 #define _HINIC3_ETHDEV_H_
 
 #include <rte_ethdev.h>
+#include <rte_kvargs.h>
+#include <rte_devargs.h>
 #include <rte_ethdev_core.h>
 
 #include "hinic3_fdir.h"
@@ -60,6 +62,12 @@
 #define HINIC3_VFTA_SIZE		(4096 / HINIC3_UINT32_BIT_SIZE)
 #define HINIC3_MAX_QUEUE_NUM		256
 
+#define HINIC3_DEFAULT_TX_CI_PENDING_LIMIT	2
+#define HINIC3_DEFAULT_TX_CI_COALESCING_TIME	2
+#define HINIC3_RX_CQE_TIMER_LOOP		5
+#define HINIC3_RX_CQE_COALESCE_NUM		7
+#define HINIC3_COALESCING_UNIT_PKTS		8 /**< Coalescing unit: 8 packets. */
+
 #define HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev) \
 	((struct hinic3_nic_dev *)(dev)->data->dev_private)
 
@@ -107,6 +115,14 @@ enum nic_feature_cap {
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
@@ -148,6 +164,7 @@ struct hinic3_nic_dev {
 
 	uint8_t pause_set; /**< Flag of PAUSE frame setting. */
 	struct nic_pause_config nic_pause;
+	struct hinic3_nic_common_dev_config config;
 
 	struct rte_ether_addr default_addr;
 	struct rte_ether_addr *mc_list;
diff --git a/drivers/net/hinic3/hinic3_nic_io.c b/drivers/net/hinic3/hinic3_nic_io.c
index d4c53645c4..c66748da2a 100644
--- a/drivers/net/hinic3/hinic3_nic_io.c
+++ b/drivers/net/hinic3/hinic3_nic_io.c
@@ -11,9 +11,6 @@
 #include "hinic3_rx.h"
 #include "hinic3_tx.h"
 
-#define HINIC3_DEAULT_TX_CI_PENDING_LIMIT	3
-#define HINIC3_DEAULT_TX_CI_COALESCING_TIME	16
-
 #define CI_IDX_HIGH_SHIFH			12
 
 #define CI_HIGN_IDX(val) ((val) >> CI_IDX_HIGH_SHIFH)
@@ -456,9 +453,6 @@ hinic3_get_func_rx_buf_size(struct hinic3_nic_dev *nic_dev)
 	nic_dev->rx_buff_len = buf_size;
 }
 
-#define HINIC3_RX_CQE_TIMER_LOOP		15
-#define HINIC3_RX_CQE_COALESCE_NUM		63
-
 int
 hinic3_init_rq_cqe_ctxts(struct hinic3_nic_dev *nic_dev)
 {
@@ -487,8 +481,8 @@ hinic3_init_rq_cqe_ctxts(struct hinic3_nic_dev *nic_dev)
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
@@ -562,8 +556,8 @@ hinic3_init_qp_ctxts(struct hinic3_nic_dev *nic_dev)
 	/* Configure CI tables for each SQ. */
 	for (q_id = 0; q_id < nic_dev->num_sqs; q_id++) {
 		sq_attr.ci_dma_base = nic_dev->txqs[q_id]->ci_dma_base >> 0x2;
-		sq_attr.pending_limit = HINIC3_DEAULT_TX_CI_PENDING_LIMIT;
-		sq_attr.coalescing_time = HINIC3_DEAULT_TX_CI_COALESCING_TIME;
+		sq_attr.pending_limit = nic_dev->config.tx_pending_limit;
+		sq_attr.coalescing_time = nic_dev->config.tx_coalescing_time;
 		sq_attr.intr_en = 0;
 		sq_attr.intr_idx = 0; /**< Tx doesn't need interrupt. */
 		sq_attr.l2nic_sqn = q_id;
-- 
2.33.0

