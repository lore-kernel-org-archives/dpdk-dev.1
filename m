Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0495C79F9F
	for <dpdk-dev@archiver.kernel.org>; Thu, 10 Sep 2026 08:02:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2529E427AD;
	Thu, 10 Sep 2026 10:02:23 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id BE9924028F
 for <dev@dpdk.org>; Thu, 10 Sep 2026 10:02:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789027341; x=1820563341;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=nNuzpeRm/Xu9HSCwX4OtclHFD+8SkyX9JLZAZ7NGW1s=;
 b=liQHtgqMJpJGyG7/yS0tsQtiGgz2K4uVYWO4yuQCk+57uRqcRGMFUUlC
 VlPy9vingA2P/nZoK1hT2IKjsBHh153ETrELO1wE467v2OBU7fgus/q02
 HVPrKngv/Czx1q971GTpGCMKrvKBq6J3O18f4aQxDzj8NFNKhetH+jsmD
 Ez45p4sZdq5hRt0RksDj3V5W01mL4BH0xATU0hh1odtqw7+fu1tAZzQAN
 Z5HZqGWL8iYQNxKY+qW1mfawcIq3Hyq6UrWwvBTgomRevoYKLOZa+lgwa
 hcdR0ul2tyFEnlB4A00Vzv90u/Nt8RPAwP0e12bDzO5RuJuJKNRNO8WRC w==;
X-CSE-ConnectionGUID: 4N3j5iiwSVS/Cm2teEbDfA==
X-CSE-MsgGUID: Q8JHugUoSx6jlPYE29dYYg==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="100989558"
X-IronPort-AV: E=Sophos;i="6.25,271,1779174000"; d="scan'208";a="100989558"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Sep 2026 01:02:21 -0700
X-CSE-ConnectionGUID: lgSc+I9mTqCZ8NT6/A37Fg==
X-CSE-MsgGUID: T5OIPu9wTU+Lm86pmXSDWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,271,1779174000"; d="scan'208";a="267272163"
Received: from unknown (HELO gnrd02..) ([10.190.212.69])
 by fmviesa006.fm.intel.com with ESMTP; 10 Sep 2026 01:02:18 -0700
From: Prudvi Deti <prudvi.deti@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Stephen Hemminger <stephen@networkplumber.org>, Ori Kam <orika@nvidia.com>,
 Aman Deep Singh <aman.deep.singh@intel.com>,
 Nirint Shah <nirint.shah@intel.com>, Prudvi Deti <prudvi.deti@intel.com>
Subject: [RFC v2 7/7] regex/hs: add Hyperscan compile flag support
Date: Thu, 10 Sep 2026 13:30:46 +0530
Message-ID: <20260910080136.1790851-8-prudvi.deti@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260910080136.1790851-1-prudvi.deti@intel.com>
References: <20260828053629.1224611-1-prudvi.deti@intel.com>
 <20260910080136.1790851-1-prudvi.deti@intel.com>
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
 doc/guides/regexdevs/hs.rst | 26 ++++++++++++++++++++-----
 drivers/regex/hs/hs_regex.c | 38 +++++++++++++++++++++++++++++++++----
 drivers/regex/hs/hs_regex.h | 23 ++++++++++++++++++----
 3 files changed, 74 insertions(+), 13 deletions(-)

diff --git a/doc/guides/regexdevs/hs.rst b/doc/guides/regexdevs/hs.rst
index b638ecc..b76296a 100644
--- a/doc/guides/regexdevs/hs.rst
+++ b/doc/guides/regexdevs/hs.rst
@@ -182,6 +182,16 @@ committed. Applications must not resubmit the original full array on
 partial failure — only correct the failed rule and resubmit it along
 with any remaining rules from the returned index onward.
 
+Calling ``rte_regexdev_start()`` is optional with this PMD:
+``enqueue_burst()`` auto-starts the device if a database has already
+been compiled or imported, so applications (such as
+``dpdk-test-regex``) that go straight from ``configure()``/
+``queue_pair_setup()`` to ``enqueue_burst()`` without an explicit
+``start()`` call still work correctly. Applications that intend to
+call ``start()`` explicitly should still do so before the first
+``enqueue_burst()`` call, since once the device auto-starts, a
+subsequent explicit ``start()`` call will fail with ``-EBUSY``.
+
 Statistics
 ~~~~~~~~~~
 
