Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79FAFF53D80
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Mar 2026 17:29:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 279FB40696;
	Mon, 16 Mar 2026 18:28:14 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 140AC40650
 for <dev@dpdk.org>; Mon, 16 Mar 2026 18:28:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773682091; x=1805218091;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=VbRzZvQ4Gj+4dM3C+ebLX2FWos9kEbyTJAdEFLqXBrE=;
 b=d+dWERZeWbZNr022eHaVYdHHdvPTHasnR6icPRhUTIDhBsUolaX6Uq/x
 xC9rzd1Ii3lEjdshqYd8yzNQJFCelyD0OlkojKyf0RZTo4KKFg4Ucmb2Z
 CGAtp8b0nAMZh9odYf2Ulbh44VyLxIQqQrE++pcd9HxpUyeqZF/U+xlyM
 TdkWgTb4p3FT67FCaKaJQ9wVzg3fFNCs5Sr38wLlwPy1FeQF80+9dEEiT
 +7qGTg/BKQPR/fXpPj+xKGSJgCNbxxE034xJJoDcVQjvY6mxJUhMjS6dn
 TDoyWqfoGPYPW7i9aizZHYny+y9AAcISZb0JTFsEk9+nccbIDRtfqu7XO A==;
X-CSE-ConnectionGUID: vqxXxxLTQzeIkWG7zAFDmQ==
X-CSE-MsgGUID: XuiTVsW+SKy+4650J5mLng==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="86059637"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="86059637"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2026 10:28:10 -0700
X-CSE-ConnectionGUID: NWZZ9BNhT9SlYpbJFAIcxg==
X-CSE-MsgGUID: iVlkJBeOTxSCKZQhb2+k2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="221228241"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa010.jf.intel.com with ESMTP; 16 Mar 2026 10:28:09 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [RFC PATCH v1 10/21] net/ixgbe: reimplement FDIR parser
Date: Mon, 16 Mar 2026 17:27:38 +0000
Message-ID: <17b9dbf689c75cb11b5c17456fe8b618c48f6890.1773681365.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1773681363.git.anatoly.burakov@intel.com>
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

Use the new flow graph API and the common parsing framework to implement
flow parser for flow director.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/ixgbe/ixgbe_ethdev.h    |    1 +
 drivers/net/intel/ixgbe/ixgbe_fdir.c      |   13 +-
 drivers/net/intel/ixgbe/ixgbe_flow.c      | 1542 +--------------------
 drivers/net/intel/ixgbe/ixgbe_flow.h      |    4 +
 drivers/net/intel/ixgbe/ixgbe_flow_fdir.c | 1510 ++++++++++++++++++++
 drivers/net/intel/ixgbe/meson.build       |    1 +
 6 files changed, 1526 insertions(+), 1545 deletions(-)
 create mode 100644 drivers/net/intel/ixgbe/ixgbe_flow_fdir.c

diff --git a/drivers/net/intel/ixgbe/ixgbe_ethdev.h b/drivers/net/intel/ixgbe/ixgbe_ethdev.h
index ccfe23c233..17b9fa918f 100644
--- a/drivers/net/intel/ixgbe/ixgbe_ethdev.h
+++ b/drivers/net/intel/ixgbe/ixgbe_ethdev.h
@@ -50,6 +50,7 @@
 #define IXGBE_VMDQ_DCB_NB_QUEUES     IXGBE_MAX_RX_QUEUE_NUM
 #define IXGBE_DCB_NB_QUEUES          IXGBE_MAX_RX_QUEUE_NUM
 #define IXGBE_NONE_MODE_TX_NB_QUEUES 64
+#define IXGBE_MAX_FLX_SOURCE_OFF 62
 
 #ifndef NBBY
 #define NBBY	8	/* number of bits in a byte */
diff --git a/drivers/net/intel/ixgbe/ixgbe_fdir.c b/drivers/net/intel/ixgbe/ixgbe_fdir.c
index 0bdfbd411a..2556b4fb3e 100644
--- a/drivers/net/intel/ixgbe/ixgbe_fdir.c
+++ b/drivers/net/intel/ixgbe/ixgbe_fdir.c
@@ -36,7 +36,6 @@
 #define SIG_BUCKET_256KB_HASH_MASK      0x7FFF  /* 15 bits */
 #define IXGBE_DEFAULT_FLEXBYTES_OFFSET  12 /* default flexbytes offset in bytes */
 #define IXGBE_FDIR_MAX_FLEX_LEN         2 /* len in bytes of flexbytes */
-#define IXGBE_MAX_FLX_SOURCE_OFF        62
 #define IXGBE_FDIRCTRL_FLEX_MASK        (0x1F << IXGBE_FDIRCTRL_FLEX_SHIFT)
 #define IXGBE_FDIRCMD_CMD_INTERVAL_US   10
 
@@ -635,10 +634,11 @@ int
 ixgbe_fdir_configure(struct rte_eth_dev *dev)
 {
 	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
+	struct rte_eth_fdir_conf *global_fdir_conf = IXGBE_DEV_FDIR_CONF(dev);
 	int err;
 	uint32_t fdirctrl, pbsize;
 	int i;
-	enum rte_fdir_mode mode = IXGBE_DEV_FDIR_CONF(dev)->mode;
+	enum rte_fdir_mode mode = global_fdir_conf->mode;
 
 	PMD_INIT_FUNC_TRACE();
 
@@ -659,7 +659,10 @@ ixgbe_fdir_configure(struct rte_eth_dev *dev)
 	    mode != RTE_FDIR_MODE_PERFECT)
 		return -ENOSYS;
 
-	err = configure_fdir_flags(IXGBE_DEV_FDIR_CONF(dev), &fdirctrl);
+	/* drop queue is always fixed */
+	global_fdir_conf->drop_queue = IXGBE_FDIR_DROP_QUEUE;
+
+	err = configure_fdir_flags(global_fdir_conf, &fdirctrl);
 	if (err)
 		return err;
 
@@ -681,12 +684,12 @@ ixgbe_fdir_configure(struct rte_eth_dev *dev)
 	for (i = 1; i < 8; i++)
 		IXGBE_WRITE_REG(hw, IXGBE_RXPBSIZE(i), 0);
 
-	err = fdir_set_input_mask(dev, &IXGBE_DEV_FDIR_CONF(dev)->mask);
+	err = fdir_set_input_mask(dev, &global_fdir_conf->mask);
 	if (err < 0) {
 		PMD_INIT_LOG(ERR, " Error on setting FD mask");
 		return err;
 	}
