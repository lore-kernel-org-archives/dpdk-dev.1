Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E9C2CA9EBE
	for <dpdk-dev@archiver.kernel.org>; Sat, 10 Oct 2026 14:46:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CDBEC40A81;
	Sat, 10 Oct 2026 16:45:28 +0200 (CEST)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [220.197.30.221])
 by mails.dpdk.org (Postfix) with ESMTP id D67CB4028C
 for <dev@dpdk.org>; Sat, 10 Oct 2026 16:45:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=ldjwyFlt9EpUWhJdalxLaIfkJuOzTYj/h2wCHS/gwiw=;
 b=CE6BgbLTtVcHuHE7Bxk7/ZbZqEBPomt1BuBF/Ol15Ufctb9dmgRXEknlvYtJXL
 XjyfB52mYdy2hsFA0T1hT9ZMJ7CUFB2jMnck8Qe+SccTfPtHc7v88iC9iiYXdby5
 gGPIMdwIZBi4oS4+4udYfPnQWisaE+YV8OxjSFjiJ+jbk=
From: Jiacheng Ye <yejiacheng4@h-partners.com>
To: dev@dpdk.org
Cc: Feifei Wang <wangfeifei40@huawei.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v1 11/17] net/hinic3: add device kvargs parameters support
Date: Sat, 10 Oct 2026 22:45:02 +0800
Message-ID: <20261010144509.2731-12-yejiacheng4@h-partners.com>
X-Mailer: git-send-email 2.53.0.windows.2
In-Reply-To: <20261010144509.2731-1-yejiacheng4@h-partners.com>
References: <20261010144509.2731-1-yejiacheng4@h-partners.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-CM-TRANSID: As8vCgDX70B4T8pqMdk9Aw--.440S13
X-Coremail-Antispam: 1Uf129KBjvJXoW3Xr4rKr4UXw4xtw4UCFyxGrg_yoWDJF4xpF
 W5GFyDAFWDJrsxJFs5Ka1xua45Xwn3J3y2ga43AaySkFn5ZrWvy34DGrW3ZFsxXrZrJa17
 ZrWxKa1qkw1qqaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j0ZXOUUUUU=
Sender: wff_light@vip.163.com
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiNh5ASmrKT342FgAA3T
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

Parse device key/value arguments so runtime tunables such as the RX empty=0D
threshold and TX free-loop limit can be configured per deployment.=0D
=0D
Forward the parsed compact CQE enable flag to firmware at vport enable so=0D
it honours the rx_cqe_compact_en argument.=0D
=0D
Signed-off-by: Jiacheng Ye <yejiacheng4@h-partners.com>=0D
---=0D
 doc/guides/rel_notes/release_26_11.rst   |   1 +=0D
 drivers/net/hinic3/base/hinic3_nic_cfg.c |   2 +-=0D
 drivers/net/hinic3/hinic3_ethdev.c       | 103 ++++++++++++++++++++++-=0D
 drivers/net/hinic3/hinic3_ethdev.h       |  22 +++++=0D
 drivers/net/hinic3/hinic3_nic_io.c       |   7 +-=0D
 5 files changed, 128 insertions(+), 7 deletions(-)=0D
=0D
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/=
release_26_11.rst=0D
index 2e8e1e082a..d4cc028120 100644=0D
--- a/doc/guides/rel_notes/release_26_11.rst=0D
+++ b/doc/guides/rel_notes/release_26_11.rst=0D
@@ -99,6 +99,7 @@ New Features=0D
   * Added Class of Service (COS) mask and map support.=0D
   * Updated RSS hash type configuration.=0D
   * Added support for the SP560 NIC.=0D
+  * Added device parameters for runtime configuration.=0D
 =0D
 * **Updated Intel iavf driver.**=0D
 =0D
diff --git a/drivers/net/hinic3/base/hinic3_nic_cfg.c b/drivers/net/hinic3/=
base/hinic3_nic_cfg.c=0D
index 235b36dcce..7f0c0e7d77 100644=0D
--- a/drivers/net/hinic3/base/hinic3_nic_cfg.c=0D
+++ b/drivers/net/hinic3/base/hinic3_nic_cfg.c=0D
@@ -455,7 +455,7 @@ hinic3_set_vport_enable(struct hinic3_hwdev *hwdev, boo=
l enable)=0D
 	en_state.func_id =3D hinic3_global_func_id(hwdev);=0D
 	en_state.state =3D enable ? 1 : 0;=0D
 	en_state.num_qps =3D nic_dev->num_rqs;=0D
