Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66EC2F44863
	for <dpdk-dev@archiver.kernel.org>; Fri, 10 Apr 2026 13:13:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3457D40654;
	Fri, 10 Apr 2026 15:13:37 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id 873D1402F1
 for <dev@dpdk.org>; Fri, 10 Apr 2026 15:13:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775826816; x=1807362816;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=KzypvDp379MScrx67XPgcYKQkr0ylH7HGpCB69BdCpo=;
 b=e6xDRaQC/kqIjnmyN+Zs0GE6dDZxBkiznprTaCLTvFDrozfebkMcDMSS
 wmuyADPd6DPNyzbh2KITZTlkqUKvI+sOI4gtOgf3mmnuyK7heOSTSE9Pu
 okD3wuYiOCxNuAIPdR5khP3RDjUgSpNbgIOIs0kC+NHYiT+s/0+mXvZ8K
 9pkorHADcotHJGgBIliBRJO2yMQmplvseKHLbkFjyyCT5m8fNpUx0BRk/
 /krczbVOzmcODXpTOXVVvBSSedscmJxpxFyn3UFXkUKd8STjc+OIizs+d
 cI1o7eog3qXJqyxesR0hIxmhg8TsKxFjH0UBMw+VWBRZrDVmLHTa8UEKX w==;
X-CSE-ConnectionGUID: fozeGo6pQF6PW6z7cWaAJA==
X-CSE-MsgGUID: b233I2jzQTqAEZYw4t7tvQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11754"; a="76736316"
X-IronPort-AV: E=Sophos;i="6.23,171,1770624000"; d="scan'208";a="76736316"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Apr 2026 06:13:35 -0700
X-CSE-ConnectionGUID: 2koSw5VRSWKRVus9kpWMxw==
X-CSE-MsgGUID: 5hS+kJqkSZu5uBwcpX0Oag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,171,1770624000"; d="scan'208";a="234084623"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa005.jf.intel.com with ESMTP; 10 Apr 2026 06:13:34 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v3 03/29] net/ixgbe: reduce FDIR conf macro usage
Date: Fri, 10 Apr 2026 14:12:57 +0100
Message-ID: <4a7f22ff44d52467e3e76225d918b5d0faaf15f5.1775826526.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1775826526.git.anatoly.burakov@intel.com>
 <cover.1775826526.git.anatoly.burakov@intel.com>
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
 drivers/net/intel/ixgbe/ixgbe_ethdev.c |  3 +-
 drivers/net/intel/ixgbe/ixgbe_fdir.c   | 39 ++++++++++++++++----------
 2 files changed, 26 insertions(+), 16 deletions(-)

