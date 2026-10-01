Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C84BCA5FD4
	for <dpdk-dev@archiver.kernel.org>; Thu,  1 Oct 2026 17:40:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 12123402BF;
	Thu,  1 Oct 2026 19:40:55 +0200 (CEST)
Received: from mail-pl1-f228.google.com (mail-pl1-f228.google.com
 [209.85.214.228])
 by mails.dpdk.org (Postfix) with ESMTP id 74D40400D5
 for <dev@dpdk.org>; Thu,  1 Oct 2026 19:40:53 +0200 (CEST)
Received: by mail-pl1-f228.google.com with SMTP id
 d9443c01a7336-2df8d686d10so18080975ad.3
 for <dev@dpdk.org>; Thu, 01 Oct 2026 10:40:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790876452; x=1791481252;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Pbhbek7daXf8rnHrbEUvXf2XON2OOgZYLt3rbbIG50o=;
 b=BZVT8hqn7yN30ni/RsI87kx+I/DHeTGspJ8qEQRBQNyRKl1neW9pWRYMHxWQwzy9kM
 mW7CmQb417hltIU8W/CRjCreuAGLShmkt5ZmESn7ZmSblCdBUiH0Mpbaw6jtvcfCecYJ
 P61PY4tez6LzcnLm7vODeCE/M0tYXQGHgmtn8I4jQMF80+zKuUH/zsBeFh3zywNWrO6k
 EkEw2EF2fTfuRLk7mPnSNRC33EdVm0zFxfyWQs82TYjWUwefC/dtSv+ceiDAaCZati73
 85DjrZWdlT7yv9E5tLBO5z4P2HIKBYanX5/fLNAqttYefEGhepAv9Ibd2Ff3r5WiOExN
 iVAA==
X-Gm-Message-State: AFq9FYL3Sw2hV388yfWeN26kr3akX/g7PT27LBbiovuJIiO6lKVErZAD
 kTnTYeTjT61TkdJjDGCzCSLOfdgfXT+6hHh6GmXUY9E93UFo7iVefdaY8rXdY56OqMKelh8b8mN
 2yfzVXKt2+m8wpZYhHEfWPGRo5bx8B2KQYYxuWqw99k0PPHIc1rV8o2DNf+8esOz2U35WON0/hG
 XG477AqOYb1WTUhGlbTpzHAqwElZxlSb++IQwlWiyQcREgZDe1sebOCpZxiBqA2i+WpvZ2Uw==
X-Gm-Gg: AYBFou1lshctjem3GwsfHaSTkfN+A9JSIFZluwofaIVhT+YMGcneYQe2xZGzzWgB09G
 mmk0TtDakjPCde/y4Wjk4e/dvl2Li3bDn7QXE+4lHO3BO4WTN5wKT2mJT60E9gkfMhtdWl5SSPJ
 5k35OYD1mscUSn2Nxvt1dD+TZSdwSjXg7kZn0E0OqADjtvhfsxl7BGUHjdi8Nwzyh0vnA3X6bQ9
 OE/a3OUJGnAkfy+WNaOxwYO8qWBvHcr7kAujU6Cfeo1f+hIBmugitR0BS/lSvef4xCKIqKu8GPA
 2/vkEcrmOR7TW9g5wWbiIUpXM6YJx34omzf8Eh+LWyfDhantHwq1C+eXx/ngaIR6jbekctw3RWZ
 bKYoePNy3jIkkRpSqrCqh+VpkB+A4u7aHRAkPaIR+z+7i4xkCncb8qlQ3WiECM7JE0NUWm10sXL
 5K7s4K/mXGaNoFFSB1PWesqxrMXf17pimisxLGoA==
X-Received: by 2002:a17:90b:224b:b0:3a0:9640:8028 with SMTP id
 98e67ed59e1d1-3a6ce96aa22mr300161a91.59.1790876452224; 
 Thu, 01 Oct 2026 10:40:52 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-125.dlp.protect.broadcom.com. [144.49.247.125])
 by smtp-relay.gmail.com with ESMTPS id
 98e67ed59e1d1-3a4f46d3910sm1730352a91.5.2026.10.01.10.40.51
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 01 Oct 2026 10:40:52 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ot1-f72.google.com with SMTP id
 46e09a7af769-815f2b1ecc3so2039065a34.2
 for <dev@dpdk.org>; Thu, 01 Oct 2026 10:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1790876450; x=1791481250; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Pbhbek7daXf8rnHrbEUvXf2XON2OOgZYLt3rbbIG50o=;
 b=ItJul3E7nqiAwoo7tLoEWmwZL/oJmEupZ1YH9bBV6HX/nUfO1c20rDQxjR+VzVd49h
 Q8gv/521MC98MDUeGZ3XuvtDjwZY5yhkG1/8IfA0XaR3WHfvcGpmaOHcX6toVVIU8gMr
 dO2vbLLEpF+ai6SSL66C0w/4oi2qM/3RjTWLM=
