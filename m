Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8DCFCA5FF5
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 Oct 2026 20:25:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 38BFA40E0B;
	Mon,  5 Oct 2026 22:25:28 +0200 (CEST)
Received: from mail-pj1-f97.google.com (mail-pj1-f97.google.com
 [209.85.216.97]) by mails.dpdk.org (Postfix) with ESMTP id 501D0402DD
 for <dev@dpdk.org>; Mon,  5 Oct 2026 22:25:26 +0200 (CEST)
Received: by mail-pj1-f97.google.com with SMTP id
 98e67ed59e1d1-3a7d9d9b67bso136554a91.2
 for <dev@dpdk.org>; Mon, 05 Oct 2026 13:25:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791231925; x=1791836725;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=I0uWASKrhdLtR45kl0Qm48BfAmbkF9nGvXZAmn0KCkQ=;
 b=Xzsj8MJleWhRp0j0IjWakEpzWRD+EqeVWt44HUfcE39NMnw+2rjD7O7BUr6aZLixey
 xMLrEaYXqLLwe5kOkchJ0wXSmQuu+fIHQwyRuFY5N4Z80Nxs16UBy9uFQT1ggJ6BI+SY
 S2tM/cWVBKtfFALvyXZm1qevIrZsv+FvYUR1+LvERNyfWbzIqQaG7kU1WN6ZVsvtlDk0
 n2P8OV+zBCA+D/gKFM1jHVD+xtggtIlY7ISLikN++FzcGa+MmEZrKW20WTxLI4qP0hFM
 UvUiL666XI9LeW4e3dB+dXvewmhLtIIjtbw4VhOm5z5IVjfASmD27P3kfwnnWuSgXk1U
 xXOQ==
X-Gm-Message-State: AFq9FYIdcRDCqp/pJFPeo/UK95v/dkL0CLkBYKZlmf6fb+A8UDZN83vW
 nUZPJbdo6NFmMFTJYI6mP4vnV3FIrH0D+lEwDZw3sZoXWsT1VIT3eakO2GelfPWNtiL1qpW2qqg
 t/ghPsNAkqSgxQflWadEvUN8G+JiWzB06WnYHG4mgHvvwTV/FGIKykeRLASbBsqlz1RpuaHEDDf
 0FSRht9se+hiMqIgcpgbkYL9n6bnpW4XefH70Kxk5pAwuAVKAxk4kBvuaz4/0BRR+aTkPk8g==
X-Gm-Gg: AYBFou1a+hUzdTOlJnS0iVkZy4U3YdKKFxMFwFTfThst+3LNdeGbYyAGLlBwPyK8y8M
 wRMkrp14frkk4WdtgIuUk92XIXiF/gw06IGSnnOEPS/Ll7VIkGSFwSN91w78YIu08NMe72r1H4f
 sWryiiHwiPkvoy8lIosV6cEp1fbU+eCxbn8HQqM+GCQuXWyKuOYJ5i+LiUnIjG0OwzzvrGARAfw
 kHibQg/BqnDOi0+BuETbm4RcG4x2ZF3QxuibL77NN7xZOFzYx2t0AXfOIfsCheQhv0CRxdgK6QR
 hQqSbbdgPS4rBPjPK8JfdOON/W9u6pB1MMSp69MCd73LDLvJZ998GYpCJcAvAuFGnOe9ekrlZjo
 abP2R7DOZEcRdqoIeAxmsbF0lS1+a/hFUabf6ZiSznLMob6o1uTQvaOiDfRobhWlNseYhWkBohi
 YKdQBzBHbvlPBkYwgizUYZ7hjE+PEFEZh+kVM=
X-Received: by 2002:a17:90b:288d:b0:3a8:1ffc:391b with SMTP id
 98e67ed59e1d1-3a81ffc3b58mr1272525a91.43.1791231924897; 
 Mon, 05 Oct 2026 13:25:24 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-25.dlp.protect.broadcom.com. [144.49.247.25])
 by smtp-relay.gmail.com with ESMTPS id
 98e67ed59e1d1-3a85437d4c3sm300555a91.7.2026.10.05.13.25.24
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 05 Oct 2026 13:25:24 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-534f3fe0236so38702931cf.2
 for <dev@dpdk.org>; Mon, 05 Oct 2026 13:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1791231923; x=1791836723; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=I0uWASKrhdLtR45kl0Qm48BfAmbkF9nGvXZAmn0KCkQ=;
 b=H63Y4no85h8M5FBCv0GQmyZArI2+Jt55HySZchIz+qbmVIfzKV4+gr7PFBduSj77GI
 ruHS2jrGTGeXX6hZmFP5cW2VmTneCqumnR4r+jm0yiA8qtfyUhnd1SCmnlDC6KeHFURU
 6QhmaVig/XaIigx/t9fFCTCriUXgVmLJ8sOLc=
