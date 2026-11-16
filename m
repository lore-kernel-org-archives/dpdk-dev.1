Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D794F606A880
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Nov 2026 10:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=MI4rKxz5
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DD58440150;
	Mon, 16 Nov 2026 11:18:14 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTPS id BBDED400EF;
 Mon, 16 Nov 2026 11:18:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794824295; x=1826360295;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=z+YjR6DYr2pJZcgHdna77KlV2OaLhJ7q/QQOYYiylxY=;
 b=MI4rKxz5tjajfy9JOxiDeWD3yWv9gbYnEF05n00/KySvAfhmn88w+V5z
 HH7Wf33wreduT20PWWSNBgRvlfIPy+Rq1YAtUQ+edXFmJOE9pLYkoC2lh
 sK6bI/9FoLBO/l9z2BkkeGzSKqlj00OmB+kZUq3LhbSi2DSMpcb4QZR7z
 jmoIDgL0OfKXBffqEQuWvFIdN9PqtGcInE0gLdgBj36idOXdkmkzQESiU
 hbslQ5eaDAMonPa3EE7g2kL9ardfEV+AZRnxiJVUrBcuBIohHZJgKhuSw
 O/8LTS6ejQW92cNMDkq+xz13d+wIaiF9TCltEWMEIFS4ERKtUqPlOb5Zc Q==;
X-CSE-ConnectionGUID: eSocF9rhRHijHyqIAt1yzA==
X-CSE-MsgGUID: yGhP3oF9QL2EA8ANYkyu9w==
X-IronPort-AV: E=McAfee;i="6800,10657,11967"; a="3434017"
X-IronPort-AV: E=Sophos;i="6.27,216,1787036400"; 
   d="scan'208";a="3434017"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Nov 2026 02:18:12 -0800
X-CSE-ConnectionGUID: yLx9Q/7BScS8vHq5IiWq7A==
X-CSE-MsgGUID: W5QU0UT0QeuJIbaP1c/55g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,216,1787036400"; d="scan'208";a="11224251"
Received: from pae.iind.intel.com (HELO PAE-35.iind.intel.com) ([10.49.105.82])
 by fmviesa012.fm.intel.com with ESMTP; 16 Nov 2026 02:18:10 -0800
From: Anurag Mandal <anurag.mandal@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, Anurag Mandal <anurag.mandal@intel.com>,
 stable@dpdk.org
Subject: [PATCH] net/e1000: fix VF multicast hashes never removed from MTA
Date: Mon, 16 Nov 2026 10:13:06 +0000
Message-Id: <20261116101306.814093-1-anurag.mandal@intel.com>
X-Mailer: git-send-email 2.25.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The igb PF set each VF's multicast hash bits in the shared
MTA but never cleared them, and saved the list in vfinfo[0]
regardless of which VF sent it.
Hashes a VF dropped therefore stayed set, even after an
empty list or a VF reset.
Conversely, setting the PF multicast list rewrote the MTA
without the VF entries, so the VFs lost their multicast
groups.

Store the list per VF and rebuild the MTA from the PF shadow
list plus all VF lists on VF list update, VF reset and PF
list update, similar to Linux kernel igb driver.

Bugzilla ID: 2081
Fixes: be2d648a2dd3 ("igb: add PF support")
Cc: stable@dpdk.org

Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
---
 drivers/net/intel/e1000/e1000_ethdev.h |  2 ++
 drivers/net/intel/e1000/igb_ethdev.c   |  3 ++
 drivers/net/intel/e1000/igb_pf.c       | 48 ++++++++++++++++++--------
 3 files changed, 39 insertions(+), 14 deletions(-)

diff --git a/drivers/net/intel/e1000/e1000_ethdev.h b/drivers/net/intel/e1000/e1000_ethdev.h
index 0907c7c259..e3d7a11716 100644
--- a/drivers/net/intel/e1000/e1000_ethdev.h
+++ b/drivers/net/intel/e1000/e1000_ethdev.h
@@ -463,6 +463,8 @@ void igb_pf_mbx_process(struct rte_eth_dev *eth_dev);
 
 int igb_pf_host_configure(struct rte_eth_dev *eth_dev);
 
+void igb_pf_restore_mta(struct rte_eth_dev *dev);
+
 void igb_rxq_info_get(struct rte_eth_dev *dev, uint16_t queue_id,
 	struct rte_eth_rxq_info *qinfo);
 
diff --git a/drivers/net/intel/e1000/igb_ethdev.c b/drivers/net/intel/e1000/igb_ethdev.c
index c65a468b26..d80531c872 100644
--- a/drivers/net/intel/e1000/igb_ethdev.c
+++ b/drivers/net/intel/e1000/igb_ethdev.c
@@ -4810,6 +4810,9 @@ eth_igb_set_mc_addr_list(struct rte_eth_dev *dev,
 
 	hw = E1000_DEV_PRIVATE_TO_HW(dev->data->dev_private);
 	e1000_update_mc_addr_list(hw, (u8 *)mc_addr_set, nb_mc_addr);
+	/* the base code rewrote the MTA from the PF list only: add the VF hashes back */
+	if (RTE_ETH_DEV_SRIOV(dev).active)
+		igb_pf_restore_mta(dev);
 	return 0;
 }
 
