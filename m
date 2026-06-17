Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1F05CD98E4
	for <dpdk-dev@archiver.kernel.org>; Wed, 17 Jun 2026 13:52:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B2D0F40670;
	Wed, 17 Jun 2026 15:52:08 +0200 (CEST)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com
 [209.85.218.53]) by mails.dpdk.org (Postfix) with ESMTP id F33B94027A
 for <dev@dpdk.org>; Wed, 17 Jun 2026 10:10:27 +0200 (CEST)
Received: by mail-ej1-f53.google.com with SMTP id
 a640c23a62f3a-beb2a97cc9aso1027466866b.2
 for <dev@dpdk.org>; Wed, 17 Jun 2026 01:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781683827; x=1782288627; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:reply-to:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=85UVIzi1eAxZaWPfdREL5ov9XXpIqIlyP9OhlRmPl+I=;
 b=MGM9uKxcMcuCdnCaFGblKAOnsOgrj66n8v1gQSPziaT/+q1Sx5fR7Dy/ugHkeD3vVi
 jmKCIMy3tTQspst+QHse/svtWubmByw4KZBknYcoqMAGAmSBDyf5wo1gGtNAmYWgtD5P
 +EYhrlRH/SHcf5m6RaJ0JmFWkJaphMrYyeHIThHh3woGJ7ENtzGIFYyR93sQX2aY7wzd
 33e2HYV8JQmnJIUUzPRwjXStoWVmo+jJ06QjTmZzr5cNgjPiLCR0MCFL7ReNcu1aJ5yH
 2h4FBtPUhCtLjf2UmjvQVvALkUAVKvS7V3soV6w0rSBTLQMWL1J6ivDyf3bh1FULQKQq
 m4wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781683827; x=1782288627;
 h=content-transfer-encoding:mime-version:reply-to:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=85UVIzi1eAxZaWPfdREL5ov9XXpIqIlyP9OhlRmPl+I=;
 b=jWfuP8L7S8dFmU74P2P0aP8gidJBG8Vu0A40/a6h2jUjGGODpA7h6c96iYFvn9oo3v
 wE5cgSPk4Rf7QfnlBC3DYnP3eoXOgcrTc1rEIiiY8r3AYR6uEe4eH5TAhQb9RrLVIqfv
 +rcv+XFRNyjW81ecDzQrZp5/IQkF8PSxQUtGYwKOG8mVdZS0kYTobkFpsHbiDxWw2yFB
 keqlhpfhFg+k/dhcVmPMp7rku7tTNH4qutgzcoHPhDOmmmriBwpOGhcGrm8vXSA2S/Vo
 4ldvkQhQIEER0Q+M/8IaX+24GyuI3ZQ08vBUx4UoFhbI1JiAhcyG4scgIkmsn3Lw6v6Q
 xq5w==
X-Gm-Message-State: AOJu0Yxxm3BuHNu+FZwixyGfXk2yXrPGqdeMWCrZIP/ORSPtFtHGbLOE
 zQcdJCl5F0Ec4O8mulE1tPFjYTmX65jSOIhSdPLwbWhpaFDAqRcxCzz5sqTWzEHn
X-Gm-Gg: AfdE7cnxkY8/7agNjhPVwI9aM0rSwofeFcIjoS4pY9mZi830s36hnpPV40t/kBplMEy
 YLYbp+RW7f1IGlWZ9PB+Ig25vtkRdP6vVJ52eePM7Jq62DWRZ8LjWlcGGYWzrAwk4cYehdEbju4
 69Tz72XdL/ODeOlpyLHMaPESbe12Tk4QNXJ3wE4WaufyEVeS0OpzpxALrTfpTde0mJc+HiSuQ9R
 z2om+YWUwKdTlIHh8NXCJMSKJTuu2xWW9tA3J+F/qMYq1REo2L/d4MhT3riXb0Hq4O0BcZTeLbl
 V1eI1PTg7i+JGv0MxLJricH9rv/IleO8MHRYyfBv1153E/QLhg46AzF/lZ2P+UQsAP5CtaEDiIv
 OMBW3MQmjG7EUY2QgAWW07HQ+c741az0f/NLzAkiOitn3viGgIK0yESzCdaf7b6LhausZy1ayEC
 T3UKT/wH19YNCM6hn0KLRqWdwddMH5SGKektOmsTTrSpbNEq9nWCUXh5KxnHELutWMU+YPLg==
X-Received: by 2002:a17:907:9617:b0:bed:7f50:c724 with SMTP id
 a640c23a62f3a-c05a7daa279mr172684566b.37.1781683827184; 
 Wed, 17 Jun 2026 01:10:27 -0700 (PDT)