diff --git a/drivers/net/intel/ixgbe/ixgbe_ethdev.c b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
index 4cfaf47a38..076cc632bf 100644
--- a/drivers/net/intel/ixgbe/ixgbe_ethdev.c
+++ b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
@@ -2613,6 +2613,7 @@ ixgbe_dev_start(struct rte_eth_dev *dev)
 {
 	struct ixgbe_hw *hw =
 		IXGBE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
+	struct rte_eth_fdir_conf *fdir_conf = IXGBE_DEV_FDIR_CONF(dev);
 	struct ixgbe_vf_info *vfinfo =
 		*IXGBE_DEV_PRIVATE_TO_P_VFDATA(dev->data->dev_private);
 	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
@@ -2717,7 +2718,7 @@ ixgbe_dev_start(struct rte_eth_dev *dev)
 	/* Configure DCB hw */
 	ixgbe_configure_dcb(dev);
 
-	if (IXGBE_DEV_FDIR_CONF(dev)->mode != RTE_FDIR_MODE_NONE) {
+	if (fdir_conf->mode != RTE_FDIR_MODE_NONE) {
 		err = ixgbe_fdir_configure(dev);
 		if (err)
 			goto error;
diff --git a/drivers/net/intel/ixgbe/ixgbe_fdir.c b/drivers/net/intel/ixgbe/ixgbe_fdir.c
index 0bdfbd411a..e07c2adbda 100644
--- a/drivers/net/intel/ixgbe/ixgbe_fdir.c
+++ b/drivers/net/intel/ixgbe/ixgbe_fdir.c
@@ -253,6 +253,7 @@ static int
 fdir_set_input_mask_82599(struct rte_eth_dev *dev)
 {
 	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
+	struct rte_eth_fdir_conf *fdir_conf = IXGBE_DEV_FDIR_CONF(dev);
 	struct ixgbe_hw_fdir_info *info =
 			IXGBE_DEV_PRIVATE_TO_FDIR_INFO(dev->data->dev_private);
 	/*
@@ -316,7 +317,7 @@ fdir_set_input_mask_82599(struct rte_eth_dev *dev)
 	reg = IXGBE_PCI_REG_ADDR(hw, IXGBE_FDIRDIP4M);
 	*reg = ~(info->mask.dst_ipv4_mask);
 
-	if (IXGBE_DEV_FDIR_CONF(dev)->mode == RTE_FDIR_MODE_SIGNATURE) {
+	if (fdir_conf->mode == RTE_FDIR_MODE_SIGNATURE) {
 		/*
 		 * Store source and destination IPv6 masks (bit reversed)
 		 */
@@ -337,6 +338,7 @@ static int
 fdir_set_input_mask_x550(struct rte_eth_dev *dev)
 {
 	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
+	struct rte_eth_fdir_conf *fdir_conf = IXGBE_DEV_FDIR_CONF(dev);
 	struct ixgbe_hw_fdir_info *info =
 			IXGBE_DEV_PRIVATE_TO_FDIR_INFO(dev->data->dev_private);
 	/* mask VM pool and DIPv6 since there are currently not supported
@@ -345,7 +347,7 @@ fdir_set_input_mask_x550(struct rte_eth_dev *dev)
 	uint32_t fdirm = IXGBE_FDIRM_POOL | IXGBE_FDIRM_DIPv6 |
 			 IXGBE_FDIRM_FLEX;
 	uint32_t fdiripv6m;
-	enum rte_fdir_mode mode = IXGBE_DEV_FDIR_CONF(dev)->mode;
+	enum rte_fdir_mode mode = fdir_conf->mode;
 	uint16_t mac_mask;
 
 	PMD_INIT_FUNC_TRACE();
@@ -468,7 +470,8 @@ static int
 ixgbe_fdir_store_input_mask(struct rte_eth_dev *dev,
 			    const struct rte_eth_fdir_masks *input_mask)
 {
-	enum rte_fdir_mode mode = IXGBE_DEV_FDIR_CONF(dev)->mode;
+	struct rte_eth_fdir_conf *fdir_conf = IXGBE_DEV_FDIR_CONF(dev);
+	enum rte_fdir_mode mode = fdir_conf->mode;
 
 	if (mode >= RTE_FDIR_MODE_SIGNATURE &&
 	    mode <= RTE_FDIR_MODE_PERFECT)
@@ -484,7 +487,8 @@ ixgbe_fdir_store_input_mask(struct rte_eth_dev *dev,
 int
 ixgbe_fdir_set_input_mask(struct rte_eth_dev *dev)
 {
-	enum rte_fdir_mode mode = IXGBE_DEV_FDIR_CONF(dev)->mode;
+	struct rte_eth_fdir_conf *fdir_conf = IXGBE_DEV_FDIR_CONF(dev);
+	enum rte_fdir_mode mode = fdir_conf->mode;
 
 	if (mode >= RTE_FDIR_MODE_SIGNATURE &&
 	    mode <= RTE_FDIR_MODE_PERFECT)
@@ -635,10 +639,11 @@ int
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
 
@@ -659,7 +664,7 @@ ixgbe_fdir_configure(struct rte_eth_dev *dev)
 	    mode != RTE_FDIR_MODE_PERFECT)
 		return -ENOSYS;
 
-	err = configure_fdir_flags(IXGBE_DEV_FDIR_CONF(dev), &fdirctrl);
+	err = configure_fdir_flags(fdir_conf, &fdirctrl);
 	if (err)
 		return err;
 
@@ -681,12 +686,12 @@ ixgbe_fdir_configure(struct rte_eth_dev *dev)
 	for (i = 1; i < 8; i++)
 		IXGBE_WRITE_REG(hw, IXGBE_RXPBSIZE(i), 0);
 
-	err = fdir_set_input_mask(dev, &IXGBE_DEV_FDIR_CONF(dev)->mask);
+	err = fdir_set_input_mask(dev, &fdir_conf->mask);
 	if (err < 0) {
 		PMD_INIT_LOG(ERR, " Error on setting FD mask");
 		return err;
 	}
-	err = ixgbe_set_fdir_flex_conf(dev, &IXGBE_DEV_FDIR_CONF(dev)->flex_conf,
+	err = ixgbe_set_fdir_flex_conf(dev, &fdir_conf->flex_conf,
 				       &fdirctrl);
 	if (err < 0) {
 		PMD_INIT_LOG(ERR, " Error on setting FD flexible arguments.");
@@ -1115,6 +1120,7 @@ ixgbe_fdir_filter_program(struct rte_eth_dev *dev,
 			  bool update)
 {
 	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
+	struct rte_eth_fdir_conf *fdir_conf = IXGBE_DEV_FDIR_CONF(dev);
 	uint32_t fdircmd_flags;
 	uint32_t fdirhash;
 	uint8_t queue;
@@ -1122,7 +1128,7 @@ ixgbe_fdir_filter_program(struct rte_eth_dev *dev,
 	int err;
 	struct ixgbe_hw_fdir_info *info =
 		IXGBE_DEV_PRIVATE_TO_FDIR_INFO(dev->data->dev_private);
-	enum rte_fdir_mode fdir_mode = IXGBE_DEV_FDIR_CONF(dev)->mode;
+	enum rte_fdir_mode fdir_mode = fdir_conf->mode;
 	struct ixgbe_fdir_filter *node;
 	bool add_node = FALSE;
 
@@ -1167,12 +1173,12 @@ ixgbe_fdir_filter_program(struct rte_eth_dev *dev,
 			return -ENOTSUP;
 		}
 		fdirhash = atr_compute_perfect_hash_82599(&rule->ixgbe_fdir,
-							  IXGBE_DEV_FDIR_CONF(dev)->pballoc);
+						  fdir_conf->pballoc);
 		fdirhash |= rule->soft_id <<
 			IXGBE_FDIRHASH_SIG_SW_INDEX_SHIFT;
 	} else
 		fdirhash = atr_compute_sig_hash_82599(&rule->ixgbe_fdir,
-						      IXGBE_DEV_FDIR_CONF(dev)->pballoc);
+					      fdir_conf->pballoc);
 
 	if (del) {
 		err = ixgbe_remove_fdir_filter(info, &rule->ixgbe_fdir);
@@ -1190,7 +1196,7 @@ ixgbe_fdir_filter_program(struct rte_eth_dev *dev,
 	fdircmd_flags = (update) ? IXGBE_FDIRCMD_FILTER_UPDATE : 0;
 	if (rule->fdirflags & IXGBE_FDIRCMD_DROP) {
 		if (is_perfect) {
-			queue = IXGBE_DEV_FDIR_CONF(dev)->drop_queue;
+			queue = fdir_conf->drop_queue;
 			fdircmd_flags |= IXGBE_FDIRCMD_DROP;
 		} else {
 			PMD_DRV_LOG(ERR, "Drop option is not supported in"
@@ -1281,6 +1287,7 @@ void
 ixgbe_fdir_info_get(struct rte_eth_dev *dev, struct rte_eth_fdir_info *fdir_info)
 {
 	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
+	struct rte_eth_fdir_conf *fdir_conf = IXGBE_DEV_FDIR_CONF(dev);
 	struct ixgbe_hw_fdir_info *info =
 			IXGBE_DEV_PRIVATE_TO_FDIR_INFO(dev->data->dev_private);
 	uint32_t fdirctrl, max_num;
@@ -1290,7 +1297,7 @@ ixgbe_fdir_info_get(struct rte_eth_dev *dev, struct rte_eth_fdir_info *fdir_info
 	offset = ((fdirctrl & IXGBE_FDIRCTRL_FLEX_MASK) >>
 			IXGBE_FDIRCTRL_FLEX_SHIFT) * sizeof(uint16_t);
 
-	fdir_info->mode = IXGBE_DEV_FDIR_CONF(dev)->mode;
+	fdir_info->mode = fdir_conf->mode;
 	max_num = (1 << (FDIRENTRIES_NUM_SHIFT +
 			(fdirctrl & FDIRCTRL_PBALLOC_MASK)));
 	if (fdir_info->mode >= RTE_FDIR_MODE_PERFECT &&
@@ -1340,10 +1347,11 @@ void
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
@@ -1396,11 +1404,12 @@ void
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

