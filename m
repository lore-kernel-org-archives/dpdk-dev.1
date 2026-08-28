Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BF81C61DB9
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Aug 2026 05:37:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3D980402BB;
	Fri, 28 Aug 2026 07:37:27 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id 5911040695
 for <dev@dpdk.org>; Fri, 28 Aug 2026 07:37:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787895445; x=1819431445;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Pc6vCdCN3D08fYeaUKxpNL+6njhljQx3kjr+hQOwzfk=;
 b=CxGdomaDCnO8QwiDPIxtFy53jTNYhoY9Ddfbmgq+5uAh1n3C90xDF6LQ
 TL4Zv+JW0HDRPuAi1E9KQf5RauRhDA2UOkW4R/ZshgnkX0h5TXhxj/Sc6
 tGPu3fAS1Q2LCsRWc+oY9+hbHpr82ixoJeDRkdOLIVukhPLU4XNU1Ydii
 c0AsvFyEHZWSJeD5uCwLeqccMFap+lsQaBbI1hAuNee9VlbFBmyIsKICL
 F7T55nndlFNpXJa5uryZEcg8gLpMdpsUcXJTVgG+r3zoiKfCY7VgjgeLg
 feICv5Ej245M8vpHU6Tx+PJJB4c6mNAHKQfgeDOeqe5EnN6HW3HNizcr0 g==;
X-CSE-ConnectionGUID: tpZn/xXeS56mNjCEQwzJoQ==
X-CSE-MsgGUID: UCTsNtXZTQCBDeo6/VKO5Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11888"; a="88425737"
X-IronPort-AV: E=Sophos;i="6.25,248,1779174000"; d="scan'208";a="88425737"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Aug 2026 22:37:24 -0700
X-CSE-ConnectionGUID: XzGIU/n9TXiojgu/g3INZg==
X-CSE-MsgGUID: RliFYJ7FRLOdqVdRYNjR/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,248,1779174000"; d="scan'208";a="267477200"
Received: from unknown (HELO gnrd02..) ([10.190.212.69])
 by orviesa008.jf.intel.com with ESMTP; 27 Aug 2026 22:37:22 -0700
From: Prudvi Deti <prudvi.deti@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, orika@nvidia.com, nirint.shah@intel.com,
 prudvi.deti@intel.com
Subject: [RFC 7/7] regex/hs: add Hyperscan compile flag support
Date: Fri, 28 Aug 2026 11:05:56 +0530
Message-ID: <20260828053629.1224611-8-prudvi.deti@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260828053629.1224611-1-prudvi.deti@intel.com>
References: <20260828053629.1224611-1-prudvi.deti@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Map standard DPDK rule flags (ALLOW_EMPTY, CASELESS, DOTALL,
MULTILINE, UCP, UTF) and PMD-private Hyperscan flags (SINGLEMATCH,
PREFILTER, SOM_LEFTMOST, COMBINATION, QUIET) to HS_FLAG_*
constants during compilation.

Add flag validation in rule_db_update to reject unknown flag bits.
Update info_get to advertise all supported standard flags.

Signed-off-by: Prudvi Deti <prudvi.deti@intel.com>
---
 doc/guides/regexdevs/hs.rst | 16 ++++++++----
 drivers/regex/hs/hs_regex.c | 51 ++++++++++++++++++++++++++++++++++---
 drivers/regex/hs/hs_regex.h | 17 ++++++++++---
 3 files changed, 72 insertions(+), 12 deletions(-)

diff --git a/doc/guides/regexdevs/hs.rst b/doc/guides/regexdevs/hs.rst
index 9c5f666..de85667 100644
--- a/doc/guides/regexdevs/hs.rst
+++ b/doc/guides/regexdevs/hs.rst
@@ -135,12 +135,18 @@ All counters can be reset in bulk or selectively by stat id via
 Limitations
 -----------
 
-- Scanning is synchronous: ``enqueue_burst`` blocks until
-  ``hs_scan()`` completes for each operation.
 - Multi-segment mbufs are linearized (``rte_pktmbuf_linearize()``)
