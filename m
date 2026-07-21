Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E8E7C44529
	for <dpdk-dev@archiver.kernel.org>; Tue, 21 Jul 2026 08:29:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 14DAB402A7;
	Tue, 21 Jul 2026 10:29:00 +0200 (CEST)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com
 [209.85.208.46]) by mails.dpdk.org (Postfix) with ESMTP id D389440289
 for <dev@dpdk.org>; Tue, 21 Jul 2026 10:17:48 +0200 (CEST)
Received: by mail-ed1-f46.google.com with SMTP id
 4fb4d7f45d1cf-69c7c8accffso160690a12.2
 for <dev@dpdk.org>; Tue, 21 Jul 2026 01:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784621868; x=1785226668; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:reply-to:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=/+uA/io7yBsxKBMPg0v3m2js0g2K+FnMvz2mIgdKyz8=;
 b=FbHPyjlzk/N6ADox0WLVnKAVzKxIdnPf48jqcb8hdPO+6UGNCo8w6vVu7vExtNE97K
 XW8pbrpcYGr2Ir0YXT1s7AUHP01J219KMAUx52azHQCCXtIvqLQOCi4Zn41vsIksa5fa
 MjSOE47Cb6RKA0fdISsymDWt753RS5QSmbv6hhfZY7ogrH43Zgy38X6GNpBb5lN958tD
 3NdD5NKWWdNokeG3AY5THUtmQImvIx4e7S5Marazm8Z7mhP4wck6sm3o4qwkDqE62/7M
 s+UpAbxiIN083LgHQ+NgeoWSP2Q36YtOGyyRZgrnHmVAc+vehFIz9W8w9wmYIq/rn7/X
 uHxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784621868; x=1785226668;
 h=content-transfer-encoding:mime-version:reply-to:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/+uA/io7yBsxKBMPg0v3m2js0g2K+FnMvz2mIgdKyz8=;
 b=CPfWxOwGUr3g67jE5LLe3e31yVg6TsWoWp5a1ohA8ENf0IqbGZiRkOMd3tOiqt08LG
 iWPArlhPCB8pfP3tT9x0viYpYrHGxNGi9MxHXNfyd0nalO+eFm5ivfUmvece1eIm0oqM
 2cImigA49668+fkyHvD3L5d2GHt01lu2TQx/Irv3oM+tTP3wvo0WUOTXW1t/uB8snNbn
 kaFYWtdkCdV0NO/4YLA1bBffXr2Vhjc9R60D2qQp7yLdDDKYErZdqLr2zr0Av2tPOJhG
 sj1IBNEf2SI8ShCzmTtIl9/17cW8KoSU1AVQmAySwUKoh6jUZlhiE1i/jIFmSdrgQEzT
 e2yA==
X-Gm-Message-State: AOJu0YzhT7+tYdd/yt7ZWuUR9BMlw2SP3dZVph+lYG5vZwMo8lq2p1VI
 ryetOxjtMNpvqco18shn6ZztKG/9YkTB+9jSI1xvGvZA4CHS+n8dyrTZn+LxwhbC
X-Gm-Gg: AR+sD10VydJAGx3xmmWQgeY/rQBk7ghFMLBlWDPkHlZGhdmOwMyb+D3KUHjvLefichV
 /UNwbvyI5rsEYEqjftdwyJEBF1YllapFpKvY9/M6x+O6gVPcQu1q+y6ddkzJ01VwyRA2Lv1PjqN
 10HgpRfK+yaebOjeAOxE0yNHG8SQr8/UO46Ozv20PBEGKfsexc7XF5rHVpslbJNVHUGGalF30MI
 VPOpT1YRgYCcIXXbGnqVyyXRzrplkzVyVA3bSULHiI+Mp9Q5kUxkgBQBh9NMcsd6yyzi+qMMZxG
 C06lgKKHqrnxfZRA4YOJBhnoP5d/E4/LV5I8ULcIPNs52dXYYR/SDPY+crHi1lmXUTn8CJP9iOj
 Iw9lCPOunJ0gFdWoTN5SVR+0LXiKBzc0W9+QExAnlLh1hu/WVRXg+GPd2oQyiM37MOtJhlI8xGB
 fCGjXJxUxReK5DGI/i3QS2QH0Fl7motywNaBqnVmKNPPosfoQ1UsyH3TnwHrhDX9E/N+aK8Q==