diff --git a/drivers/net/intel/e1000/igb_pf.c b/drivers/net/intel/e1000/igb_pf.c
index e7f77e69da..2ce79a56d2 100644
--- a/drivers/net/intel/e1000/igb_pf.c
+++ b/drivers/net/intel/e1000/igb_pf.c
@@ -229,6 +229,34 @@ set_rx_mode(struct rte_eth_dev *dev)
 	E1000_WRITE_REG(hw, E1000_RCTL, fctrl);
 }
 
+/* MTA is shared by the PF and all VFs: rebuild it from the PF list and each VF list */
+void
+igb_pf_restore_mta(struct rte_eth_dev *dev)
+{
+	struct e1000_hw *hw = E1000_DEV_PRIVATE_TO_HW(dev->data->dev_private);
+	struct e1000_vf_info *vfinfo =
+		*(E1000_DEV_PRIVATE_TO_P_VFDATA(dev->data->dev_private));
+	uint32_t mta[MAX_MTA_REG];
+	uint32_t vector_bit;
+	uint32_t vector_reg;
+	uint16_t vf;
+	int i;
+
+	memcpy(mta, hw->mac.mta_shadow, sizeof(mta));
+
+	for (vf = 0; vf < dev_num_vf(dev); vf++) {
+		for (i = 0; i < vfinfo[vf].num_vf_mc_hashes; i++) {
+			vector_reg = (vfinfo[vf].vf_mc_hashes[i] >> 5) & 0x7F;
+			vector_bit = vfinfo[vf].vf_mc_hashes[i] & 0x1F;
+			mta[vector_reg] |= (1U << vector_bit);
+		}
+	}
+
+	for (i = hw->mac.mta_reg_count - 1; i >= 0; i--)
+		E1000_WRITE_REG_ARRAY(hw, E1000_MTA, i, mta[i]);
+	E1000_WRITE_FLUSH(hw);
+}
+
 static inline void
 igb_vf_reset_event(struct rte_eth_dev *dev, uint16_t vf)
 {
@@ -246,6 +274,7 @@ igb_vf_reset_event(struct rte_eth_dev *dev, uint16_t vf)
 
 	/* reset multicast table array for vf */
 	vfinfo[vf].num_vf_mc_hashes = 0;
+	igb_pf_restore_mta(dev);
 
 	/* reset rx mode */
 	set_rx_mode(dev);
@@ -319,16 +348,12 @@ igb_vf_set_mac_addr(struct rte_eth_dev *dev, uint32_t vf, uint32_t *msgbuf)
 }
 
 static int
-igb_vf_set_multicast(struct rte_eth_dev *dev, __rte_unused uint32_t vf, uint32_t *msgbuf)
+igb_vf_set_multicast(struct rte_eth_dev *dev, uint32_t vf, uint32_t *msgbuf)
 {
 	int i;
-	uint32_t vector_bit;
-	uint32_t vector_reg;
-	uint32_t mta_reg;
 	int entries = (msgbuf[0] & E1000_VT_MSGINFO_MASK) >>
 		E1000_VT_MSGINFO_SHIFT;
 	uint16_t *hash_list = (uint16_t *)&msgbuf[1];
-	struct e1000_hw *hw = E1000_DEV_PRIVATE_TO_HW(dev->data->dev_private);
 	struct e1000_vf_info *vfinfo =
 		*(E1000_DEV_PRIVATE_TO_P_VFDATA(dev->data->dev_private));
 
@@ -340,23 +365,18 @@ igb_vf_set_multicast(struct rte_eth_dev *dev, __rte_unused uint32_t vf, uint32_t
 	 * to this VF for later use to restore when the PF multi cast
 	 * list changes
 	 */
-	vfinfo->num_vf_mc_hashes = (uint16_t)entries;
+	vfinfo[vf].num_vf_mc_hashes = (uint16_t)entries;
 
 	/*
 	 * VFs are limited to using the MTA hash table for their multicast
 	 * addresses
 	 */
 	for (i = 0; i < entries; i++) {
-		vfinfo->vf_mc_hashes[i] = hash_list[i];
+		vfinfo[vf].vf_mc_hashes[i] = hash_list[i];
 	}
 
-	for (i = 0; i < vfinfo->num_vf_mc_hashes; i++) {
-		vector_reg = (vfinfo->vf_mc_hashes[i] >> 5) & 0x7F;
-		vector_bit = vfinfo->vf_mc_hashes[i] & 0x1F;
-		mta_reg = E1000_READ_REG_ARRAY(hw, E1000_MTA, vector_reg);
-		mta_reg |= (1 << vector_bit);
-		E1000_WRITE_REG_ARRAY(hw, E1000_MTA, vector_reg, mta_reg);
-	}
+	/* the message carries the full list: replace what this VF had */
+	igb_pf_restore_mta(dev);
 
 	return 0;
 }
-- 
2.25.1