-  before scanning; linearization failure marks the op with
-  ``RTE_REGEX_OPS_RSP_RESOURCE_LIMIT_REACHED_F``.
-- Multi-process mode is not supported.
+  before scanning. If linearization fails (first mbuf buffer too
+  small for the full packet), the op is returned to the application
+  with ``RTE_REGEX_OPS_RSP_RESOURCE_LIMIT_REACHED_F`` and zero
+  matches. Applications scanning large payloads should allocate
+  mbufs with sufficient ``data_room_size``.
+- Multi-process mode is not supported. The PMD rejects secondary
+  processes at probe time. Hyperscan's compiled database and scratch
+  space are allocated in process-private memory and cannot be shared
+  across separate OS processes. Multi-lcore (multiple threads within
+  a single process) is fully supported — each lcore uses its own
+  queue pair with dedicated scratch space.
 - Each queue pair must be used by exactly one lcore
   (single-producer/single-consumer model).
 
diff --git a/drivers/regex/hs/hs_regex.c b/drivers/regex/hs/hs_regex.c
index b42f791..515370d 100644
--- a/drivers/regex/hs/hs_regex.c
+++ b/drivers/regex/hs/hs_regex.c
@@ -101,9 +101,11 @@ hs_regex_info_get(struct rte_regexdev *dev, struct rte_regexdev_info *info)
 	info->max_rules_per_group = HS_REGEX_MAX_RULES;
 	info->max_groups = HS_REGEX_MAX_GROUPS;
 	info->regexdev_capa = RTE_REGEXDEV_CAPA_RUNTIME_COMPILATION_F;
-	info->rule_flags = RTE_REGEX_PCRE_RULE_CASELESS_F |
+	info->rule_flags = RTE_REGEX_PCRE_RULE_ALLOW_EMPTY_F |
+			   RTE_REGEX_PCRE_RULE_CASELESS_F |
 			   RTE_REGEX_PCRE_RULE_DOTALL_F |
 			   RTE_REGEX_PCRE_RULE_MULTILINE_F |
+			   RTE_REGEX_PCRE_RULE_UCP_F |
 			   RTE_REGEX_PCRE_RULE_UTF_F;
 
 	return 0;