X-Received: by 2002:a05:622a:44c:b0:535:33a0:520c with SMTP id
 d75a77b69052e-53533a06c62mr59327501cf.3.1791231923350; 
 Mon, 05 Oct 2026 13:25:23 -0700 (PDT)
X-Received: by 2002:a05:622a:44c:b0:535:33a0:520c with SMTP id
 d75a77b69052e-53533a06c62mr59326241cf.3.1791231921641; 
 Mon, 05 Oct 2026 13:25:21 -0700 (PDT)
Received: from r740-105-132.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5353d622a55sm8712831cf.23.2026.10.05.13.25.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 13:25:21 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com,
	stable@dpdk.org
Subject: [PATCH] net/bnxt: fix hash seeding and hot-upgrade lock handling
Date: Mon,  5 Oct 2026 15:25:19 -0500
Message-Id: <20261005202519.17873-1-manish.kurup@broadcom.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
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

From: Kishore Padmanabha <kishore.padmanabha@broadcom.com>

Seed the CRC32 hash used for TruFlow flow-offload table lookups
with a per-table random value instead of computing an unkeyed
CRC32 directly. An unkeyed hash lets an attacker who can influence
flow-key contents craft inputs that collide in the same bucket,
degrading flow insertion into worst-case behavior.

Also track whether the ULP context lock was actually acquired
during hot-upgrade failover cleanup, and only release it if so,
instead of releasing unconditionally on every cleanup path. Releasing
a lock that was never acquired corrupts the lock state and can lead
to a use-after-free on a later acquire.

Fixes: b14da6540294 ("net/bnxt/tf_ulp: use optimized CRC32 hash")
Fixes: eeefaecba000 ("net/bnxt/tf_ulp: support hot upgrade")
Cc: stable@dpdk.org

Signed-off-by: Kishore Padmanabha <kishore.padmanabha@broadcom.com>
Signed-off-by: Manish Kurup <manish.kurup@broadcom.com>
---
 drivers/net/bnxt/tf_ulp/ulp_gen_hash.c   | 22 +++++++++++++++-------
 drivers/net/bnxt/tf_ulp/ulp_gen_hash.h   |  6 ++++++
 drivers/net/bnxt/tf_ulp/ulp_tfc_ha_mgr.c |  5 ++++-
 3 files changed, 25 insertions(+), 8 deletions(-)

diff --git a/drivers/net/bnxt/tf_ulp/ulp_gen_hash.c b/drivers/net/bnxt/tf_ulp/ulp_gen_hash.c
index 74cdd5c1da..215c8f39f8 100644
--- a/drivers/net/bnxt/tf_ulp/ulp_gen_hash.c
+++ b/drivers/net/bnxt/tf_ulp/ulp_gen_hash.c
@@ -6,6 +6,7 @@
 #include <rte_bitops.h>
 #include <rte_log.h>
 #include <rte_malloc.h>
+#include <rte_random.h>
 #include <rte_hash_crc.h>
 
 #include "bnxt_tf_common.h"
@@ -98,6 +99,12 @@ ulp_gen_hash_tbl_list_init(struct ulp_hash_create_params *cparams,
 		return -ENOMEM;
 	}
 	*hash_table = hash_tbl;
+
+	/* Random per-table seed so the CRC hash cannot be predicted offline
+	 * from attacker-controlled flow match fields.
+	 */
+	hash_tbl->hash_seed = (uint32_t)rte_rand();
+
 	/* allocate the memory for the hash key table */
 	hash_tbl->num_key_entries = cparams->num_key_entries;
 	hash_tbl->key_tbl.data_size = cparams->key_size;
@@ -204,31 +211,32 @@ ulp_gen_hash_tbl_list_key_search(struct ulp_gen_hash_tbl *hash_tbl,
 		return -EINVAL;
 	}
 
