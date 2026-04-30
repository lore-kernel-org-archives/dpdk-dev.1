Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2AC1CCFA13
	for <dpdk-dev@archiver.kernel.org>; Thu, 30 Apr 2026 11:15:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1907840A6B;
	Thu, 30 Apr 2026 13:15:09 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id D7BB040695
 for <dev@dpdk.org>; Thu, 30 Apr 2026 13:15:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777547706; x=1809083706;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=lV2zNfy0NI10JNl6TDMeojZToUk4no9LCFsrhGuGPG0=;
 b=ftxB4XryPdD9VCipWta1E3yJXPplDx3JjSbmV+AZSg9xaiCQ/lnwKzS/
 pRW9AgAGd5fGXbUaInD4fKIf85Mv45kX0BZen85KlkEnqD6zI60B1B8ch
 9oYRCTWD1io1VrhYq3Q0cMKcTyeJCO9gaqTHTeEAyAYI9oixyPAZxI8v+
 +4NGZoa7dhWo1iXxNC3FTnh0H25HX77xi/jsGIzFHbXukfUABOpgNQCF/
 dFwjmeD4QCfuuXPO9uMB/Ao45m/oQd7Tfoms/rd8TIoMSFd2y64V6y4pL
 050WrwxXHuK4jS/GyRDkUbSkpMHZW6wskcmTIPpAbpF7nxfmuYHQd7QS0 Q==;
X-CSE-ConnectionGUID: xwZHGFb6SjuiAZ4nJKQJIQ==
X-CSE-MsgGUID: AP6tXRk0Q6ekIO4QDACLTQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="78482285"
X-IronPort-AV: E=Sophos;i="6.23,208,1770624000"; d="scan'208";a="78482285"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Apr 2026 04:15:05 -0700
X-CSE-ConnectionGUID: ZQxag0UTSWOFtncUmaCn7g==
X-CSE-MsgGUID: SSOVcfrFTA+hUSRu+VVBKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,208,1770624000"; d="scan'208";a="234444787"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa008.jf.intel.com with ESMTP; 30 Apr 2026 04:15:05 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v1 10/15] net/ixgbe: reduce FDIR conf macro usage
Date: Thu, 30 Apr 2026 12:14:39 +0100
Message-ID: <dd993da438102fa004afadb3e7595b1aa1fa7b59.1777547413.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1777547413.git.anatoly.burakov@intel.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Currently, there are quite a few places where FDIR_CONF macro is used
repeatedly within the same function. Change these instances to only get the
fdir conf pointer once, and use the pointer instead.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/ixgbe/ixgbe_ethdev.c |  3 ++-
 drivers/net/intel/ixgbe/ixgbe_fdir.c   | 34 ++++++++++++++++----------
 2 files changed, 23 insertions(+), 14 deletions(-)

