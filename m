Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9650760A8F6E
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 Oct 2026 15:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=vip.163.com header.i=@vip.163.com header.a=rsa-sha256 header.s=s110527 header.b=ex+7qi5b
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6876F40E03;
	Mon, 19 Oct 2026 17:20:16 +0200 (CEST)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [220.197.30.220])
 by mails.dpdk.org (Postfix) with ESMTP id 9B38D4066C
 for <dev@dpdk.org>; Mon, 19 Oct 2026 17:20:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=oS39CzU3eEFcgd21T6XQ2vOnlMMD6tvbeX+UGXve35o=;
 b=ex+7qi5bNSS4ak/uq5dt8r8L+GV7VRdDnKCQ5I90pbNKXGYYCz2EGHiYsPbn2G
 /KbiCn2YExER7fyU2kb8n5kDtcfMLliXdpYg9gnA5POBHZnxtS2mlfFLG1l2Fjbg
 61UJvbT6xJj1Lj50NjDTk+5RgViwTlvhA+3p5cNM89x3c=
From: Jiacheng Ye <yejiacheng4@h-partners.com>
To: dev@dpdk.org
Cc: Feifei Wang <wangfeifei40@huawei.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH 19/27] net/hinic3: add device kvargs parameters support
Date: Mon, 19 Oct 2026 23:19:21 +0800
Message-ID: <20261019151930.1572-20-yejiacheng4@h-partners.com>
X-Mailer: git-send-email 2.53.0.windows.2
In-Reply-To: <20261019151930.1572-1-yejiacheng4@h-partners.com>
References: <20261014150923.838-1-yejiacheng4@h-partners.com>
 <20261019151930.1572-1-yejiacheng4@h-partners.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Ac8vCgCXK5cUNdZqqgUkBA--.15723S21
X-Coremail-Antispam: 1Uf129KBjvAXoW3CryxKFyDGr18Jry5WryrXrb_yoW8JFy8Co
 WfZrWayr13tr1Iyry2gws7CFW3Jryv9rn5A39xCwn7WFW7WFy3tF9xtw1rCFy0qr9YyFn7
 AFy8Ja9xta1UJ3s3n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
 AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUzgAwUUUUU
Sender: wff_light@vip.163.com
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiNgClr2rWNSDUqgAA3r
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_ZEN_BLOCKED_OPENDNS,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Expose the TX CI coalescing and RX compact CQE tunables through device
key/value arguments so they can be configured per deployment without
recompiling the driver. The coalescing defaults are set lower than the
previous fixed values to cut latency while keeping enough packets in flight
to sustain line rate.

Forward the parsed compact CQE enable flag to firmware at vport enable so
the hardware honours the rx_cqe_compact_en argument.

Mask the compact CQE enable flag against the NIC capability so a NIC
without compact CQE support is never enabled for it in firmware while the
receive path still uses the non-compact WQE format.

Signed-off-by: Jiacheng Ye <yejiacheng4@h-partners.com>
---
 doc/guides/nics/hinic3.rst               |  22 ++++
 doc/guides/rel_notes/release_26_11.rst   |   1 +
 drivers/net/hinic3/base/hinic3_nic_cfg.c |   3 +-
 drivers/net/hinic3/hinic3_ethdev.c       | 144 +++++++++++++++++++++--
 drivers/net/hinic3/hinic3_ethdev.h       |  17 +++
 drivers/net/hinic3/hinic3_nic_io.c       |   7 +-
 6 files changed, 180 insertions(+), 14 deletions(-)

diff --git a/doc/guides/nics/hinic3.rst b/doc/guides/nics/hinic3.rst
index bc518ce7fc..b47cabccec 100644
--- a/doc/guides/nics/hinic3.rst
+++ b/doc/guides/nics/hinic3.rst
@@ -48,6 +48,28 @@ Driver compilation and testing
 Refer to the document :doc:`build_and_test` for details.
 
 