@@ -197,12 +207,18 @@ Limitations
   Hyperscan PMD and is not supported. DPDK requires ordering matches by rule
   ID, start offset, and match length, while Hyperscan without SOM reports only
   the match end offset.
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
 - Control-plane calls (``configure``, ``queue_pair_setup``,
diff --git a/drivers/regex/hs/hs_regex.c b/drivers/regex/hs/hs_regex.c
index 395cf84..05607c5 100644
--- a/drivers/regex/hs/hs_regex.c
+++ b/drivers/regex/hs/hs_regex.c
@@ -103,9 +103,11 @@ hs_regex_info_get(struct rte_regexdev *dev, struct rte_regexdev_info *info)
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
@@ -336,7 +338,12 @@ hs_regex_rule_db_update(struct rte_regexdev *dev,
 		RTE_REGEX_PCRE_RULE_DOTALL_F |
 		RTE_REGEX_PCRE_RULE_MULTILINE_F |
 		RTE_REGEX_PCRE_RULE_UCP_F |
-		RTE_REGEX_PCRE_RULE_UTF_F;
+		RTE_REGEX_PCRE_RULE_UTF_F |
+		HS_REGEX_RULE_SINGLEMATCH_F |
+		HS_REGEX_RULE_PREFILTER_F |
+		HS_REGEX_RULE_SOM_LEFTMOST_F |
+		HS_REGEX_RULE_COMBINATION_F |
+		HS_REGEX_RULE_QUIET_F;
 	uint64_t flag_bits;
 	uint64_t rf;
 	uint16_t i;
@@ -586,8 +593,22 @@ hs_regex_rule_db_compile_activate(struct rte_regexdev *dev)
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
@@ -1003,8 +1024,17 @@ hs_regex_enqueue_burst(struct rte_regexdev *dev, uint16_t qp_id,
 	}
 
 	if (unlikely(priv->dev_state != HS_REGEX_DEV_STARTED)) {
-		HS_LOG(ERR, "enqueue: device not started");
-		return 0;
+		/*
+		 * Auto-start if DB is ready (supports apps that skip
+		 * start, e.g. dpdk-test-regex; see hs.rst).
+		 */
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
index 07e737b..211d876 100644
--- a/drivers/regex/hs/hs_regex.h
+++ b/drivers/regex/hs/hs_regex.h
@@ -22,6 +22,18 @@
  * Hyperscan allocates memory proportional to this size).
  */
 #define HS_REGEX_MAX_RULE_DB_LEN (512U * 1024 * 1024)
+/* PMD-specific rule flags using bits 32+ to avoid overlap with DPDK flags. */
+
+/** Report at most one match per pattern per scan (maps to HS_FLAG_SINGLEMATCH). */
+#define HS_REGEX_RULE_SINGLEMATCH_F  (1ULL << 32)
+/** Treat pattern as a prefilter approximation (maps to HS_FLAG_PREFILTER). */
+#define HS_REGEX_RULE_PREFILTER_F    (1ULL << 33)
+/** Report leftmost start of match offset (maps to HS_FLAG_SOM_LEFTMOST). */
+#define HS_REGEX_RULE_SOM_LEFTMOST_F (1ULL << 34)
+/** Enable logical combination expressions (maps to HS_FLAG_COMBINATION). */
+#define HS_REGEX_RULE_COMBINATION_F  (1ULL << 35)
+/** Ignore match reporting for this pattern (maps to HS_FLAG_QUIET). */
+#define HS_REGEX_RULE_QUIET_F        (1ULL << 36)
 
 /* Ext params encoded in rule_flags bits 37-63 */
 #define HS_REGEX_EXT_MAX_OFFSET_SHIFT 37
@@ -31,10 +43,10 @@
 
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
@@ -56,6 +68,7 @@ struct hs_regex_qp {
 	uint16_t tail;
 	uint16_t count;
 	hs_scratch_t *scratch;
+	/* Per-QP counters exported via xstats. */
 	uint64_t qp_enqueued;
 	uint64_t qp_dequeued;
 	uint64_t qp_matches;
@@ -77,9 +90,11 @@ struct hs_regex_priv {
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