Received: from mpeim-l-pw0j0p1n.cisco.com
 ([2001:420:44f5:1250:14a7:2a07:58ff:b5b4])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bfdb8b23f8fsm731847166b.53.2026.06.17.01.10.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 01:10:26 -0700 (PDT)
From: Maxime Peim <maxime.peim@gmail.com>
To: dev@dpdk.org
Cc: david.marchand@redhat.com
Subject: [PATCH v2] eal: fix core_index for non-EAL registered threads
Date: Wed, 17 Jun 2026 10:09:49 +0200
Message-ID: <20260617080949.1658507-1-maxime.peim@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 17 Jun 2026 15:52:05 +0200
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
Reply-To: 20260422075414.2528455-1-maxime.peim@gmail.com
Errors-To: dev-bounces@dpdk.org

Threads registered via rte_thread_register() are assigned a valid
lcore_id by eal_lcore_non_eal_allocate(), but their core_index in
lcore_config is left at -1. This value was set during rte_eal_cpu_init()
for lcores with ROLE_OFF (undetected CPUs) and is never updated when the
lcore is later allocated to a non-EAL thread.

As a result, rte_lcore_index() returns -1 for registered non-EAL
threads. Libraries that use rte_lcore_index() to select per-lcore
caches fall back to a shared global path when it returns -1, causing
severe contention under concurrent access from multiple registered
threads.

A concrete example is the mlx5 indexed memory pool (mlx5_ipool), which
uses rte_lcore_index() in mlx5_ipool_malloc_cache() to select a per-core
cache slot. When core_index is -1, all registered threads are funneled
into a single shared slot protected by a spinlock. In testing with VPP
(which registers worker threads via rte_thread_register()), this caused
async flow rule insertion throughput to drop from ~6.4M rules/sec to
~1.2M rules/sec with 4 workers -- a 5x regression attributable entirely
to spinlock contention in the ipool allocator.

Fix by tracking currently allocated core_index values in a bitset and
assigning non-EAL threads the first free index. Keep the bitset in sync
when initial EAL lcores are configured, when EAL core-list parsing
remaps lcores, and when non-EAL registration fails or releases an lcore.

Fixes: 5c307ba2a5b1 ("eal: register non-EAL threads as lcores")
Signed-off-by: Maxime Peim <maxime.peim@gmail.com>
---
v2:
  - Track allocated core_index values with a bitset instead of deriving
    the next non-EAL index from lcore_count, avoiding duplicate indices
    after non-EAL lcore release.
  - Keep the bitset in sync when default EAL lcores are discovered, when
    EAL lcore options remap the active set, and when non-EAL lcore
    registration rolls back or releases an lcore.

 lib/eal/common/eal_common_lcore.c   | 19 ++++++++++++++++++-
 lib/eal/common/eal_common_options.c |  5 +++++
 lib/eal/common/eal_private.h        |  3 +++
 3 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/lib/eal/common/eal_common_lcore.c b/lib/eal/common/eal_common_lcore.c
index 39411f9370..b5f59a6380 100644
--- a/lib/eal/common/eal_common_lcore.c
+++ b/lib/eal/common/eal_common_lcore.c
@@ -6,8 +6,9 @@
 #include <stdlib.h>
 #include <string.h>
 
-#include <rte_common.h>
+#include <rte_bitset.h>
 #include <rte_branch_prediction.h>
+#include <rte_common.h>
 #include <rte_errno.h>
 #include <rte_lcore.h>
 #include <rte_log.h>
@@ -184,6 +185,9 @@ rte_eal_cpu_init(void)
 		/* By default, lcore 1:1 map to cpu id */
 		CPU_SET(lcore_id, &lcore_config[lcore_id].cpuset);
 
+		/* This is the first time we discover the lcores, so the bitset should be zeroed */
+		rte_bitset_set(config->core_indices, count);
+
 		/* By default, each detected core is enabled */
 		config->lcore_role[lcore_id] = ROLE_RTE;
 		lcore_config[lcore_id].core_role = ROLE_RTE;
@@ -373,11 +377,20 @@ eal_lcore_non_eal_allocate(void)
 	struct lcore_callback *callback;
 	struct lcore_callback *prev;
 	unsigned int lcore_id;
+	int core_index = -1;
 
 	rte_rwlock_write_lock(&lcore_lock);
+	core_index = rte_bitset_find_first_clear(cfg->core_indices, RTE_MAX_LCORE);
+	if (core_index == -1) {
+		EAL_LOG(DEBUG, "No core_index available.");
+		lcore_id = RTE_MAX_LCORE;
+		goto out;
+	}
 	for (lcore_id = 0; lcore_id < RTE_MAX_LCORE; lcore_id++) {
 		if (cfg->lcore_role[lcore_id] != ROLE_OFF)
 			continue;
+		rte_bitset_set(cfg->core_indices, core_index);
+		lcore_config[lcore_id].core_index = core_index;
 		cfg->lcore_role[lcore_id] = ROLE_NON_EAL;
 		cfg->lcore_count++;
 		break;
@@ -399,6 +412,8 @@ eal_lcore_non_eal_allocate(void)
 		}
 		EAL_LOG(DEBUG, "Initialization refused for lcore %u.",
 			lcore_id);
