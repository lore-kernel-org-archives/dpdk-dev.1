Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9056EE81BCB
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Feb 2026 14:14:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EDA1040666;
	Mon,  9 Feb 2026 15:14:07 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTP id 53DD24066D
 for <dev@dpdk.org>; Mon,  9 Feb 2026 15:14:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770646444; x=1802182444;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=XKUXtgQBHF6QaKPxcROMEX4InKrc7tliA6Oz/nitsRM=;
 b=Dr1l7hdZgnHT/wOqsNjUE6h/a426I1nsvaTYN9rME9Egtns+kC9koZ9l
 8DjES2LimEh5lIZZIqrBNBaLbIvmBR+M6j+MSYCKcuy23/GDmstovHmnB
 6BAycj18RAVFk7QWaIv47DCxBzEZ/Scv4fsWEKm5ADKcoo6nSRu34LDyl
 GqC3wkntqBen+DPleLjEDgyPeaALU9YhYT2qrCOWBM2zVej0RREgVqDTL
 iFzZ5aGFAaz+5cEl3nrodWCMZmNeWp6Eg8s8igMTmGu+fA9GmOeXgxuLK
 gEkzmRIwtY+ULb+vpSKUMcdx9dpjeOLdWUM4PeOBvVCw3a1fodZ75uH3e g==;
X-CSE-ConnectionGUID: zT19/ss8TPKJwkkXM3b64A==
X-CSE-MsgGUID: FrkhGfxIT86YCYzBXcunrQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11696"; a="71658488"
X-IronPort-AV: E=Sophos;i="6.21,282,1763452800"; d="scan'208";a="71658488"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Feb 2026 06:14:03 -0800
X-CSE-ConnectionGUID: +kiYsJatQfKitnqfbxu55Q==
X-CSE-MsgGUID: VUei6zFuTLOs4BK9LUjvQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,282,1763452800"; d="scan'208";a="242215994"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa002.jf.intel.com with ESMTP; 09 Feb 2026 06:14:03 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v1 06/12] net/i40e: make default RSS key global
Date: Mon,  9 Feb 2026 14:13:42 +0000
Message-ID: <593e5100dfba10c4b3d3a0737b7de025f1c54e0a.1770646012.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1770646012.git.anatoly.burakov@intel.com>
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

Currently, there are multiple places where we need a default RSS key, but
in each of those places we define it as a local variable. Make it global
constant, and adjust all callers to use the global constant. When dealing
with adminq, we cannot send down the constant because adminq commands do
not guarantee const-ness, so copy RSS key into a local buffer before
sending it down to hardware.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/i40e/i40e_ethdev.c | 22 ++++++++++------------
 drivers/net/intel/i40e/i40e_hash.c   | 23 +++++++++++++++++------
 drivers/net/intel/i40e/i40e_hash.h   |  3 +++
 3 files changed, 30 insertions(+), 18 deletions(-)

diff --git a/drivers/net/intel/i40e/i40e_ethdev.c b/drivers/net/intel/i40e/i40e_ethdev.c
index f327a3927f..770c78473e 100644
--- a/drivers/net/intel/i40e/i40e_ethdev.c
+++ b/drivers/net/intel/i40e/i40e_ethdev.c
@@ -9064,23 +9064,21 @@ i40e_pf_reset_rss_reta(struct i40e_pf *pf)
 int
 i40e_pf_reset_rss_key(struct i40e_pf *pf)
 {
-	const uint8_t key_len = (I40E_PFQF_HKEY_MAX_INDEX + 1) *
-			sizeof(uint32_t);
-	uint8_t *rss_key;
+	uint8_t key_buf[I40E_RSS_KEY_LEN];
+	const uint8_t *rss_key;
 
 	/* Reset key */
 	rss_key = pf->dev_data->dev_conf.rx_adv_conf.rss_conf.rss_key;
-	if (!rss_key ||
-	    pf->dev_data->dev_conf.rx_adv_conf.rss_conf.rss_key_len < key_len) {
-		static uint32_t rss_key_default[] = {0x6b793944,
-			0x23504cb5, 0x5bea75b6, 0x309f4f12, 0x3dc0a2b8,
-			0x024ddcdf, 0x339b8ca0, 0x4c4af64a, 0x34fac605,
-			0x55d85839, 0x3a58997d, 0x2ec938e1, 0x66031581};
+	if (!rss_key || pf->dev_data->dev_conf.rx_adv_conf.rss_conf.rss_key_len < sizeof(key_buf))
+		rss_key = i40e_rss_key_default;
 
-		rss_key = (uint8_t *)rss_key_default;
-	}
+	/*
+	 * adminq does not guarantee const-ness of RSS key once a command is sent down, so make a
+	 * local copy.
+	 */
+	memcpy(&key_buf, rss_key, sizeof(key_buf));
 
-	return i40e_set_rss_key(pf->main_vsi, rss_key, key_len);
+	return i40e_set_rss_key(pf->main_vsi, key_buf, sizeof(key_buf));
 }
 
 static int
