Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7150606A31E
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Nov 2026 17:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=vip.163.com header.i=@vip.163.com header.a=rsa-sha256 header.s=s110527 header.b=m/I4Cl7w
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8769340B9C;
	Wed, 25 Nov 2026 18:06:03 +0100 (CET)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [220.197.30.220])
 by mails.dpdk.org (Postfix) with ESMTPS id 20DF440663
 for <dev@dpdk.org>; Wed, 25 Nov 2026 18:05:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=wYA9cXv+pBrw2AmFxn0a+s/3gZ40UXGv9XsqZaP/a/Y=;
 b=m/I4Cl7whUnnN2Y1iXXy8xjGWAAToXVGz4qLka4CBOn4nS9PpZOmhHlCuxehUT
 CcYDUNl7+og4MLbJc0agA6tJ4q9I1/pPprjcF55uXfRrLlzkcyqgkZ3mACz800er
 JGbCvsIvHpDIOKzVyVwJgDd7DkiTjkeJYmMrOEz4s0I1Q=
From: Jiacheng Ye <yejiacheng4@h-partners.com>
To: dev@dpdk.org
Cc: Feifei Wang <wangfeifei40@huawei.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v9 17/30] net/hinic3: add COS mask and COS map support
Date: Thu, 26 Nov 2026 01:04:11 +0800
Message-ID: <20261125170425.5430-18-yejiacheng4@h-partners.com>
X-Mailer: git-send-email 2.56.0.windows.2
In-Reply-To: <20261125170425.5430-1-yejiacheng4@h-partners.com>
References: <20261125170425.5430-1-yejiacheng4@h-partners.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: As8vCgDn77FiFQdrEdNeBQ--.6538S19
X-Coremail-Antispam: 1Uf129KBjvJXoWxKFykJr4DGF13uFW5WrWkXrb_yoWfGrWUpF
 WUGayDAFZrtr4Ut3WkJ3yDA3W5XasFk3y2k340kas09Fs5ZFyDZ34DKFW7Ar4rXrW7AF17
 Zr4jk39F9w1vqwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jbo7NUUUUU=
Sender: wff_light@vip.163.com
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiNw78B2sHFW4fzQAA3H
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

Apply the firmware COS mask/map when setting up Tx queues so the configured
COS value selects the intended queue.

The VF default COS limit HINIC3_COS_NUM_MAX_HTN (4) only applies to the
HTN tile used by SP230, where the firmware cos_mask can select four
non-contiguous COS values for the NIC and cos_map[] maps every other COS
to default_cos. SP620 and SP560 assign all eight COS to the NIC, so drop
the clamp there.

Fixes: 9204b6b7bb1a ("net/hinic3: split new/old command queue operations")

Signed-off-by: Jiacheng Ye <yejiacheng4@h-partners.com>
---
 doc/guides/rel_notes/release_26_11.rst   |  1 +
 drivers/net/hinic3/base/hinic3_hw_cfg.c  |  2 +
 drivers/net/hinic3/base/hinic3_hw_cfg.h  |  8 +++-
 drivers/net/hinic3/base/hinic3_nic_cfg.c |  2 +-
 drivers/net/hinic3/base/hinic3_nic_cfg.h |  1 -
 drivers/net/hinic3/hinic3_ethdev.c       | 59 +++++++++++++++++++++---
 drivers/net/hinic3/hinic3_ethdev.h       |  2 +
 7 files changed, 64 insertions(+), 11 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index e0d042f681..4ccc9ad5a7 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -133,6 +133,7 @@ New Features
   * Added vport statistics, including CIR drop, and VF link
     aggregation (LAG) support.
   * Added FEC mode get and set support.
+  * Added Class of Service (COS) mask and map support.
   * Added mailbox message counter reporting through the device private dump API.
 
 * **Updated Intel iavf driver.**