diff --git a/drivers/net/intel/ixgbe/ixgbe_ethdev.c b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
index ee1b499b49..dc3aa49ec4 100644
--- a/drivers/net/intel/ixgbe/ixgbe_ethdev.c
+++ b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
@@ -2614,6 +2614,7 @@ ixgbe_dev_start(struct rte_eth_dev *dev)
 {
 	struct ixgbe_hw *hw =
 		IXGBE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
+	struct rte_eth_fdir_conf *fdir_conf = IXGBE_DEV_FDIR_CONF(dev);
 	struct ixgbe_vf_info *vfinfo =
 		*IXGBE_DEV_PRIVATE_TO_P_VFDATA(dev->data->dev_private);
 	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
@@ -2718,7 +2719,7 @@ ixgbe_dev_start(struct rte_eth_dev *dev)
 	/* Configure DCB hw */
 	ixgbe_configure_dcb(dev);
 
-	if (IXGBE_DEV_FDIR_CONF(dev)->mode != RTE_FDIR_MODE_NONE) {
+	if (fdir_conf->mode != RTE_FDIR_MODE_NONE) {
 		err = ixgbe_fdir_configure(dev);
 		if (err)
 			goto error;
diff --git a/drivers/net/intel/ixgbe/ixgbe_fdir.c b/drivers/net/intel/ixgbe/ixgbe_fdir.c
index 5f7159abf2..51557cf68d 100644
--- a/drivers/net/intel/ixgbe/ixgbe_fdir.c
+++ b/drivers/net/intel/ixgbe/ixgbe_fdir.c
@@ -251,6 +251,7 @@ static int
 fdir_set_input_mask_82599(struct rte_eth_dev *dev)
 {
 	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
+	struct rte_eth_fdir_conf *fdir_conf = IXGBE_DEV_FDIR_CONF(dev);
 	struct ixgbe_hw_fdir_info *info =
 			IXGBE_DEV_PRIVATE_TO_FDIR_INFO(dev->data->dev_private);
 	/*
@@ -313,7 +314,7 @@ fdir_set_input_mask_82599(struct rte_eth_dev *dev)
 	reg = IXGBE_PCI_REG_ADDR(hw, IXGBE_FDIRDIP4M);
 	*reg = ~(info->mask.dst_ipv4_mask);
 
-	if (IXGBE_DEV_FDIR_CONF(dev)->mode == RTE_FDIR_MODE_SIGNATURE) {
+	if (fdir_conf->mode == RTE_FDIR_MODE_SIGNATURE) {
 		/*
 		 * Store source and destination IPv6 masks (bit reversed)
 		 */
@@ -334,6 +335,7 @@ static int
 fdir_set_input_mask_x550(struct rte_eth_dev *dev)
 {
 	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
+	struct rte_eth_fdir_conf *fdir_conf = IXGBE_DEV_FDIR_CONF(dev);
 	struct ixgbe_hw_fdir_info *info =
 			IXGBE_DEV_PRIVATE_TO_FDIR_INFO(dev->data->dev_private);
 	/* mask VM pool and DIPv6 since there are currently not supported
@@ -342,7 +344,7 @@ fdir_set_input_mask_x550(struct rte_eth_dev *dev)
 	uint32_t fdirm = IXGBE_FDIRM_POOL | IXGBE_FDIRM_DIPv6 |
 			 IXGBE_FDIRM_FLEX;
 	uint32_t fdiripv6m;
-	enum rte_fdir_mode mode = IXGBE_DEV_FDIR_CONF(dev)->mode;
+	enum rte_fdir_mode mode = fdir_conf->mode;
 	uint16_t mac_mask;
 
 	PMD_INIT_FUNC_TRACE();
@@ -425,7 +427,8 @@ fdir_set_input_mask_x550(struct rte_eth_dev *dev)
 int
 ixgbe_fdir_set_input_mask(struct rte_eth_dev *dev)
 {
-	enum rte_fdir_mode mode = IXGBE_DEV_FDIR_CONF(dev)->mode;
+	struct rte_eth_fdir_conf *fdir_conf = IXGBE_DEV_FDIR_CONF(dev);
+	enum rte_fdir_mode mode = fdir_conf->mode;
 
 	if (mode >= RTE_FDIR_MODE_SIGNATURE &&
 	    mode <= RTE_FDIR_MODE_PERFECT)
@@ -563,10 +566,11 @@ int
 ixgbe_fdir_configure(struct rte_eth_dev *dev)
 {
 	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
+	struct rte_eth_fdir_conf *fdir_conf = IXGBE_DEV_FDIR_CONF(dev);
 	int err;
 	uint32_t fdirctrl, pbsize;
 	int i;
-	enum rte_fdir_mode mode = IXGBE_DEV_FDIR_CONF(dev)->mode;
+	enum rte_fdir_mode mode = fdir_conf->mode;
 
 	PMD_INIT_FUNC_TRACE();
 
@@ -587,7 +591,7 @@ ixgbe_fdir_configure(struct rte_eth_dev *dev)
 	    mode != RTE_FDIR_MODE_PERFECT)
 		return -ENOSYS;
 
-	err = configure_fdir_flags(IXGBE_DEV_FDIR_CONF(dev), &fdirctrl);
+	err = configure_fdir_flags(fdir_conf, &fdirctrl);
 	if (err)
 		return err;
 
@@ -614,7 +618,7 @@ ixgbe_fdir_configure(struct rte_eth_dev *dev)
 		PMD_INIT_LOG(ERR, " Error on setting FD mask");
 		return err;
 	}
-	err = ixgbe_set_fdir_flex_conf(dev, &IXGBE_DEV_FDIR_CONF(dev)->flex_conf,
+	err = ixgbe_set_fdir_flex_conf(dev, &fdir_conf->flex_conf,
 				       &fdirctrl);
 	if (err < 0) {
 		PMD_INIT_LOG(ERR, " Error on setting FD flexible arguments.");
@@ -1043,6 +1047,7 @@ ixgbe_fdir_filter_program(struct rte_eth_dev *dev,
 			  bool update)
 {
 	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
+	struct rte_eth_fdir_conf *fdir_conf = IXGBE_DEV_FDIR_CONF(dev);
 	uint32_t fdircmd_flags;
 	uint32_t fdirhash;
 	uint8_t queue;
@@ -1050,7 +1055,7 @@ ixgbe_fdir_filter_program(struct rte_eth_dev *dev,
 	int err;
 	struct ixgbe_hw_fdir_info *info =
 		IXGBE_DEV_PRIVATE_TO_FDIR_INFO(dev->data->dev_private);
-	enum rte_fdir_mode fdir_mode = IXGBE_DEV_FDIR_CONF(dev)->mode;
+	enum rte_fdir_mode fdir_mode = fdir_conf->mode;
 	struct ixgbe_fdir_filter *node;
 	bool add_node = FALSE;
 
@@ -1095,12 +1100,12 @@ ixgbe_fdir_filter_program(struct rte_eth_dev *dev,
 			return -ENOTSUP;
 		}
 		fdirhash = atr_compute_perfect_hash_82599(&rule->ixgbe_fdir,
-							  IXGBE_DEV_FDIR_CONF(dev)->pballoc);
+				fdir_conf->pballoc);
 		fdirhash |= rule->soft_id <<
 			IXGBE_FDIRHASH_SIG_SW_INDEX_SHIFT;
 	} else
 		fdirhash = atr_compute_sig_hash_82599(&rule->ixgbe_fdir,
-						      IXGBE_DEV_FDIR_CONF(dev)->pballoc);
+				fdir_conf->pballoc);
 
 	if (del) {
 		err = ixgbe_remove_fdir_filter(info, &rule->ixgbe_fdir);
@@ -1118,7 +1123,7 @@ ixgbe_fdir_filter_program(struct rte_eth_dev *dev,
 	fdircmd_flags = (update) ? IXGBE_FDIRCMD_FILTER_UPDATE : 0;
 	if (rule->fdirflags & IXGBE_FDIRCMD_DROP) {
 		if (is_perfect) {
-			queue = IXGBE_DEV_FDIR_CONF(dev)->drop_queue;
+			queue = fdir_conf->drop_queue;
 			fdircmd_flags |= IXGBE_FDIRCMD_DROP;
 		} else {
 			PMD_DRV_LOG(ERR, "Drop option is not supported in"
@@ -1209,6 +1214,7 @@ void
 ixgbe_fdir_info_get(struct rte_eth_dev *dev, struct rte_eth_fdir_info *fdir_info)
 {
 	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
+	struct rte_eth_fdir_conf *fdir_conf = IXGBE_DEV_FDIR_CONF(dev);
 	struct ixgbe_hw_fdir_info *info =
 			IXGBE_DEV_PRIVATE_TO_FDIR_INFO(dev->data->dev_private);
 	uint32_t fdirctrl, max_num;
@@ -1218,7 +1224,7 @@ ixgbe_fdir_info_get(struct rte_eth_dev *dev, struct rte_eth_fdir_info *fdir_info
 	offset = ((fdirctrl & IXGBE_FDIRCTRL_FLEX_MASK) >>
 			IXGBE_FDIRCTRL_FLEX_SHIFT) * sizeof(uint16_t);
 
-	fdir_info->mode = IXGBE_DEV_FDIR_CONF(dev)->mode;
+	fdir_info->mode = fdir_conf->mode;
 	max_num = (1 << (FDIRENTRIES_NUM_SHIFT +
 			(fdirctrl & FDIRCTRL_PBALLOC_MASK)));
 	if (fdir_info->mode >= RTE_FDIR_MODE_PERFECT &&
@@ -1268,10 +1274,11 @@ void
 ixgbe_fdir_stats_get(struct rte_eth_dev *dev, struct rte_eth_fdir_stats *fdir_stats)
 {
 	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
+	struct rte_eth_fdir_conf *fdir_conf = IXGBE_DEV_FDIR_CONF(dev);
 	struct ixgbe_hw_fdir_info *info =
 		IXGBE_DEV_PRIVATE_TO_FDIR_INFO(dev->data->dev_private);
 	uint32_t reg, max_num;
-	enum rte_fdir_mode fdir_mode = IXGBE_DEV_FDIR_CONF(dev)->mode;
+	enum rte_fdir_mode fdir_mode = fdir_conf->mode;
 
 	/* Get the information from registers */
 	reg = IXGBE_READ_REG(hw, IXGBE_FDIRFREE);
@@ -1324,11 +1331,12 @@ void
 ixgbe_fdir_filter_restore(struct rte_eth_dev *dev)
 {
 	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
+	struct rte_eth_fdir_conf *fdir_conf = IXGBE_DEV_FDIR_CONF(dev);
 	struct ixgbe_hw_fdir_info *fdir_info =
 		IXGBE_DEV_PRIVATE_TO_FDIR_INFO(dev->data->dev_private);
 	struct ixgbe_fdir_filter *node;
 	bool is_perfect = FALSE;
-	enum rte_fdir_mode fdir_mode = IXGBE_DEV_FDIR_CONF(dev)->mode;
+	enum rte_fdir_mode fdir_mode = fdir_conf->mode;
 
 	if (fdir_mode >= RTE_FDIR_MODE_PERFECT &&
 	    fdir_mode <= RTE_FDIR_MODE_PERFECT_TUNNEL)
-- 
2.47.3