+Runtime Configuration
+---------------------
+
+The driver can be configured at initialization via EAL device parameters.
+The following parameters are supported:
+
+- ``tx_pending_limit`` (default **2**): TX completion index coalescing
+  pending limit, in units of 8 packets.
+
+- ``tx_coalescing_time`` (default **2**): TX completion index coalescing
+  time, in microseconds.
+
+- ``rx_cqe_compact_en`` (default **1**): enable (``1``) or disable (``0``)
+  compact CQE mode.
+
+- ``rx_cqe_coalesce_num`` (default **7**): RX CQE coalescing count, in
+  units of 8 packets.
+
+- ``rx_cqe_timer_loop`` (default **5**): RX CQE coalescing timer loop, in
+  microseconds.
+
+
 Limitations or Known issues
 ---------------------------
 
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index f346328d24..00fa8418df 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -150,6 +150,7 @@ New Features
   * Updated RSS hash type configuration.
   * Added mailbox message counter reporting through the device private dump API.
   * Added support for the SP560 NIC.
+  * Added device parameters for runtime configuration.
 
 * **Updated Intel iavf driver.**
 
diff --git a/drivers/net/hinic3/base/hinic3_nic_cfg.c b/drivers/net/hinic3/base/hinic3_nic_cfg.c
index 2d928388f8..5d6ad7e14d 100644
--- a/drivers/net/hinic3/base/hinic3_nic_cfg.c
+++ b/drivers/net/hinic3/base/hinic3_nic_cfg.c
@@ -457,8 +457,7 @@ hinic3_set_vport_enable(struct hinic3_hwdev *hwdev, bool enable)
 	en_state.func_id = hinic3_global_func_id(hwdev);
 	en_state.state = enable ? 1 : 0;
 	en_state.num_qps = nic_dev->num_rqs;
