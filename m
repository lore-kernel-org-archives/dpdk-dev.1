Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2242C88E72
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Sep 2026 15:30:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3149340E2F;
	Mon, 14 Sep 2026 17:30:30 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id 66A7640E1F;
 Mon, 14 Sep 2026 17:30:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789399829; x=1820935829;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=bQS4DVbZYSZISLCqndKhbvScB3NYSgFdkRte+roajFs=;
 b=Gij3xfQlTat144DpiG6rrVQN7giQTFq/Tl88GQam+wnIOvQ/GarLoOau
 wsgz+9nG6V/l/+9hLr3prZr0xy+y+R8PrAkpRGbUgJlAwEvLdXQ9fYoNp
 ytlXzGBO7P5M+8HkgD2qiFAT6ezY1uoy9Pql7bm4qc5KktARJMe28/wdA
 9pf9Up63eVKos0xMJ7nngBE61gW4qUaRVWWcEwHSLKysjQPJK+ft352FG
 VH40eqe+cvJQ2q1a3a3pRiWS4lCQRxvEJ45838Z3XzHqbqaIMbXD6CC5V
 6t6niIAHyzBUUrGGD37u1e8NGO5htJpd3+SwJtUx/SCfop7n+LbY/B6bQ A==;
X-CSE-ConnectionGUID: QcQi/tRwROiG2lisNNSdNw==
X-CSE-MsgGUID: nbwlz2TxTdmezNgiZVKAeQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="89882424"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="89882424"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Sep 2026 08:30:27 -0700
X-CSE-ConnectionGUID: 2tdq4vTYQZKC3kzdJ6eWbg==
X-CSE-MsgGUID: tT8taTD3TMGm8P2XL1RjBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="310943575"
Received: from silpixa00401385.ir.intel.com (HELO
 localhost.ger.corp.intel.com) ([10.20.227.210])
 by orviesa001.jf.intel.com with ESMTP; 14 Sep 2026 08:30:26 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
	stable@dpdk.org
Subject: [PATCH] net/ice: fix overflow on storing device args
Date: Mon, 14 Sep 2026 16:30:19 +0100
Message-ID: <20260914153019.4034539-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <bug-2037-3@https.bugs.dpdk.org>
References: <bug-2037-3@https.bugs.dpdk.org>
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

Boolean device args to ice driver are sometimes stored as an int and
sometimes as a uint8_t. The parse bool function stores them as an int,
leading to overflow when storing a uint8_t value.

Fix all these by standardizing on "bool" type, both for the arg values
in the structure and inside the parsing function.

Bugzilla ID: 2037
Fixes: 603beeb970b5 ("net/ice: add safe mode devarg")
Cc: stable@dpdk.org

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
Note: this fix is superceded by the kvargs numeric args patchset [1].
However, that patchset relies on new kvargs features unlikely to be
backported, so this standalone fix is useful for backporting or if the
whole other set doesn't make the 26.11 release.

[1] https://patches.dpdk.org/project/dpdk/list/?series=39247
---
 drivers/net/intel/ice/ice_ethdev.c | 13 +++++++------
 drivers/net/intel/ice/ice_ethdev.h | 10 +++++-----
 2 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/net/intel/ice/ice_ethdev.c b/drivers/net/intel/ice/ice_ethdev.c
index 76b8ff0a72..3938186228 100644
--- a/drivers/net/intel/ice/ice_ethdev.c
+++ b/drivers/net/intel/ice/ice_ethdev.c
@@ -1083,7 +1083,7 @@ ice_init_mac_address(struct rte_eth_dev *dev)
 		return -ENOMEM;
 	}
 	/* store it to dev data */
-	if (ad->devargs.default_mac_disable != 1)
+	if (!ad->devargs.default_mac_disable)
 		rte_ether_addr_copy((struct rte_ether_addr *)hw->port_info[0].mac.perm_addr,
 			&dev->data->mac_addrs[0]);
 	return 0;
@@ -1113,7 +1113,7 @@ ice_add_mac_filter(struct ice_vsi *vsi, struct rte_ether_addr *mac_addr)
 	struct ice_adapter *ad = (struct ice_adapter *)hw->back;
 	int ret = 0;
 
-	if (ad->devargs.default_mac_disable == 1 && rte_is_same_ether_addr(mac_addr,
+	if (ad->devargs.default_mac_disable && rte_is_same_ether_addr(mac_addr,
 			(struct rte_ether_addr *)hw->port_info[0].mac.perm_addr)) {
 		PMD_DRV_LOG(ERR, "This Default MAC filter is disabled.");
 		return 0;
@@ -1763,7 +1763,7 @@ ice_setup_vsi(struct ice_pf *pf, enum ice_vsi_type type)
 		 */
 		vsi_ctx.info.sw_id = hw->port_info->sw_id;
 		/* Source Prune */
-		if (ad->devargs.source_prune != 1) {
+		if (!ad->devargs.source_prune) {
 			/* Disable source prune to support VRRP
 			 * when source-prune devarg is not set
 			 */
@@ -2139,7 +2139,7 @@ ice_base_queue_get(struct ice_pf *pf)
 static int
 parse_bool(const char *key, const char *value, void *args)
 {
-	int *i = args;
+	bool *i = args;
 
 	if (value == NULL || value[0] == '\0') {
 		PMD_DRV_LOG(WARNING, "key:\"%s\", requires a value, which must be 0 or 1", key);
@@ -2758,7 +2758,7 @@ ice_dev_init(struct rte_eth_dev *dev)
 	}
 
 	if (ret) {
-		if (ad->devargs.safe_mode_support == 0) {
+		if (!ad->devargs.safe_mode_support) {
 			PMD_INIT_LOG(ERR, "Failed to load the DDP package,"
 					"Use safe-mode-support=1 to enter Safe Mode");
 			goto err_init_fw;
@@ -4211,7 +4211,8 @@ __vsi_queues_bind_intr(struct ice_vsi *vsi, uint16_t msix_vect,
 {
 	struct ice_hw *hw = ICE_VSI_TO_HW(vsi);
 	uint32_t val, val_tx;
-	int rx_low_latency, i;
+	bool rx_low_latency;
+	int i;
 
 	rx_low_latency = vsi->adapter->devargs.rx_low_latency;
 	for (i = 0; i < nb_queue; i++) {
diff --git a/drivers/net/intel/ice/ice_ethdev.h b/drivers/net/intel/ice/ice_ethdev.h
index 7ee3ea8a70..3ca820ccb6 100644
--- a/drivers/net/intel/ice/ice_ethdev.h
+++ b/drivers/net/intel/ice/ice_ethdev.h
@@ -622,16 +622,16 @@ struct ice_pf {
  * Cache devargs parse result.
  */
 struct ice_devargs {
-	int rx_low_latency;
-	int safe_mode_support;
+	bool rx_low_latency;
+	bool safe_mode_support;
 	uint8_t proto_xtr_dflt;
-	uint8_t default_mac_disable;
+	bool default_mac_disable;
 	uint8_t proto_xtr[ICE_MAX_QUEUE_NUM];
 	uint8_t pin_idx;
 	uint8_t pps_out_ena;
-	uint8_t ddp_load_sched;
+	bool ddp_load_sched;
 	uint8_t tm_exposed_levels;
-	uint8_t source_prune;
+	bool source_prune;
 	uint32_t rl_burst_size;
 	int link_state_on_close;
 	int xtr_field_offs;
-- 
2.53.0