-	/* calculate the hash */
+	/* calculate the hash, keyed with the table's random per-instance
+	 * seed so the bucket a key lands in cannot be predicted offline.
+	 */
 	switch (hash_tbl->key_tbl.data_size) {
 	case 1:
 		hash_id = rte_hash_crc_1byte(*entry->key_data,
-					     ~0U);
+					     hash_tbl->hash_seed);
 		break;
 	case 2:
 		hash_id = rte_hash_crc_2byte(*((uint16_t *)entry->key_data),
-					     ~0U);
+					     hash_tbl->hash_seed);
 		break;
 	case 4:
 		hash_id = rte_hash_crc_4byte(*((uint32_t *)entry->key_data),
-					     ~0U);
+					     hash_tbl->hash_seed);
 		break;
 	case 8:
 		hash_id = rte_hash_crc_8byte(*((uint64_t *)entry->key_data),
-					     ~0U);
+					     hash_tbl->hash_seed);
 		break;
 	default:
 		hash_id = rte_hash_crc(entry->key_data,
 				       hash_tbl->key_tbl.data_size,
-				       ~0U);
+				       hash_tbl->hash_seed);
 		break;
 	}
-	hash_id = (uint16_t)(((hash_id >> 16) & 0xffff) ^ (hash_id & 0xffff));
 	hash_id &= hash_tbl->hash_mask;
 	hash_id = hash_id * hash_tbl->hash_bkt_num;
 
diff --git a/drivers/net/bnxt/tf_ulp/ulp_gen_hash.h b/drivers/net/bnxt/tf_ulp/ulp_gen_hash.h
index d3f3840cbe..3aabea07ac 100644
--- a/drivers/net/bnxt/tf_ulp/ulp_gen_hash.h
+++ b/drivers/net/bnxt/tf_ulp/ulp_gen_hash.h
@@ -57,6 +57,12 @@ struct ulp_gen_hash_tbl {
 	uint32_t			hash_bkt_num;
 	struct ulp_hash_bucket_entry	*hash_list;
 	uint32_t			hash_mask;
+	/* Per-table random seed for the CRC hash, set at init time so the
+	 * bucket a given key lands in cannot be predicted/targeted offline
+	 * by an attacker who controls flow match fields (hash-flooding
+	 * mitigation).
+	 */
+	uint32_t			hash_seed;
 
 	/* Bit allocator - to allocate key_res index */
 	struct bit_alloc_list		bit_list;
diff --git a/drivers/net/bnxt/tf_ulp/ulp_tfc_ha_mgr.c b/drivers/net/bnxt/tf_ulp/ulp_tfc_ha_mgr.c
index be14b65804..694de307de 100644
--- a/drivers/net/bnxt/tf_ulp/ulp_tfc_ha_mgr.c
+++ b/drivers/net/bnxt/tf_ulp/ulp_tfc_ha_mgr.c
@@ -60,6 +60,7 @@ ulp_tfc_hot_upgrade_mgr_timer_cb(void *arg)
 	struct tfc *tfcp = NULL;
 	uint16_t fw_fid = 0;
 	int32_t rc = 0;
+	bool ctx_locked = false;
 
 	ulp_ctx = bnxt_ulp_cntxt_entry_acquire(arg);
 	if (ulp_ctx == NULL) {
@@ -67,6 +68,7 @@ ulp_tfc_hot_upgrade_mgr_timer_cb(void *arg)
 				  ulp_tfc_hot_upgrade_mgr_timer_cb, arg);
 		return;
 	}
+	ctx_locked = true;
 
 	tfcp = bnxt_ulp_cntxt_tfcp_get(ulp_ctx);
 	if (unlikely(tfcp == NULL)) {
@@ -120,7 +122,8 @@ ulp_tfc_hot_upgrade_mgr_timer_cb(void *arg)
 	}
 
 cleanup:
-	bnxt_ulp_cntxt_entry_release();
+	if (ctx_locked)
+		bnxt_ulp_cntxt_entry_release();
 	if (restart_timer)
 		rte_eal_alarm_set(US_PER_S * ULP_HOT_UPGRADE_TIMER_SEC,
 				  ulp_tfc_hot_upgrade_mgr_timer_cb, arg);
-- 
2.31.1

