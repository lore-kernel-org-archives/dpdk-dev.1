Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87B26CA1007
	for <dpdk-dev@archiver.kernel.org>; Tue,  2 Sep 2025 17:27:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5CBC04065B;
	Tue,  2 Sep 2025 19:27:24 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id 969B24042C
 for <dev@dpdk.org>; Tue,  2 Sep 2025 19:27:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756834042; x=1788370042;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=HHhaU/lrp6gtCMByKVGp3lfnDqWCEztLuvF0a4M9g3A=;
 b=DPFiKbFQPFl2/Q/Txk2sVtsNvQLf/cpT7Dp1JTuxGMpGbwfkXtTy5SVk
 jLxzwI0Ga+gljTHX3RdbuiNTePa9gdiSrISsf0+iI4Y/KbcFGS5VLz2cS
 eTFfRWWWVbEbHxz92vCynOBlWRZvNDrVcwG/sNCm3W7nUEaRrXtCtwykt
 PF8YbgZC2YMYxaSGTV2gIsSMCYOP9DPhT71nEIA7VVaMaryfYd2apphOb
 GvS0O+aEqH9+IvVzHgJA5rBY568PGVmyuMsO4U6JjT+nTlVIU75sH+VfP
 HQHv6cVAAQX5hVWUL3DNCuTrEVAmWtm682KvhyZ8MbN2DigPzdXg0nbdg g==;
X-CSE-ConnectionGUID: T4D1E7deSb2rEzqLp0RK+A==
X-CSE-MsgGUID: X+tKgo68Q+mg24KY7qEWrQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11541"; a="69731946"
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; d="scan'208";a="69731946"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2025 10:27:12 -0700
X-CSE-ConnectionGUID: /8bYQ+B+T1qoZyFImBmhlw==
X-CSE-MsgGUID: sL3RIVTRSc+JKT6/h4mo5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; d="scan'208";a="171229103"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by orviesa007.jf.intel.com with ESMTP; 02 Sep 2025 10:27:12 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v1 01/12] net/ice/base: add direction metadata
Date: Tue,  2 Sep 2025 18:26:51 +0100
Message-ID: <cd2a7623f02e88a0aff0200a41ad8f4de7543f57.1756833701.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1756833701.git.anatoly.burakov@intel.com>
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

From: Marcin Szycik <marcin.szycik@intel.com>

Currently it is possible to create a rule which might break Tx traffic,
because by default all switch rules apply to both Rx and Tx traffic. In
order to avoid situations where Tx traffic accidentally matches Rx rule,
always add direction metadata to all switch rules.

However, because we're adding a new piece of metadata to all rules, some
rules might get too big and be rejected because they were already maxing
out rule capacity. To avoid that, we will only add direction metadata to
rules that are big enough to store it, on the assumption that if a rule
is already big enough to max out the capacity, the rule is therefore so
hyper-specific that it is highly unlikely to match both Rx and Tx
traffic, and so the direction is implied by the fact that the rule is so
specific.

Signed-off-by: Marcin Szycik <marcin.szycik@intel.com>
Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/ice/base/ice_protocol_type.h |  1 +
 drivers/net/intel/ice/base/ice_switch.c        | 14 ++++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/drivers/net/intel/ice/base/ice_protocol_type.h b/drivers/net/intel/ice/base/ice_protocol_type.h
index de960d7d1b..789f0d7ca5 100644
--- a/drivers/net/intel/ice/base/ice_protocol_type.h
+++ b/drivers/net/intel/ice/base/ice_protocol_type.h
@@ -226,6 +226,7 @@ enum ice_prot_id {
 #define ICE_TUN_FLAG_MDID_OFF(word) \
 	(ICE_MDID_SIZE * (ICE_TUN_FLAG_MDID + (word)))
 #define ICE_TUN_FLAG_MASK 0xFF
+#define ICE_FROM_NETWORK_FLAG_MASK 0x8
 #define ICE_DIR_FLAG_MASK 0x10
 #define ICE_TUN_FLAG_IN_VLAN_MASK 0x80 /* VLAN inside tunneled header */
 #define ICE_TUN_FLAG_VLAN_MASK 0x01
diff --git a/drivers/net/intel/ice/base/ice_switch.c b/drivers/net/intel/ice/base/ice_switch.c
index 777fc88d01..54cc2e1c07 100644
--- a/drivers/net/intel/ice/base/ice_switch.c
+++ b/drivers/net/intel/ice/base/ice_switch.c
@@ -7925,6 +7925,20 @@ ice_add_special_words(struct ice_adv_rule_info *rinfo,
 	u16 mask;
 	u16 off;
 
+	/*
+	 * Failing to add direction metadata is not considered an error, because
+	 * the kinds of rules which would trigger this error are already so
+	 * highly specific that they're unlikely to match both Rx and Tx traffic
+	 * at the same time.
+	 */
+	if (lkup_exts->n_val_words < ICE_MAX_CHAIN_WORDS) {
+		u8 word = lkup_exts->n_val_words++;
+
+		lkup_exts->fv_words[word].prot_id = ICE_META_DATA_ID_HW;
+		lkup_exts->fv_words[word].off = ICE_TUN_FLAG_MDID_OFF(0);
+		lkup_exts->field_mask[word] = ICE_FROM_NETWORK_FLAG_MASK;
+	}
+
 	/* If this is a tunneled packet, then add recipe index to match the
 	 * tunnel bit in the packet metadata flags. If this is a tun_and_non_tun
 	 * packet, then add recipe index to match the direction bit in the flag.
-- 
2.47.3