-	err = ixgbe_set_fdir_flex_conf(dev, &IXGBE_DEV_FDIR_CONF(dev)->flex_conf,
+	err = ixgbe_set_fdir_flex_conf(dev, &global_fdir_conf->flex_conf,
 				       &fdirctrl);
 	if (err < 0) {
 		PMD_INIT_LOG(ERR, " Error on setting FD flexible arguments.");
diff --git a/drivers/net/intel/ixgbe/ixgbe_flow.c b/drivers/net/intel/ixgbe/ixgbe_flow.c
index 74ddc699fa..ea32025079 100644
--- a/drivers/net/intel/ixgbe/ixgbe_flow.c
+++ b/drivers/net/intel/ixgbe/ixgbe_flow.c
@@ -48,13 +48,6 @@
 #include "../common/flow_engine.h"
 #include "ixgbe_flow.h"
 
-#define IXGBE_MAX_FLX_SOURCE_OFF 62
-
-/* fdir filter list structure */
-struct ixgbe_fdir_rule_ele {
-	TAILQ_ENTRY(ixgbe_fdir_rule_ele) entries;
-	struct ixgbe_fdir_rule filter_info;
-};
 /* rss filter list structure */
 struct ixgbe_rss_conf_ele {
 	TAILQ_ENTRY(ixgbe_rss_conf_ele) entries;
@@ -66,11 +59,9 @@ struct ixgbe_flow_mem {
 	struct rte_flow *flow;
 };
 
-TAILQ_HEAD(ixgbe_fdir_rule_filter_list, ixgbe_fdir_rule_ele);
 TAILQ_HEAD(ixgbe_rss_filter_list, ixgbe_rss_conf_ele);
 TAILQ_HEAD(ixgbe_flow_mem_list, ixgbe_flow_mem);
 
-static struct ixgbe_fdir_rule_filter_list filter_fdir_list;
 static struct ixgbe_rss_filter_list filter_rss_list;
 static struct ixgbe_flow_mem_list ixgbe_flow_list;
 
@@ -81,28 +72,10 @@ const struct ci_flow_engine_list ixgbe_flow_engine_list = {
 		&ixgbe_l2_tunnel_flow_engine,
 		&ixgbe_ntuple_flow_engine,
 		&ixgbe_security_flow_engine,
+		&ixgbe_fdir_flow_engine,
+		&ixgbe_fdir_tunnel_flow_engine,
 	},
 };
-
-/**
- * Endless loop will never happen with below assumption
- * 1. there is at least one no-void item(END)
- * 2. cur is before END.
- */
-static inline
-const struct rte_flow_item *next_no_void_pattern(
-		const struct rte_flow_item pattern[],
-		const struct rte_flow_item *cur)
-{
-	const struct rte_flow_item *next =
-		cur ? cur + 1 : &pattern[0];
-	while (1) {
-		if (next->type != RTE_FLOW_ITEM_TYPE_VOID)
-			return next;
-		next++;
-	}
-}
-
 /*
  * All ixgbe engines mostly check the same stuff, so use a common check.
  */
@@ -158,1403 +131,6 @@ ixgbe_flow_actions_check(const struct ci_flow_actions *actions,
  * normally the packets should use network order.
  */
 
-/* search next no void pattern and skip fuzzy */
-static inline
-const struct rte_flow_item *next_no_fuzzy_pattern(
-		const struct rte_flow_item pattern[],
-		const struct rte_flow_item *cur)
-{
-	const struct rte_flow_item *next =
-		next_no_void_pattern(pattern, cur);
-	while (1) {
-		if (next->type != RTE_FLOW_ITEM_TYPE_FUZZY)
-			return next;
-		next = next_no_void_pattern(pattern, next);
-	}
-}
-
-static inline uint8_t signature_match(const struct rte_flow_item pattern[])
-{
-	const struct rte_flow_item_fuzzy *spec, *last, *mask;
-	const struct rte_flow_item *item;
-	uint32_t sh, lh, mh;
-	int i = 0;
-
-	while (1) {
-		item = pattern + i;
-		if (item->type == RTE_FLOW_ITEM_TYPE_END)
-			break;
-
-		if (item->type == RTE_FLOW_ITEM_TYPE_FUZZY) {
-			spec = item->spec;
-			last = item->last;
-			mask = item->mask;
-
-			if (!spec || !mask)
-				return 0;
-
-			sh = spec->thresh;
-
-			if (!last)
-				lh = sh;
-			else
-				lh = last->thresh;
-
-			mh = mask->thresh;
-			sh = sh & mh;
-			lh = lh & mh;
-
-			if (!sh || sh > lh)
-				return 0;
-
-			return 1;
-		}
-
-		i++;
-	}
-
-	return 0;
-}
-
-/**
- * Parse the rule to see if it is a IP or MAC VLAN flow director rule.
- * And get the flow director filter info BTW.
- * UDP/TCP/SCTP PATTERN:
- * The first not void item can be ETH or IPV4 or IPV6
- * The second not void item must be IPV4 or IPV6 if the first one is ETH.
- * The next not void item could be UDP or TCP or SCTP (optional)
- * The next not void item could be RAW (for flexbyte, optional)
- * The next not void item must be END.
- * A Fuzzy Match pattern can appear at any place before END.
- * Fuzzy Match is optional for IPV4 but is required for IPV6
- * MAC VLAN PATTERN:
- * The first not void item must be ETH.
- * The second not void item must be MAC VLAN.
- * The next not void item must be END.
- * ACTION:
- * The first not void action should be QUEUE or DROP.
- * The second not void optional action should be MARK,
- * mark_id is a uint32_t number.
- * The next not void action should be END.
- * UDP/TCP/SCTP pattern example:
- * ITEM		Spec			Mask
- * ETH		NULL			NULL
- * IPV4		src_addr 192.168.1.20	0xFFFFFFFF
- *		dst_addr 192.167.3.50	0xFFFFFFFF
- * UDP/TCP/SCTP	src_port	80	0xFFFF
- *		dst_port	80	0xFFFF
- * FLEX	relative	0	0x1
- *		search		0	0x1
- *		reserved	0	0
- *		offset		12	0xFFFFFFFF
- *		limit		0	0xFFFF
- *		length		2	0xFFFF
- *		pattern[0]	0x86	0xFF
- *		pattern[1]	0xDD	0xFF
- * END
- * MAC VLAN pattern example:
- * ITEM		Spec			Mask
- * ETH		dst_addr
-		{0xAC, 0x7B, 0xA1,	{0xFF, 0xFF, 0xFF,
-		0x2C, 0x6D, 0x36}	0xFF, 0xFF, 0xFF}
- * MAC VLAN	tci	0x2016		0xEFFF
- * END
- * Other members in mask and spec should set to 0x00.
- * Item->last should be NULL.
- */
-static int
-ixgbe_parse_fdir_filter_normal(struct rte_eth_dev *dev,
-			       const struct rte_flow_item pattern[],
-			       const struct ci_flow_actions *parsed_actions,
-			       struct ixgbe_fdir_rule *rule,
-			       struct rte_flow_error *error)
-{
-	const struct rte_flow_item *item;
-	const struct rte_flow_item_eth *eth_spec;
-	const struct rte_flow_item_eth *eth_mask;
-	const struct rte_flow_item_ipv4 *ipv4_spec;
-	const struct rte_flow_item_ipv4 *ipv4_mask;
-	const struct rte_flow_item_ipv6 *ipv6_spec;
-	const struct rte_flow_item_ipv6 *ipv6_mask;
-	const struct rte_flow_item_tcp *tcp_spec;
-	const struct rte_flow_item_tcp *tcp_mask;
-	const struct rte_flow_item_udp *udp_spec;
-	const struct rte_flow_item_udp *udp_mask;
-	const struct rte_flow_item_sctp *sctp_spec;
-	const struct rte_flow_item_sctp *sctp_mask;
-	const struct rte_flow_item_vlan *vlan_spec;
-	const struct rte_flow_item_vlan *vlan_mask;
-	const struct rte_flow_item_raw *raw_mask;
-	const struct rte_flow_item_raw *raw_spec;
-	const struct rte_flow_action *fwd_action, *aux_action;
-	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
-	uint8_t j;
-
-	fwd_action = parsed_actions->actions[0];
-	/* can be NULL */
-	aux_action = parsed_actions->actions[1];
-
-	/* check if this is a signature match */
-	if (signature_match(pattern))
-		rule->mode = RTE_FDIR_MODE_SIGNATURE;
-	else
-		rule->mode = RTE_FDIR_MODE_PERFECT;
-
-	/* set up action */
-	if (fwd_action->type == RTE_FLOW_ACTION_TYPE_QUEUE) {
-		const struct rte_flow_action_queue *q_act = fwd_action->conf;
-		rule->queue = q_act->index;
-	} else {
-		/* signature mode does not support drop action. */
-		if (rule->mode == RTE_FDIR_MODE_SIGNATURE) {
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ACTION, fwd_action,
-				"Signature mode does not support drop action.");
-			return -rte_errno;
-		}
-		rule->fdirflags = IXGBE_FDIRCMD_DROP;
-	}
-
-	/* set up mark action */
-	if (aux_action != NULL && aux_action->type == RTE_FLOW_ACTION_TYPE_MARK) {
-		const struct rte_flow_action_mark *m_act = aux_action->conf;
-		rule->soft_id = m_act->id;
-	}
-
-	/**
-	 * Some fields may not be provided. Set spec to 0 and mask to default
-	 * value. So, we need not do anything for the not provided fields later.
-	 */
-	memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-	memset(&rule->mask, 0xFF, sizeof(struct ixgbe_hw_fdir_mask));
-	rule->mask.vlan_tci_mask = 0;
-	rule->mask.flex_bytes_mask = 0;
-	rule->mask.dst_port_mask = 0;
-	rule->mask.src_port_mask = 0;
-
-	/**
-	 * The first not void item should be
-	 * MAC or IPv4 or TCP or UDP or SCTP.
-	 */
-	item = next_no_fuzzy_pattern(pattern, NULL);
-	if (item->type != RTE_FLOW_ITEM_TYPE_ETH &&
-	    item->type != RTE_FLOW_ITEM_TYPE_IPV4 &&
-	    item->type != RTE_FLOW_ITEM_TYPE_IPV6 &&
-	    item->type != RTE_FLOW_ITEM_TYPE_TCP &&
-	    item->type != RTE_FLOW_ITEM_TYPE_UDP &&
-	    item->type != RTE_FLOW_ITEM_TYPE_SCTP) {
-		memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-		rte_flow_error_set(error, EINVAL,
-			RTE_FLOW_ERROR_TYPE_ITEM,
-			item, "Not supported by fdir filter");
-		return -rte_errno;
-	}
-
-	/*Not supported last point for range*/
-	if (item->last) {
-		rte_flow_error_set(error, EINVAL,
-			RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
-			item, "Not supported last point for range");
-		return -rte_errno;
-	}
-
-	/* Get the MAC info. */
-	if (item->type == RTE_FLOW_ITEM_TYPE_ETH) {
-		/**
-		 * Only support vlan and dst MAC address,
-		 * others should be masked.
-		 */
-		if (item->spec && !item->mask) {
-			memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ITEM,
-				item, "Not supported by fdir filter");
-			return -rte_errno;
-		}
-
-		if (item->spec) {
-			rule->b_spec = TRUE;
-			eth_spec = item->spec;
-
-			/* Get the dst MAC. */
-			for (j = 0; j < RTE_ETHER_ADDR_LEN; j++) {
-				rule->ixgbe_fdir.formatted.inner_mac[j] =
-					eth_spec->hdr.dst_addr.addr_bytes[j];
-			}
-		}
-
-
-		if (item->mask) {
-
-			rule->b_mask = TRUE;
-			eth_mask = item->mask;
-
-			/* Ether type should be masked. */
-			if (eth_mask->hdr.ether_type ||
-			    rule->mode == RTE_FDIR_MODE_SIGNATURE) {
-				memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-				rte_flow_error_set(error, EINVAL,
-					RTE_FLOW_ERROR_TYPE_ITEM,
-					item, "Not supported by fdir filter");
-				return -rte_errno;
-			}
-
-			/* If ethernet has meaning, it means MAC VLAN mode. */
-			rule->mode = RTE_FDIR_MODE_PERFECT_MAC_VLAN;
-
-			/**
-			 * src MAC address must be masked,
-			 * and don't support dst MAC address mask.
-			 */
-			for (j = 0; j < RTE_ETHER_ADDR_LEN; j++) {
-				if (eth_mask->hdr.src_addr.addr_bytes[j] ||
-					eth_mask->hdr.dst_addr.addr_bytes[j] != 0xFF) {
-					memset(rule, 0,
-					sizeof(struct ixgbe_fdir_rule));
-					rte_flow_error_set(error, EINVAL,
-					RTE_FLOW_ERROR_TYPE_ITEM,
-					item, "Not supported by fdir filter");
-					return -rte_errno;
-				}
-			}
-
-			/* When no VLAN, considered as full mask. */
-			rule->mask.vlan_tci_mask = rte_cpu_to_be_16(0xEFFF);
-		}
-		/*** If both spec and mask are item,
-		 * it means don't care about ETH.
-		 * Do nothing.
-		 */
-
-		/**
-		 * Check if the next not void item is vlan or ipv4.
-		 * IPv6 is not supported.
-		 */
-		item = next_no_fuzzy_pattern(pattern, item);
-		if (rule->mode == RTE_FDIR_MODE_PERFECT_MAC_VLAN) {
-			if (item->type != RTE_FLOW_ITEM_TYPE_VLAN) {
-				memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-				rte_flow_error_set(error, EINVAL,
-					RTE_FLOW_ERROR_TYPE_ITEM,
-					item, "Not supported by fdir filter");
-				return -rte_errno;
-			}
-		} else {
-			if (item->type != RTE_FLOW_ITEM_TYPE_IPV4 &&
-					item->type != RTE_FLOW_ITEM_TYPE_VLAN) {
-				memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-				rte_flow_error_set(error, EINVAL,
-					RTE_FLOW_ERROR_TYPE_ITEM,
-					item, "Not supported by fdir filter");
-				return -rte_errno;
-			}
-		}
-	}
-
-	if (item->type == RTE_FLOW_ITEM_TYPE_VLAN) {
-		if (!(item->spec && item->mask)) {
-			memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ITEM,
-				item, "Not supported by fdir filter");
-			return -rte_errno;
-		}
-
-		/*Not supported last point for range*/
-		if (item->last) {
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
-				item, "Not supported last point for range");
-			return -rte_errno;
-		}
-
-		vlan_spec = item->spec;
-		vlan_mask = item->mask;
-
-		rule->ixgbe_fdir.formatted.vlan_id = vlan_spec->hdr.vlan_tci;
-
-		rule->mask.vlan_tci_mask = vlan_mask->hdr.vlan_tci;
-		rule->mask.vlan_tci_mask &= rte_cpu_to_be_16(0xEFFF);
-		/* More than one tags are not supported. */
-
-		/* Next not void item must be END */
-		item = next_no_fuzzy_pattern(pattern, item);
-		if (item->type != RTE_FLOW_ITEM_TYPE_END) {
-			memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ITEM,
-				item, "Not supported by fdir filter");
-			return -rte_errno;
-		}
-	}
-
-	/* Get the IPV4 info. */
-	if (item->type == RTE_FLOW_ITEM_TYPE_IPV4) {
-		/**
-		 * Set the flow type even if there's no content
-		 * as we must have a flow type.
-		 */
-		rule->ixgbe_fdir.formatted.flow_type =
-			IXGBE_ATR_FLOW_TYPE_IPV4;
-		/*Not supported last point for range*/
-		if (item->last) {
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
-				item, "Not supported last point for range");
-			return -rte_errno;
-		}
-		/**
-		 * Only care about src & dst addresses,
-		 * others should be masked.
-		 */
-		if (!item->mask) {
-			memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ITEM,
-				item, "Not supported by fdir filter");
-			return -rte_errno;
-		}
-		rule->b_mask = TRUE;
-		ipv4_mask = item->mask;
-		if (ipv4_mask->hdr.version_ihl ||
-		    ipv4_mask->hdr.type_of_service ||
-		    ipv4_mask->hdr.total_length ||
-		    ipv4_mask->hdr.packet_id ||
-		    ipv4_mask->hdr.fragment_offset ||
-		    ipv4_mask->hdr.time_to_live ||
-		    ipv4_mask->hdr.next_proto_id ||
-		    ipv4_mask->hdr.hdr_checksum) {
-			memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ITEM,
-				item, "Not supported by fdir filter");
-			return -rte_errno;
-		}
-		rule->mask.dst_ipv4_mask = ipv4_mask->hdr.dst_addr;
-		rule->mask.src_ipv4_mask = ipv4_mask->hdr.src_addr;
-
-		if (item->spec) {
-			rule->b_spec = TRUE;
-			ipv4_spec = item->spec;
-			rule->ixgbe_fdir.formatted.dst_ip[0] =
-				ipv4_spec->hdr.dst_addr;
-			rule->ixgbe_fdir.formatted.src_ip[0] =
-				ipv4_spec->hdr.src_addr;
-		}
-
-		/**
-		 * Check if the next not void item is
-		 * TCP or UDP or SCTP or END.
-		 */
-		item = next_no_fuzzy_pattern(pattern, item);
-		if (item->type != RTE_FLOW_ITEM_TYPE_TCP &&
-		    item->type != RTE_FLOW_ITEM_TYPE_UDP &&
-		    item->type != RTE_FLOW_ITEM_TYPE_SCTP &&
-		    item->type != RTE_FLOW_ITEM_TYPE_END &&
-		    item->type != RTE_FLOW_ITEM_TYPE_RAW) {
-			memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ITEM,
-				item, "Not supported by fdir filter");
-			return -rte_errno;
-		}
-	}
-
-	/* Get the IPV6 info. */
-	if (item->type == RTE_FLOW_ITEM_TYPE_IPV6) {
-		/**
-		 * Set the flow type even if there's no content
-		 * as we must have a flow type.
-		 */
-		rule->ixgbe_fdir.formatted.flow_type =
-			IXGBE_ATR_FLOW_TYPE_IPV6;
-
-		/**
-		 * 1. must signature match
-		 * 2. not support last
-		 * 3. mask must not null
-		 */
-		if (rule->mode != RTE_FDIR_MODE_SIGNATURE ||
-		    item->last ||
-		    !item->mask) {
-			memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
-				item, "Not supported last point for range");
-			return -rte_errno;
-		}
-
-		rule->b_mask = TRUE;
-		ipv6_mask = item->mask;
-		if (ipv6_mask->hdr.vtc_flow ||
-		    ipv6_mask->hdr.payload_len ||
-		    ipv6_mask->hdr.proto ||
-		    ipv6_mask->hdr.hop_limits) {
-			memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ITEM,
-				item, "Not supported by fdir filter");
-			return -rte_errno;
-		}
-
-		/* check src addr mask */
-		for (j = 0; j < 16; j++) {
-			if (ipv6_mask->hdr.src_addr.a[j] == 0) {
-				rule->mask.src_ipv6_mask &= ~(1 << j);
-			} else if (ipv6_mask->hdr.src_addr.a[j] != UINT8_MAX) {
-				memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-				rte_flow_error_set(error, EINVAL,
-					RTE_FLOW_ERROR_TYPE_ITEM,
-					item, "Not supported by fdir filter");
-				return -rte_errno;
-			}
-		}
-
-		/* check dst addr mask */
-		for (j = 0; j < 16; j++) {
-			if (ipv6_mask->hdr.dst_addr.a[j] == 0) {
-				rule->mask.dst_ipv6_mask &= ~(1 << j);
-			} else if (ipv6_mask->hdr.dst_addr.a[j] != UINT8_MAX) {
-				memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-				rte_flow_error_set(error, EINVAL,
-					RTE_FLOW_ERROR_TYPE_ITEM,
-					item, "Not supported by fdir filter");
-				return -rte_errno;
-			}
-		}
-
-		if (item->spec) {
-			rule->b_spec = TRUE;
-			ipv6_spec = item->spec;
-			rte_memcpy(rule->ixgbe_fdir.formatted.src_ip,
-				   &ipv6_spec->hdr.src_addr, 16);
-			rte_memcpy(rule->ixgbe_fdir.formatted.dst_ip,
-				   &ipv6_spec->hdr.dst_addr, 16);
-		}
-
-		/**
-		 * Check if the next not void item is
-		 * TCP or UDP or SCTP or END.
-		 */
-		item = next_no_fuzzy_pattern(pattern, item);
-		if (item->type != RTE_FLOW_ITEM_TYPE_TCP &&
-		    item->type != RTE_FLOW_ITEM_TYPE_UDP &&
-		    item->type != RTE_FLOW_ITEM_TYPE_SCTP &&
-		    item->type != RTE_FLOW_ITEM_TYPE_END &&
-		    item->type != RTE_FLOW_ITEM_TYPE_RAW) {
-			memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ITEM,
-				item, "Not supported by fdir filter");
-			return -rte_errno;
-		}
-	}
-
-	/* Get the TCP info. */
-	if (item->type == RTE_FLOW_ITEM_TYPE_TCP) {
-		/**
-		 * Set the flow type even if there's no content
-		 * as we must have a flow type.
-		 */
-		rule->ixgbe_fdir.formatted.flow_type |=
-			IXGBE_ATR_L4TYPE_TCP;
-		/*Not supported last point for range*/
-		if (item->last) {
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
-				item, "Not supported last point for range");
-			return -rte_errno;
-		}
-		/**
-		 * Only care about src & dst ports,
-		 * others should be masked.
-		 */
-		if (!item->mask) {
-			memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ITEM,
-				item, "Not supported by fdir filter");
-			return -rte_errno;
-		}
-		rule->b_mask = TRUE;
-		tcp_mask = item->mask;
-		if (tcp_mask->hdr.sent_seq ||
-		    tcp_mask->hdr.recv_ack ||
-		    tcp_mask->hdr.data_off ||
-		    tcp_mask->hdr.tcp_flags ||
-		    tcp_mask->hdr.rx_win ||
-		    tcp_mask->hdr.cksum ||
-		    tcp_mask->hdr.tcp_urp) {
-			memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ITEM,
-				item, "Not supported by fdir filter");
-			return -rte_errno;
-		}
-		rule->mask.src_port_mask = tcp_mask->hdr.src_port;
-		rule->mask.dst_port_mask = tcp_mask->hdr.dst_port;
-
-		if (item->spec) {
-			rule->b_spec = TRUE;
-			tcp_spec = item->spec;
-			rule->ixgbe_fdir.formatted.src_port =
-				tcp_spec->hdr.src_port;
-			rule->ixgbe_fdir.formatted.dst_port =
-				tcp_spec->hdr.dst_port;
-		}
-
-		item = next_no_fuzzy_pattern(pattern, item);
-		if (item->type != RTE_FLOW_ITEM_TYPE_RAW &&
-		    item->type != RTE_FLOW_ITEM_TYPE_END) {
-			memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ITEM,
-				item, "Not supported by fdir filter");
-			return -rte_errno;
-		}
-
-	}
-
-	/* Get the UDP info */
-	if (item->type == RTE_FLOW_ITEM_TYPE_UDP) {
-		/**
-		 * Set the flow type even if there's no content
-		 * as we must have a flow type.
-		 */
-		rule->ixgbe_fdir.formatted.flow_type |=
-			IXGBE_ATR_L4TYPE_UDP;
-		/*Not supported last point for range*/
-		if (item->last) {
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
-				item, "Not supported last point for range");
-			return -rte_errno;
-		}
-		/**
-		 * Only care about src & dst ports,
-		 * others should be masked.
-		 */
-		if (!item->mask) {
-			memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ITEM,
-				item, "Not supported by fdir filter");
-			return -rte_errno;
-		}
-		rule->b_mask = TRUE;
-		udp_mask = item->mask;
-		if (udp_mask->hdr.dgram_len ||
-		    udp_mask->hdr.dgram_cksum) {
-			memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ITEM,
-				item, "Not supported by fdir filter");
-			return -rte_errno;
-		}
-		rule->mask.src_port_mask = udp_mask->hdr.src_port;
-		rule->mask.dst_port_mask = udp_mask->hdr.dst_port;
-
-		if (item->spec) {
-			rule->b_spec = TRUE;
-			udp_spec = item->spec;
-			rule->ixgbe_fdir.formatted.src_port =
-				udp_spec->hdr.src_port;
-			rule->ixgbe_fdir.formatted.dst_port =
-				udp_spec->hdr.dst_port;
-		}
-
-		item = next_no_fuzzy_pattern(pattern, item);
-		if (item->type != RTE_FLOW_ITEM_TYPE_RAW &&
-		    item->type != RTE_FLOW_ITEM_TYPE_END) {
-			memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ITEM,
-				item, "Not supported by fdir filter");
-			return -rte_errno;
-		}
-
-	}
-
-	/* Get the SCTP info */
-	if (item->type == RTE_FLOW_ITEM_TYPE_SCTP) {
-		/**
-		 * Set the flow type even if there's no content
-		 * as we must have a flow type.
-		 */
-		rule->ixgbe_fdir.formatted.flow_type |=
-			IXGBE_ATR_L4TYPE_SCTP;
-		/*Not supported last point for range*/
-		if (item->last) {
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
-				item, "Not supported last point for range");
-			return -rte_errno;
-		}
-
-		/* only some mac types support sctp port */
-		if (hw->mac.type == ixgbe_mac_X550 ||
-		    hw->mac.type == ixgbe_mac_X550EM_x ||
-		    hw->mac.type == ixgbe_mac_X550EM_a ||
-		    hw->mac.type == ixgbe_mac_E610) {
-			/**
-			 * Only care about src & dst ports,
-			 * others should be masked.
-			 */
-			if (!item->mask) {
-				memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-				rte_flow_error_set(error, EINVAL,
-					RTE_FLOW_ERROR_TYPE_ITEM,
-					item, "Not supported by fdir filter");
-				return -rte_errno;
-			}
-			rule->b_mask = TRUE;
-			sctp_mask = item->mask;
-			if (sctp_mask->hdr.tag ||
-				sctp_mask->hdr.cksum) {
-				memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-				rte_flow_error_set(error, EINVAL,
-					RTE_FLOW_ERROR_TYPE_ITEM,
-					item, "Not supported by fdir filter");
-				return -rte_errno;
-			}
-			rule->mask.src_port_mask = sctp_mask->hdr.src_port;
-			rule->mask.dst_port_mask = sctp_mask->hdr.dst_port;
-
-			if (item->spec) {
-				rule->b_spec = TRUE;
-				sctp_spec = item->spec;
-				rule->ixgbe_fdir.formatted.src_port =
-					sctp_spec->hdr.src_port;
-				rule->ixgbe_fdir.formatted.dst_port =
-					sctp_spec->hdr.dst_port;
-			}
-		/* others even sctp port is not supported */
-		} else {
-			sctp_mask = item->mask;
-			if (sctp_mask &&
-				(sctp_mask->hdr.src_port ||
-				 sctp_mask->hdr.dst_port ||
-				 sctp_mask->hdr.tag ||
-				 sctp_mask->hdr.cksum)) {
-				memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-				rte_flow_error_set(error, EINVAL,
-					RTE_FLOW_ERROR_TYPE_ITEM,
-					item, "Not supported by fdir filter");
-				return -rte_errno;
-			}
-		}
-
-		item = next_no_fuzzy_pattern(pattern, item);
-		if (item->type != RTE_FLOW_ITEM_TYPE_RAW &&
-			item->type != RTE_FLOW_ITEM_TYPE_END) {
-			memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ITEM,
-				item, "Not supported by fdir filter");
-			return -rte_errno;
-		}
-	}
-
-	/* Get the flex byte info */
-	if (item->type == RTE_FLOW_ITEM_TYPE_RAW) {
-		/* Not supported last point for range*/
-		if (item->last) {
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
-				item, "Not supported last point for range");
-			return -rte_errno;
-		}
-		/* mask should not be null */
-		if (!item->mask || !item->spec) {
-			memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ITEM,
-				item, "Not supported by fdir filter");
-			return -rte_errno;
-		}
-
-		raw_mask = item->mask;
-
-		/* check mask */
-		if (raw_mask->relative != 0x1 ||
-		    raw_mask->search != 0x1 ||
-		    raw_mask->reserved != 0x0 ||
-		    (uint32_t)raw_mask->offset != 0xffffffff ||
-		    raw_mask->limit != 0xffff ||
-		    raw_mask->length != 0xffff) {
-			memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ITEM,
-				item, "Not supported by fdir filter");
-			return -rte_errno;
-		}
-
-		raw_spec = item->spec;
-
-		/* check spec */
-		if (raw_spec->relative != 0 ||
-		    raw_spec->search != 0 ||
-		    raw_spec->reserved != 0 ||
-		    raw_spec->offset > IXGBE_MAX_FLX_SOURCE_OFF ||
-		    raw_spec->offset % 2 ||
-		    raw_spec->limit != 0 ||
-		    raw_spec->length != 2 ||
-		    /* pattern can't be 0xffff */
-		    (raw_spec->pattern[0] == 0xff &&
-		     raw_spec->pattern[1] == 0xff)) {
-			memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ITEM,
-				item, "Not supported by fdir filter");
-			return -rte_errno;
-		}
-
-		/* check pattern mask */
-		if (raw_mask->pattern[0] != 0xff ||
-		    raw_mask->pattern[1] != 0xff) {
-			memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ITEM,
-				item, "Not supported by fdir filter");
-			return -rte_errno;
-		}
-
-		rule->mask.flex_bytes_mask = 0xffff;
-		rule->ixgbe_fdir.formatted.flex_bytes =
-			(((uint16_t)raw_spec->pattern[1]) << 8) |
-			raw_spec->pattern[0];
-		rule->flex_bytes_offset = raw_spec->offset;
-	}
-
-	if (item->type != RTE_FLOW_ITEM_TYPE_END) {
-		/* check if the next not void item is END */
-		item = next_no_fuzzy_pattern(pattern, item);
-		if (item->type != RTE_FLOW_ITEM_TYPE_END) {
-			memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ITEM,
-				item, "Not supported by fdir filter");
-			return -rte_errno;
-		}
-	}
-
-	return 0;
-}
-
-#define NVGRE_PROTOCOL 0x6558
-
-/**
- * Parse the rule to see if it is a VxLAN or NVGRE flow director rule.
- * And get the flow director filter info BTW.
- * VxLAN PATTERN:
- * The first not void item must be ETH.
- * The second not void item must be IPV4/ IPV6.
- * The third not void item must be NVGRE.
- * The next not void item must be END.
- * NVGRE PATTERN:
- * The first not void item must be ETH.
- * The second not void item must be IPV4/ IPV6.
- * The third not void item must be NVGRE.
- * The next not void item must be END.
- * ACTION:
- * The first not void action should be QUEUE or DROP.
- * The second not void optional action should be MARK,
- * mark_id is a uint32_t number.
- * The next not void action should be END.
- * VxLAN pattern example:
- * ITEM		Spec			Mask
- * ETH		NULL			NULL
- * IPV4/IPV6	NULL			NULL
- * UDP		NULL			NULL
- * VxLAN	vni{0x00, 0x32, 0x54}	{0xFF, 0xFF, 0xFF}
- * MAC VLAN	tci	0x2016		0xEFFF
- * END
- * NEGRV pattern example:
- * ITEM		Spec			Mask
- * ETH		NULL			NULL
- * IPV4/IPV6	NULL			NULL
- * NVGRE	protocol	0x6558	0xFFFF
- *		tni{0x00, 0x32, 0x54}	{0xFF, 0xFF, 0xFF}
- * MAC VLAN	tci	0x2016		0xEFFF
- * END
- * other members in mask and spec should set to 0x00.
- * item->last should be NULL.
- */
-static int
-ixgbe_parse_fdir_filter_tunnel(const struct rte_flow_item pattern[],
-			       const struct ci_flow_actions *parsed_actions,
-			       struct ixgbe_fdir_rule *rule,
-			       struct rte_flow_error *error)
-{
-	const struct rte_flow_item *item;
-	const struct rte_flow_item_vxlan *vxlan_spec;
-	const struct rte_flow_item_vxlan *vxlan_mask;
-	const struct rte_flow_item_nvgre *nvgre_spec;
-	const struct rte_flow_item_nvgre *nvgre_mask;
-	const struct rte_flow_item_eth *eth_spec;
-	const struct rte_flow_item_eth *eth_mask;
-	const struct rte_flow_item_vlan *vlan_spec;
-	const struct rte_flow_item_vlan *vlan_mask;
-	const struct rte_flow_action *fwd_action, *aux_action;
-	uint32_t j;
-
-	fwd_action = parsed_actions->actions[0];
-	/* can be NULL */
-	aux_action = parsed_actions->actions[1];
-
-	/* set up queue/drop action */
-	if (fwd_action->type == RTE_FLOW_ACTION_TYPE_QUEUE) {
-		const struct rte_flow_action_queue *q_act = fwd_action->conf;
-		rule->queue = q_act->index;
-	} else {
-		rule->fdirflags = IXGBE_FDIRCMD_DROP;
-	}
-
-	/* set up mark action */
-	if (aux_action != NULL && aux_action->type == RTE_FLOW_ACTION_TYPE_MARK) {
-		const struct rte_flow_action_mark *mark = aux_action->conf;
-		rule->soft_id = mark->id;
-	}
-
-	/**
-	 * Some fields may not be provided. Set spec to 0 and mask to default
-	 * value. So, we need not do anything for the not provided fields later.
-	 */
-	memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-	memset(&rule->mask, 0xFF, sizeof(struct ixgbe_hw_fdir_mask));
-	rule->mask.vlan_tci_mask = 0;
-
-	/**
-	 * The first not void item should be
-	 * MAC or IPv4 or IPv6 or UDP or VxLAN.
-	 */
-	item = next_no_void_pattern(pattern, NULL);
-	if (item->type != RTE_FLOW_ITEM_TYPE_ETH &&
-	    item->type != RTE_FLOW_ITEM_TYPE_IPV4 &&
-	    item->type != RTE_FLOW_ITEM_TYPE_IPV6 &&
-	    item->type != RTE_FLOW_ITEM_TYPE_UDP &&
-	    item->type != RTE_FLOW_ITEM_TYPE_VXLAN &&
-	    item->type != RTE_FLOW_ITEM_TYPE_NVGRE) {
-		memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-		rte_flow_error_set(error, EINVAL,
-			RTE_FLOW_ERROR_TYPE_ITEM,
-			item, "Not supported by fdir filter");
-		return -rte_errno;
-	}
-
-	rule->mode = RTE_FDIR_MODE_PERFECT_TUNNEL;
-
-	/* Skip MAC. */
-	if (item->type == RTE_FLOW_ITEM_TYPE_ETH) {
-		/* Only used to describe the protocol stack. */
-		if (item->spec || item->mask) {
-			memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ITEM,
-				item, "Not supported by fdir filter");
-			return -rte_errno;
-		}
-		/* Not supported last point for range*/
-		if (item->last) {
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
-				item, "Not supported last point for range");
-			return -rte_errno;
-		}
-
-		/* Check if the next not void item is IPv4 or IPv6. */
-		item = next_no_void_pattern(pattern, item);
-		if (item->type != RTE_FLOW_ITEM_TYPE_IPV4 &&
-		    item->type != RTE_FLOW_ITEM_TYPE_IPV6) {
-			memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ITEM,
-				item, "Not supported by fdir filter");
-			return -rte_errno;
-		}
-	}
-
-	/* Skip IP. */
-	if (item->type == RTE_FLOW_ITEM_TYPE_IPV4 ||
-	    item->type == RTE_FLOW_ITEM_TYPE_IPV6) {
-		/* Only used to describe the protocol stack. */
-		if (item->spec || item->mask) {
-			memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ITEM,
-				item, "Not supported by fdir filter");
-			return -rte_errno;
-		}
-		/*Not supported last point for range*/
-		if (item->last) {
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
-				item, "Not supported last point for range");
-			return -rte_errno;
-		}
-
-		/* Check if the next not void item is UDP or NVGRE. */
-		item = next_no_void_pattern(pattern, item);
-		if (item->type != RTE_FLOW_ITEM_TYPE_UDP &&
-		    item->type != RTE_FLOW_ITEM_TYPE_NVGRE) {
-			memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ITEM,
-				item, "Not supported by fdir filter");
-			return -rte_errno;
-		}
-	}
-
-	/* Skip UDP. */
-	if (item->type == RTE_FLOW_ITEM_TYPE_UDP) {
-		/* Only used to describe the protocol stack. */
-		if (item->spec || item->mask) {
-			memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ITEM,
-				item, "Not supported by fdir filter");
-			return -rte_errno;
-		}
-		/*Not supported last point for range*/
-		if (item->last) {
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
-				item, "Not supported last point for range");
-			return -rte_errno;
-		}
-
-		/* Check if the next not void item is VxLAN. */
-		item = next_no_void_pattern(pattern, item);
-		if (item->type != RTE_FLOW_ITEM_TYPE_VXLAN) {
-			memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ITEM,
-				item, "Not supported by fdir filter");
-			return -rte_errno;
-		}
-	}
-
-	/* Get the VxLAN info */
-	if (item->type == RTE_FLOW_ITEM_TYPE_VXLAN) {
-		rule->ixgbe_fdir.formatted.tunnel_type =
-				IXGBE_FDIR_VXLAN_TUNNEL_TYPE;
-
-		/* Only care about VNI, others should be masked. */
-		if (!item->mask) {
-			memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ITEM,
-				item, "Not supported by fdir filter");
-			return -rte_errno;
-		}
-		/*Not supported last point for range*/
-		if (item->last) {
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
-				item, "Not supported last point for range");
-			return -rte_errno;
-		}
-		rule->b_mask = TRUE;
-
-		/* Tunnel type is always meaningful. */
-		rule->mask.tunnel_type_mask = 1;
-
-		vxlan_mask = item->mask;
-		if (vxlan_mask->hdr.flags) {
-			memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ITEM,
-				item, "Not supported by fdir filter");
-			return -rte_errno;
-		}
-		/* VNI must be totally masked or not. */
-		if ((vxlan_mask->hdr.vni[0] || vxlan_mask->hdr.vni[1] ||
-			vxlan_mask->hdr.vni[2]) &&
-			((vxlan_mask->hdr.vni[0] != 0xFF) ||
-			(vxlan_mask->hdr.vni[1] != 0xFF) ||
-				(vxlan_mask->hdr.vni[2] != 0xFF))) {
-			memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ITEM,
-				item, "Not supported by fdir filter");
-			return -rte_errno;
-		}
-
-		rte_memcpy(&rule->mask.tunnel_id_mask, vxlan_mask->hdr.vni,
-			RTE_DIM(vxlan_mask->hdr.vni));
-
-		if (item->spec) {
-			rule->b_spec = TRUE;
-			vxlan_spec = item->spec;
-			rte_memcpy(((uint8_t *)
-				&rule->ixgbe_fdir.formatted.tni_vni),
-				vxlan_spec->hdr.vni, RTE_DIM(vxlan_spec->hdr.vni));
-		}
-	}
-
-	/* Get the NVGRE info */
-	if (item->type == RTE_FLOW_ITEM_TYPE_NVGRE) {
-		rule->ixgbe_fdir.formatted.tunnel_type =
-				IXGBE_FDIR_NVGRE_TUNNEL_TYPE;
-
-		/**
-		 * Only care about flags0, flags1, protocol and TNI,
-		 * others should be masked.
-		 */
-		if (!item->mask) {
-			memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ITEM,
-				item, "Not supported by fdir filter");
-			return -rte_errno;
-		}
-		/*Not supported last point for range*/
-		if (item->last) {
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
-				item, "Not supported last point for range");
-			return -rte_errno;
-		}
-		rule->b_mask = TRUE;
-
-		/* Tunnel type is always meaningful. */
-		rule->mask.tunnel_type_mask = 1;
-
-		nvgre_mask = item->mask;
-		if (nvgre_mask->flow_id) {
-			memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ITEM,
-				item, "Not supported by fdir filter");
-			return -rte_errno;
-		}
-		if (nvgre_mask->protocol &&
-		    nvgre_mask->protocol != 0xFFFF) {
-			memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ITEM,
-				item, "Not supported by fdir filter");
-			return -rte_errno;
-		}
-		if (nvgre_mask->c_k_s_rsvd0_ver &&
-		    nvgre_mask->c_k_s_rsvd0_ver !=
-			rte_cpu_to_be_16(0xFFFF)) {
-			memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ITEM,
-				item, "Not supported by fdir filter");
-			return -rte_errno;
-		}
-		/* TNI must be totally masked or not. */
-		if (nvgre_mask->tni[0] &&
-		    ((nvgre_mask->tni[0] != 0xFF) ||
-		    (nvgre_mask->tni[1] != 0xFF) ||
-		    (nvgre_mask->tni[2] != 0xFF))) {
-			memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ITEM,
-				item, "Not supported by fdir filter");
-			return -rte_errno;
-		}
-		/* tni is a 24-bits bit field */
-		rte_memcpy(&rule->mask.tunnel_id_mask, nvgre_mask->tni,
-			RTE_DIM(nvgre_mask->tni));
-		rule->mask.tunnel_id_mask <<= 8;
-
-		if (item->spec) {
-			rule->b_spec = TRUE;
-			nvgre_spec = item->spec;
-			if (nvgre_spec->c_k_s_rsvd0_ver !=
-			    rte_cpu_to_be_16(0x2000) &&
-				nvgre_mask->c_k_s_rsvd0_ver) {
-				memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-				rte_flow_error_set(error, EINVAL,
-					RTE_FLOW_ERROR_TYPE_ITEM,
-					item, "Not supported by fdir filter");
-				return -rte_errno;
-			}
-			if (nvgre_mask->protocol &&
-			    nvgre_spec->protocol !=
-			    rte_cpu_to_be_16(NVGRE_PROTOCOL)) {
-				memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-				rte_flow_error_set(error, EINVAL,
-					RTE_FLOW_ERROR_TYPE_ITEM,
-					item, "Not supported by fdir filter");
-				return -rte_errno;
-			}
-			/* tni is a 24-bits bit field */
-			rte_memcpy(&rule->ixgbe_fdir.formatted.tni_vni,
-			nvgre_spec->tni, RTE_DIM(nvgre_spec->tni));
-		}
-	}
-
-	/* check if the next not void item is MAC */
-	item = next_no_void_pattern(pattern, item);
-	if (item->type != RTE_FLOW_ITEM_TYPE_ETH) {
-		memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-		rte_flow_error_set(error, EINVAL,
-			RTE_FLOW_ERROR_TYPE_ITEM,
-			item, "Not supported by fdir filter");
-		return -rte_errno;
-	}
-
-	/**
-	 * Only support vlan and dst MAC address,
-	 * others should be masked.
-	 */
-
-	if (!item->mask) {
-		memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-		rte_flow_error_set(error, EINVAL,
-			RTE_FLOW_ERROR_TYPE_ITEM,
-			item, "Not supported by fdir filter");
-		return -rte_errno;
-	}
-	/*Not supported last point for range*/
-	if (item->last) {
-		rte_flow_error_set(error, EINVAL,
-			RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
-			item, "Not supported last point for range");
-		return -rte_errno;
-	}
-	rule->b_mask = TRUE;
-	eth_mask = item->mask;
-
-	/* Ether type should be masked. */
-	if (eth_mask->hdr.ether_type) {
-		memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-		rte_flow_error_set(error, EINVAL,
-			RTE_FLOW_ERROR_TYPE_ITEM,
-			item, "Not supported by fdir filter");
-		return -rte_errno;
-	}
-
-	/* src MAC address should be masked. */
-	for (j = 0; j < RTE_ETHER_ADDR_LEN; j++) {
-		if (eth_mask->hdr.src_addr.addr_bytes[j]) {
-			memset(rule, 0,
-			       sizeof(struct ixgbe_fdir_rule));
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ITEM,
-				item, "Not supported by fdir filter");
-			return -rte_errno;
-		}
-	}
-	rule->mask.mac_addr_byte_mask = 0;
-	for (j = 0; j < RTE_ETHER_ADDR_LEN; j++) {
-		/* It's a per byte mask. */
-		if (eth_mask->hdr.dst_addr.addr_bytes[j] == 0xFF) {
-			rule->mask.mac_addr_byte_mask |= 0x1 << j;
-		} else if (eth_mask->hdr.dst_addr.addr_bytes[j]) {
-			memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ITEM,
-				item, "Not supported by fdir filter");
-			return -rte_errno;
-		}
-	}
-
-	/* When no vlan, considered as full mask. */
-	rule->mask.vlan_tci_mask = rte_cpu_to_be_16(0xEFFF);
-
-	if (item->spec) {
-		rule->b_spec = TRUE;
-		eth_spec = item->spec;
-
-		/* Get the dst MAC. */
-		for (j = 0; j < RTE_ETHER_ADDR_LEN; j++) {
-			rule->ixgbe_fdir.formatted.inner_mac[j] =
-				eth_spec->hdr.dst_addr.addr_bytes[j];
-		}
-	}
-
-	/**
-	 * Check if the next not void item is vlan or ipv4.
-	 * IPv6 is not supported.
-	 */
-	item = next_no_void_pattern(pattern, item);
-	if ((item->type != RTE_FLOW_ITEM_TYPE_VLAN) &&
-		(item->type != RTE_FLOW_ITEM_TYPE_IPV4)) {
-		memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-		rte_flow_error_set(error, EINVAL,
-			RTE_FLOW_ERROR_TYPE_ITEM,
-			item, "Not supported by fdir filter");
-		return -rte_errno;
-	}
-	/*Not supported last point for range*/
-	if (item->last) {
-		rte_flow_error_set(error, EINVAL,
-			RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
-			item, "Not supported last point for range");
-		return -rte_errno;
-	}
-
-	if (item->type == RTE_FLOW_ITEM_TYPE_VLAN) {
-		if (!(item->spec && item->mask)) {
-			memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ITEM,
-				item, "Not supported by fdir filter");
-			return -rte_errno;
-		}
-
-		vlan_spec = item->spec;
-		vlan_mask = item->mask;
-
-		rule->ixgbe_fdir.formatted.vlan_id = vlan_spec->hdr.vlan_tci;
-
-		rule->mask.vlan_tci_mask = vlan_mask->hdr.vlan_tci;
-		rule->mask.vlan_tci_mask &= rte_cpu_to_be_16(0xEFFF);
-		/* More than one tags are not supported. */
-
-		/* check if the next not void item is END */
-		item = next_no_void_pattern(pattern, item);
-
-		if (item->type != RTE_FLOW_ITEM_TYPE_END) {
-			memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ITEM,
-				item, "Not supported by fdir filter");
-			return -rte_errno;
-		}
-	}
-
-	/**
-	 * If the tags is 0, it means don't care about the VLAN.
-	 * Do nothing.
-	 */
-
-	return 0;
-}
-
-/*
- * Check flow director actions
- */
-static int
-ixgbe_fdir_actions_check(const struct ci_flow_actions *parsed_actions,
-	const struct ci_flow_actions_check_param *param __rte_unused,
-	struct rte_flow_error *error)
-{
-	const enum rte_flow_action_type fwd_actions[] = {
-		RTE_FLOW_ACTION_TYPE_QUEUE,
-		RTE_FLOW_ACTION_TYPE_DROP,
-		RTE_FLOW_ACTION_TYPE_END
-	};
-	const struct rte_flow_action *action, *drop_action = NULL;
-
-	/* do the generic checks first */
-	int ret = ixgbe_flow_actions_check(parsed_actions, param, error);
-	if (ret)
-		return ret;
-
-	/* first action must be a forwarding action */
-	action = parsed_actions->actions[0];
-	if (!ci_flow_action_type_in_list(action->type, fwd_actions)) {
-		return rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_ACTION,
-					  action, "First action must be QUEUE or DROP");
-	}
-	/* remember if we have a drop action */
-	if (action->type == RTE_FLOW_ACTION_TYPE_DROP) {
-		drop_action = action;
-	}
-
-	/* second action, if specified, must not be a forwarding action */
-	action = parsed_actions->actions[1];
-	if (action != NULL && ci_flow_action_type_in_list(action->type, fwd_actions)) {
-		return rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_ACTION,
-					  action, "Conflicting actions");
-	}
-	/* if we didn't have a drop action before but now we do, remember that */
-	if (drop_action == NULL && action != NULL && action->type == RTE_FLOW_ACTION_TYPE_DROP) {
-		drop_action = action;
-	}
-	/* drop must be the only action */
-	if (drop_action != NULL && action != NULL) {
-		return rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_ACTION,
-					  action, "Conflicting actions");
-	}
-	return 0;
-}
-
-static int
-ixgbe_parse_fdir_filter(struct rte_eth_dev *dev,
-			const struct rte_flow_attr *attr,
-			const struct rte_flow_item pattern[],
-			const struct rte_flow_action actions[],
-			struct ixgbe_fdir_rule *rule,
-			struct rte_flow_error *error)
-{
-	int ret;
-	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
-	struct rte_eth_fdir_conf *fdir_conf = IXGBE_DEV_FDIR_CONF(dev);
-	struct ci_flow_actions parsed_actions;
-	struct ci_flow_actions_check_param ap_param = {
-		.allowed_types = (const enum rte_flow_action_type[]){
-			/* queue/mark/drop allowed here */
-			RTE_FLOW_ACTION_TYPE_QUEUE,
-			RTE_FLOW_ACTION_TYPE_DROP,
-			RTE_FLOW_ACTION_TYPE_MARK,
-			RTE_FLOW_ACTION_TYPE_END
-		},
-		.driver_ctx = dev,
-		.check = ixgbe_fdir_actions_check
-	};
-
-	if (hw->mac.type != ixgbe_mac_82599EB &&
-			hw->mac.type != ixgbe_mac_X540 &&
-			hw->mac.type != ixgbe_mac_X550 &&
-			hw->mac.type != ixgbe_mac_X550EM_x &&
-			hw->mac.type != ixgbe_mac_X550EM_a &&
-			hw->mac.type != ixgbe_mac_E610)
-		return -ENOTSUP;
-
-	/* validate attributes */
-	ret = ci_flow_check_attr(attr, NULL, error);
-	if (ret)
-		return ret;
-
-	/* parse requested actions */
-	ret = ci_flow_check_actions(actions, &ap_param, &parsed_actions, error);
-	if (ret)
-		return ret;
-
-	fdir_conf->drop_queue = IXGBE_FDIR_DROP_QUEUE;
-
-	ret = ixgbe_parse_fdir_filter_normal(dev, pattern, &parsed_actions, rule, error);
-
-	if (!ret)
-		goto step_next;
-
-	ret = ixgbe_parse_fdir_filter_tunnel(pattern, &parsed_actions, rule, error);
-
-	if (ret)
-		return ret;
-
-step_next:
-
-	if (hw->mac.type == ixgbe_mac_82599EB &&
-		rule->fdirflags == IXGBE_FDIRCMD_DROP &&
-		(rule->ixgbe_fdir.formatted.src_port != 0 ||
-		rule->ixgbe_fdir.formatted.dst_port != 0))
-		return -ENOTSUP;
-
-	if (fdir_conf->mode == RTE_FDIR_MODE_NONE) {
-		fdir_conf->mode = rule->mode;
-		ret = ixgbe_fdir_configure(dev);
-		if (ret) {
-			fdir_conf->mode = RTE_FDIR_MODE_NONE;
-			return ret;
-		}
-	} else if (fdir_conf->mode != rule->mode) {
-		return -ENOTSUP;
-	}
-
-	if (rule->queue >= dev->data->nb_rx_queues)
-		return -ENOTSUP;
-
-	return ret;
-}
-
 /* Flow actions check specific to RSS filter */
 static int
 ixgbe_flow_actions_check_rss(const struct ci_flow_actions *parsed_actions,
@@ -1665,7 +241,6 @@ ixgbe_clear_rss_filter(struct rte_eth_dev *dev)
 void
 ixgbe_filterlist_init(void)
 {
-	TAILQ_INIT(&filter_fdir_list);
 	TAILQ_INIT(&filter_rss_list);
 	TAILQ_INIT(&ixgbe_flow_list);
 }
@@ -1673,17 +248,9 @@ ixgbe_filterlist_init(void)
 void
 ixgbe_filterlist_flush(void)
 {
-	struct ixgbe_fdir_rule_ele *fdir_rule_ptr;
 	struct ixgbe_flow_mem *ixgbe_flow_mem_ptr;
 	struct ixgbe_rss_conf_ele *rss_filter_ptr;
 
-	while ((fdir_rule_ptr = TAILQ_FIRST(&filter_fdir_list))) {
-		TAILQ_REMOVE(&filter_fdir_list,
-				 fdir_rule_ptr,
-				 entries);
-		rte_free(fdir_rule_ptr);
-	}
-
 	while ((rss_filter_ptr = TAILQ_FIRST(&filter_rss_list))) {
 		TAILQ_REMOVE(&filter_rss_list,
 				 rss_filter_ptr,
@@ -1715,15 +282,10 @@ ixgbe_flow_create(struct rte_eth_dev *dev,
 {
 	struct ixgbe_adapter *ad = dev->data->dev_private;
 	int ret;
-	struct ixgbe_fdir_rule fdir_rule;
-	struct ixgbe_hw_fdir_info *fdir_info =
-		IXGBE_DEV_PRIVATE_TO_FDIR_INFO(dev->data->dev_private);
 	struct ixgbe_rte_flow_rss_conf rss_conf;
 	struct rte_flow *flow = NULL;
-	struct ixgbe_fdir_rule_ele *fdir_rule_ptr;
 	struct ixgbe_rss_conf_ele *rss_filter_ptr;
 	struct ixgbe_flow_mem *ixgbe_flow_mem_ptr;
-	uint8_t first_mask = FALSE;
 
 	/* try the new flow engine first */
 	flow = ci_flow_create(&ad->flow_engine_conf, &ixgbe_flow_engine_list,
@@ -1750,81 +312,6 @@ ixgbe_flow_create(struct rte_eth_dev *dev,
 	TAILQ_INSERT_TAIL(&ixgbe_flow_list,
 				ixgbe_flow_mem_ptr, entries);
 
-	memset(&fdir_rule, 0, sizeof(struct ixgbe_fdir_rule));
-	ret = ixgbe_parse_fdir_filter(dev, attr, pattern,
-				actions, &fdir_rule, error);
-	if (!ret) {
-		/* A mask cannot be deleted. */
-		if (fdir_rule.b_mask) {
-			if (!fdir_info->mask_added) {
-				/* It's the first time the mask is set. */
-				*&fdir_info->mask = *&fdir_rule.mask;
-
-				if (fdir_rule.mask.flex_bytes_mask) {
-					ret = ixgbe_fdir_set_flexbytes_offset(dev,
-						fdir_rule.flex_bytes_offset);
-					if (ret)
-						goto out;
-				}
-				ret = ixgbe_fdir_set_input_mask(dev);
-				if (ret)
-					goto out;
-
-				fdir_info->mask_added = TRUE;
-				first_mask = TRUE;
-			} else {
-				/**
-				 * Only support one global mask,
-				 * all the masks should be the same.
-				 */
-				ret = memcmp(&fdir_info->mask,
-					&fdir_rule.mask,
-					sizeof(struct ixgbe_hw_fdir_mask));
-				if (ret)
-					goto out;
-
-				if (fdir_rule.mask.flex_bytes_mask &&
-				    fdir_info->flex_bytes_offset !=
-				    fdir_rule.flex_bytes_offset)
-					goto out;
-			}
-		}
-
-		if (fdir_rule.b_spec) {
-			ret = ixgbe_fdir_filter_program(dev, &fdir_rule,
-					FALSE, FALSE);
-			if (!ret) {
-				fdir_rule_ptr = rte_zmalloc("ixgbe_fdir_filter",
-					sizeof(struct ixgbe_fdir_rule_ele), 0);
-				if (!fdir_rule_ptr) {
-					PMD_DRV_LOG(ERR, "failed to allocate memory");
-					goto out;
-				}
-				rte_memcpy(&fdir_rule_ptr->filter_info,
-					&fdir_rule,
-					sizeof(struct ixgbe_fdir_rule));
-				TAILQ_INSERT_TAIL(&filter_fdir_list,
-					fdir_rule_ptr, entries);
-				flow->rule = fdir_rule_ptr;
-				flow->filter_type = RTE_ETH_FILTER_FDIR;
-
-				return flow;
-			}
-
-			if (ret) {
-				/**
-				 * clean the mask_added flag if fail to
-				 * program
-				 **/
-				if (first_mask)
-					fdir_info->mask_added = FALSE;
-				goto out;
-			}
-		}
-
-		goto out;
-	}
-
 	memset(&rss_conf, 0, sizeof(struct ixgbe_rte_flow_rss_conf));
 	ret = ixgbe_parse_rss_filter(dev, attr,
 					actions, &rss_conf, error);
@@ -1871,7 +358,6 @@ ixgbe_flow_validate(struct rte_eth_dev *dev,
 		struct rte_flow_error *error)
 {
 	struct ixgbe_adapter *ad = dev->data->dev_private;
-	struct ixgbe_fdir_rule fdir_rule;
 	struct ixgbe_rte_flow_rss_conf rss_conf;
 	int ret;
 
@@ -1883,12 +369,6 @@ ixgbe_flow_validate(struct rte_eth_dev *dev,
 
 	/* fall back to legacy engines */
 
-	memset(&fdir_rule, 0, sizeof(struct ixgbe_fdir_rule));
-	ret = ixgbe_parse_fdir_filter(dev, attr, pattern,
-				actions, &fdir_rule, error);
-	if (!ret)
-		return 0;
-
 	memset(&rss_conf, 0, sizeof(struct ixgbe_rte_flow_rss_conf));
 	ret = ixgbe_parse_rss_filter(dev, attr,
 					actions, &rss_conf, error);
@@ -1906,11 +386,7 @@ ixgbe_flow_destroy(struct rte_eth_dev *dev,
 	int ret;
 	struct rte_flow *pmd_flow = flow;
 	enum rte_filter_type filter_type = pmd_flow->filter_type;
-	struct ixgbe_fdir_rule fdir_rule;
-	struct ixgbe_fdir_rule_ele *fdir_rule_ptr;
 	struct ixgbe_flow_mem *ixgbe_flow_mem_ptr;
-	struct ixgbe_hw_fdir_info *fdir_info =
-		IXGBE_DEV_PRIVATE_TO_FDIR_INFO(dev->data->dev_private);
 	struct ixgbe_rss_conf_ele *rss_filter_ptr;
 
 	/* try the new flow engine first */
@@ -1923,20 +399,6 @@ ixgbe_flow_destroy(struct rte_eth_dev *dev,
 	/* fall back to legacy engines */
 
 	switch (filter_type) {
-	case RTE_ETH_FILTER_FDIR:
-		fdir_rule_ptr = (struct ixgbe_fdir_rule_ele *)pmd_flow->rule;
-		rte_memcpy(&fdir_rule,
-			&fdir_rule_ptr->filter_info,
-			sizeof(struct ixgbe_fdir_rule));
-		ret = ixgbe_fdir_filter_program(dev, &fdir_rule, TRUE, FALSE);
-		if (!ret) {
-			TAILQ_REMOVE(&filter_fdir_list,
-				fdir_rule_ptr, entries);
-			rte_free(fdir_rule_ptr);
-			if (TAILQ_EMPTY(&filter_fdir_list))
-				fdir_info->mask_added = false;
-		}
-		break;
 	case RTE_ETH_FILTER_HASH:
 		rss_filter_ptr = (struct ixgbe_rss_conf_ele *)
 				pmd_flow->rule;
diff --git a/drivers/net/intel/ixgbe/ixgbe_flow.h b/drivers/net/intel/ixgbe/ixgbe_flow.h
index daff23e227..91ee5106e3 100644
--- a/drivers/net/intel/ixgbe/ixgbe_flow.h
+++ b/drivers/net/intel/ixgbe/ixgbe_flow.h
@@ -14,6 +14,8 @@ enum ixgbe_flow_engine_type {
 	IXGBE_FLOW_ENGINE_TYPE_L2_TUNNEL,
 	IXGBE_FLOW_ENGINE_TYPE_NTUPLE,
 	IXGBE_FLOW_ENGINE_TYPE_SECURITY,
+	IXGBE_FLOW_ENGINE_TYPE_FDIR,
+	IXGBE_FLOW_ENGINE_TYPE_FDIR_TUNNEL,
 };
 
 int
@@ -28,5 +30,7 @@ extern const struct ci_flow_engine ixgbe_syn_flow_engine;
 extern const struct ci_flow_engine ixgbe_l2_tunnel_flow_engine;
 extern const struct ci_flow_engine ixgbe_ntuple_flow_engine;
 extern const struct ci_flow_engine ixgbe_security_flow_engine;
+extern const struct ci_flow_engine ixgbe_fdir_flow_engine;
+extern const struct ci_flow_engine ixgbe_fdir_tunnel_flow_engine;
 
 #endif /*  _IXGBE_FLOW_H_ */
diff --git a/drivers/net/intel/ixgbe/ixgbe_flow_fdir.c b/drivers/net/intel/ixgbe/ixgbe_flow_fdir.c
new file mode 100644
index 0000000000..c0c43ddbff
--- /dev/null
+++ b/drivers/net/intel/ixgbe/ixgbe_flow_fdir.c
@@ -0,0 +1,1510 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2026 Intel Corporation
+ */
+
+#include <rte_common.h>
+#include <rte_flow.h>
+#include <rte_flow_graph.h>
+#include <rte_ether.h>
+
+#include "ixgbe_ethdev.h"
+#include "ixgbe_flow.h"
+#include "../common/flow_check.h"
+#include "../common/flow_util.h"
+#include "../common/flow_engine.h"
+
+struct ixgbe_fdir_flow {
+	struct rte_flow flow;
+	struct ixgbe_fdir_rule rule;
+};
+
+struct ixgbe_fdir_ctx {
+	struct ci_flow_engine_ctx base;
+	struct ixgbe_fdir_rule rule;
+	bool supports_sctp_ports;
+	const struct rte_flow_action *fwd_action;
+	const struct rte_flow_action *aux_action;
+};
+
+#define IXGBE_FDIR_VLAN_TCI_MASK	rte_cpu_to_be_16(0xEFFF)
+
+/**
+ * FDIR normal graph implementation
+ * Pattern: START -> [ETH] -> (IPv4|IPv6) -> [TCP|UDP|SCTP] -> [RAW] -> END
+ * Pattern: START -> ETH -> VLAN -> END
+ */
+
+enum ixgbe_fdir_normal_node_id {
+	IXGBE_FDIR_NORMAL_NODE_START = RTE_FLOW_NODE_FIRST,
+	/* special node to report fuzzy matches */
+	IXGBE_FDIR_NORMAL_NODE_FUZZY,
+	IXGBE_FDIR_NORMAL_NODE_ETH,
+	IXGBE_FDIR_NORMAL_NODE_VLAN,
+	IXGBE_FDIR_NORMAL_NODE_IPV4,
+	IXGBE_FDIR_NORMAL_NODE_IPV6,
+	IXGBE_FDIR_NORMAL_NODE_TCP,
+	IXGBE_FDIR_NORMAL_NODE_UDP,
+	IXGBE_FDIR_NORMAL_NODE_SCTP,
+	IXGBE_FDIR_NORMAL_NODE_RAW,
+	IXGBE_FDIR_NORMAL_NODE_END,
+	IXGBE_FDIR_NORMAL_NODE_MAX,
+};
+
+static inline uint8_t
+signature_match(const struct rte_flow_item *item)
+{
+	const struct rte_flow_item_fuzzy *spec, *last, *mask;
+	uint32_t sh, lh, mh;
+
+	spec = item->spec;
+	last = item->last;
+	mask = item->mask;
+
+	if (spec == NULL && mask == NULL)
+		return 0;
+
+	sh = spec->thresh;
+
+	if (last == NULL)
+		lh = sh;
+	else
+		lh = last->thresh;
+
+	mh = mask->thresh;
+	sh = sh & mh;
+	lh = lh & mh;
+
+	/*
+	 * A fuzzy item selects signature mode only when the masked threshold range
+	 * is non-empty. Otherwise this stays a perfect-match rule.
+	 */
+	if (!sh || sh > lh)
+		return 0;
+
+	return 1;
+}
+
+static int
+ixgbe_process_fdir_normal_fuzzy(void *ctx, const struct rte_flow_item *item,
+		struct rte_flow_error *error __rte_unused)
+{
+	struct ixgbe_fdir_ctx *fdir_ctx = ctx;
+
+	fdir_ctx->rule.mode = RTE_FDIR_MODE_PERFECT;
+
+	/* spec and mask are optional */
+	if (item->spec == NULL && item->mask == NULL)
+		return 0;
+
+	if (signature_match(item)) {
+		fdir_ctx->rule.mode = RTE_FDIR_MODE_SIGNATURE;
+	}
+
+	return 0;
+}
+
+static int
+ixgbe_validate_fdir_normal_eth(const void *ctx, const struct rte_flow_item *item,
+		struct rte_flow_error *error)
+{
+	const struct ixgbe_fdir_ctx *fdir_ctx = (const struct ixgbe_fdir_ctx *)ctx;
+	const struct rte_flow_item_eth *eth_mask = item->mask;
+
+	if (item->spec == NULL && item->mask == NULL)
+		return 0;
+
+	/* we cannot have ETH item in signature mode */
+	if (fdir_ctx->rule.mode == RTE_FDIR_MODE_SIGNATURE) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"ETH item not supported in signature mode");
+	}
+	/* ethertype isn't supported by FDIR */
+	if (!CI_FIELD_IS_ZERO(&eth_mask->hdr.ether_type)) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"Ethertype filtering not supported");
+	}
+	/* source address mask must be all zeroes */
+	if (!CI_FIELD_IS_ZERO(&eth_mask->hdr.src_addr)) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"Source MAC filtering not supported");
+	}
+	/* destination address mask must be all ones */
+	if (!CI_FIELD_IS_MASKED(&eth_mask->hdr.dst_addr)) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"Destination MAC filtering must be exact match");
+	}
+	return 0;
+}
+
+static int
+ixgbe_process_fdir_normal_eth(void *ctx, const struct rte_flow_item *item,
+		struct rte_flow_error *error __rte_unused)
+{
+	struct ixgbe_fdir_ctx *fdir_ctx = ctx;
+	struct ixgbe_fdir_rule *rule = &fdir_ctx->rule;
+	const struct rte_flow_item_eth *eth_spec = item->spec;
+	const struct rte_flow_item_eth *eth_mask = item->mask;
+
+
+	if (eth_spec == NULL && eth_mask == NULL)
+		return 0;
+
+	/* copy dst MAC */
+	rule->b_spec = TRUE;
+	memcpy(rule->ixgbe_fdir.formatted.inner_mac, eth_spec->hdr.dst_addr.addr_bytes,
+			RTE_ETHER_ADDR_LEN);
+
+	/* set tunnel type */
+	rule->mode = RTE_FDIR_MODE_PERFECT_MAC_VLAN;
+	/* when no VLAN specified, set full mask */
+	rule->b_mask = TRUE;
+	rule->mask.vlan_tci_mask = IXGBE_FDIR_VLAN_TCI_MASK;
+
+	return 0;
+}
+
+static int
+ixgbe_process_fdir_normal_vlan(void *ctx, const struct rte_flow_item *item,
+		struct rte_flow_error *error __rte_unused)
+{
+	const struct rte_flow_item_vlan *vlan_spec = item->spec;
+	const struct rte_flow_item_vlan *vlan_mask = item->mask;
+	struct ixgbe_fdir_ctx *fdir_ctx = ctx;
+	struct ixgbe_fdir_rule *rule = &fdir_ctx->rule;
+
+	rule->ixgbe_fdir.formatted.vlan_id = vlan_spec->hdr.vlan_tci;
+
+	rule->mask.vlan_tci_mask = vlan_mask->hdr.vlan_tci;
+	rule->mask.vlan_tci_mask &= IXGBE_FDIR_VLAN_TCI_MASK;
+
+	return 0;
+}
+
+static int
+ixgbe_validate_fdir_normal_ipv4(const void *ctx,
+			    const struct rte_flow_item *item,
+			    struct rte_flow_error *error)
+{
+	const struct rte_flow_item_ipv4 *ipv4_mask = item->mask;
+	const struct ixgbe_fdir_ctx *fdir_ctx = ctx;
+	const struct ixgbe_fdir_rule *rule = &fdir_ctx->rule;
+
+	if (rule->mode == RTE_FDIR_MODE_PERFECT_MAC_VLAN) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"IPv4 not supported with ETH/VLAN items");
+	}
+
+	if (ipv4_mask->hdr.version_ihl ||
+	    ipv4_mask->hdr.type_of_service ||
+	    ipv4_mask->hdr.total_length ||
+	    ipv4_mask->hdr.packet_id ||
+	    ipv4_mask->hdr.fragment_offset ||
+	    ipv4_mask->hdr.time_to_live ||
+	    ipv4_mask->hdr.next_proto_id ||
+	    ipv4_mask->hdr.hdr_checksum) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"Only src/dst addresses supported");
+	}
+
+	return 0;
+}
+
+static int
+ixgbe_process_fdir_normal_ipv4(void *ctx,
+			   const struct rte_flow_item *item,
+			   struct rte_flow_error *error __rte_unused)
+{
+	struct ixgbe_fdir_ctx *fdir_ctx = ctx;
+	const struct rte_flow_item_ipv4 *ipv4_spec = item->spec;
+	const struct rte_flow_item_ipv4 *ipv4_mask = item->mask;
+	struct ixgbe_fdir_rule *rule = &fdir_ctx->rule;
+
+	rule->ixgbe_fdir.formatted.flow_type = IXGBE_ATR_FLOW_TYPE_IPV4;
+
+	/* spec may not be present */
+	if (ipv4_spec) {
+		rule->b_spec = TRUE;
+		rule->ixgbe_fdir.formatted.dst_ip[0] = ipv4_spec->hdr.dst_addr;
+		rule->ixgbe_fdir.formatted.src_ip[0] = ipv4_spec->hdr.src_addr;
+	}
+
+	rule->b_mask = TRUE;
+	rule->mask.dst_ipv4_mask = ipv4_mask->hdr.dst_addr;
+	rule->mask.src_ipv4_mask = ipv4_mask->hdr.src_addr;
+
+	return 0;
+}
+
+static int
+ixgbe_validate_fdir_normal_ipv6(const void *ctx,
+			    const struct rte_flow_item *item,
+			    struct rte_flow_error *error)
+{
+	const struct ixgbe_fdir_ctx *fdir_ctx = ctx;
+	const struct rte_flow_item_ipv6 *ipv6_mask = item->mask;
+	const struct ixgbe_fdir_rule *rule = &fdir_ctx->rule;
+
+	if (rule->mode == RTE_FDIR_MODE_PERFECT_MAC_VLAN) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"IPv6 not supported with ETH/VLAN items");
+	}
+
+	if (rule->mode != RTE_FDIR_MODE_SIGNATURE) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"IPv6 only supported in signature mode");
+	}
+
+	ipv6_mask = item->mask;
+
+	if (ipv6_mask->hdr.vtc_flow ||
+	    ipv6_mask->hdr.payload_len ||
+	    ipv6_mask->hdr.proto ||
+	    ipv6_mask->hdr.hop_limits) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"Only src/dst addresses supported");
+	}
+
+	if (!CI_FIELD_IS_ZERO_OR_MASKED(&ipv6_mask->hdr.src_addr)) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"Partial src address masks not supported");
+	}
+	if (!CI_FIELD_IS_ZERO_OR_MASKED(&ipv6_mask->hdr.dst_addr)) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"Partial dst address masks not supported");
+	}
+
+	return 0;
+}
+
+static int
+ixgbe_process_fdir_normal_ipv6(void *ctx,
+			   const struct rte_flow_item *item,
+			   struct rte_flow_error *error __rte_unused)
+{
+	struct ixgbe_fdir_ctx *fdir_ctx = ctx;
+	const struct rte_flow_item_ipv6 *ipv6_spec = item->spec;
+	const struct rte_flow_item_ipv6 *ipv6_mask = item->mask;
+	struct ixgbe_fdir_rule *rule = &fdir_ctx->rule;
+	uint8_t j;
+
+	rule->ixgbe_fdir.formatted.flow_type = IXGBE_ATR_FLOW_TYPE_IPV6;
+
+	/* spec may not be present */
+	if (ipv6_spec) {
+		rule->b_spec = TRUE;
+		memcpy(rule->ixgbe_fdir.formatted.src_ip, &ipv6_spec->hdr.src_addr,
+				sizeof(struct rte_ipv6_addr));
+		memcpy(rule->ixgbe_fdir.formatted.dst_ip, &ipv6_spec->hdr.dst_addr,
+				sizeof(struct rte_ipv6_addr));
+	}
+
+	rule->b_mask = TRUE;
+	for (j = 0; j < sizeof(struct rte_ipv6_addr); j++) {
+		if (ipv6_mask->hdr.src_addr.a[j] == 0)
+			rule->mask.src_ipv6_mask &= ~(1 << j);
+		if (ipv6_mask->hdr.dst_addr.a[j] == 0)
+			rule->mask.dst_ipv6_mask &= ~(1 << j);
+	}
+
+	return 0;
+}
+
+static int
+ixgbe_validate_fdir_normal_tcp(const void *ctx,
+			   const struct rte_flow_item *item,
+			   struct rte_flow_error *error)
+{
+	const struct rte_flow_item_tcp *tcp_mask = item->mask;
+	const struct ixgbe_fdir_ctx *fdir_ctx = ctx;
+	const struct ixgbe_fdir_rule *rule = &fdir_ctx->rule;
+
+	if (rule->mode == RTE_FDIR_MODE_PERFECT_MAC_VLAN) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"TCP not supported with ETH/VLAN items");
+	}
+
+	if (tcp_mask->hdr.sent_seq ||
+	    tcp_mask->hdr.recv_ack ||
+	    tcp_mask->hdr.data_off ||
+	    tcp_mask->hdr.tcp_flags ||
+	    tcp_mask->hdr.rx_win ||
+	    tcp_mask->hdr.cksum ||
+	    tcp_mask->hdr.tcp_urp) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"Only src/dst ports supported");
+	}
+
+	return 0;
+}
+
+static int
+ixgbe_process_fdir_normal_tcp(void *ctx,
+			  const struct rte_flow_item *item,
+			  struct rte_flow_error *error __rte_unused)
+{
+	struct ixgbe_fdir_ctx *fdir_ctx = ctx;
+	const struct rte_flow_item_tcp *tcp_spec = item->spec;
+	const struct rte_flow_item_tcp *tcp_mask = item->mask;
+	struct ixgbe_fdir_rule *rule = &fdir_ctx->rule;
+
+	rule->ixgbe_fdir.formatted.flow_type |= IXGBE_ATR_L4TYPE_TCP;
+
+	/* spec is optional */
+	if (tcp_spec) {
+		rule->b_spec = TRUE;
+		rule->ixgbe_fdir.formatted.src_port = tcp_spec->hdr.src_port;
+		rule->ixgbe_fdir.formatted.dst_port = tcp_spec->hdr.dst_port;
+	}
+
+	rule->b_mask = TRUE;
+	rule->mask.src_port_mask = tcp_mask->hdr.src_port;
+	rule->mask.dst_port_mask = tcp_mask->hdr.dst_port;
+
+	return 0;
+}
+
+static int
+ixgbe_validate_fdir_normal_udp(const void *ctx,
+			   const struct rte_flow_item *item,
+			   struct rte_flow_error *error)
+{
+	const struct rte_flow_item_udp *udp_mask = item->mask;
+	const struct ixgbe_fdir_ctx *fdir_ctx = ctx;
+	const struct ixgbe_fdir_rule *rule = &fdir_ctx->rule;
+
+	if (rule->mode == RTE_FDIR_MODE_PERFECT_MAC_VLAN) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"IPv4 not supported with ETH/VLAN items");
+	}
+
+	if (udp_mask->hdr.dgram_len ||
+	    udp_mask->hdr.dgram_cksum) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"Only src/dst ports supported");
+	}
+
+	return 0;
+}
+
+static int
+ixgbe_process_fdir_normal_udp(void *ctx,
+			  const struct rte_flow_item *item,
+			  struct rte_flow_error *error __rte_unused)
+{
+	struct ixgbe_fdir_ctx *fdir_ctx = ctx;
+	const struct rte_flow_item_udp *udp_spec = item->spec;
+	const struct rte_flow_item_udp *udp_mask = item->mask;
+	struct ixgbe_fdir_rule *rule = &fdir_ctx->rule;
+
+	rule->ixgbe_fdir.formatted.flow_type |= IXGBE_ATR_L4TYPE_UDP;
+
+	/* spec is optional */
+	if (udp_spec) {
+		rule->b_spec = TRUE;
+		rule->ixgbe_fdir.formatted.src_port = udp_spec->hdr.src_port;
+		rule->ixgbe_fdir.formatted.dst_port = udp_spec->hdr.dst_port;
+	}
+
+	rule->b_mask = TRUE;
+	rule->mask.src_port_mask = udp_mask->hdr.src_port;
+	rule->mask.dst_port_mask = udp_mask->hdr.dst_port;
+
+	return 0;
+}
+
+static int
+ixgbe_validate_fdir_normal_sctp(const void *ctx,
+			    const struct rte_flow_item *item,
+			    struct rte_flow_error *error)
+{
+	const struct rte_flow_item_sctp *sctp_mask = item->mask;
+	const struct ixgbe_fdir_ctx *fdir_ctx = ctx;
+	const struct ixgbe_fdir_rule *rule = &fdir_ctx->rule;
+
+	if (rule->mode == RTE_FDIR_MODE_PERFECT_MAC_VLAN) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"IPv4 not supported with ETH/VLAN items");
+	}
+
+	/* mask is optional */
+	if (sctp_mask == NULL)
+		return 0;
+
+	/* mask can only be specified for some hardware */
+	if (!fdir_ctx->supports_sctp_ports) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"SCTP mask not supported");
+	}
+
+	/* Tag and checksum not supported */
+	if (sctp_mask->hdr.tag ||
+	    sctp_mask->hdr.cksum) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"SCTP tag/cksum not supported");
+	}
+
+	return 0;
+}
+
+static int
+ixgbe_process_fdir_normal_sctp(void *ctx,
+			   const struct rte_flow_item *item,
+			   struct rte_flow_error *error __rte_unused)
+{
+	struct ixgbe_fdir_ctx *fdir_ctx = ctx;
+	const struct rte_flow_item_sctp *sctp_spec = item->spec;
+	const struct rte_flow_item_sctp *sctp_mask = item->mask;
+	struct ixgbe_fdir_rule *rule = &fdir_ctx->rule;
+
+	fdir_ctx->rule.ixgbe_fdir.formatted.flow_type |= IXGBE_ATR_L4TYPE_SCTP;
+
+	/* spec is optional */
+	if (sctp_spec) {
+		rule->b_spec = TRUE;
+		rule->ixgbe_fdir.formatted.src_port = sctp_spec->hdr.src_port;
+		rule->ixgbe_fdir.formatted.dst_port = sctp_spec->hdr.dst_port;
+	}
+
+	/* mask is optional */
+	if (sctp_mask) {
+		rule->b_mask = TRUE;
+		rule->mask.src_port_mask = sctp_mask->hdr.src_port;
+		rule->mask.dst_port_mask = sctp_mask->hdr.dst_port;
+	}
+
+	return 0;
+}
+
+static int
+ixgbe_validate_fdir_normal_raw(const void *ctx __rte_unused,
+			   const struct rte_flow_item *item,
+			   struct rte_flow_error *error)
+{
+	const struct rte_flow_item_raw *raw_spec;
+	const struct rte_flow_item_raw *raw_mask;
+
+	raw_mask = item->mask;
+
+	if (raw_mask->relative != 0x1 ||
+	    raw_mask->search != 0x1 ||
+	    raw_mask->reserved != 0x0 ||
+	    (uint32_t)raw_mask->offset != 0xffffffff ||
+	    raw_mask->limit != 0xffff ||
+	    raw_mask->length != 0xffff) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"Invalid RAW mask");
+	}
+
+	raw_spec = item->spec;
+
+	if (raw_spec->relative != 0 ||
+	    raw_spec->search != 0 ||
+	    raw_spec->reserved != 0 ||
+	    raw_spec->offset > IXGBE_MAX_FLX_SOURCE_OFF ||
+	    raw_spec->offset % 2 ||
+	    raw_spec->limit != 0 ||
+	    raw_spec->length != 2 ||
+	    (raw_spec->pattern[0] == 0xff &&
+	     raw_spec->pattern[1] == 0xff)) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"Invalid RAW spec");
+	}
+
+	if (raw_mask->pattern[0] != 0xff ||
+	    raw_mask->pattern[1] != 0xff) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"RAW pattern must be fully masked");
+	}
+
+	return 0;
+}
+
+static int
+ixgbe_process_fdir_normal_raw(void *ctx,
+			  const struct rte_flow_item *item,
+			  struct rte_flow_error *error __rte_unused)
+{
+	struct ixgbe_fdir_ctx *fdir_ctx = ctx;
+	const struct rte_flow_item_raw *raw_spec = item->spec;
+	struct ixgbe_fdir_rule *rule = &fdir_ctx->rule;
+
+	rule->b_spec = TRUE;
+	rule->ixgbe_fdir.formatted.flex_bytes =
+		(((uint16_t)raw_spec->pattern[1]) << 8) | raw_spec->pattern[0];
+	rule->flex_bytes_offset = raw_spec->offset;
+
+	rule->b_mask = TRUE;
+	rule->mask.flex_bytes_mask = 0xffff;
+
+	return 0;
+}
+
+const struct rte_flow_graph ixgbe_fdir_normal_graph = {
+	.nodes = (struct rte_flow_graph_node[]) {
+		[IXGBE_FDIR_NORMAL_NODE_START] = {
+			.name = "START",
+		},
+		[IXGBE_FDIR_NORMAL_NODE_FUZZY] = {
+			.name = "FUZZY",
+			.type = RTE_FLOW_ITEM_TYPE_FUZZY,
+			.process = ixgbe_process_fdir_normal_fuzzy,
+			.constraints = RTE_FLOW_NODE_EXPECT_EMPTY |
+			               RTE_FLOW_NODE_EXPECT_SPEC_MASK |
+			               RTE_FLOW_NODE_EXPECT_RANGE,
+		},
+		[IXGBE_FDIR_NORMAL_NODE_ETH] = {
+			.name = "ETH",
+			.type = RTE_FLOW_ITEM_TYPE_ETH,
+			.validate = ixgbe_validate_fdir_normal_eth,
+			.process = ixgbe_process_fdir_normal_eth,
+			.constraints = RTE_FLOW_NODE_EXPECT_EMPTY |
+			               RTE_FLOW_NODE_EXPECT_SPEC_MASK,
+		},
+		[IXGBE_FDIR_NORMAL_NODE_VLAN] = {
+			.name = "VLAN",
+			.type = RTE_FLOW_ITEM_TYPE_VLAN,
+			.process = ixgbe_process_fdir_normal_vlan,
+			.constraints = RTE_FLOW_NODE_EXPECT_SPEC_MASK,
+		},
+		[IXGBE_FDIR_NORMAL_NODE_IPV4] = {
+			.name = "IPV4",
+			.type = RTE_FLOW_ITEM_TYPE_IPV4,
+			.validate = ixgbe_validate_fdir_normal_ipv4,
+			.process = ixgbe_process_fdir_normal_ipv4,
+			.constraints = RTE_FLOW_NODE_EXPECT_MASK |
+				       RTE_FLOW_NODE_EXPECT_SPEC_MASK,
+		},
+		[IXGBE_FDIR_NORMAL_NODE_IPV6] = {
+			.name = "IPV6",
+			.type = RTE_FLOW_ITEM_TYPE_IPV6,
+			.validate = ixgbe_validate_fdir_normal_ipv6,
+			.process = ixgbe_process_fdir_normal_ipv6,
+			.constraints = RTE_FLOW_NODE_EXPECT_MASK |
+				       RTE_FLOW_NODE_EXPECT_SPEC_MASK,
+		},
+		[IXGBE_FDIR_NORMAL_NODE_TCP] = {
+			.name = "TCP",
+			.type = RTE_FLOW_ITEM_TYPE_TCP,
+			.validate = ixgbe_validate_fdir_normal_tcp,
+			.process = ixgbe_process_fdir_normal_tcp,
+			.constraints = RTE_FLOW_NODE_EXPECT_MASK |
+				       RTE_FLOW_NODE_EXPECT_SPEC_MASK,
+		},
+		[IXGBE_FDIR_NORMAL_NODE_UDP] = {
+			.name = "UDP",
+			.type = RTE_FLOW_ITEM_TYPE_UDP,
+			.validate = ixgbe_validate_fdir_normal_udp,
+			.process = ixgbe_process_fdir_normal_udp,
+			.constraints = RTE_FLOW_NODE_EXPECT_MASK |
+				       RTE_FLOW_NODE_EXPECT_SPEC_MASK,
+		},
+		[IXGBE_FDIR_NORMAL_NODE_SCTP] = {
+			.name = "SCTP",
+			.type = RTE_FLOW_ITEM_TYPE_SCTP,
+			.validate = ixgbe_validate_fdir_normal_sctp,
+			.process = ixgbe_process_fdir_normal_sctp,
+			.constraints = RTE_FLOW_NODE_EXPECT_EMPTY |
+				       RTE_FLOW_NODE_EXPECT_MASK |
+				       RTE_FLOW_NODE_EXPECT_SPEC_MASK,
+		},
+		[IXGBE_FDIR_NORMAL_NODE_RAW] = {
+			.name = "RAW",
+			.type = RTE_FLOW_ITEM_TYPE_RAW,
+			.constraints = RTE_FLOW_NODE_EXPECT_SPEC_MASK,
+			.validate = ixgbe_validate_fdir_normal_raw,
+			.process = ixgbe_process_fdir_normal_raw,
+		},
+		[IXGBE_FDIR_NORMAL_NODE_END] = {
+			.name = "END",
+			.type = RTE_FLOW_ITEM_TYPE_END,
+		},
+	},
+	.edges = (struct rte_flow_graph_edge[]) {
+		[IXGBE_FDIR_NORMAL_NODE_START] = {
+			.next = (const size_t[]) {
+				IXGBE_FDIR_NORMAL_NODE_ETH,
+				IXGBE_FDIR_NORMAL_NODE_IPV4,
+				IXGBE_FDIR_NORMAL_NODE_IPV6,
+				IXGBE_FDIR_NORMAL_NODE_TCP,
+				IXGBE_FDIR_NORMAL_NODE_UDP,
+				IXGBE_FDIR_NORMAL_NODE_SCTP,
+				RTE_FLOW_NODE_EDGE_END
+			}
+		},
+		[IXGBE_FDIR_NORMAL_NODE_ETH] = {
+			.next = (const size_t[]) {
+				IXGBE_FDIR_NORMAL_NODE_VLAN,
+				IXGBE_FDIR_NORMAL_NODE_IPV4,
+				IXGBE_FDIR_NORMAL_NODE_IPV6,
+				RTE_FLOW_NODE_EDGE_END
+			}
+		},
+		[IXGBE_FDIR_NORMAL_NODE_VLAN] = {
+			.next = (const size_t[]) {
+				IXGBE_FDIR_NORMAL_NODE_END,
+				RTE_FLOW_NODE_EDGE_END
+			}
+		},
+		[IXGBE_FDIR_NORMAL_NODE_IPV4] = {
+			.next = (const size_t[]) {
+				IXGBE_FDIR_NORMAL_NODE_TCP,
+				IXGBE_FDIR_NORMAL_NODE_UDP,
+				IXGBE_FDIR_NORMAL_NODE_SCTP,
+				IXGBE_FDIR_NORMAL_NODE_RAW,
+				IXGBE_FDIR_NORMAL_NODE_END,
+				RTE_FLOW_NODE_EDGE_END
+			}
+		},
+		[IXGBE_FDIR_NORMAL_NODE_IPV6] = {
+			.next = (const size_t[]) {
+				IXGBE_FDIR_NORMAL_NODE_TCP,
+				IXGBE_FDIR_NORMAL_NODE_UDP,
+				IXGBE_FDIR_NORMAL_NODE_SCTP,
+				IXGBE_FDIR_NORMAL_NODE_RAW,
+				IXGBE_FDIR_NORMAL_NODE_END,
+				RTE_FLOW_NODE_EDGE_END
+			}
+		},
+		[IXGBE_FDIR_NORMAL_NODE_TCP] = {
+			.next = (const size_t[]) {
+				IXGBE_FDIR_NORMAL_NODE_RAW,
+				IXGBE_FDIR_NORMAL_NODE_END,
+				RTE_FLOW_NODE_EDGE_END
+			}
+		},
+		[IXGBE_FDIR_NORMAL_NODE_UDP] = {
+			.next = (const size_t[]) {
+				IXGBE_FDIR_NORMAL_NODE_RAW,
+				IXGBE_FDIR_NORMAL_NODE_END,
+				RTE_FLOW_NODE_EDGE_END
+			}
+		},
+		[IXGBE_FDIR_NORMAL_NODE_SCTP] = {
+			.next = (const size_t[]) {
+				IXGBE_FDIR_NORMAL_NODE_RAW,
+				IXGBE_FDIR_NORMAL_NODE_END,
+				RTE_FLOW_NODE_EDGE_END
+			}
+		},
+		[IXGBE_FDIR_NORMAL_NODE_RAW] = {
+			.next = (const size_t[]) {
+				IXGBE_FDIR_NORMAL_NODE_END,
+				RTE_FLOW_NODE_EDGE_END
+			}
+		},
+	},
+};
+
+/**
+ * FDIR tunnel graph implementation (VxLAN and NVGRE)
+ * Pattern: START -> [OUTER_ETH] -> (OUTER_IPv4|OUTER_IPv6) -> [UDP] -> (VXLAN|NVGRE) -> INNER_ETH -> [VLAN] -> END
+ * VxLAN:  START -> [OUTER_ETH] -> (OUTER_IPv4|OUTER_IPv6) -> UDP -> VXLAN -> INNER_ETH -> [VLAN] -> END
+ * NVGRE:  START -> [OUTER_ETH] -> (OUTER_IPv4|OUTER_IPv6) -> NVGRE -> INNER_ETH -> [VLAN] -> END
+ */
+
+enum ixgbe_fdir_tunnel_node_id {
+	IXGBE_FDIR_TUNNEL_NODE_START = RTE_FLOW_NODE_FIRST,
+	IXGBE_FDIR_TUNNEL_NODE_OUTER_ETH,
+	IXGBE_FDIR_TUNNEL_NODE_OUTER_IPV4,
+	IXGBE_FDIR_TUNNEL_NODE_OUTER_IPV6,
+	IXGBE_FDIR_TUNNEL_NODE_UDP,
+	IXGBE_FDIR_TUNNEL_NODE_VXLAN,
+	IXGBE_FDIR_TUNNEL_NODE_NVGRE,
+	IXGBE_FDIR_TUNNEL_NODE_INNER_ETH,
+	IXGBE_FDIR_TUNNEL_NODE_INNER_IPV4,
+	IXGBE_FDIR_TUNNEL_NODE_VLAN,
+	IXGBE_FDIR_TUNNEL_NODE_END,
+	IXGBE_FDIR_TUNNEL_NODE_MAX,
+};
+
+static int
+ixgbe_validate_fdir_tunnel_vxlan(const void *ctx __rte_unused,
+				 const struct rte_flow_item *item,
+				 struct rte_flow_error *error)
+{
+	const struct rte_flow_item_vxlan *vxlan_mask = item->mask;
+
+	if (vxlan_mask->hdr.flags) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"VxLAN flags must be masked");
+	}
+
+	if (!CI_FIELD_IS_ZERO_OR_MASKED(&vxlan_mask->hdr.vni)) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"Partial VNI mask not supported");
+	}
+
+	return 0;
+}
+
+static int
+ixgbe_process_fdir_tunnel_vxlan(void *ctx,
+				const struct rte_flow_item *item,
+				struct rte_flow_error *error __rte_unused)
+{
+	struct ixgbe_fdir_ctx *fdir_ctx = ctx;
+	const struct rte_flow_item_vxlan *vxlan_spec = item->spec;
+	const struct rte_flow_item_vxlan *vxlan_mask = item->mask;
+	struct ixgbe_fdir_rule *rule = &fdir_ctx->rule;
+
+	rule->ixgbe_fdir.formatted.tunnel_type = IXGBE_FDIR_VXLAN_TUNNEL_TYPE;
+
+	/* spec is optional */
+	if (vxlan_spec != NULL) {
+		rule->b_spec = TRUE;
+		memcpy(((uint8_t *)&rule->ixgbe_fdir.formatted.tni_vni), vxlan_spec->hdr.vni,
+				RTE_DIM(vxlan_spec->hdr.vni));
+	}
+
+	rule->b_mask = TRUE;
+	rule->mask.tunnel_type_mask = 1;
+	memcpy(&rule->mask.tunnel_id_mask, vxlan_mask->hdr.vni, RTE_DIM(vxlan_mask->hdr.vni));
+
+	return 0;
+}
+
+static int
+ixgbe_validate_fdir_tunnel_nvgre(const void *ctx __rte_unused,
+				 const struct rte_flow_item *item,
+				 struct rte_flow_error *error)
+{
+	const struct rte_flow_item_nvgre *nvgre_mask;
+
+	nvgre_mask = item->mask;
+
+	if (nvgre_mask->flow_id) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"NVGRE flow ID must not be masked");
+	}
+
+	if (!CI_FIELD_IS_ZERO_OR_MASKED(&nvgre_mask->protocol)) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"NVGRE protocol must be fully masked or unmasked");
+	}
+
+	if (!CI_FIELD_IS_ZERO_OR_MASKED(&nvgre_mask->c_k_s_rsvd0_ver)) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"NVGRE flags must be fully masked or unmasked");
+	}
+
+	if (!CI_FIELD_IS_ZERO_OR_MASKED(&nvgre_mask->tni)) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"Partial TNI mask not supported");
+	}
+
+	/* if spec is present, validate flags and protocol values */
+	if (item->spec) {
+		const struct rte_flow_item_nvgre *nvgre_spec = item->spec;
+
+		if (nvgre_mask->c_k_s_rsvd0_ver &&
+		    nvgre_spec->c_k_s_rsvd0_ver != rte_cpu_to_be_16(0x2000)) {
+			return rte_flow_error_set(error, EINVAL,
+					RTE_FLOW_ERROR_TYPE_ITEM, item,
+					"NVGRE flags must be 0x2000");
+		}
+		if (nvgre_mask->protocol &&
+		    nvgre_spec->protocol != rte_cpu_to_be_16(0x6558)) {
+			return rte_flow_error_set(error, EINVAL,
+					RTE_FLOW_ERROR_TYPE_ITEM, item,
+					"NVGRE protocol must be 0x6558");
+		}
+	}
+
+	return 0;
+}
+
+#define NVGRE_FLAGS 0x2000
+#define NVGRE_PROTOCOL 0x6558
+static int
+ixgbe_process_fdir_tunnel_nvgre(void *ctx,
+				const struct rte_flow_item *item,
+				struct rte_flow_error *error __rte_unused)
+{
+	struct ixgbe_fdir_ctx *fdir_ctx = ctx;
+	const struct rte_flow_item_nvgre *nvgre_spec = item->spec;
+	const struct rte_flow_item_nvgre *nvgre_mask = item->mask;
+	struct ixgbe_fdir_rule *rule = &fdir_ctx->rule;
+
+	rule->ixgbe_fdir.formatted.tunnel_type = IXGBE_FDIR_NVGRE_TUNNEL_TYPE;
+
+	/* spec is optional */
+	if (nvgre_spec != NULL) {
+		rule->b_spec = TRUE;
+		memcpy(&fdir_ctx->rule.ixgbe_fdir.formatted.tni_vni,
+				nvgre_spec->tni, RTE_DIM(nvgre_spec->tni));
+	}
+
+	rule->b_mask = TRUE;
+	rule->mask.tunnel_type_mask = 1;
+	memcpy(&rule->mask.tunnel_id_mask, nvgre_mask->tni, RTE_DIM(nvgre_mask->tni));
+	rule->mask.tunnel_id_mask <<= 8;
+	return 0;
+}
+
+static int
+ixgbe_validate_fdir_tunnel_inner_eth(const void *ctx __rte_unused,
+				     const struct rte_flow_item *item,
+				     struct rte_flow_error *error)
+{
+	const struct rte_flow_item_eth *eth_mask = item->mask;
+
+	if (eth_mask->hdr.ether_type) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"Ether type mask not supported");
+	}
+
+	/* src addr must not be masked */
+	if (!CI_FIELD_IS_ZERO(&eth_mask->hdr.src_addr)) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"Masking not supported for src MAC address");
+	}
+
+	/* dst addr must be either fully masked or fully unmasked */
+	if (!CI_FIELD_IS_ZERO_OR_MASKED(&eth_mask->hdr.dst_addr)) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"Partial masks not supported for dst MAC address");
+	}
+
+	return 0;
+}
+
+static int
+ixgbe_process_fdir_tunnel_inner_eth(void *ctx,
+				    const struct rte_flow_item *item,
+				    struct rte_flow_error *error __rte_unused)
+{
+	struct ixgbe_fdir_ctx *fdir_ctx = ctx;
+	const struct rte_flow_item_eth *eth_spec = item->spec;
+	const struct rte_flow_item_eth *eth_mask = item->mask;
+	struct ixgbe_fdir_rule *rule = &fdir_ctx->rule;
+	uint8_t j;
+
+	/* spec is optional */
+	if (eth_spec != NULL) {
+		rule->b_spec = TRUE;
+		memcpy(&rule->ixgbe_fdir.formatted.inner_mac, eth_spec->hdr.src_addr.addr_bytes,
+				RTE_ETHER_ADDR_LEN);
+	}
+
+	rule->b_mask = TRUE;
+	rule->mask.mac_addr_byte_mask = 0;
+	for (j = 0; j < RTE_ETHER_ADDR_LEN; j++) {
+		if (eth_mask->hdr.dst_addr.addr_bytes[j] == 0xFF) {
+			rule->mask.mac_addr_byte_mask |= 0x1 << j;
+		}
+	}
+
+	/* When no vlan, considered as full mask. */
+	rule->mask.vlan_tci_mask = IXGBE_FDIR_VLAN_TCI_MASK;
+
+	return 0;
+}
+
+static int
+ixgbe_process_fdir_tunnel_vlan(void *ctx,
+			       const struct rte_flow_item *item,
+			       struct rte_flow_error *error __rte_unused)
+{
+	struct ixgbe_fdir_ctx *fdir_ctx = ctx;
+	const struct rte_flow_item_vlan *vlan_spec = item->spec;
+	const struct rte_flow_item_vlan *vlan_mask = item->mask;
+	struct ixgbe_fdir_rule *rule = &fdir_ctx->rule;
+
+	rule->ixgbe_fdir.formatted.vlan_id = vlan_spec->hdr.vlan_tci;
+
+	rule->mask.vlan_tci_mask = vlan_mask->hdr.vlan_tci;
+	rule->mask.vlan_tci_mask &= IXGBE_FDIR_VLAN_TCI_MASK;
+
+	return 0;
+}
+
+const struct rte_flow_graph ixgbe_fdir_tunnel_graph = {
+	.nodes = (struct rte_flow_graph_node[]) {
+		[IXGBE_FDIR_TUNNEL_NODE_START] = {
+			.name = "START",
+		},
+		[IXGBE_FDIR_TUNNEL_NODE_OUTER_ETH] = {
+			.name = "OUTER_ETH",
+			.type = RTE_FLOW_ITEM_TYPE_ETH,
+			.constraints = RTE_FLOW_NODE_EXPECT_EMPTY,
+		},
+		[IXGBE_FDIR_TUNNEL_NODE_OUTER_IPV4] = {
+			.name = "OUTER_IPV4",
+			.type = RTE_FLOW_ITEM_TYPE_IPV4,
+			.constraints = RTE_FLOW_NODE_EXPECT_EMPTY,
+		},
+		[IXGBE_FDIR_TUNNEL_NODE_OUTER_IPV6] = {
+			.name = "OUTER_IPV6",
+			.type = RTE_FLOW_ITEM_TYPE_IPV6,
+			.constraints = RTE_FLOW_NODE_EXPECT_EMPTY,
+		},
+		[IXGBE_FDIR_TUNNEL_NODE_UDP] = {
+			.name = "UDP",
+			.type = RTE_FLOW_ITEM_TYPE_UDP,
+			.constraints = RTE_FLOW_NODE_EXPECT_EMPTY,
+		},
+		[IXGBE_FDIR_TUNNEL_NODE_VXLAN] = {
+			.name = "VXLAN",
+			.type = RTE_FLOW_ITEM_TYPE_VXLAN,
+			.validate = ixgbe_validate_fdir_tunnel_vxlan,
+			.process = ixgbe_process_fdir_tunnel_vxlan,
+			.constraints = RTE_FLOW_NODE_EXPECT_MASK |
+				RTE_FLOW_NODE_EXPECT_SPEC_MASK,
+		},
+		[IXGBE_FDIR_TUNNEL_NODE_NVGRE] = {
+			.name = "NVGRE",
+			.type = RTE_FLOW_ITEM_TYPE_NVGRE,
+			.validate = ixgbe_validate_fdir_tunnel_nvgre,
+			.process = ixgbe_process_fdir_tunnel_nvgre,
+			.constraints = RTE_FLOW_NODE_EXPECT_MASK |
+				RTE_FLOW_NODE_EXPECT_SPEC_MASK,
+		},
+		[IXGBE_FDIR_TUNNEL_NODE_INNER_ETH] = {
+			.name = "INNER_ETH",
+			.type = RTE_FLOW_ITEM_TYPE_ETH,
+			.validate = ixgbe_validate_fdir_tunnel_inner_eth,
+			.process = ixgbe_process_fdir_tunnel_inner_eth,
+			.constraints = RTE_FLOW_NODE_EXPECT_MASK |
+				RTE_FLOW_NODE_EXPECT_SPEC_MASK,
+		},
+		[IXGBE_FDIR_TUNNEL_NODE_INNER_IPV4] = {
+			.name = "INNER_IPV4",
+			.type = RTE_FLOW_ITEM_TYPE_IPV4,
+			.constraints = RTE_FLOW_NODE_EXPECT_EMPTY,
+		},
+		[IXGBE_FDIR_TUNNEL_NODE_VLAN] = {
+			.name = "VLAN",
+			.type = RTE_FLOW_ITEM_TYPE_VLAN,
+			.process = ixgbe_process_fdir_tunnel_vlan,
+			.constraints = RTE_FLOW_NODE_EXPECT_SPEC_MASK,
+		},
+		[IXGBE_FDIR_TUNNEL_NODE_END] = {
+			.name = "END",
+			.type = RTE_FLOW_ITEM_TYPE_END,
+		},
+	},
+	.edges = (struct rte_flow_graph_edge[]) {
+		[IXGBE_FDIR_TUNNEL_NODE_START] = {
+			.next = (const size_t[]) {
+				IXGBE_FDIR_TUNNEL_NODE_OUTER_ETH,
+				IXGBE_FDIR_TUNNEL_NODE_OUTER_IPV4,
+				IXGBE_FDIR_TUNNEL_NODE_OUTER_IPV6,
+				IXGBE_FDIR_TUNNEL_NODE_UDP,
+				IXGBE_FDIR_TUNNEL_NODE_VXLAN,
+				IXGBE_FDIR_TUNNEL_NODE_NVGRE,
+				RTE_FLOW_NODE_EDGE_END
+			}
+		},
+		[IXGBE_FDIR_TUNNEL_NODE_OUTER_ETH] = {
+			.next = (const size_t[]) {
+				IXGBE_FDIR_TUNNEL_NODE_OUTER_IPV4,
+				IXGBE_FDIR_TUNNEL_NODE_OUTER_IPV6,
+				RTE_FLOW_NODE_EDGE_END
+			}
+		},
+		[IXGBE_FDIR_TUNNEL_NODE_OUTER_IPV4] = {
+			.next = (const size_t[]) {
+				IXGBE_FDIR_TUNNEL_NODE_UDP,
+				IXGBE_FDIR_TUNNEL_NODE_NVGRE,
+				RTE_FLOW_NODE_EDGE_END
+			}
+		},
+		[IXGBE_FDIR_TUNNEL_NODE_OUTER_IPV6] = {
+			.next = (const size_t[]) {
+				IXGBE_FDIR_TUNNEL_NODE_UDP,
+				IXGBE_FDIR_TUNNEL_NODE_NVGRE,
+				RTE_FLOW_NODE_EDGE_END
+			}
+		},
+		[IXGBE_FDIR_TUNNEL_NODE_UDP] = {
+			.next = (const size_t[]) {
+				IXGBE_FDIR_TUNNEL_NODE_VXLAN,
+				RTE_FLOW_NODE_EDGE_END
+			}
+		},
+		[IXGBE_FDIR_TUNNEL_NODE_VXLAN] = {
+			.next = (const size_t[]) {
+				IXGBE_FDIR_TUNNEL_NODE_INNER_ETH,
+				RTE_FLOW_NODE_EDGE_END
+			}
+		},
+		[IXGBE_FDIR_TUNNEL_NODE_NVGRE] = {
+			.next = (const size_t[]) {
+				IXGBE_FDIR_TUNNEL_NODE_INNER_ETH,
+				RTE_FLOW_NODE_EDGE_END
+			}
+		},
+		[IXGBE_FDIR_TUNNEL_NODE_INNER_ETH] = {
+			.next = (const size_t[]) {
+				IXGBE_FDIR_TUNNEL_NODE_VLAN,
+				IXGBE_FDIR_TUNNEL_NODE_INNER_IPV4,
+				IXGBE_FDIR_TUNNEL_NODE_END,
+				RTE_FLOW_NODE_EDGE_END
+			}
+		},
+		[IXGBE_FDIR_TUNNEL_NODE_VLAN] = {
+			.next = (const size_t[]) {
+				IXGBE_FDIR_TUNNEL_NODE_END,
+				RTE_FLOW_NODE_EDGE_END
+			}
+		},
+	},
+};
+
+static int
+ixgbe_fdir_actions_check(const struct ci_flow_actions *parsed_actions,
+	const struct ci_flow_actions_check_param *param __rte_unused,
+	struct rte_flow_error *error)
+{
+	const enum rte_flow_action_type fwd_actions[] = {
+		RTE_FLOW_ACTION_TYPE_QUEUE,
+		RTE_FLOW_ACTION_TYPE_DROP,
+		RTE_FLOW_ACTION_TYPE_END
+	};
+	const struct rte_flow_action *action, *drop_action = NULL;
+
+	/* do the generic checks first */
+	int ret = ixgbe_flow_actions_check(parsed_actions, param, error);
+	if (ret)
+		return ret;
+
+	/* first action must be a forwarding action */
+	action = parsed_actions->actions[0];
+	if (!ci_flow_action_type_in_list(action->type, fwd_actions)) {
+		return rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_ACTION,
+					  action, "First action must be QUEUE or DROP");
+	}
+	/* remember if we have a drop action */
+	if (action->type == RTE_FLOW_ACTION_TYPE_DROP) {
+		drop_action = action;
+	}
+
+	/* second action, if specified, must not be a forwarding action */
+	action = parsed_actions->actions[1];
+	if (action != NULL && ci_flow_action_type_in_list(action->type, fwd_actions)) {
+		return rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_ACTION,
+					  action, "Conflicting actions");
+	}
+	/* if we didn't have a drop action before but now we do, remember that */
+	if (drop_action == NULL && action != NULL && action->type == RTE_FLOW_ACTION_TYPE_DROP) {
+		drop_action = action;
+	}
+	/* drop must be the only action */
+	if (drop_action != NULL && action != NULL) {
+		return rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_ACTION,
+					  action, "Conflicting actions");
+	}
+	return 0;
+}
+
+static int
+ixgbe_flow_fdir_ctx_validate(struct ci_flow_engine_ctx *ctx, struct rte_flow_error *error)
+{
+	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(ctx->dev->data->dev_private);
+	struct ixgbe_fdir_ctx *fdir_ctx = (struct ixgbe_fdir_ctx *)ctx;
+	struct rte_eth_fdir_conf *global_fdir_conf = IXGBE_DEV_FDIR_CONF(ctx->dev);
+
+	/* DROP action cannot be used with signature matches */
+	if ((fdir_ctx->rule.mode == RTE_FDIR_MODE_SIGNATURE) &&
+	    (fdir_ctx->fwd_action->type == RTE_FLOW_ACTION_TYPE_DROP)) {
+		return rte_flow_error_set(error, ENOTSUP,
+			RTE_FLOW_ERROR_TYPE_UNSPECIFIED, NULL,
+			"DROP action not supported with signature mode");
+	}
+
+	/* 82599 does not support port drop with port match */
+	if (hw->mac.type == ixgbe_mac_82599EB &&
+		fdir_ctx->fwd_action->type == RTE_FLOW_ACTION_TYPE_DROP &&
+		(fdir_ctx->rule.ixgbe_fdir.formatted.src_port != 0 ||
+		 fdir_ctx->rule.ixgbe_fdir.formatted.dst_port != 0)) {
+		return rte_flow_error_set(error, ENOTSUP,
+			RTE_FLOW_ERROR_TYPE_ACTION, fdir_ctx->fwd_action,
+			"82599 does not support drop action with port match.");
+	}
+
+	/* check for conflicting filter modes */
+	if (global_fdir_conf->mode != fdir_ctx->rule.mode) {
+		return rte_flow_error_set(error, ENOTSUP,
+			RTE_FLOW_ERROR_TYPE_UNSPECIFIED, NULL,
+			"Conflicting filter modes");
+	}
+
+	return 0;
+}
+
+static int
+ixgbe_flow_fdir_ctx_parse_common(const struct rte_flow_action *actions,
+		const struct rte_flow_attr *attr,
+		struct ci_flow_engine_ctx *ctx,
+		struct rte_flow_error *error)
+{
+	struct ixgbe_fdir_ctx *fdir_ctx = (struct ixgbe_fdir_ctx *)ctx;
+	struct ci_flow_actions parsed_actions;
+	struct ci_flow_actions_check_param ap_param = {
+		.allowed_types = (const enum rte_flow_action_type[]){
+			/* queue/mark/drop allowed here */
+			RTE_FLOW_ACTION_TYPE_QUEUE,
+			RTE_FLOW_ACTION_TYPE_DROP,
+			RTE_FLOW_ACTION_TYPE_MARK,
+			RTE_FLOW_ACTION_TYPE_END
+		},
+		.driver_ctx = ctx->dev,
+		.check = ixgbe_fdir_actions_check
+	};
+	struct ixgbe_fdir_rule *rule = &fdir_ctx->rule;
+	int ret;
+
+	/* validate attributes */
+	ret = ci_flow_check_attr(attr, NULL, error);
+	if (ret)
+		return ret;
+
+	/* parse requested actions */
+	ret = ci_flow_check_actions(actions, &ap_param, &parsed_actions, error);
+	if (ret)
+		return ret;
+
+	fdir_ctx->fwd_action = parsed_actions.actions[0];
+	/* can be NULL */
+	fdir_ctx->aux_action = parsed_actions.actions[1];
+
+	/* set up forward/drop action */
+	if (fdir_ctx->fwd_action->type == RTE_FLOW_ACTION_TYPE_QUEUE) {
+		const struct rte_flow_action_queue *q_act = fdir_ctx->fwd_action->conf;
+		rule->queue = q_act->index;
+	} else {
+		rule->fdirflags = IXGBE_FDIRCMD_DROP;
+	}
+
+	/* set up mark action */
+	if (fdir_ctx->aux_action != NULL && fdir_ctx->aux_action->type == RTE_FLOW_ACTION_TYPE_MARK) {
+		const struct rte_flow_action_mark *m_act = fdir_ctx->aux_action->conf;
+		rule->soft_id = m_act->id;
+	}
+
+	return ret;
+}
+
+static int
+ixgbe_flow_fdir_ctx_parse(const struct rte_flow_action *actions,
+		const struct rte_flow_attr *attr,
+		struct ci_flow_engine_ctx *ctx,
+		struct rte_flow_error *error)
+{
+	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(ctx->dev->data->dev_private);
+	struct ixgbe_fdir_ctx *fdir_ctx = (struct ixgbe_fdir_ctx *)ctx;
+	int ret;
+
+	/* call into common part first */
+	ret = ixgbe_flow_fdir_ctx_parse_common(actions, attr, ctx, error);
+	if (ret)
+		return ret;
+
+	/* some hardware does not support SCTP matching */
+	if (hw->mac.type == ixgbe_mac_X550 ||
+			hw->mac.type == ixgbe_mac_X550EM_x ||
+			hw->mac.type == ixgbe_mac_X550EM_a ||
+			hw->mac.type == ixgbe_mac_E610)
+		fdir_ctx->supports_sctp_ports = true;
+
+	/*
+	 * Some fields may not be provided. Set spec to 0 and mask to default
+	 * value. So, we need not do anything for the not provided fields later.
+	 */
+	memset(&fdir_ctx->rule.mask, 0xFF, sizeof(struct ixgbe_hw_fdir_mask));
+	fdir_ctx->rule.mask.vlan_tci_mask = 0;
+	fdir_ctx->rule.mask.flex_bytes_mask = 0;
+	fdir_ctx->rule.mask.dst_port_mask = 0;
+	fdir_ctx->rule.mask.src_port_mask = 0;
+
+	return 0;
+}
+
+static int
+ixgbe_flow_fdir_tunnel_ctx_parse(const struct rte_flow_action *actions,
+		const struct rte_flow_attr *attr,
+		struct ci_flow_engine_ctx *ctx,
+		struct rte_flow_error *error)
+{
+	struct ixgbe_fdir_ctx *fdir_ctx = (struct ixgbe_fdir_ctx *)ctx;
+	int ret;
+
+	/* call into common part first */
+	ret = ixgbe_flow_fdir_ctx_parse_common(actions, attr, ctx, error);
+	if (ret)
+		return ret;
+
+	/**
+	 * Some fields may not be provided. Set spec to 0 and mask to default
+	 * value. So, we need not do anything for the not provided fields later.
+	 */
+	memset(&fdir_ctx->rule.mask, 0xFF, sizeof(struct ixgbe_hw_fdir_mask));
+	fdir_ctx->rule.mask.vlan_tci_mask = 0;
+
+	fdir_ctx->rule.mode = RTE_FDIR_MODE_PERFECT_TUNNEL;
+
+	return 0;
+}
+
+static int
+ixgbe_flow_fdir_ctx_to_flow(const struct ci_flow_engine_ctx *ctx,
+		struct ci_flow *flow,
+		struct rte_flow_error *error __rte_unused)
+{
+	const struct ixgbe_fdir_ctx *fdir_ctx = (const struct ixgbe_fdir_ctx *)ctx;
+	struct ixgbe_fdir_flow *fdir_flow = (struct ixgbe_fdir_flow *)flow;
+
+	fdir_flow->rule = fdir_ctx->rule;
+
+	return 0;
+}
+
+/* 1 if needs mask install, 0 if doesn't, -1 if incompatible */
+static int
+ixgbe_flow_fdir_needs_mask_install(struct ixgbe_fdir_flow *fdir_flow)
+{
+	struct ixgbe_adapter *adapter = fdir_flow->flow.flow.dev->data->dev_private;
+	struct ixgbe_hw_fdir_info *global_fdir_info = IXGBE_DEV_PRIVATE_TO_FDIR_INFO(adapter);
+	struct ixgbe_fdir_rule *rule = &fdir_flow->rule;
+	int ret;
+
+	/* if rule doesn't have a mask, don't do anything */
+	if (rule->b_mask == 0)
+		return 0;
+
+	/* rule has a mask, check if global config doesn't */
+	if (!global_fdir_info->mask_added)
+		return 1;
+
+	/* global config has a mask, check if it matches */
+	ret = memcmp(&global_fdir_info->mask, &rule->mask, sizeof(rule->mask));
+	if (ret)
+		return -1;
+
+	/* does rule specify flex bytes mask? */
+	if (rule->mask.flex_bytes_mask == 0)
+		/* compatible */
+		return 0;
+
+	/* if flex bytes mask is set, check if offset matches */
+	if (global_fdir_info->flex_bytes_offset != rule->flex_bytes_offset)
+		return -1;
+
+	/* compatible */
+	return 0;
+}
+
+static int
+ixgbe_flow_fdir_install_mask(struct ixgbe_fdir_flow *fdir_flow, struct rte_flow_error *error)
+{
+	struct rte_eth_dev *dev = fdir_flow->flow.flow.dev;
+	struct ixgbe_adapter *adapter = dev->data->dev_private;
+	struct ixgbe_hw_fdir_info *global_fdir_info = IXGBE_DEV_PRIVATE_TO_FDIR_INFO(adapter);
+	struct ixgbe_fdir_rule *rule = &fdir_flow->rule;
+	int ret;
+
+	/* store mask */
+	global_fdir_info->mask = rule->mask;
+
+	/* do we need flex byte mask? */
+	if (rule->mask.flex_bytes_mask != 0) {
+		ret = ixgbe_fdir_set_flexbytes_offset(dev, rule->flex_bytes_offset);
+		if (ret != 0) {
+			return rte_flow_error_set(error, ret,
+				RTE_FLOW_ERROR_TYPE_UNSPECIFIED, NULL,
+				"Failed to set flex bytes offset");
+		}
+	}
+
+	/* set mask */
+	ret = ixgbe_fdir_set_input_mask(dev);
+	if (ret != 0) {
+		return rte_flow_error_set(error, ret,
+			RTE_FLOW_ERROR_TYPE_UNSPECIFIED, NULL,
+			"Failed to set input mask");
+	}
+
+	return 0;
+}
+
+static int
+ixgbe_flow_fdir_flow_install(struct ci_flow *flow,
+		struct rte_flow_error *error)
+{
+	struct rte_eth_dev *dev = flow->dev;
+	struct ixgbe_adapter *adapter = dev->data->dev_private;
+	struct rte_eth_fdir_conf *global_fdir_conf = IXGBE_DEV_FDIR_CONF(dev);
+	struct ixgbe_hw_fdir_info *global_fdir_info = IXGBE_DEV_PRIVATE_TO_FDIR_INFO(adapter);
+	struct ixgbe_fdir_flow *fdir_flow = (struct ixgbe_fdir_flow *)flow;
+	struct ixgbe_fdir_rule *rule = &fdir_flow->rule;
+	bool mask_installed = false;
+	int ret;
+
+	/* if flow director isn't configured, configure it */
+	if (global_fdir_conf->mode == RTE_FDIR_MODE_NONE) {
+		global_fdir_conf->mode = rule->mode;
+		ret = ixgbe_fdir_configure(dev);
+		if (ret) {
+			global_fdir_conf->mode = RTE_FDIR_MODE_NONE;
+
+			return rte_flow_error_set(error, ret,
+				RTE_FLOW_ERROR_TYPE_UNSPECIFIED, NULL,
+				"Failed to configure flow director");
+		}
+	}
+
+	/* check if we need to install the mask first */
+	ret = ixgbe_flow_fdir_needs_mask_install(fdir_flow);
+	if (ret < 0) {
+		return rte_flow_error_set(error, EINVAL,
+			RTE_FLOW_ERROR_TYPE_UNSPECIFIED, NULL,
+			"Flow mask is incompatible with existing rules");
+	} else if (ret > 0) {
+		/* no mask yet, install it */
+		ret = ixgbe_flow_fdir_install_mask(fdir_flow, error);
+		if (ret != 0)
+			return ret;
+		mask_installed = true;
+	}
+
+	/* now install the rule */
+	if (rule->b_spec) {
+		ret = ixgbe_fdir_filter_program(dev, rule, FALSE, FALSE);
+		if (ret) {
+			return rte_flow_error_set(error, ret,
+				RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
+				NULL,
+				"Failed to program flow director filter");
+		}
+	}
+
+	/* if we installed a mask, mark it as installed */
+	if (mask_installed)
+		global_fdir_info->mask_added = TRUE;
+
+	return 0;
+}
+
+static int
+ixgbe_flow_fdir_flow_uninstall(struct ci_flow *flow,
+		struct rte_flow_error *error)
+{
+	struct rte_eth_dev *dev = flow->dev;
+	struct ixgbe_adapter *adapter = dev->data->dev_private;
+	struct rte_eth_fdir_conf *global_fdir_conf = IXGBE_DEV_FDIR_CONF(dev);
+	struct ixgbe_hw_fdir_info *global_fdir_info = IXGBE_DEV_PRIVATE_TO_FDIR_INFO(adapter);
+	struct ixgbe_fdir_flow *fdir_flow = (struct ixgbe_fdir_flow *)flow;
+	struct ixgbe_fdir_rule *rule = &fdir_flow->rule;
+	int ret;
+
+	/* uninstall the rule */
+	ret = ixgbe_fdir_filter_program(dev, rule, TRUE, FALSE);
+	if (ret != 0) {
+		return rte_flow_error_set(error, ret,
+			RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
+			NULL,
+			"Failed to remove flow director filter");
+	}
+
+	/* when last filter is removed, also remove the mask */
+	if (!TAILQ_EMPTY(&global_fdir_info->fdir_list))
+		return 0;
+
+	global_fdir_info->mask_added = FALSE;
+	global_fdir_info->mask = (struct ixgbe_hw_fdir_mask){0};
+	global_fdir_conf->mode = RTE_FDIR_MODE_NONE;
+
+	return 0;
+}
+
+static bool
+ixgbe_flow_fdir_is_available(const struct ci_flow_engine *engine __rte_unused,
+		const struct rte_eth_dev *dev)
+{
+	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
+
+	return hw->mac.type == ixgbe_mac_82599EB ||
+			hw->mac.type == ixgbe_mac_X540 ||
+			hw->mac.type == ixgbe_mac_X550 ||
+			hw->mac.type == ixgbe_mac_X550EM_x ||
+			hw->mac.type == ixgbe_mac_X550EM_a ||
+			hw->mac.type == ixgbe_mac_E610;
+}
+
+static bool
+ixgbe_flow_fdir_tunnel_is_available(const struct ci_flow_engine *engine __rte_unused,
+		const struct rte_eth_dev *dev)
+{
+	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
+
+	return hw->mac.type == ixgbe_mac_X550 ||
+			hw->mac.type == ixgbe_mac_X550EM_x ||
+			hw->mac.type == ixgbe_mac_X550EM_a ||
+			hw->mac.type == ixgbe_mac_E610;
+}
+
+const struct ci_flow_engine_ops ixgbe_fdir_ops = {
+	.is_available = ixgbe_flow_fdir_is_available,
+	.ctx_parse = ixgbe_flow_fdir_ctx_parse,
+	.ctx_validate = ixgbe_flow_fdir_ctx_validate,
+	.ctx_to_flow = ixgbe_flow_fdir_ctx_to_flow,
+	.flow_install = ixgbe_flow_fdir_flow_install,
+	.flow_uninstall = ixgbe_flow_fdir_flow_uninstall,
+};
+
+const struct ci_flow_engine_ops ixgbe_fdir_tunnel_ops = {
+	.is_available = ixgbe_flow_fdir_tunnel_is_available,
+	.ctx_parse = ixgbe_flow_fdir_tunnel_ctx_parse,
+	.ctx_validate = ixgbe_flow_fdir_ctx_validate,
+	.ctx_to_flow = ixgbe_flow_fdir_ctx_to_flow,
+	.flow_install = ixgbe_flow_fdir_flow_install,
+	.flow_uninstall = ixgbe_flow_fdir_flow_uninstall,
+};
+
+const struct ci_flow_engine ixgbe_fdir_flow_engine = {
+	.name = "ixgbe_fdir",
+	.ctx_size = sizeof(struct ixgbe_fdir_ctx),
+	.flow_size = sizeof(struct ixgbe_fdir_flow),
+	.type = IXGBE_FLOW_ENGINE_TYPE_FDIR,
+	.ops = &ixgbe_fdir_ops,
+	.graph = &ixgbe_fdir_normal_graph,
+};
+
+const struct ci_flow_engine ixgbe_fdir_tunnel_flow_engine = {
+	.name = "ixgbe_fdir_tunnel",
+	.ctx_size = sizeof(struct ixgbe_fdir_ctx),
+	.flow_size = sizeof(struct ixgbe_fdir_flow),
+	.type = IXGBE_FLOW_ENGINE_TYPE_FDIR_TUNNEL,
+	.ops = &ixgbe_fdir_tunnel_ops,
+	.graph = &ixgbe_fdir_tunnel_graph,
+};
diff --git a/drivers/net/intel/ixgbe/meson.build b/drivers/net/intel/ixgbe/meson.build
index 65ffe19939..770125350e 100644
--- a/drivers/net/intel/ixgbe/meson.build
+++ b/drivers/net/intel/ixgbe/meson.build
@@ -16,6 +16,7 @@ sources += files(
         'ixgbe_flow_l2tun.c',
         'ixgbe_flow_ntuple.c',
         'ixgbe_flow_security.c',
+        'ixgbe_flow_fdir.c',
         'ixgbe_ipsec.c',
         'ixgbe_pf.c',
         'ixgbe_rxtx.c',
-- 
2.47.3