-	en_state.rx_compact_wqe_en =3D HINIC3_SUPPORT_RX_HW_COMPACT_CQE(nic_dev);=
=0D
+	en_state.rx_compact_wqe_en =3D nic_dev->config.rx_cqe_compact_en;=0D
 =0D
 	err =3D hinic3_msg_to_mgmt_sync(hwdev, HINIC3_MOD_L2NIC,=0D
 				      HINIC3_NIC_CMD_SET_VPORT_ENABLE,=0D
diff --git a/drivers/net/hinic3/hinic3_ethdev.c b/drivers/net/hinic3/hinic3=
_ethdev.c=0D
index 603330846e..e5749ec718 100644=0D
--- a/drivers/net/hinic3/hinic3_ethdev.c=0D
+++ b/drivers/net/hinic3/hinic3_ethdev.c=0D
@@ -32,6 +32,8 @@=0D
 #define HINIC3_DEFAULT_RX_FREE_THRESH 32u=0D
 #define HINIC3_DEFAULT_TX_FREE_THRESH 32u=0D
 =0D
+#define HINIC3_RX_EMPTY_THRESHOLD   3=0D
+#define HINIC3_DEFAULT_TX_FREE_LOOP 1000=0D
 #define HINIC3_RX_WAIT_CYCLE_THRESH 150=0D
 =0D
 /**=0D
@@ -3955,10 +3957,98 @@ hinic3_func_init(struct rte_eth_dev *eth_dev)=0D
 	return err;=0D
 }=0D
 =0D
+static int=0D
+hinic3_nic_common_args_check_handler(const char *key, const char *val, voi=
d *opaque)=0D
+{=0D
+	struct hinic3_nic_common_dev_config *config =3D opaque;=0D
+	signed long tmp;=0D
+=0D
+	if (val =3D=3D NULL || *val =3D=3D '\0') {=0D
+		PMD_DRV_LOG(ERR, "Key %s is missing value.", key);=0D
+		return -EINVAL;=0D
+	}=0D
+=0D
+	errno =3D 0;=0D
+	tmp =3D strtol(val, NULL, 0);=0D
+	if (errno) {=0D
+		rte_errno =3D errno;=0D
+		PMD_DRV_LOG(WARNING, "%s: \"%s\" is an invalid integer.", key, val);=0D
+		return -rte_errno;=0D
+	}=0D
+=0D
+	if (strcmp(key, "rx_empty_threshold") =3D=3D 0) {=0D
+		config->rx_empty_threshold =3D tmp;=0D
+	} else if (strcmp(key, "tx_free_loop") =3D=3D 0) {=0D
+		config->tx_free_loop =3D tmp;=0D
+	} else if (strcmp(key, "tx_pending_limit") =3D=3D 0) {=0D
+		config->tx_pending_limit =3D tmp / HINIC3_CI_PENDING_LIMIT_UNIT;=0D
+	} else if (strcmp(key, "tx_coalescing_time") =3D=3D 0) {=0D
+		config->tx_coalescing_time =3D tmp / HINIC3_CI_COALESCING_TIME_UNIT;=0D
+	} else if (strcmp(key, "rx_cqe_compact_en") =3D=3D 0) {=0D
+		config->rx_cqe_compact_en =3D !!tmp;=0D
+	} else if (strcmp(key, "rx_cqe_coalesce_num") =3D=3D 0) {=0D
+		config->rx_cqe_coalesce_num =3D tmp / HINIC3_CI_PENDING_LIMIT_UNIT;=0D
+	} else if (strcmp(key, "rx_cqe_timer_loop") =3D=3D 0) {=0D
+		config->rx_cqe_timer_loop =3D tmp / HINIC3_CI_COALESCING_TIME_UNIT;=0D
+	} else if (strcmp(key, "rx_empty_loop") =3D=3D 0) {=0D
+		config->rx_empty_loop =3D (unsigned int)tmp;=0D
+	} else {=0D
+		PMD_DRV_LOG(ERR, "Unknown parameter: %s", key);=0D
+		return -EINVAL;=0D
+	}=0D
+=0D
+	return 0;=0D
+}=0D
+=0D
+static int=0D
+hinic3_nic_common_config_get(struct rte_pci_device *pci_dev,=0D
+			     struct hinic3_nic_common_dev_config *config)=0D
+{=0D
+	int ret =3D 0;=0D
+	struct rte_kvargs *kvlist;=0D
+	struct rte_device *eal_dev =3D &pci_dev->device;=0D
+=0D
+	/* Set private param defaults. */=0D
+	config->rx_empty_threshold =3D HINIC3_RX_EMPTY_THRESHOLD;=0D
+	config->tx_free_loop =3D HINIC3_DEFAULT_TX_FREE_LOOP;=0D
+	config->tx_pending_limit =3D HINIC3_DEFAULT_TX_CI_PENDING_LIMIT;=0D
+	config->tx_coalescing_time =3D HINIC3_DEFAULT_TX_CI_COALESCING_TIME;=0D
+	config->rx_cqe_compact_en =3D HINIC3_RX_CQE_COMPACT_EN;=0D
+	config->rx_cqe_coalesce_num =3D HINIC3_RX_CQE_COALESCE_NUM;=0D
+	config->rx_cqe_timer_loop =3D HINIC3_RX_CQE_TIMER_LOOP;=0D
+	config->rx_empty_loop =3D 0;	/* disabled by default */=0D
+=0D
+	if (eal_dev->devargs =3D=3D NULL)=0D
+		return 0;=0D
+=0D
+	kvlist =3D rte_kvargs_parse(eal_dev->devargs->args, NULL);=0D
+	if (kvlist =3D=3D NULL) {=0D
+		PMD_DRV_LOG(ERR, "nic private parameter err, the format must be '-a dev,=
[key]=3D[value]'.");=0D
+		return -EINVAL;=0D
+	}=0D
+=0D
+	ret =3D rte_kvargs_process(kvlist, NULL, hinic3_nic_common_args_check_han=
dler, config);=0D
+	if (ret)=0D
+		ret =3D -rte_errno;=0D
+=0D
+	rte_kvargs_free(kvlist);=0D
+=0D
+	PMD_DRV_LOG(INFO,=0D
+		"tx_pending_limit:%upkt, tx_coalescing_time:%uus, rx_cqe_coalesce_num:%u=
pkt, rx_cqe_timer_loop:%uus, rx_empty_loop:%u.",=0D
+		config->tx_pending_limit * HINIC3_CI_PENDING_LIMIT_UNIT,=0D
+		config->tx_coalescing_time * HINIC3_CI_COALESCING_TIME_UNIT,=0D
+		config->rx_cqe_coalesce_num * HINIC3_CI_PENDING_LIMIT_UNIT,=0D
+		config->rx_cqe_timer_loop * HINIC3_CI_COALESCING_TIME_UNIT,=0D
+		config->rx_empty_loop);=0D
+	return ret;=0D
+}=0D
+=0D
 static int=0D
 hinic3_dev_init(struct rte_eth_dev *eth_dev)=0D
 {=0D
 	struct rte_pci_device *pci_dev;=0D
+	struct hinic3_nic_dev *nic_dev =3D HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(eth_=
dev);=0D
+	int err =3D 0;=0D
 =0D
 	pci_dev =3D RTE_CLASS_TO_BUS_DEVICE(eth_dev, *pci_dev);=0D
 =0D
@@ -3971,10 +4061,21 @@ hinic3_dev_init(struct rte_eth_dev *eth_dev)=0D
 	PMD_DRV_LOG(DEBUG, "Network Interface pmd driver version: %s",=0D
 		    HINIC3_PMD_DRV_VERSION);=0D
 =0D
+	err =3D hinic3_func_init(eth_dev);=0D
+	if (err)=0D
+		return err;=0D
+=0D
+	err =3D hinic3_nic_common_config_get(pci_dev, &nic_dev->config);=0D
+	if (err < 0) {=0D
+		PMD_DRV_LOG(ERR, "Failed to get nic device arguments: %s",=0D
+			strerror(rte_errno));=0D
+		return err;=0D
+	}=0D
+=0D
 	eth_dev->rx_pkt_burst =3D hinic3_recv_pkts;=0D
 	eth_dev->tx_pkt_burst =3D hinic3_xmit_pkts;=0D
 =0D
-	return hinic3_func_init(eth_dev);=0D
+	return err;=0D
 }=0D
 =0D
 static int=0D
diff --git a/drivers/net/hinic3/hinic3_ethdev.h b/drivers/net/hinic3/hinic3=
_ethdev.h=0D
index 34c74f95d9..8191564fb8 100644=0D
--- a/drivers/net/hinic3/hinic3_ethdev.h=0D
+++ b/drivers/net/hinic3/hinic3_ethdev.h=0D
@@ -6,6 +6,8 @@=0D
 #define _HINIC3_ETHDEV_H_=0D
 =0D
 #include <rte_ethdev.h>=0D
+#include <rte_kvargs.h>=0D
+#include <rte_devargs.h>=0D
 #include <rte_ethdev_core.h>=0D
 =0D
 #include "hinic3_fdir.h"=0D
@@ -60,6 +62,14 @@=0D
 #define HINIC3_VFTA_SIZE		(4096 / HINIC3_UINT32_BIT_SIZE)=0D
 #define HINIC3_MAX_QUEUE_NUM		256=0D
 =0D
+#define HINIC3_DEFAULT_TX_CI_PENDING_LIMIT	2=0D
+#define HINIC3_DEFAULT_TX_CI_COALESCING_TIME	2=0D
+#define HINIC3_RX_CQE_COMPACT_EN		1=0D
+#define HINIC3_RX_CQE_TIMER_LOOP		8=0D
+#define HINIC3_RX_CQE_COALESCE_NUM		7=0D
+#define HINIC3_CI_PENDING_LIMIT_UNIT		8=0D
+#define HINIC3_CI_COALESCING_TIME_UNIT		5=0D
+=0D
 #define HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev) \=0D
 	((struct hinic3_nic_dev *)(dev)->data->dev_private)=0D
 =0D
@@ -107,6 +117,17 @@ enum nic_feature_cap {=0D
 TAILQ_HEAD(hinic3_ethertype_filter_list, rte_flow);=0D
 TAILQ_HEAD(hinic3_fdir_rule_filter_list, rte_flow);=0D
 =0D
+struct hinic3_nic_common_dev_config {=0D
+	unsigned int rx_empty_threshold; /**< consecutive empty RX polls; skip RX=
 if exceeded */=0D
+	unsigned int rx_empty_loop; /**< max empty CQE spin count; 0 =3D no limit=
 */=0D
+	unsigned int tx_free_loop; /**< max retry attempts for TX desc reclaim; s=
top if exceeded */=0D
+	unsigned int tx_pending_limit; /**< TX CI coalescing parameter pending_li=
mit. */=0D
+	unsigned int tx_coalescing_time; /**< TX CI coalescing parameter coalesci=
ng_time. */=0D
+	unsigned int rx_cqe_compact_en; /**< cqe mode, 0 -- separate cqe, 1 -- co=
mpact cqe. */=0D
+	unsigned int rx_cqe_coalesce_num; /**< RX CQE parameter coalesce_num. */=
=0D
+	unsigned int rx_cqe_timer_loop; /**< RX CQE parameter time_loop. */=0D
+};=0D
+=0D
 enum nic_type {=0D
 	NIC_SP620 =3D 0,=0D
 	NIC_SP560 =3D 1,=0D
@@ -146,6 +167,7 @@ struct hinic3_nic_dev {=0D
 =0D
 	uint8_t pause_set; /**< Flag of PAUSE frame setting. */=0D
 	struct nic_pause_config nic_pause;=0D
+	struct hinic3_nic_common_dev_config config;=0D
 =0D
 	struct rte_ether_addr default_addr;=0D
 	struct rte_ether_addr *mc_list;=0D
diff --git a/drivers/net/hinic3/hinic3_nic_io.c b/drivers/net/hinic3/hinic3=
_nic_io.c=0D
index 361586868e..5b905f203e 100644=0D
--- a/drivers/net/hinic3/hinic3_nic_io.c=0D
+++ b/drivers/net/hinic3/hinic3_nic_io.c=0D
@@ -538,9 +538,6 @@ hinic3_get_func_rx_buf_size(struct hinic3_nic_dev *nic_=
dev)=0D
 	nic_dev->rx_buff_len =3D buf_size;=0D
 }=0D
 =0D
-#define HINIC3_RX_CQE_TIMER_LOOP		15=0D
-#define HINIC3_RX_CQE_COALESCE_NUM		63=0D
-=0D
 int=0D
 hinic3_init_rq_cqe_ctxts(struct hinic3_nic_dev *nic_dev)=0D
 {=0D
@@ -569,8 +566,8 @@ hinic3_init_rq_cqe_ctxts(struct hinic3_nic_dev *nic_dev=
)=0D
 			rq_ci_paddr =3D rxq->rq_ci_paddr >> CQE_CTX_CI_ADDR_SHIFT;=0D
 			cqe_ctx.ci_addr_hi =3D upper_32_bits(rq_ci_paddr);=0D
 			cqe_ctx.ci_addr_lo =3D lower_32_bits(rq_ci_paddr);=0D
-			cqe_ctx.threshold_cqe_num =3D HINIC3_RX_CQE_COALESCE_NUM;=0D
-			cqe_ctx.timer_loop =3D HINIC3_RX_CQE_TIMER_LOOP;=0D
+			cqe_ctx.threshold_cqe_num =3D nic_dev->config.rx_cqe_coalesce_num;=0D
+			cqe_ctx.timer_loop =3D nic_dev->config.rx_cqe_timer_loop;=0D
 		} else {=0D
 			cqe_ctx.threshold_cqe_num =3D 0;=0D
 			cqe_ctx.timer_loop =3D 0;=0D
-- =0D
2.33.0=0D
=0D