@@ -296,6 +298,18 @@ hs_regex_rule_db_update(struct rte_regexdev *dev,
 			uint16_t nb_rules)
 {
 	struct hs_regex_priv *priv;
+	const uint64_t known_flags = RTE_REGEX_PCRE_RULE_ALLOW_EMPTY_F |
+		RTE_REGEX_PCRE_RULE_CASELESS_F |
+		RTE_REGEX_PCRE_RULE_DOTALL_F |
+		RTE_REGEX_PCRE_RULE_MULTILINE_F |
+		RTE_REGEX_PCRE_RULE_UCP_F |
+		RTE_REGEX_PCRE_RULE_UTF_F |
+		HS_REGEX_RULE_SINGLEMATCH_F |
+		HS_REGEX_RULE_PREFILTER_F |
+		HS_REGEX_RULE_SOM_LEFTMOST_F |
+		HS_REGEX_RULE_COMBINATION_F |
+		HS_REGEX_RULE_QUIET_F;
+	uint64_t flag_bits;
 	uint64_t rf;
 	uint16_t i;
 
@@ -325,6 +339,17 @@ hs_regex_rule_db_update(struct rte_regexdev *dev,
 	}
 
 	for (i = 0; i < nb_rules; i++) {
+		flag_bits = rules[i].rule_flags &
+			((1ULL << HS_REGEX_EXT_MAX_OFFSET_SHIFT) - 1);
+
+		if (flag_bits & ~known_flags) {
+			HS_LOG(ERR, "Rule %u: unsupported flags 0x%" PRIx64,
+			       rules[i].rule_id,
+			       (uint64_t)(flag_bits & ~known_flags));
+			rte_errno = ENOTSUP;
+			return i;
+		}
+
 		if (rules[i].op == RTE_REGEX_RULE_OP_ADD) {
 			uint32_t idx;
 
@@ -493,8 +518,22 @@ hs_regex_rule_db_compile_activate(struct rte_regexdev *dev)
 			flags[i] |= HS_FLAG_DOTALL;
 		if (priv->rules[i].rule_flags & RTE_REGEX_PCRE_RULE_MULTILINE_F)
 			flags[i] |= HS_FLAG_MULTILINE;
+		if (priv->rules[i].rule_flags & HS_REGEX_RULE_SINGLEMATCH_F)
+			flags[i] |= HS_FLAG_SINGLEMATCH;
 		if (priv->rules[i].rule_flags & RTE_REGEX_PCRE_RULE_UTF_F)
 			flags[i] |= HS_FLAG_UTF8;
+		if (priv->rules[i].rule_flags & RTE_REGEX_PCRE_RULE_UCP_F)
+			flags[i] |= HS_FLAG_UCP;
+		if (priv->rules[i].rule_flags & HS_REGEX_RULE_PREFILTER_F)
+			flags[i] |= HS_FLAG_PREFILTER;
+		if (priv->rules[i].rule_flags & HS_REGEX_RULE_SOM_LEFTMOST_F)
+			flags[i] |= HS_FLAG_SOM_LEFTMOST;
+		if (priv->rules[i].rule_flags & HS_REGEX_RULE_COMBINATION_F)
+			flags[i] |= HS_FLAG_COMBINATION;
+		if (priv->rules[i].rule_flags & HS_REGEX_RULE_QUIET_F)
+			flags[i] |= HS_FLAG_QUIET;
+		if (priv->rules[i].rule_flags & RTE_REGEX_PCRE_RULE_ALLOW_EMPTY_F)
+			flags[i] |= HS_FLAG_ALLOWEMPTY;
 
 		/* Extended parameters */
 		ext[i].flags = 0;
@@ -886,8 +925,14 @@ hs_regex_enqueue_burst(struct rte_regexdev *dev, uint16_t qp_id,
 	}
 
 	if (unlikely(priv->dev_state != HS_REGEX_DEV_STARTED)) {
-		HS_LOG(ERR, "enqueue: device not started");
-		return 0;
+		/* Auto-start if DB is ready (supports apps that skip start). */
+		if (priv->db_compiled) {
+			priv->dev_state = HS_REGEX_DEV_STARTED;
+			HS_LOG(NOTICE, "enqueue: auto-started device");
+		} else {
+			HS_LOG(ERR, "enqueue: device not started and no DB");
+			return 0;
+		}
 	}
 
 	if (unlikely(priv->db == NULL)) {
diff --git a/drivers/regex/hs/hs_regex.h b/drivers/regex/hs/hs_regex.h
index ddd6d9b..2641482 100644
--- a/drivers/regex/hs/hs_regex.h
+++ b/drivers/regex/hs/hs_regex.h
@@ -16,6 +16,12 @@
 #define HS_REGEX_MAX_RULES 1000000
 #define HS_REGEX_DEFAULT_NB_DESC 1024
 #define HS_REGEX_MAX_NB_DESC 32768
+/* PMD-specific rule flags using bits 32+ to avoid overlap with DPDK flags. */
+#define HS_REGEX_RULE_SINGLEMATCH_F  (1ULL << 32)
+#define HS_REGEX_RULE_PREFILTER_F    (1ULL << 33)
+#define HS_REGEX_RULE_SOM_LEFTMOST_F (1ULL << 34)
+#define HS_REGEX_RULE_COMBINATION_F  (1ULL << 35)
+#define HS_REGEX_RULE_QUIET_F        (1ULL << 36)
 
 /* Ext params encoded in rule_flags bits 37-63 */
 #define HS_REGEX_EXT_MAX_OFFSET_SHIFT 37
@@ -25,10 +31,10 @@
 
 /* Device lifecycle state machine. */
 enum hs_regex_dev_state {
-	HS_REGEX_DEV_CREATED = 0,
-	HS_REGEX_DEV_CONFIGURED,
-	HS_REGEX_DEV_STARTED,
-	HS_REGEX_DEV_STOPPED,
+	HS_REGEX_DEV_CREATED = 0,   /* after dev_create, before configure */
+	HS_REGEX_DEV_CONFIGURED,    /* after configure */
+	HS_REGEX_DEV_STARTED,       /* after start */
+	HS_REGEX_DEV_STOPPED,       /* after stop (can restart) */
 };
 
 /* Per-rule entry stored before compilation */
@@ -50,6 +56,7 @@ struct hs_regex_qp {
 	uint16_t tail;
 	uint16_t count;
 	hs_scratch_t *scratch;
+	/* Per-QP counters exported via xstats. */
 	uint64_t qp_enqueued;
 	uint64_t qp_dequeued;
 	uint64_t qp_matches;
@@ -71,9 +78,11 @@ struct hs_regex_priv {
 	uint16_t max_matches;
 	uint16_t nb_groups;
 
+	/* Lifecycle state used to validate configure/start/stop. */
 	enum hs_regex_dev_state dev_state;
 };
 
+/* Device lifecycle */
 int hs_regex_dev_create(const char *name, struct rte_device *device);
 void hs_regex_dev_destroy(const char *name);
 
-- 
2.43.0