-	en_state.rx_compact_wqe_en = HINIC3_SUPPORT_RX_HW_COMPACT_CQE(nic_dev) ||
-				     HINIC3_SUPPORT_RX_SW_COMPACT_CQE(nic_dev);
+	en_state.rx_compact_wqe_en = nic_dev->config.rx_cqe_compact_en;
 
 	err = hinic3_msg_to_mgmt_sync(hwdev, HINIC3_MOD_L2NIC,
 				      HINIC3_NIC_CMD_SET_VPORT_ENABLE,
diff --git a/drivers/net/hinic3/hinic3_ethdev.c b/drivers/net/hinic3/hinic3_ethdev.c
index 431c2435bb..4fd884e542 100644
--- a/drivers/net/hinic3/hinic3_ethdev.c
+++ b/drivers/net/hinic3/hinic3_ethdev.c
@@ -1158,8 +1158,7 @@ hinic3_rx_queue_setup(struct rte_eth_dev *dev, uint16_t qid, uint16_t nb_desc,
 	}
 
 	/* If NIC support compact CQE, use compact wqe as default. */
-	if (HINIC3_SUPPORT_RX_HW_COMPACT_CQE(nic_dev) ||
-	    HINIC3_SUPPORT_RX_SW_COMPACT_CQE(nic_dev)) {
+	if (nic_dev->config.rx_cqe_compact_en) {
 		rxq->wqe_type = HINIC3_COMPACT_RQ_WQE;
 	} else {
 		if (buf_size >= HINIC3_RX_BUF_SIZE_4K &&
@@ -1219,8 +1218,7 @@ hinic3_rx_queue_setup(struct rte_eth_dev *dev, uint16_t qid, uint16_t nb_desc,
 		goto alloc_rx_info_fail;
 	}
 
-	if (HINIC3_SUPPORT_RX_HW_COMPACT_CQE(nic_dev) ||
-	    HINIC3_SUPPORT_RX_SW_COMPACT_CQE(nic_dev)) {
+	if (nic_dev->config.rx_cqe_compact_en) {
 		ci_mz = hinic3_dma_zone_reserve(dev, "hinic3_ci_mz", qid,
 						sizeof(*rxq->rq_ci),
 						RTE_CACHE_LINE_SIZE, (int)socket_id);
@@ -1459,8 +1457,7 @@ hinic3_rx_queue_release(struct rte_eth_dev *dev, uint16_t queue_id)
 
 	hinic3_free_rxq_mbufs(rxq);
 
-	if (HINIC3_SUPPORT_RX_HW_COMPACT_CQE(nic_dev) ||
-	    HINIC3_SUPPORT_RX_SW_COMPACT_CQE(nic_dev))
+	if (nic_dev->config.rx_cqe_compact_en)
 		hinic3_memzone_free(rxq->ci_mz);
 	else
 		hinic3_memzone_free(rxq->cqe_mz);
@@ -3940,10 +3937,114 @@ hinic3_func_init(struct rte_eth_dev *eth_dev)
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
+		if (tmp > UINT8_MAX)
+			goto out_of_range;
+		config->tx_pending_limit = tmp;
+	} else if (strcmp(key, "tx_coalescing_time") == 0) {
+		if (tmp > UINT8_MAX)
+			goto out_of_range;
+		config->tx_coalescing_time = tmp;
+	} else if (strcmp(key, "rx_cqe_compact_en") == 0) {
+		config->rx_cqe_compact_en = !!tmp;
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
+	if (ret < 0)
+		ret = -EINVAL;
+
+	rte_kvargs_free(kvlist);
+
+	PMD_DRV_LOG(INFO,
+		"tx_pending_limit:%upkt, tx_coalescing_time:%uus, rx_cqe_coalesce_num:%upkt, rx_cqe_timer_loop:%uus.",
+		config->tx_pending_limit,
+		config->tx_coalescing_time,
+		config->rx_cqe_coalesce_num,
+		config->rx_cqe_timer_loop);
+	return ret;
+}
+
+static void hinic3_nic_feature_init(struct hinic3_nic_dev *nic_dev)
+{
+	if ((HINIC3_SUPPORT_RX_HW_COMPACT_CQE(nic_dev) ||
+	     HINIC3_SUPPORT_RX_SW_COMPACT_CQE(nic_dev)) &&
+	    nic_dev->config.rx_cqe_compact_en == HINIC3_RX_CQE_COMPACT_EN) {
+		nic_dev->config.rx_cqe_compact_en = HINIC3_RX_CQE_COMPACT_EN;
+		PMD_DRV_LOG(INFO, "nic compact_cqe is on.");
+	} else {
+		nic_dev->config.rx_cqe_compact_en = 0;
+		PMD_DRV_LOG(INFO, "nic compact_cqe is off.");
+	}
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
 
@@ -3956,10 +4057,33 @@ hinic3_dev_init(struct rte_eth_dev *eth_dev)
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
+	if (rte_eal_process_type() == RTE_PROC_PRIMARY) {
+		nic_dev->config = config;
+		hinic3_nic_feature_init(nic_dev);
+	}
+
 	eth_dev->rx_pkt_burst = hinic3_recv_pkts;
 	eth_dev->tx_pkt_burst = hinic3_xmit_pkts;
 
-	return hinic3_func_init(eth_dev);
+	return 0;
 }
 
 static int
@@ -4014,6 +4138,12 @@ static struct rte_pci_driver rte_hinic3_pmd = {
 
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
index 7ab9b661d5..e4e5132235 100644
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
+#define HINIC3_RX_CQE_COMPACT_EN		1
+#define HINIC3_RX_CQE_TIMER_LOOP		5
+#define HINIC3_RX_CQE_COALESCE_NUM		7
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
@@ -146,6 +162,7 @@ struct hinic3_nic_dev {
 
 	uint8_t pause_set; /**< Flag of PAUSE frame setting. */
 	struct nic_pause_config nic_pause;
+	struct hinic3_nic_common_dev_config config;
 
 	struct rte_ether_addr default_addr;
 	struct rte_ether_addr *mc_list;
diff --git a/drivers/net/hinic3/hinic3_nic_io.c b/drivers/net/hinic3/hinic3_nic_io.c
index d4c53645c4..fbf5e9bc2b 100644
--- a/drivers/net/hinic3/hinic3_nic_io.c
+++ b/drivers/net/hinic3/hinic3_nic_io.c
@@ -456,9 +456,6 @@ hinic3_get_func_rx_buf_size(struct hinic3_nic_dev *nic_dev)
 	nic_dev->rx_buff_len = buf_size;
 }
 
-#define HINIC3_RX_CQE_TIMER_LOOP		15
-#define HINIC3_RX_CQE_COALESCE_NUM		63
-
 int
 hinic3_init_rq_cqe_ctxts(struct hinic3_nic_dev *nic_dev)
 {
@@ -487,8 +484,8 @@ hinic3_init_rq_cqe_ctxts(struct hinic3_nic_dev *nic_dev)
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