+		rte_bitset_clear(cfg->core_indices, lcore_config[lcore_id].core_index);
+		lcore_config[lcore_id].core_index = -1;
 		cfg->lcore_role[lcore_id] = ROLE_OFF;
 		cfg->lcore_count--;
 		lcore_id = RTE_MAX_LCORE;
@@ -420,6 +435,8 @@ eal_lcore_non_eal_release(unsigned int lcore_id)
 		goto out;
 	TAILQ_FOREACH(callback, &lcore_callbacks, next)
 		callback_uninit(callback, lcore_id);
+	rte_bitset_clear(cfg->core_indices, lcore_config[lcore_id].core_index);
+	lcore_config[lcore_id].core_index = -1;
 	cfg->lcore_role[lcore_id] = ROLE_OFF;
 	cfg->lcore_count--;
 out:
diff --git a/lib/eal/common/eal_common_options.c b/lib/eal/common/eal_common_options.c
index 290386dc63..8f35fb376d 100644
--- a/lib/eal/common/eal_common_options.c
+++ b/lib/eal/common/eal_common_options.c
@@ -891,6 +891,7 @@ eal_parse_service_coremask(const char *coremask)
 		if (coremask[i] != '0')
 			return -1;
 
+	rte_bitset_clear_all(cfg->core_indices, RTE_MAX_LCORE);
 	for (; idx < RTE_MAX_LCORE; idx++)
 		lcore_config[idx].core_index = -1;
 
@@ -917,6 +918,7 @@ update_lcore_config(const rte_cpuset_t *cpuset, bool remap, uint16_t remap_base)
 	int ret = 0;
 
 	/* set everything to disabled first, then set up values */
+	rte_bitset_clear_all(cfg->core_indices, RTE_MAX_LCORE);
 	for (i = 0; i < RTE_MAX_LCORE; i++) {
 		cfg->lcore_role[i] = ROLE_OFF;
 		lcore_config[i].core_index = -1;
@@ -946,6 +948,7 @@ update_lcore_config(const rte_cpuset_t *cpuset, bool remap, uint16_t remap_base)
 				continue;
 			}
 
+			rte_bitset_set(cfg->core_indices, count);
 			cfg->lcore_role[lcore_id] = ROLE_RTE;
 			lcore_config[lcore_id].core_index = count;
 			CPU_ZERO(&lcore_config[lcore_id].cpuset);
@@ -1368,6 +1371,7 @@ eal_parse_lcores(const char *lcores)
 	CPU_ZERO(&cpuset);
 
 	/* Reset lcore config */
+	rte_bitset_clear_all(cfg->core_indices, RTE_MAX_LCORE);
 	for (idx = 0; idx < RTE_MAX_LCORE; idx++) {
 		cfg->lcore_role[idx] = ROLE_OFF;
 		lcore_config[idx].core_index = -1;
@@ -1432,6 +1436,7 @@ eal_parse_lcores(const char *lcores)
 			set_count--;
 
 			if (cfg->lcore_role[idx] != ROLE_RTE) {
+				rte_bitset_set(cfg->core_indices, count);
 				lcore_config[idx].core_index = count;
 				cfg->lcore_role[idx] = ROLE_RTE;
 				count++;
diff --git a/lib/eal/common/eal_private.h b/lib/eal/common/eal_private.h
index e032dd10c9..2b7a4fddbc 100644
--- a/lib/eal/common/eal_private.h
+++ b/lib/eal/common/eal_private.h
@@ -11,6 +11,7 @@
 #include <sys/queue.h>
 
 #include <dev_driver.h>
+#include <rte_bitset.h>
 #include <rte_lcore.h>
 #include <rte_log.h>
 #include <rte_memory.h>
@@ -44,6 +45,8 @@ extern struct lcore_config lcore_config[RTE_MAX_LCORE];
  * The global RTE configuration structure.
  */
 struct rte_config {
+	RTE_BITSET_DECLARE(core_indices,
+			   RTE_MAX_LCORE); /**< bitset of currently allocated core_indices */
 	uint32_t main_lcore;         /**< Id of the main lcore */
 	uint32_t lcore_count;        /**< Number of available logical cores. */
 	uint32_t numa_node_count;    /**< Number of detected NUMA nodes. */
-- 
2.43.0
