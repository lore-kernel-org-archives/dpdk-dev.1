Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 372C5CC6B1A
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Oct 2026 15:09:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B437540687;
	Wed, 14 Oct 2026 17:09:47 +0200 (CEST)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [1.95.21.4])
 by mails.dpdk.org (Postfix) with ESMTP id 0AE854042C
 for <dev@dpdk.org>; Wed, 14 Oct 2026 17:09:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=Rfbml2n6xwWG75g1VIS6CAQWyae/mJsE/GHqblIXWxk=;
 b=RLdL7ImTjOnVyNm1H7W/xz1VI/DXy/C/ogg98KLICD2wbK3PliKjraZnY8oPGX
 0M0pAOK21J1eZ4OLxoSao4WqzhpLvLJQzo+4MVnEz3AxKoomJdTyf32h/KyeuL+M
 I0otU4g5dX5oPm4yWShxm/57r5AeRau20MX4KPHq8/VJM=
From: Jiacheng Ye <yejiacheng4@h-partners.com>
To: dev@dpdk.org
Cc: Feifei Wang <wangfeifei40@huawei.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v2 06/26] net/hinic3: add NIC type identification
Date: Wed, 14 Oct 2026 23:09:02 +0800
Message-ID: <20261014150923.838-7-yejiacheng4@h-partners.com>
X-Mailer: git-send-email 2.53.0.windows.2
In-Reply-To: <20261014150923.838-1-yejiacheng4@h-partners.com>
References: <20261010144509.2731-1-yejiacheng4@h-partners.com>
 <20261014150923.838-1-yejiacheng4@h-partners.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: As8vCgAXMEEym89qB_SFAw--.62919S8
X-Coremail-Antispam: 1Uf129KBjvJXoWxCryUKF4DAr4kZF18AFy8uFg_yoW5Xr13pa
 y7Ka97ZFWDGw4vv3ZxGa9IyF15Za1xu34jga4kAas09F45Zr1UA34UJrWSyrnxKrW7uFy2
 vF12kw4v93Wjqw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UtsqAUUUUU=
Sender: wff_light@vip.163.com
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiNxaCjGrPmzYffgAA3G
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

Identify the NIC type from its PCI device ID at initialization and store it
in the NIC private data, so per-model behaviour can be selected without
scattered PCI device ID comparisons.

Signed-off-by: Jiacheng Ye <yejiacheng4@h-partners.com>
---
 drivers/net/hinic3/hinic3_ethdev.c | 17 +++++++++++++++++
 drivers/net/hinic3/hinic3_ethdev.h | 10 ++++++++++
 2 files changed, 27 insertions(+)

diff --git a/drivers/net/hinic3/hinic3_ethdev.c b/drivers/net/hinic3/hinic3_ethdev.c
index 9944edf978..678ed46454 100644
--- a/drivers/net/hinic3/hinic3_ethdev.c
+++ b/drivers/net/hinic3/hinic3_ethdev.c
@@ -482,6 +482,22 @@ hinic3_init_default_cos(struct hinic3_nic_dev *nic_dev)
 	return 0;
 }
 
+static enum nic_type
+hinic3_get_nic_type(struct rte_pci_device *pci_dev)
+{
+	switch (pci_dev->id.device_id) {
+	case HINIC3_DEV_ID_SP620:
+	case HINIC3_DEV_ID_VF_SP620:
+	case HINIC3_DEV_ID_SP920: /* SP920 is the DPU card of SP620. */
+		return NIC_SP620;
+	case HINIC3_DEV_ID_SP230:
+	case HINIC3_DEV_ID_VF_SP230:
+		return NIC_SP230;
+	default:
+		return NIC_UNKNOWN;
+	}
+}
+
 /**
  * Initialize Class of Service (CoS). For PF devices, it also sync the link
  * status with the physical port.
@@ -3420,6 +3436,7 @@ hinic3_func_init(struct rte_eth_dev *eth_dev)
 
 	nic_dev = HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(eth_dev);
 	memset(nic_dev, 0, sizeof(*nic_dev));
+	nic_dev->nic_type = hinic3_get_nic_type(pci_dev);
 	snprintf(nic_dev->dev_name, sizeof(nic_dev->dev_name),
 		"dbdf-%.4x:%.2x:%.2x.%x", pci_dev->addr.domain,
 		pci_dev->addr.bus, pci_dev->addr.devid,
diff --git a/drivers/net/hinic3/hinic3_ethdev.h b/drivers/net/hinic3/hinic3_ethdev.h
index 9061e2b217..c46fcfcbec 100644
--- a/drivers/net/hinic3/hinic3_ethdev.h
+++ b/drivers/net/hinic3/hinic3_ethdev.h
@@ -106,6 +106,12 @@ enum nic_feature_cap {
 TAILQ_HEAD(hinic3_ethertype_filter_list, rte_flow);
 TAILQ_HEAD(hinic3_fdir_rule_filter_list, rte_flow);
 
+enum nic_type {
+	NIC_SP620 = 0,
+	NIC_SP230 = 1,
+	NIC_UNKNOWN = 2,
+};
+
 struct hinic3_nic_dev {
 	struct hinic3_hwdev *hwdev; /**< Hardware device. */
 	struct hinic3_txq **txqs;
@@ -152,9 +158,13 @@ struct hinic3_nic_dev {
 	struct hinic3_nic_cmdq_ops *cmdq_ops;
 	struct hinic3_nic_rx_ops *rx_ops;
 	struct hinic3_nic_tx_ops *tx_ops;
+	enum nic_type nic_type; /**< NIC type. */
 
 };
 
+#define HINIC3_IS_SP620_NIC(nic_dev) ((nic_dev)->nic_type == NIC_SP620)
+#define HINIC3_IS_SP230_NIC(nic_dev) ((nic_dev)->nic_type == NIC_SP230)
+
 extern const struct rte_flow_ops hinic3_flow_ops;
 
 /**
-- 
2.33.0