X-Received: by 2002:a05:6402:a50b:10b0:69e:9b48:f3db with SMTP id
 4fb4d7f45d1cf-69e9b490116mr2843239a12.29.1784621868109; 
 Tue, 21 Jul 2026 01:17:48 -0700 (PDT)
Received: from mpeim-l-pw0j0p1n.cisco.com
 ([2001:420:44f5:1250:14a7:2a07:58ff:b5b4])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-69e7000c3e2sm5542910a12.30.2026.07.21.01.17.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 01:17:47 -0700 (PDT)
From: Maxime Peim <maxime.peim@gmail.com>
To: dev@dpdk.org
Cc: david.marchand@redhat.com
Subject: [PATCH v3] eal: fix core_index for non-EAL registered threads
Date: Tue, 21 Jul 2026 10:13:10 +0200
Message-ID: <20260721081310.2542794-1-maxime.peim@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 21 Jul 2026 10:28:58 +0200
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
Reply-To: 20260617080949.1658507-1-maxime.peim@gmail.com
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

Fix by setting core_index to the next sequential index (cfg->lcore_count)
in eal_lcore_non_eal_allocate() before incrementing the count. Also reset
core_index back to -1 on the error rollback path and in
eal_lcore_non_eal_release() for correctness.

Fixes: 5c307ba2a5 ("eal: register non-EAL threads as lcores")
Fixes: 99c05ce5ef ("eal: parse coremask as cpuset")
Signed-off-by: Maxime Peim <maxime.peim@gmail.com>
---
v2:
  - Track allocated core_index values with a bitset instead of deriving
    the next non-EAL index from lcore_count, avoiding duplicate indices
    after non-EAL lcore release.
  - Keep the bitset in sync when default EAL lcores are discovered, when
    EAL lcore options remap the active set, and when non-EAL lcore
    registration rolls back or releases an lcore.
v3:
  - Fix commit message to track also 99c05ce5ef

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
index 1049838d73..42cdef632f 100644
--- a/lib/eal/common/eal_common_options.c
+++ b/lib/eal/common/eal_common_options.c
@@ -911,6 +911,7 @@ eal_parse_service_coremask(const char *coremask)
 		if (coremask[i] != '0')
 			return -1;

+	rte_bitset_clear_all(cfg->core_indices, RTE_MAX_LCORE);
 	for (; idx < RTE_MAX_LCORE; idx++)
 		lcore_config[idx].core_index = -1;

@@ -937,6 +938,7 @@ update_lcore_config(const rte_cpuset_t *cpuset, bool remap, uint16_t remap_base)
 	int ret = 0;

 	/* set everything to disabled first, then set up values */
+	rte_bitset_clear_all(cfg->core_indices, RTE_MAX_LCORE);
 	for (i = 0; i < RTE_MAX_LCORE; i++) {
 		cfg->lcore_role[i] = ROLE_OFF;
 		lcore_config[i].core_index = -1;
@@ -966,6 +968,7 @@ update_lcore_config(const rte_cpuset_t *cpuset, bool remap, uint16_t remap_base)
 				continue;
 			}

+			rte_bitset_set(cfg->core_indices, count);
 			cfg->lcore_role[lcore_id] = ROLE_RTE;
 			lcore_config[lcore_id].core_index = count;
 			CPU_ZERO(&lcore_config[lcore_id].cpuset);
@@ -1388,6 +1391,7 @@ eal_parse_lcores(const char *lcores)
 	CPU_ZERO(&cpuset);

 	/* Reset lcore config */
+	rte_bitset_clear_all(cfg->core_indices, RTE_MAX_LCORE);
 	for (idx = 0; idx < RTE_MAX_LCORE; idx++) {
 		cfg->lcore_role[idx] = ROLE_OFF;
 		lcore_config[idx].core_index = -1;
@@ -1452,6 +1456,7 @@ eal_parse_lcores(const char *lcores)
 			set_count--;

 			if (cfg->lcore_role[idx] != ROLE_RTE) {
+				rte_bitset_set(cfg->core_indices, count);
 				lcore_config[idx].core_index = count;
 				cfg->lcore_role[idx] = ROLE_RTE;
 				count++;
diff --git a/lib/eal/common/eal_private.h b/lib/eal/common/eal_private.h
index 0c0544beaf..6340bab8be 100644
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