X-Received: by 2002:a05:6830:927:b0:820:f0ee:1fcf with SMTP id
 46e09a7af769-82285f5b852mr377047a34.29.1790876450423; 
 Thu, 01 Oct 2026 10:40:50 -0700 (PDT)
X-Received: by 2002:a05:6830:927:b0:820:f0ee:1fcf with SMTP id
 46e09a7af769-82285f5b852mr377017a34.29.1790876449742; 
 Thu, 01 Oct 2026 10:40:49 -0700 (PDT)
Received: from r740-105-132.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-822768d21b0sm521509a34.1.2026.10.01.10.40.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2026 10:40:48 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com, Farah Smith <farah.smith@broadcom.com>,
 stable@dpdk.org
Subject: [PATCH] net/bnxt: fix global table scope shutdown order
Date: Thu,  1 Oct 2026 12:40:39 -0500
Message-Id: <20261001174039.1155386-1-manish.kurup@broadcom.com>
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

From: Farah Smith <farah.smith@broadcom.com>

Track per-port table-scope teardown state (scope type and, for GLOBAL
scope, a shared FID reference count) and clean up in the correct
order on bnxt_en/DPDK shutdown.

Previously, unloading the L2 kernel driver with DPDK shutdown could
crash because table-scope resources were torn down without properly
tracking which FID was the last user of a GLOBAL scope. Fix this by
introducing glb_tbl_scope_fid_cnt bookkeeping and freeing the per-port
CPM before removing the FID from the scope, and only fully retiring
shared GLOBAL-scope memory once the reference count reaches zero.

The teardown order was initially fid_rem -> mem_free, but that
sequence was found to trigger PXP errors: fid_rem disables the scope
in firmware, so any subsequent mem_free on that scope is operating on
an already-disabled scope. Reordered to cpm_free -> fid_rem -> mem_free
so the scope is only disabled and its memory released after this
port's CPM is torn down, with fid_rem no longer preceding mem_free.

Fixes: 23e0dc62d19e ("net/bnxt/tf_core: add global table scope")
Cc: stable@dpdk.org

Signed-off-by: Farah Smith <farah.smith@broadcom.com>
Signed-off-by: Kishore Padmanabha <kishore.padmanabha@broadcom.com>
Signed-off-by: Manish Kurup <manish.kurup@broadcom.com>
---
 drivers/net/bnxt/tf_ulp/bnxt_ulp.h     |   3 +
 drivers/net/bnxt/tf_ulp/bnxt_ulp_tfc.c | 162 ++++++++++++++++++++++---
 drivers/net/bnxt/tf_ulp/bnxt_ulp_tfc.h |  23 ++++
 3 files changed, 172 insertions(+), 16 deletions(-)

diff --git a/drivers/net/bnxt/tf_ulp/bnxt_ulp.h b/drivers/net/bnxt/tf_ulp/bnxt_ulp.h
index afd883df2c..ba526e838d 100644
--- a/drivers/net/bnxt/tf_ulp/bnxt_ulp.h
+++ b/drivers/net/bnxt/tf_ulp/bnxt_ulp.h
@@ -15,6 +15,7 @@
 #include "rte_mtr.h"
 
 #include "bnxt.h"
+#include "cfa_types.h"
 #include "ulp_template_db_enum.h"
 #include "ulp_tun.h"
 #include "bnxt_tf_common.h"