diff --git a/drivers/net/intel/i40e/i40e_hash.c b/drivers/net/intel/i40e/i40e_hash.c
index 3149682197..f20b40e7d0 100644
--- a/drivers/net/intel/i40e/i40e_hash.c
+++ b/drivers/net/intel/i40e/i40e_hash.c
@@ -233,6 +233,22 @@ struct i40e_hash_match_pattern {
 					RTE_ETH_RSS_NONFRAG_IPV6_UDP | \
 					RTE_ETH_RSS_NONFRAG_IPV6_SCTP)
 
+const uint8_t i40e_rss_key_default[] = {
+	0x44, 0x39, 0x79, 0x6b,
+	0xb5, 0x4c, 0x50, 0x23,
+	0xb6, 0x75, 0xea, 0x5b,
+	0x12, 0x4f, 0x9f, 0x30,
+	0xb8, 0xa2, 0xc0, 0x3d,
+	0xdf, 0xdc, 0x4d, 0x02,
+	0xa0, 0x8c, 0x9b, 0x33,
+	0x4a, 0xf6, 0x4a, 0x4c,
+	0x05, 0xc6, 0xfa, 0x34,
+	0x39, 0x58, 0xd8, 0x55,
+	0x7d, 0x99, 0x58, 0x3a,
+	0xe1, 0x38, 0xc9, 0x2e,
+	0x81, 0x15, 0x03, 0x66
+};
+
 /* Current supported patterns and RSS types.
  * All items that have the same pattern types are together.
  */
@@ -910,17 +926,12 @@ i40e_hash_parse_key(const struct rte_flow_action_rss *rss_act,
 	const uint8_t *key = rss_act->key;
 
 	if (!key || rss_act->key_len != sizeof(rss_conf->key)) {
-		const uint32_t rss_key_default[] = {0x6b793944,
-			0x23504cb5, 0x5bea75b6, 0x309f4f12, 0x3dc0a2b8,
-			0x024ddcdf, 0x339b8ca0, 0x4c4af64a, 0x34fac605,
-			0x55d85839, 0x3a58997d, 0x2ec938e1, 0x66031581};
-
 		if (rss_act->key_len != sizeof(rss_conf->key))
 			PMD_DRV_LOG(WARNING,
 				    "RSS key length invalid, must be %u bytes, now set key to default",
 				    (uint32_t)sizeof(rss_conf->key));
 
-		memcpy(rss_conf->key, rss_key_default, sizeof(rss_conf->key));
+		memcpy(rss_conf->key, i40e_rss_key_default, sizeof(rss_conf->key));
 	} else {
 		memcpy(rss_conf->key, key, sizeof(rss_conf->key));
 	}
diff --git a/drivers/net/intel/i40e/i40e_hash.h b/drivers/net/intel/i40e/i40e_hash.h
index ff8c91c030..2513d84565 100644
--- a/drivers/net/intel/i40e/i40e_hash.h
+++ b/drivers/net/intel/i40e/i40e_hash.h
@@ -27,6 +27,9 @@ int i40e_hash_filter_destroy(struct i40e_pf *pf,
 			     const struct i40e_rss_filter *rss_filter);
 int i40e_hash_filter_flush(struct i40e_pf *pf);
 
+#define I40E_RSS_KEY_LEN ((I40E_PFQF_HKEY_MAX_INDEX + 1) * sizeof(uint32_t))
+extern const uint8_t i40e_rss_key_default[I40E_RSS_KEY_LEN];
+
 #ifdef __cplusplus
 }
 #endif
-- 
2.47.3