diff --git a/drivers/net/hinic3/base/hinic3_hw_cfg.c b/drivers/net/hinic3/base/hinic3_hw_cfg.c
index 8899f98515..e7971509d5 100644
--- a/drivers/net/hinic3/base/hinic3_hw_cfg.c
+++ b/drivers/net/hinic3/base/hinic3_hw_cfg.c
@@ -22,6 +22,8 @@ parse_pub_res_cap(struct service_cap *cap,
 	cap->chip_svc_type = cap->svc_type;
 
 	cap->cos_valid_bitmap = dev_cap->valid_cos_bitmap;
+	cap->cos_mask_mode = dev_cap->cos_mask_mode;
+	cap->cos_mask_bitmap = dev_cap->cos_mask_bitmap;
 	cap->flexq_en = dev_cap->flexq_en;
 
 	cap->host_total_function = dev_cap->host_total_func;
diff --git a/drivers/net/hinic3/base/hinic3_hw_cfg.h b/drivers/net/hinic3/base/hinic3_hw_cfg.h
index 46a9c9bf4b..62af1daa25 100644
--- a/drivers/net/hinic3/base/hinic3_hw_cfg.h
+++ b/drivers/net/hinic3/base/hinic3_hw_cfg.h
@@ -40,6 +40,8 @@ struct service_cap {
 
 	uint8_t flexq_en;
 	uint8_t cos_valid_bitmap;
+	uint8_t cos_mask_mode;
+	uint8_t cos_mask_bitmap;
 	uint16_t max_vf; /**< Max VF number that PF supported. */
 
 	struct nic_service_cap nic_cap; /**< NIC capability. */
@@ -80,9 +82,11 @@ struct hinic3_cfg_cmd_dev_cap {
 	uint8_t flexq_en;
 	uint8_t valid_cos_bitmap;
 	/* Reserved for func_valid_cos_bitmap. */
-	uint16_t rsvd_cos;
+	uint16_t rsvd_valid_cos[2];
+	uint8_t cos_mask_mode;
+	uint8_t cos_mask_bitmap;
 
-	uint32_t rsvd[11];
+	uint32_t rsvd[10];
 
 	/* l2nic */
 	uint16_t nic_max_sq_id;
diff --git a/drivers/net/hinic3/base/hinic3_nic_cfg.c b/drivers/net/hinic3/base/hinic3_nic_cfg.c
index b6717f2990..531ac0ecf9 100644
--- a/drivers/net/hinic3/base/hinic3_nic_cfg.c
+++ b/drivers/net/hinic3/base/hinic3_nic_cfg.c
@@ -1492,7 +1492,7 @@ hinic3_vf_get_default_cos(struct hinic3_hwdev *hwdev, uint8_t *cos_id)
 		return -EIO;
 	}
 
-	*cos_id = vf_dcb.state.default_cos % HINIC3_COS_NUM_MAX_HTN;
+	*cos_id = vf_dcb.state.default_cos;
 
 	return 0;
 }
diff --git a/drivers/net/hinic3/base/hinic3_nic_cfg.h b/drivers/net/hinic3/base/hinic3_nic_cfg.h
index 9458a576c4..b5d7ce07a1 100644
--- a/drivers/net/hinic3/base/hinic3_nic_cfg.h
+++ b/drivers/net/hinic3/base/hinic3_nic_cfg.h
@@ -23,7 +23,6 @@
 #define HINIC3_MIN_MTU_SIZE		256
 
 #define HINIC3_COS_NUM_MAX		8
-#define HINIC3_COS_NUM_MAX_HTN		4
 
 #define HINIC3_VLAN_TAG_SIZE	4
 #define HINIC3_ETH_OVERHEAD \
diff --git a/drivers/net/hinic3/hinic3_ethdev.c b/drivers/net/hinic3/hinic3_ethdev.c
index 4f337791fc..325764dee4 100644
--- a/drivers/net/hinic3/hinic3_ethdev.c
+++ b/drivers/net/hinic3/hinic3_ethdev.c
@@ -76,6 +76,9 @@ enum hinic3_rx_mod {
 #define HINIC3_DEFAULT_RX_MODE \
 	(HINIC3_RX_MODE_UC | HINIC3_RX_MODE_MC | HINIC3_RX_MODE_BC)
 
+#define HINIC3_DEFAULT_COS_MASK		0x7
+#define HINIC3_DEFAULT_COS_MASK_BITMAP	0xff
+
 struct hinic3_xstats_name_off {
 	char name[RTE_ETH_XSTATS_NAME_SIZE];
 	uint32_t offset;
@@ -451,10 +454,8 @@ hinic3_deinit_mac_addr(struct rte_eth_dev *eth_dev)
 static int
 hinic3_pf_get_default_cos(struct hinic3_hwdev *hwdev, uint8_t *cos_id)
 {
-	struct hinic3_nic_dev *nic_dev = hwdev->dev_handle;
 	uint8_t default_cos = 0;
 	uint8_t valid_cos_bitmap;
-	uint8_t cos_num_max;
 	uint8_t i;
 
 	valid_cos_bitmap = hwdev->cfg_mgmt->svc_cap.cos_valid_bitmap;
@@ -463,10 +464,7 @@ hinic3_pf_get_default_cos(struct hinic3_hwdev *hwdev, uint8_t *cos_id)
 		return -EFAULT;
 	}
 
-	cos_num_max = nic_dev->feature_cap & NIC_F_HTN_CMDQ ?
-		      HINIC3_COS_NUM_MAX_HTN : HINIC3_COS_NUM_MAX;
-
-	for (i = 0; i < cos_num_max; i++) {
+	for (i = 0; i < HINIC3_COS_NUM_MAX; i++) {
 		if (valid_cos_bitmap & RTE_BIT32(i))
 			/* Find max cos id as default cos. */
 			default_cos = i;
@@ -477,12 +475,53 @@ hinic3_pf_get_default_cos(struct hinic3_hwdev *hwdev, uint8_t *cos_id)
 	return 0;
 }
 
+static void
+hinic3_get_cos_mask(struct hinic3_hwdev *hwdev, uint8_t *cos_mask)
+{
+	uint8_t cos_mask_mode;
+
+	cos_mask_mode = hwdev->cfg_mgmt->svc_cap.cos_mask_mode;
+	if (!cos_mask_mode) {
+		*cos_mask = HINIC3_DEFAULT_COS_MASK; /* default: 8 COS*/
+		PMD_DRV_LOG(INFO,
+			"cos mask not provided by firmware, use default 0x%x",
+			HINIC3_DEFAULT_COS_MASK);
+		return;
+	}
+
+	*cos_mask = cos_mask_mode;
+}
+
+static void
+hinic3_get_cos_mask_bitmap(struct hinic3_nic_dev *nic_dev)
+{
+	int i;
+	uint8_t default_cos = 0;
+	uint8_t cos_mask_bitmap = nic_dev->hwdev->cfg_mgmt->svc_cap.cos_mask_bitmap == 0
+			? HINIC3_DEFAULT_COS_MASK_BITMAP
+			: nic_dev->hwdev->cfg_mgmt->svc_cap.cos_mask_bitmap;
+
+	PMD_DRV_LOG(INFO, "cos_mask_bitmap: 0x%x", cos_mask_bitmap);
+	for (i = HINIC3_COS_NUM_MAX - 1; i >= 0; i--) {
+		if (cos_mask_bitmap & RTE_BIT32(i)) {
+			default_cos = i;
+			break;
+		}
+	}
+
+	for (i = 0; i < HINIC3_COS_NUM_MAX; i++)
+		nic_dev->cos_map[i] = ((RTE_BIT32(i) & cos_mask_bitmap) == 0) ? default_cos : i;
+}
+
 static int
 hinic3_init_default_cos(struct hinic3_nic_dev *nic_dev)
 {
+	uint8_t cos_mask = 0;
 	uint8_t cos_id = 0;
 	int err;
 
+	hinic3_get_cos_mask(nic_dev->hwdev, &cos_mask);
+
 	if (!HINIC3_IS_VF(nic_dev->hwdev)) {
 		err = hinic3_pf_get_default_cos(nic_dev->hwdev, &cos_id);
 		if (err) {
@@ -497,8 +536,9 @@ hinic3_init_default_cos(struct hinic3_nic_dev *nic_dev)
 		}
 	}
 
+	nic_dev->cos_mask = cos_mask;
 	nic_dev->default_cos = cos_id;
-	PMD_DRV_LOG(DEBUG, "Default cos %d", nic_dev->default_cos);
+	PMD_DRV_LOG(DEBUG, "Default cos %d, cos mask %d", nic_dev->default_cos, nic_dev->cos_mask);
 	return 0;
 }
 
@@ -533,6 +573,7 @@ hinic3_set_default_hw_feature(struct hinic3_nic_dev *nic_dev)
 {
 	int err;
 
+	hinic3_get_cos_mask_bitmap(nic_dev);
 	err = hinic3_init_default_cos(nic_dev);
 	if (err)
 		return err;
@@ -1297,6 +1338,10 @@ hinic3_tx_queue_setup(struct rte_eth_dev *dev, uint16_t qid, uint16_t nb_desc,
 	else
 		txq->cos = nic_dev->default_cos;
 
+	if (HINIC3_IS_SP230_NIC(nic_dev))
+		txq->cos = nic_dev->cos_map[txq->cos &
+			(HINIC3_COS_NUM_MAX - 1) & nic_dev->cos_mask];
+
 	txq->tx_deferred_start = tx_conf->tx_deferred_start;
 	txq->tx_wqe_compact_task = HINIC3_SUPPORT_TX_WQE_COMPACT_TASK(nic_dev);
 
diff --git a/drivers/net/hinic3/hinic3_ethdev.h b/drivers/net/hinic3/hinic3_ethdev.h
index c3384e5fd0..935b7719ca 100644
--- a/drivers/net/hinic3/hinic3_ethdev.h
+++ b/drivers/net/hinic3/hinic3_ethdev.h
@@ -133,6 +133,7 @@ struct hinic3_nic_dev {
 	uint8_t rx_queue_list[HINIC3_MAX_QUEUE_NUM];
 	rte_spinlock_t queue_list_lock;
 
+	uint32_t cos_mask;
 	uint32_t default_cos;
 	uint32_t rx_csum_en;
 
@@ -155,6 +156,7 @@ struct hinic3_nic_dev {
 	struct hinic3_tcam_info tcam;
 	struct hinic3_ethertype_filter_list filter_ethertype_list;
 	struct hinic3_fdir_rule_filter_list filter_fdir_rule_list;
+	uint8_t cos_map[HINIC3_COS_NUM_MAX];
 	struct hinic3_nic_cmdq_ops *cmdq_ops;
 	struct hinic3_nic_rx_ops *rx_ops;
 	struct hinic3_nic_tx_ops *tx_ops;
-- 
2.33.0