@@ -115,6 +116,8 @@ struct bnxt_ulp_vfr_rule_info {
 
 struct bnxt_ulp_data {
 	uint32_t			tbl_scope_id;
+	enum cfa_scope_type		tbl_scope_type; /* for deinit */
+	uint16_t			glb_tbl_scope_fid_cnt; /* only for GLOBAL scope */
 	struct bnxt_ulp_mark_tbl	*mark_tbl;
 	uint32_t			dev_id; /* Hardware device id */
 	uint32_t			ref_cnt;
diff --git a/drivers/net/bnxt/tf_ulp/bnxt_ulp_tfc.c b/drivers/net/bnxt/tf_ulp/bnxt_ulp_tfc.c
index d5ce4c3c18..dcd64fa598 100644
--- a/drivers/net/bnxt/tf_ulp/bnxt_ulp_tfc.c
+++ b/drivers/net/bnxt/tf_ulp/bnxt_ulp_tfc.c
@@ -111,6 +111,64 @@ bnxt_ulp_cntxt_tbl_scope_max_pools_set(struct bnxt_ulp_context *ulp_ctx,
 	return 0;
 }
 
+int32_t
+bnxt_ulp_cntxt_tbl_scope_type_get(struct bnxt_ulp_context *ulp_ctx,
+				  enum cfa_scope_type *scope_type)
+{
+	if (ulp_ctx == NULL || ulp_ctx->cfg_data == NULL || scope_type == NULL)
+		return -EINVAL;
+	*scope_type = ulp_ctx->cfg_data->tbl_scope_type;
+	return 0;
+}
+
+int32_t
+bnxt_ulp_cntxt_tbl_scope_type_set(struct bnxt_ulp_context *ulp_ctx,
+				  enum cfa_scope_type scope_type)
+{
+	if (ulp_ctx == NULL || ulp_ctx->cfg_data == NULL)
+		return -EINVAL;
+	ulp_ctx->cfg_data->tbl_scope_type = scope_type;
+	return 0;
+}
+
+uint16_t
+bnxt_ulp_cntxt_glb_tbl_scope_fid_cnt_get(struct bnxt_ulp_context *ulp_ctx)
+{
+	if (ulp_ctx == NULL || ulp_ctx->cfg_data == NULL)
+		return 0;
+	return ulp_ctx->cfg_data->glb_tbl_scope_fid_cnt;
+}
+
+int32_t
+bnxt_ulp_cntxt_glb_tbl_scope_fid_cnt_set(struct bnxt_ulp_context *ulp_ctx,
+					 uint16_t fid_cnt)
+{
+	if (ulp_ctx == NULL || ulp_ctx->cfg_data == NULL)
+		return -EINVAL;
+	ulp_ctx->cfg_data->glb_tbl_scope_fid_cnt = fid_cnt;
+	return 0;
+}
+
+int32_t
+bnxt_ulp_cntxt_glb_tbl_scope_fid_cnt_inc(struct bnxt_ulp_context *ulp_ctx)
+{
+	if (ulp_ctx == NULL || ulp_ctx->cfg_data == NULL)
+		return -EINVAL;
+	ulp_ctx->cfg_data->glb_tbl_scope_fid_cnt++;
+	return 0;
+}
+
+int32_t
+bnxt_ulp_cntxt_glb_tbl_scope_fid_cnt_dec(struct bnxt_ulp_context *ulp_ctx)
+{
+	if (ulp_ctx == NULL || ulp_ctx->cfg_data == NULL)
+		return -EINVAL;
+	if (ulp_ctx->cfg_data->glb_tbl_scope_fid_cnt == 0)
+		return -EINVAL;
+	ulp_ctx->cfg_data->glb_tbl_scope_fid_cnt--;
+	return 0;
+}
+
 enum tfc_tbl_scope_bucket_factor
 bnxt_ulp_cntxt_em_mulitplier_get(struct bnxt_ulp_context *ulp_ctx)
 {
@@ -299,39 +357,82 @@ ulp_tfc_dparms_init(struct bnxt *bp,
 static void
 ulp_tfc_tbl_scope_deinit(struct bnxt *bp)
 {
-	uint16_t fid = 0, fid_cnt = 0;
-	struct tfc *tfcp;
+	uint16_t fid = 0;
+	uint16_t our_fid_cnt = 0;
+	struct tfc *tfcp = NULL;
 	uint8_t tsid = 0;
 	int32_t rc;
+	enum cfa_scope_type scope_type = CFA_SCOPE_TYPE_INVALID;
+	int32_t scope_rc;
+	bool have_scope = false;
 
 	tfcp = bnxt_ulp_cntxt_tfcp_get(bp->ulp_ctx);
 	if (tfcp == NULL)
-		return;
+		goto cleanup;
 
 	rc = bnxt_ulp_cntxt_tsid_get(bp->ulp_ctx, &tsid);
-	if (unlikely(rc))
-		BNXT_DRV_DBG(ERR, "Failed to get the table scope\n");
+	if (rc) {
+		BNXT_DRV_DBG(ERR, "tsid_get failed rc=%d, skipping table-scope deinit", rc);
+		goto cleanup;
+	}
 
 	rc = bnxt_ulp_cntxt_fid_get(bp->ulp_ctx, &fid);
-	if (rc)
+	if (rc) {
+		BNXT_DRV_DBG(ERR, "fid_get failed rc=%d, skipping table-scope deinit", rc);
+		goto cleanup;
+	}
+
+	have_scope = true;
+
+	if (bnxt_ulp_cntxt_acquire_fdb_lock(bp->ulp_ctx)) {
+		BNXT_DRV_DBG(ERR, "acquire_fdb_lock failed, proceeding with teardown using conservative fid_cnt");
+		our_fid_cnt = 1; /* Conservative: avoid invalidating shared scope in mem_free */
+	} else {
+		scope_rc = bnxt_ulp_cntxt_tbl_scope_type_get(bp->ulp_ctx, &scope_type);
+		if (scope_rc) {
+			BNXT_DRV_DBG(ERR,
+				     "tbl_scope_type_get failed rc=%d, proceeding with teardown using conservative fid_cnt",
+				     scope_rc);
+			our_fid_cnt = 1; /* avoid invalidating shared scope in mem_free */
+		} else if (scope_type == CFA_SCOPE_TYPE_GLOBAL) {
+			rc = bnxt_ulp_cntxt_glb_tbl_scope_fid_cnt_dec(bp->ulp_ctx);
+			if (rc) {
+				BNXT_DRV_DBG(WARNING,
+					     "glb_tbl_scope_fid_cnt dec failed (e.g. already 0), continuing teardown TSID:%d FID:%d",
+					     tsid, fid);
+				/* Pass 1 so mem_free won't treat as last FID & invalidate scope */
+				our_fid_cnt = 1;
+			} else {
+				our_fid_cnt = bnxt_ulp_cntxt_glb_tbl_scope_fid_cnt_get(bp->ulp_ctx);
+			}
+		} else {
+			our_fid_cnt = 0;
+		}
+		bnxt_ulp_cntxt_release_fdb_lock(bp->ulp_ctx);
+	}
+
+cleanup:
+	if (!have_scope)
 		return;
 
-	rc = tfc_tbl_scope_fid_rem(tfcp, fid, tsid, &fid_cnt);
+	/* Free this port's CPM before mem_free; mem_free invalidates tsid scope state */
+	rc = tfc_tbl_scope_cpm_free(tfcp, tsid);
 	if (rc)
-		BNXT_DRV_DBG(ERR, "Failed removing FID from TSID:%d FID:%d",
+		BNXT_DRV_DBG(ERR, "Failed Freeing CPM TSID:%d FID:%d",
 			     tsid, fid);
 	else
-		BNXT_DRV_DBG(DEBUG, "Removed FID from TSID:%d FID:%d",
-			     tsid, fid);
+		BNXT_DRV_DBG(DEBUG, "Freed CPM TSID:%d FID: %d", tsid, fid);
 
-	rc = tfc_tbl_scope_cpm_free(tfcp, tsid);
+	rc = tfc_tbl_scope_fid_rem(tfcp, fid, tsid, NULL);
 	if (rc)
-		BNXT_DRV_DBG(ERR, "Failed Freeing CPM TSID:%d FID:%d",
+		BNXT_DRV_DBG(ERR, "Failed removing FID from TSID:%d FID:%d",
 			     tsid, fid);
 	else
-		BNXT_DRV_DBG(DEBUG, "Freed CPM TSID:%d FID: %d", tsid, fid);
+		BNXT_DRV_DBG(DEBUG, "Removed FID from TSID:%d FID:%d, remaining FID count:%d",
+			     tsid, fid, our_fid_cnt);
 
-	rc = tfc_tbl_scope_mem_free(tfcp, fid, tsid, fid_cnt);
+	/* Still attempt mem_free and fid_rem to avoid FW/driver state divergence. */
+	rc = tfc_tbl_scope_mem_free(tfcp, fid, tsid, our_fid_cnt);
 	if (rc)
 		BNXT_DRV_DBG(ERR, "Failed freeing tscope mem TSID:%d FID:%d",
 			     tsid, fid);
@@ -506,13 +607,42 @@ ulp_tfc_tbl_scope_init(struct bnxt *bp)
 	cparms.max_pools = max_pools;
 
 	rc = tfc_tbl_scope_cpm_alloc(tfcp, tsid, &cparms);
-	if (rc)
+	if (rc) {
 		BNXT_DRV_DBG(ERR, "Failed to allocate CPM TSID:%d FID:%d\n",
 			     tsid, fid);
-	else
+	} else {
 		BNXT_DRV_DBG(DEBUG, "Allocated CPM TSID:%d FID:%d\n", tsid, fid);
+		/* Inc before setting type so type==GLOBAL never without count incremented. */
+		if (bnxt_ulp_cntxt_acquire_fdb_lock(bp->ulp_ctx)) {
+			BNXT_DRV_DBG(ERR, "acquire_fdb_lock failed after CPM alloc, rolling back");
+			goto rollback;
+		}
+		if (scope_type == CFA_SCOPE_TYPE_GLOBAL) {
+			rc = bnxt_ulp_cntxt_glb_tbl_scope_fid_cnt_inc(bp->ulp_ctx);
+			if (rc) {
+				BNXT_DRV_DBG(ERR, "Failed to increment glb_tbl_scope_fid_cnt");
+				bnxt_ulp_cntxt_release_fdb_lock(bp->ulp_ctx);
+				return rc;
+			}
+		}
+		rc = bnxt_ulp_cntxt_tbl_scope_type_set(bp->ulp_ctx, scope_type);
+		bnxt_ulp_cntxt_release_fdb_lock(bp->ulp_ctx);
+	}
 
 	return rc;
+
+rollback:
+	/* Rollback: only FID in scope (glb_tbl_scope_fid_cnt_inc never ran). */
+	rc = tfc_tbl_scope_cpm_free(tfcp, tsid);
+	if (rc)
+		BNXT_DRV_DBG(INFO, "Rollback: cpm_free failed TSID:%d FID:%d rc=%d", tsid, fid, rc);
+	rc = tfc_tbl_scope_mem_free(tfcp, fid, tsid, 0);
+	if (rc)
+		BNXT_DRV_DBG(INFO, "Rollback: mem_free failed TSID:%d FID:%d rc=%d", tsid, fid, rc);
+	rc = tfc_tbl_scope_fid_rem(tfcp, fid, tsid, NULL);
+	if (rc)
+		BNXT_DRV_DBG(INFO, "Rollback: fid_rem failed TSID:%d FID:%d rc=%d", tsid, fid, rc);
+	return -1;
 }
 
 static int32_t
diff --git a/drivers/net/bnxt/tf_ulp/bnxt_ulp_tfc.h b/drivers/net/bnxt/tf_ulp/bnxt_ulp_tfc.h
index ab6608ac74..2b73043ab8 100644
--- a/drivers/net/bnxt/tf_ulp/bnxt_ulp_tfc.h
+++ b/drivers/net/bnxt/tf_ulp/bnxt_ulp_tfc.h
@@ -7,6 +7,7 @@
 #define _BNXT_ULP_TFC_H_
 
 #include "bnxt.h"
+#include "cfa_types.h"
 #include <inttypes.h>
 
 bool
@@ -24,6 +25,28 @@ bnxt_ulp_cntxt_tbl_scope_max_pools_get(struct bnxt_ulp_context *ulp_ctx);
 int32_t
 bnxt_ulp_cntxt_tbl_scope_max_pools_set(struct bnxt_ulp_context *ulp_ctx,
 				       uint32_t max);
+
+int32_t
+bnxt_ulp_cntxt_tbl_scope_type_get(struct bnxt_ulp_context *ulp_ctx,
+				  enum cfa_scope_type *scope_type);
+
+int32_t
+bnxt_ulp_cntxt_tbl_scope_type_set(struct bnxt_ulp_context *ulp_ctx,
+				  enum cfa_scope_type scope_type);
+
+uint16_t
+bnxt_ulp_cntxt_glb_tbl_scope_fid_cnt_get(struct bnxt_ulp_context *ulp_ctx);
+
+int32_t
+bnxt_ulp_cntxt_glb_tbl_scope_fid_cnt_set(struct bnxt_ulp_context *ulp_ctx,
+					 uint16_t fid_cnt);
+
+int32_t
+bnxt_ulp_cntxt_glb_tbl_scope_fid_cnt_inc(struct bnxt_ulp_context *ulp_ctx);
+
+int32_t
+bnxt_ulp_cntxt_glb_tbl_scope_fid_cnt_dec(struct bnxt_ulp_context *ulp_ctx);
+
 enum tfc_tbl_scope_bucket_factor
 bnxt_ulp_cntxt_em_mulitplier_get(struct bnxt_ulp_context *ulp_ctx);
 
-- 
2.31.1

