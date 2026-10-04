Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D80BFCA5FE6
	for <dpdk-dev@archiver.kernel.org>; Sun,  4 Oct 2026 14:20:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E2475402F0;
	Sun,  4 Oct 2026 16:20:45 +0200 (CEST)
Received: from mail-pl1-f226.google.com (mail-pl1-f226.google.com
 [209.85.214.226])
 by mails.dpdk.org (Postfix) with ESMTP id 888AA402B5
 for <dev@dpdk.org>; Sun,  4 Oct 2026 16:20:44 +0200 (CEST)
Received: by mail-pl1-f226.google.com with SMTP id
 d9443c01a7336-2e49851734cso1637445ad.3
 for <dev@dpdk.org>; Sun, 04 Oct 2026 07:20:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791123643; x=1791728443;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=faezeUDYxEw1PaA7UNLmujirMwYH/XGUhQlMozdu7So=;
 b=Jk88ZDeWnc/RPiHv/o3cgepctEElVKqgjBPbWHLrsjxC5/5NHV1v1BOu8VAbM9jhd8
 TCujbB0c6HL8tajOBW3NdsdVN5j23V7CKSxBXYasiHcIERibqLzI6AImpDrNu3lpkUmf
 W4bDNsmUogUV+NeO0QAXWm5SYHmWrSgBK+Ak0Jsf5C844EzFyg7732lrR7kwypI1/Y/j
 fw0hM38jRftYTtKCXjVWsDa494xD9g2+gt7B5IMPeOiCb2a7v4v2rYCJG4HYrSUgL6DV
 7qPBPvuyOctXRkAkdh9/D3lmdokaBXecUpWwiCiC34Pydc+/NpEnvWd95IzgG3Fa6gp8
 6xFw==
X-Gm-Message-State: AFq9FYJtjcek2P4f92LJx+6T1DShZbgYzHRTg3Iuq/WUDxbLmxA4C5i7
 K+8z6gvjpY1QQG/f+tVljg2l5QDgdalujFjUE2ybHPqBjIQQS/DbpRrTyQ+9i4hRO1eaBUx+YxJ
 jJOM+NV1DtoBI+geFCgdWaS5bwJhNK0VsBC4Y7knXrlYspI5Tw4KVJeF+g7Sx/J1Fn3zjNnLlEK
 5y67/2mbVNAQsTlBfMAJs17mxqsMTfYDhpEEWu6LPL0uPtNmIUbEk21G7+oGtTG+nLXxi6mQ==
X-Gm-Gg: AYBFou0yRjMeaVPQC6fPa613LAdY9Y/TacVj5zIS/RL573GwaD/z+czIipfMIcV+YJ/
 fuO3IPqqDhjQrGMfF7PNM7lVY7AbKnvLI5ohPFkQuBBuHhwLRUJa3rTRiSEcqn8texIiLD38S28
 TeGYXJdc7hVAwtQvxjVJG7Xc4HzzJS+ZTcBCD3wGTz9A/Hrds6S7VrBIFFphksg5pYkiEon+gI0
 1Z//pYwBUGzq237vp1j65euYKbWnwVp1KknoeI+ddS1mMhdYT+x3N0/yLzMzoTzvR7KSdgCfvpG
 KGQRWikk6YbUrpNfTbjn1+jA2+6blesBzqjQnz8bKFEUqGjdHL70dNnPdikoU2PoucWVzLL++pL
 Jy/useLtyCmgD+pAHH/SwaG4rbsYh5UBbAIg3EVzcrRnup674uPglxvPGxM1TVj918T/n1uQXYA
 48QjE2cKrFXqLPrDjp3zFuiKtJttc+xNEzE5RHRg==
X-Received: by 2002:a17:90b:37cf:b0:3a7:a9bc:729d with SMTP id
 98e67ed59e1d1-3a7a9bc9629mr1232584a91.0.1791123643200; 
 Sun, 04 Oct 2026 07:20:43 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-125.dlp.protect.broadcom.com. [144.49.247.125])
 by smtp-relay.gmail.com with ESMTPS id
 98e67ed59e1d1-3a6dcda0f5csm1120756a91.1.2026.10.04.07.20.42
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 04 Oct 2026 07:20:43 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-9106fce784dso27777566d6.2
 for <dev@dpdk.org>; Sun, 04 Oct 2026 07:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1791123641; x=1791728441; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=faezeUDYxEw1PaA7UNLmujirMwYH/XGUhQlMozdu7So=;
 b=c1vshj58FIrGbrt3tZXyPMPcVV/hhYhjGYeuX4vReAPEjSkavc9PiDKmOs/fvJFKk5
 JoSpx8aihgN+9/zXOjwepPBQaj8SxEkG9jmMwtfHO3dsQF3Fg+HeqpkP1Bm0cdcrt6iK
 TzSt7BPSmarfFqpQlEuZ/sDu/nBooAayvyzDg=
X-Received: by 2002:a05:622a:6098:b0:533:80c8:53ed with SMTP id
 d75a77b69052e-533cba5b05cmr147916621cf.9.1791123641326; 
 Sun, 04 Oct 2026 07:20:41 -0700 (PDT)
X-Received: by 2002:a05:622a:6098:b0:533:80c8:53ed with SMTP id
 d75a77b69052e-533cba5b05cmr147916021cf.9.1791123640625; 
 Sun, 04 Oct 2026 07:20:40 -0700 (PDT)
Received: from r740-105-132.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-53398aa36e6sm74595541cf.15.2026.10.04.07.20.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Oct 2026 07:20:40 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com, Farah Smith <farah.smith@broadcom.com>,
 stable@dpdk.org
Subject: [PATCH v2] net/bnxt: fix global table scope shutdown order
Date: Sun,  4 Oct 2026 09:20:37 -0500
Message-Id: <20261004142037.1583073-1-manish.kurup@broadcom.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20261001174039.1155386-1-manish.kurup@broadcom.com>
References: <20261001174039.1155386-1-manish.kurup@broadcom.com>
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
port's CPM is torn down. The relative order of fid_rem and mem_free
is unchanged from before; the new step is cpm_free running first.

Fixes: 23e0dc62d19e ("net/bnxt/tf_core: add global table scope")
Cc: stable@dpdk.org

Signed-off-by: Farah Smith <farah.smith@broadcom.com>
Signed-off-by: Kishore Padmanabha <kishore.padmanabha@broadcom.com>
Signed-off-by: Manish Kurup <manish.kurup@broadcom.com>
---
v2:
* Fix a CPM leak: the glb_tbl_scope_fid_cnt_inc() failure path in
  ulp_tfc_tbl_scope_init() returned directly instead of going through
  the rollback path, leaking the CPM just allocated a few lines above.
  Changed to "goto rollback", matching the existing rollback handling
  used by the other failure path in the same function.
* Fix an inaccurate claim in this commit message: the body previously
  said "fid_rem no longer preceding mem_free", but fid_rem's position
  relative to mem_free is unchanged from before this patch; only
  cpm_free running first is new. Reworded for accuracy.

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
index d5ce4c3c18..5ef15ef7e1 100644
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
+				goto rollback;
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

