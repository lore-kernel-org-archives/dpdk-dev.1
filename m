Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E98B4606A31A
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Oct 2026 15:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=vip.163.com header.i=@vip.163.com header.a=rsa-sha256 header.s=s110527 header.b=NsNvGV9a
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7C22B40B95;
	Fri, 23 Oct 2026 17:58:26 +0200 (CEST)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [220.197.30.223])
 by mails.dpdk.org (Postfix) with ESMTP id D7989406B4
 for <dev@dpdk.org>; Fri, 23 Oct 2026 17:58:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=li1D1JTAo/91APccblBzGWKdFAJbsAs4VrNmAhz2z2k=;
 b=NsNvGV9a5HoCchsDx3Uduqqm/If7y3NdphdaJSQb5hWRGj4jHISgpsBQG/U/Ia
 BFKXxb8OCTGqDaTOPRJT68BtsJ1bGVtA8Xj86ZmuLs6F/3nRYf/JbYjo84c9cm9U
 peHH4JfdlUpWtqdatdzbexR17kgbd0m/PRDcbCZ6t3pWA=
From: Jiacheng Ye <yejiacheng4@h-partners.com>
To: dev@dpdk.org
Cc: Feifei Wang <wangfeifei40@huawei.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v4 07/27] net/hinic3: add NIC type identification
Date: Fri, 23 Oct 2026 23:57:48 +0800
Message-ID: <20261023155809.855-8-yejiacheng4@h-partners.com>
X-Mailer: git-send-email 2.53.0.windows.2
In-Reply-To: <20261023155809.855-1-yejiacheng4@h-partners.com>
References: <20261019151930.1572-1-yejiacheng4@h-partners.com>
 <20261023155809.855-1-yejiacheng4@h-partners.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: As8vCgAnQEEUhNtqKyfqAw--.15103S9
X-Coremail-Antispam: 1Uf129KBjvJXoWxCryUKF4DAr4kZF18AFy8uFg_yoW5Xr13pa
 y7Ka97ZFWDGw4vq3ZxGa9FyF15Za1xu34jga4kAas09F15Zr1UAa4UJrWSvrnxKrW7uFy2
 vF12kw4v93Wjqw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UtsqAUUUUU=
Sender: wff_light@vip.163.com
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiNBi4wmrbhBjqAAAA3R
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

Identify the NIC type from its PCI device ID at initialization and store it
in the NIC private data, so per-model behaviour can be selected without
scattered PCI device ID comparisons.

Signed-off-by: Jiacheng Ye <yejiacheng4@h-partners.com>
---
 drivers/net/hinic3/hinic3_ethdev.c | 17 +++++++++++++++++
 drivers/net/hinic3/hinic3_ethdev.h | 10 ++++++++++
 2 files changed, 27 insertions(+)

diff --git a/drivers/net/hinic3/hinic3_ethdev.c b/drivers/net/hinic3/hinic3_ethdev.c
index 5d67615a94..8502017c86 100644
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

