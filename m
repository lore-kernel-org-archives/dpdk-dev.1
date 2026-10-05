Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6FA7CA5FFC
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 Oct 2026 15:16:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 08EBB40A73;
	Mon,  5 Oct 2026 17:16:59 +0200 (CEST)
Received: from mail-yx1-f97.google.com (mail-yx1-f97.google.com
 [74.125.224.97]) by mails.dpdk.org (Postfix) with ESMTP id 4D28040A6F
 for <dev@dpdk.org>; Mon,  5 Oct 2026 17:16:58 +0200 (CEST)
Received: by mail-yx1-f97.google.com with SMTP id
 956f58d0204a3-6776efd4ff1so113302d50.1
 for <dev@dpdk.org>; Mon, 05 Oct 2026 08:16:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791213417; x=1791818217;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:dkim-signature:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Q5vr8PHf29XK+3KG5rCfwOuQRVzYSc381e3xJySDwwI=;
 b=FoMjyd67v6kgjDLmRemErrNnLeS4s9GaLXJsaj8HDNKHMz6ojsXDKg8DYW5Np6yafG
 6IZ3oCoobZ9Il/nG+fD9RwKBaMhNKj+ZsrWJyPkdXvTkGhFRVybMsuUyTu2PjC5KKZre
 m4rVqpTBGA+UHO0jLYzyh29Z2Er/aLQujz0lD3d2cg3xJifJgUJm8P2UZ5oPAY+86Vp3
 ycBgC+mLc60P31H/Fyklj6XCaKuV5GcDn1jIHsT6iZ8Te/meX4MJinli2MTAiqYc1uPB
 RvXJiz3Q6IxA6ZzsnNrIGzkdytOZhpI178idwlhnMTAgd2sLS9eNuY+5C9p9ycEfG4Lk
 gpfg==
X-Gm-Message-State: AFq9FYL5ZphD3JwRwFIEV6vbz3yDZNkizA+5qj71FIhOki2rZ6u39na9
 FLsnT+BdikIA/VIc5g4dW+Q4gmfIz3bBMSWDd+nSnb0TtSPmfCIRQRrHiDALBzZpOpznkLT7XE/
 mjk5vLH0RprDBOPH3D8S1Op3lLzyup2AykaW8xlfGR6Y4CDdOJbJ1FkNDR/X/D43jFem+KusiL1
 zlXFN4bracHTE6WJbiAaw0msV348pHRFwPhyPDlJn/mJJaRWbJLuYm2pKe9jFCFOPtcaY57A==
X-Gm-Gg: AYBFou1rSwgTpi5PMLNLDuT027m3WkUqXZnnG6TkjmTa4KPpvCFAo2xZUh+YnBdqW7Q
 uzRDNY1l2At2luiUHmgxwLm1fUS5pHpnW6lJFt7zWJqL3zx8Zk+nKA26GqNHkeLnYcGhcW5u5wz
 2US0yYN8nDDTbNzIJEQKKoc9DKO8Bnz582dgYzRfYTxKZZxmEIRFJwv0+T53SXxhsiwS9+AdZ0v
 b9JCpgxttGGl7lWzat6q7m7X9cIT21fPaDFQRXljJk+RYfRj3iGSWHH36OKq2pwiQThzNvp0dpf
 Sa7gOtsNGcgNUA5lD2tRLmX3oNFqQCMC4pbVQlrHPAu6rHHrxKmFrVhpr3d88CLe3UREU/yhyh4
 9MjqEIrRukE4Y9QgaSiaxEAKn/2HIml0ssw1Sg1rVXSqAEv2Yc+n5HpGiz+wCBGXFII9Cg9Dn2F
 SPtWIFLEAEXkH0SdSGdnQguMUnj9Kg68korgeWkQ==
X-Received: by 2002:a05:690e:12cb:b0:677:b163:1d8b with SMTP id
 956f58d0204a3-677b1631e76mr4280582d50.57.1791213417223; 
 Mon, 05 Oct 2026 08:16:57 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
 by smtp-relay.gmail.com with ESMTPS id
 956f58d0204a3-677c1b42b9esm1314086d50.18.2026.10.05.08.16.56
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 05 Oct 2026 08:16:57 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-8ae8f5d29d5so19794617b3.2
 for <dev@dpdk.org>; Mon, 05 Oct 2026 08:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1791213416; x=1791818216; darn=dpdk.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Q5vr8PHf29XK+3KG5rCfwOuQRVzYSc381e3xJySDwwI=;
 b=KiXba6LginGLuNdjn3dvoYt7ckVYGZD3rTLB6iyEEO7J4Ni7SQgPF4nxfZpdgFFt7w
 DrcCHVWN8zOc4CoppjBQ2Z3VJPNrD/m7xBorpeToln0bnks5JbqHNG+0sMynuCFRF3P4
 v1V/m/bF62n7jsBXoI35fnusknFFhTxl0AiCQ=
X-Received: by 2002:a05:690c:f06:b0:8ac:46ff:d396 with SMTP id
 00721157ae682-8ae394a6947mr39051797b3.10.1791213415778; 
 Mon, 05 Oct 2026 08:16:55 -0700 (PDT)
X-Received: by 2002:a05:690c:f06:b0:8ac:46ff:d396 with SMTP id
 00721157ae682-8ae394a6947mr39051397b3.10.1791213414713; 
 Mon, 05 Oct 2026 08:16:54 -0700 (PDT)
Received: from r740-105-132.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-917e0b682dfsm90090926d6.19.2026.10.05.08.16.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 08:16:54 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com, Farah Smith <farah.smith@broadcom.com>,
 stable@dpdk.org
Subject: [PATCH] net/bnxt: truflow: recover CPM pools for reuse
Date: Mon,  5 Oct 2026 10:16:50 -0500
Message-Id: <20261005151650.1705842-1-manish.kurup@broadcom.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

When the CMM block free-list runs dry before all records in a pool are
consumed, the CPM permanently excluded the pool from new allocations.
Under sustained insert/delete churn, pool slots were consumed one by
one until no slots remained and all subsequent flow inserts failed.

This applies three related fixes. First, make the block-size-limited
condition recoverable once enough records are freed back. Second,
transparently rotate to the next available pool and retry on
mid-insert exhaustion. Third, apply the related cfa_mm bookkeeping
fixes needed to support the above.

Fixes: 80317ff6adfd ("net/bnxt/tf_core: support Thor2")
Cc: stable@dpdk.org

Signed-off-by: Farah Smith <farah.smith@broadcom.com>
Signed-off-by: Manish Kurup <manish.kurup@broadcom.com>
---
 drivers/net/bnxt/hcapi/cfa_v3/mm/cfa_mm.c     |  42 +++-
 .../net/bnxt/hcapi/cfa_v3/mm/cfa_mm_priv.h    |   5 +
 .../net/bnxt/hcapi/cfa_v3/mm/include/cfa_mm.h |  23 ++
 drivers/net/bnxt/tf_core/v3/tfc_act.c         | 207 ++++++++++++------
 drivers/net/bnxt/tf_core/v3/tfc_cpm.c         |  41 +++-
 drivers/net/bnxt/tf_core/v3/tfc_cpm.h         |  31 ++-
 drivers/net/bnxt/tf_core/v3/tfc_em.c          | 207 +++++++++++-------
 7 files changed, 401 insertions(+), 155 deletions(-)

diff --git a/drivers/net/bnxt/hcapi/cfa_v3/mm/cfa_mm.c b/drivers/net/bnxt/hcapi/cfa_v3/mm/cfa_mm.c
index 6e21d513ac..61822cad46 100644
--- a/drivers/net/bnxt/hcapi/cfa_v3/mm/cfa_mm.c
+++ b/drivers/net/bnxt/hcapi/cfa_v3/mm/cfa_mm.c
@@ -124,6 +124,7 @@ int cfa_mm_open(void *cmm, struct cfa_mm_open_parms *parms)
 
 	context->blk_list_tbl[0].first_blk_idx = 0;
 	context->blk_list_tbl[0].last_blk_idx = 0;
+	context->free_blk_count = num_blocks;
 
 	for (i = 1; i < num_lists; i++) {
 		context->blk_list_tbl[i].first_blk_idx = CFA_MM_INVALID32;
@@ -196,6 +197,8 @@ static uint32_t cfa_mm_blk_alloc(struct cfa_mm *context)
 	context->blk_tbl[blk_idx].prev_blk_idx = CFA_MM_INVALID32;
 	context->blk_tbl[blk_idx].next_blk_idx = CFA_MM_INVALID32;
 
+	context->free_blk_count--;
+
 	return blk_idx;
 }
 
@@ -206,6 +209,7 @@ static void cfa_mm_blk_free(struct cfa_mm *context, uint32_t blk_idx)
 
 	context->blk_tbl[blk_idx].prev_blk_idx = CFA_MM_INVALID32;
 	context->blk_tbl[blk_idx].next_blk_idx = free_list->first_blk_idx;
+	context->free_blk_count++;
 	context->blk_tbl[blk_idx].num_free_records = context->records_per_block;
 	context->blk_tbl[blk_idx].first_free_record = 0;
 	context->blk_tbl[blk_idx].num_contig_records = 0;
@@ -385,6 +389,7 @@ static int cfa_mm_test_and_set_bits(uint8_t *bmap, uint16_t start,
 int cfa_mm_alloc(void *cmm, struct cfa_mm_alloc_parms *parms)
 {
 	int ret = 0;
+	bool free_list_empty = false;
 	uint16_t list_idx, num_records;
 	uint32_t i, cnt, blk_idx, record_idx;
 	struct cfa_mm_blk_list *blk_list;
@@ -422,6 +427,16 @@ int cfa_mm_alloc(void *cmm, struct cfa_mm_alloc_parms *parms)
 	if (blk_list->first_blk_idx == CFA_MM_INVALID32) {
 		blk_idx = cfa_mm_blk_alloc(context);
 		if (unlikely(blk_idx == CFA_MM_INVALID32)) {
+			/*
+			 * The master free-block pool is empty.
+			 * Records from other size-class lists cannot be
+			 * reclaimed for this request — each block is locked
+			 * to one size class until all its records are freed.
+			 * Signal the caller that this CMM instance is
+			 * effectively full so the CPM can retire it and
+			 * rotate to a new pool on the next allocation.
+			 */
+			free_list_empty = true;
 			ret = -ENOMEM;
 			goto cfa_mm_alloc_exit;
 		}
@@ -447,6 +462,7 @@ int cfa_mm_alloc(void *cmm, struct cfa_mm_alloc_parms *parms)
 		    !blk_info->num_free_records) {
 			blk_idx = cfa_mm_blk_alloc(context);
 			if (unlikely(blk_idx == CFA_MM_INVALID32)) {
+				free_list_empty = true;
 				ret = -ENOMEM;
 				goto cfa_mm_alloc_exit;
 			}
@@ -514,7 +530,15 @@ int cfa_mm_alloc(void *cmm, struct cfa_mm_alloc_parms *parms)
 
 	parms->used_count = context->records_in_use;
 
-	parms->all_used = (context->records_in_use >= context->max_records);
+	/*
+	 * Mark the pool as fully used if the free-block pool ran dry even
+	 * when records_in_use < max_records.  An empty free-block pool means
+	 * no further allocations are possible: stranded records in size-class
+	 * lists cannot be reclaimed.  Setting all_used lets the caller (CPM)
+	 * retire this pool and rotate to a fresh one.
+	 */
+	parms->all_used = free_list_empty ||
+			  (context->records_in_use >= context->max_records);
 
 	return ret;
 }
@@ -602,6 +626,22 @@ int cfa_mm_free(void *cmm, struct cfa_mm_free_parms *parms)
 	return 0;
 }
 
+/** Return the number of unassigned blocks currently in the master free-block
+ *  pool (list_0).  This is an O(1) read of a counter maintained by
+ *  cfa_mm_blk_alloc() and cfa_mm_blk_free().  Callers compare the return
+ *  value against TFC_CPM_BLK_RECOVERY_THRESHOLD to decide whether a
+ *  blk_sz_limited pool has recovered enough capacity to re-enter rotation.
+ */
+uint32_t cfa_mm_free_blk_count(void *cmm)
+{
+	struct cfa_mm *context = (struct cfa_mm *)cmm;
+
+	if (unlikely(cmm == NULL || context->signature != CFA_MM_SIGNATURE))
+		return 0;
+
+	return context->free_blk_count;
+}
+
 int cfa_mm_entry_size_get(void *cmm, uint32_t entry_id, uint8_t *size)
 {
 	uint8_t *blk_bmap;
diff --git a/drivers/net/bnxt/hcapi/cfa_v3/mm/cfa_mm_priv.h b/drivers/net/bnxt/hcapi/cfa_v3/mm/cfa_mm_priv.h
index dbac1c3cf2..05d3eea8d0 100644
--- a/drivers/net/bnxt/hcapi/cfa_v3/mm/cfa_mm_priv.h
+++ b/drivers/net/bnxt/hcapi/cfa_v3/mm/cfa_mm_priv.h
@@ -62,6 +62,11 @@ struct cfa_mm {
 	uint32_t max_records;
 	/* Number of CFA Records in use*/
 	uint32_t records_in_use;
+	/* Number of unassigned blocks currently in the master free-block pool (list_0).
+	 * Maintained O(1) by cfa_mm_blk_alloc / cfa_mm_blk_free.
+	 * Read by cfa_mm_free_blk_count() for the CPM recovery threshold check.
+	 */
+	uint32_t free_blk_count;
 	/* Number of Records per block */
 	uint16_t records_per_block;
 	/* Maximum number of contiguous records */
diff --git a/drivers/net/bnxt/hcapi/cfa_v3/mm/include/cfa_mm.h b/drivers/net/bnxt/hcapi/cfa_v3/mm/include/cfa_mm.h
index 507a9cb773..c74b10778f 100644
--- a/drivers/net/bnxt/hcapi/cfa_v3/mm/include/cfa_mm.h
+++ b/drivers/net/bnxt/hcapi/cfa_v3/mm/include/cfa_mm.h
@@ -161,6 +161,29 @@ int cfa_mm_free(void *cmm, struct cfa_mm_free_parms *parms);
  */
 int cfa_mm_entry_size_get(void *cmm, uint32_t entry_id, uint8_t *size);
 
+/** CFA Memory Manager Free Block Count API
+ *
+ * Returns the number of unassigned blocks currently in the master
+ * free-block pool (list_0).  Each block can serve any size class up to
+ * max_contig_records, so this count is the maximum number of additional
+ * allocations (of any size) the CMM instance can still satisfy before its
+ * block pool is exhausted.
+ *
+ * This is an O(1) operation — a single field read of a counter maintained
+ * by cfa_mm_blk_alloc() and cfa_mm_blk_free() with no list traversal.
+ *
+ * Callers compare the return value against TFC_CPM_BLK_RECOVERY_THRESHOLD
+ * (defined in tfc_cpm.h) to decide whether a blk_sz_limited pool has
+ * recovered enough capacity to re-enter rotation.
+ *
+ * @param[in] cmm
+ *   Pointer to the CFA Memory Manager database
+ *
+ * @return
+ *   Number of free blocks in list_0; 0 on invalid input or empty pool
+ */
+uint32_t cfa_mm_free_blk_count(void *cmm);
+
 /**@}*/
 
 #endif /* _CFA_MM_H_ */
diff --git a/drivers/net/bnxt/tf_core/v3/tfc_act.c b/drivers/net/bnxt/tf_core/v3/tfc_act.c
index d93064dbc6..7cd419150f 100644
--- a/drivers/net/bnxt/tf_core/v3/tfc_act.c
+++ b/drivers/net/bnxt/tf_core/v3/tfc_act.c
@@ -31,6 +31,104 @@
 /* Max additional data size in bytes */
 #define TFC_ACT_DISCARD_DATA_SIZE 128
 
+/*
+ * Select or create an ACT pool and return its pool_id and CMM instance.
+ *
+ * If the CPM has an available pool, its CMM is returned directly.
+ * Otherwise a new pool is allocated from the TPM, a fresh CMM is opened
+ * for it, and it is registered with the CPM before returning.
+ *
+ * Returns 0 on success, -ENOMEM if no pools remain (non-shared scope),
+ * -EINVAL on any other error.
+ */
+static int act_get_or_alloc_pool(struct tfc *tfcp,
+				 uint8_t tsid,
+				 struct tfc_cmm_info *cmm_info,
+				 struct tfc_cpm *cpm_act,
+				 enum cfa_scope_type scope_type,
+				 uint16_t max_pools,
+				 struct tfc_ts_mem_cfg *mem_cfg,
+				 struct tfc_ts_pool_info *pi,
+				 uint16_t *pool_id,
+				 struct tfc_cmm **cmm)
+{
+	int rc;
+	struct cfa_mm_query_parms qparms;
+	struct cfa_mm_open_parms oparms;
+	uint16_t fid;
+
+	rc = tfc_cpm_get_avail_pool(cpm_act, pool_id);
+	if (!rc) {
+		rc = tfc_cpm_get_cmm_inst(cpm_act, *pool_id, cmm);
+		if (unlikely(rc)) {
+			PMD_DRV_LOG_LINE(ERR, "tfc_cpm_get_cmm_inst() failed: %d", rc);
+			return -EINVAL;
+		}
+		return 0;
+	}
+
+	/* No pool available — allocate a new one from TPM */
+	if (unlikely(scope_type == CFA_SCOPE_TYPE_NON_SHARED)) {
+		PMD_DRV_LOG_LINE(ERR, "no records remain");
+		return -ENOMEM;
+	}
+
+	rc = tfc_get_fid(tfcp, &fid);
+	if (unlikely(rc))
+		return rc;
+
+	rc = tfc_tbl_scope_pool_alloc(tfcp, fid, tsid, CFA_REGION_TYPE_ACT,
+				      cmm_info->dir, NULL, pool_id);
+	if (unlikely(rc)) {
+		PMD_DRV_LOG_LINE(ERR, "table scope pool alloc failed: %s", strerror(-rc));
+		return -EINVAL;
+	}
+
+	if (max_pools > 0 && scope_type != CFA_SCOPE_TYPE_NON_SHARED)
+		qparms.max_records = mem_cfg->rec_cnt / max_pools;
+	else
+		qparms.max_records = mem_cfg->rec_cnt;
+	if (unlikely(qparms.max_records == 0)) {
+		PMD_DRV_LOG_LINE(WARNING,
+				 "rec_cnt=0 for tsid ACT, using min 1 record for CMM (max_pools=%u)",
+				 max_pools);
+		qparms.max_records = 1;
+	}
+	qparms.max_contig_records = 1U << next_pow2((uint32_t)pi->act_max_contig_rec);
+	rc = cfa_mm_query(&qparms);
+	if (unlikely(rc)) {
+		PMD_DRV_LOG_LINE(ERR, "cfa_mm_query() failed: %s", strerror(-rc));
+		return rc;
+	}
+
+	*cmm = rte_zmalloc("tf", qparms.db_size, 0);
+	if (unlikely(*cmm == NULL)) {
+		PMD_DRV_LOG_LINE(ERR, "rte_zmalloc() failed for CMM instance");
+		return -ENOMEM;
+	}
+	oparms.db_mem_size = qparms.db_size;
+	oparms.max_contig_records = qparms.max_contig_records;
+	oparms.max_records = qparms.max_records;
+	rc = cfa_mm_open(*cmm, &oparms);
+	if (unlikely(rc)) {
+		PMD_DRV_LOG_LINE(ERR, "cfa_mm_open() failed: %d", rc);
+		rte_free(*cmm);
+		*cmm = NULL;
+		return -EINVAL;
+	}
+
+	rc = tfc_cpm_set_cmm_inst(cpm_act, *pool_id, *cmm);
+	if (unlikely(rc)) {
+		PMD_DRV_LOG_LINE(ERR, "tfc_cpm_set_cmm_inst() failed: %d", rc);
+		rte_free(*cmm);
+		*cmm = NULL;
+		return -EINVAL;
+	}
+
+	tfo_ts_set_pool_info(tfcp->tfo, tsid, cmm_info->dir, pi);
+	return 0;
+}
+
 int tfc_act_alloc(struct tfc *tfcp,
 		  uint8_t tsid,
 		  struct tfc_cmm_info *cmm_info,
@@ -91,88 +189,53 @@ int tfc_act_alloc(struct tfc *tfcp,
 		return -EINVAL;
 	}
 
-	/* if no pool available locally or all pools full */
-	rc = tfc_cpm_get_avail_pool(cpm_act, &pool_id);
+	/* Select an available pool or allocate a new one from TPM */
+	rc = act_get_or_alloc_pool(tfcp, tsid, cmm_info, cpm_act, scope_type,
+				   max_pools, &mem_cfg, &pi, &pool_id, &cmm);
+	if (unlikely(rc))
+		return rc;
 
-	if (rc) {
-		/* Allocate a pool */
-		struct cfa_mm_query_parms qparms;
-		struct cfa_mm_open_parms oparms;
-		uint16_t fid;
+	aparms.num_contig_records = (num_contig_rec == 1) ?
+			1 : 1 << next_pow2(num_contig_rec);
 
-		/* There is only 1 pool for a non-shared table scope
-		 * and it is full.
+	rc = cfa_mm_alloc(cmm, &aparms);
+	if (unlikely(rc == -ENOMEM)) {
+		/*
+		 * The pool cannot serve this allocation — either its block
+		 * free-list is exhausted (fragmented) or the pool is nearly
+		 * full.  Mark it unavailable and rotate to a fresh pool so
+		 * the caller does not see a spurious failure.
+		 * Always force all_used=true here so the CPM pushes this pool
+		 * to the tail regardless of the actual records_in_use value.
 		 */
-		if (unlikely(scope_type == CFA_SCOPE_TYPE_NON_SHARED)) {
-			PMD_DRV_LOG_LINE(ERR, "%s: no records remain",
-					 __func__);
-			return -ENOMEM;
-		}
-		rc = tfc_get_fid(tfcp, &fid);
-		if (unlikely(rc))
-			return rc;
-
-		rc = tfc_tbl_scope_pool_alloc(tfcp,
-					      fid,
-					      tsid,
-					      CFA_REGION_TYPE_ACT,
-					      cmm_info->dir,
-					      NULL,
-					      &pool_id);
+		tfc_cpm_set_usage(cpm_act, pool_id, aparms.used_count, true, false);
 
+		rc = act_get_or_alloc_pool(tfcp, tsid, cmm_info, cpm_act,
+					   scope_type, max_pools, &mem_cfg,
+					   &pi, &pool_id, &cmm);
 		if (unlikely(rc)) {
-			PMD_DRV_LOG_LINE(ERR, "table scope pool alloc failed: %s",
+			PMD_DRV_LOG_LINE(ERR, "no pool available after rotation: %s",
 					 strerror(-rc));
-			return -EINVAL;
-		}
-
-		/* Create pool CMM instance */
-		qparms.max_records = mem_cfg.rec_cnt;
-		qparms.max_contig_records = pi.act_max_contig_rec;
-		rc = cfa_mm_query(&qparms);
-		if (unlikely(rc)) {
-			PMD_DRV_LOG_LINE(ERR, "cfa_mm_query() failed: %s", strerror(-rc));
 			return rc;
 		}
-
-		cmm = rte_zmalloc("tf", qparms.db_size, 0);
-		oparms.db_mem_size = qparms.db_size;
-		oparms.max_contig_records = qparms.max_contig_records;
-		oparms.max_records = qparms.max_records / max_pools;
-		rc = cfa_mm_open(cmm, &oparms);
-		if (unlikely(rc)) {
-			PMD_DRV_LOG_LINE(ERR, "cfa_mm_open() failed: %d", rc);
-			return -EINVAL;
-		}
-
-		/* Store CMM instance in the CPM */
-		rc = tfc_cpm_set_cmm_inst(cpm_act, pool_id, cmm);
-		if (unlikely(rc)) {
-			PMD_DRV_LOG_LINE(ERR, "tfc_cpm_set_cmm_inst() failed: %d", rc);
-			return -EINVAL;
-		}
-		/* store updated pool info */
-		tfo_ts_set_pool_info(tfcp->tfo, tsid, cmm_info->dir, &pi);
-
-	} else {
-		/* Get the pool instance and allocate an act rec index from the pool */
-		rc = tfc_cpm_get_cmm_inst(cpm_act, pool_id, &cmm);
-		if (unlikely(rc)) {
-			PMD_DRV_LOG_LINE(ERR, "tfc_cpm_get_cmm_inst() failed: %d", rc);
-			return -EINVAL;
-		}
+		rc = cfa_mm_alloc(cmm, &aparms);
 	}
-	aparms.num_contig_records = 1 << next_pow2(num_contig_rec);
-	rc = cfa_mm_alloc(cmm, &aparms);
 	if (unlikely(rc)) {
 		PMD_DRV_LOG_LINE(ERR, "cfa_mm_alloc() failed: %d", rc);
-		return -EINVAL;
+		/* alloc path: recovery only occurs on free, pass false */
+		if (aparms.all_used)
+			tfc_cpm_set_usage(cpm_act, pool_id,
+					  aparms.used_count, true, false);
+		return rc;
 	}
 
-	/* Update CPM info so it will determine best pool to use next alloc */
-	rc = tfc_cpm_set_usage(pi.act_cpm, pool_id, aparms.used_count, aparms.all_used);
+	/* Update CPM so it determines the best pool for the next alloc.
+	 * Recovery (blk_sz_recovered) is not possible on the alloc path —
+	 * the free-block pool only replenishes when records are freed.
+	 */
+	rc = tfc_cpm_set_usage(cpm_act, pool_id, aparms.used_count, aparms.all_used, false);
 	if (unlikely(rc))
-		PMD_DRV_LOG_LINE(ERR, "EM insert tfc_cpm_set_usage() failed: %d", rc);
+		PMD_DRV_LOG_LINE(ERR, "ACT alloc tfc_cpm_set_usage() failed: %d", rc);
 
 	CREATE_OFFSET(&entry_offset, pi.act_pool_sz_exp, pool_id, aparms.record_offset);
 
@@ -800,7 +863,13 @@ int tfc_act_free(struct tfc *tfcp,
 		return -EINVAL;
 	}
 
-	rc = tfc_cpm_set_usage(cpm_act, pool_id, 0, false);
+	/* Update CPM with actual remaining used count so pool ordering stays correct.
+	 * Signal recovery only when free block count meets the threshold — a small
+	 * number of freed records may transiently return one block but the pool is
+	 * still heavily fragmented.
+	 */
+	rc = tfc_cpm_set_usage(cpm_act, pool_id, fparms.used_count, false,
+			       cfa_mm_free_blk_count(cmm) >= TFC_CPM_BLK_RECOVERY_THRESHOLD);
 	if (unlikely(rc))
 		PMD_DRV_LOG_LINE(ERR, "failed to set usage: %d", rc);
 
diff --git a/drivers/net/bnxt/tf_core/v3/tfc_cpm.c b/drivers/net/bnxt/tf_core/v3/tfc_cpm.c
index 8d95a0c205..8328c071f9 100644
--- a/drivers/net/bnxt/tf_core/v3/tfc_cpm.c
+++ b/drivers/net/bnxt/tf_core/v3/tfc_cpm.c
@@ -16,6 +16,16 @@ struct cpm_pool_entry {
 	struct tfc_cmm *cmm;
 	uint32_t used_count;
 	bool all_used;
+	/*
+	 * Set when the CMM block free-list (list_0) is exhausted before
+	 * records_in_use reaches pool_size.  Per-size-class block lists
+	 * strand records that cannot be reclaimed for a different size
+	 * class without fully freeing those blocks.  While set, this flag
+	 * forces all_used=true so the CPM skips this pool.  It is cleared
+	 * by tfc_cpm_set_usage() once list_0 has at least one free block
+	 * again, meaning any size class can be served immediately.
+	 */
+	bool blk_sz_limited;
 	struct cpm_pool_use *pool_use;
 };
 
@@ -312,6 +322,7 @@ int tfc_cpm_set_cmm_inst(struct tfc_cpm *cpm, uint16_t pool_id, struct tfc_cmm *
 	pool->cmm = cmm;
 	pool->used_count = 0;
 	pool->all_used = false;
+	pool->blk_sz_limited = false;
 	pool->pool_use = NULL;
 
 	if (cmm == NULL) {
@@ -369,7 +380,8 @@ int tfc_cpm_get_avail_pool(struct tfc_cpm *cpm, uint16_t *pool_id)
 	return 0;
 }
 
-int tfc_cpm_set_usage(struct tfc_cpm *cpm, uint16_t pool_id, uint32_t used_count, bool all_used)
+int tfc_cpm_set_usage(struct tfc_cpm *cpm, uint16_t pool_id, uint32_t used_count,
+		      bool all_used, bool blk_sz_recovered)
 {
 	struct cpm_pool_entry *pool;
 
@@ -396,6 +408,33 @@ int tfc_cpm_set_usage(struct tfc_cpm *cpm, uint16_t pool_id, uint32_t used_count
 		return -EINVAL;
 	}
 
+	/*
+	 * Block-size-limited detection: all_used=true but records_in_use is
+	 * still below pool_size means the CMM block free-list (list_0) ran
+	 * dry before all records were consumed.  This happens because
+	 * per-size-class block lists strand records that cannot be reclaimed
+	 * for a different size class.  Mark the pool blk_sz_limited so the
+	 * CPM skips it until list_0 recovers.
+	 */
+	if (all_used && used_count < cpm->pool_size && !pool->blk_sz_limited)
+		pool->blk_sz_limited = true;
+
+	/*
+	 * Recovery: if the caller has confirmed that list_0 has at least one
+	 * free block (sufficient to serve any size class), clear the flag and
+	 * let all_used be evaluated normally so the pool re-enters rotation.
+	 */
+	if (pool->blk_sz_limited && blk_sz_recovered)
+		pool->blk_sz_limited = false;
+
+	/*
+	 * While blk_sz_limited is set keep all_used=true so the pool stays
+	 * at the tail of the sorted list and is never returned by
+	 * tfc_cpm_get_avail_pool().
+	 */
+	if (pool->blk_sz_limited)
+		all_used = true;
+
 	pool->all_used = all_used;
 	pool->used_count = used_count;
 
diff --git a/drivers/net/bnxt/tf_core/v3/tfc_cpm.h b/drivers/net/bnxt/tf_core/v3/tfc_cpm.h
index 9e9ab858db..3d1bd874ab 100644
--- a/drivers/net/bnxt/tf_core/v3/tfc_cpm.h
+++ b/drivers/net/bnxt/tf_core/v3/tfc_cpm.h
@@ -30,6 +30,21 @@ struct tfc_cpm;
 
 #define TFC_CPM_INVALID_POOL_ID 0xFFFF
 
+/*
+ * Minimum number of free blocks that must be present in a CMM instance's
+ * master free-block pool (list_0) before a blk_sz_limited pool is allowed to
+ * re-enter rotation.  The CMM guarantees at least 8 records per block
+ * (enforced internally via CFA_MM_MIN_RECORDS_PER_BLOCK), so this threshold
+ * ensures at least 64 usable records are available before recovery is
+ * signalled.
+ *
+ * A value of 1 is technically sufficient (one free block can serve any size
+ * class), but cleanup rollbacks from failed allocations can transiently return
+ * exactly 1 block, causing premature recovery and a tight exhaust/recover
+ * oscillation.  Using 8 prevents that transient from triggering recovery.
+ */
+#define TFC_CPM_BLK_RECOVERY_THRESHOLD 8
+
 /**
  * int tfc_cpm_open
  *
@@ -167,7 +182,12 @@ int tfc_cpm_get_avail_pool(struct tfc_cpm *cpm, uint16_t *pool_id);
 /**
  * int tfc_cpm_set_usage
  *
- * Set the usage_count and all_used fields for the specified pool_id
+ * Set the usage_count and all_used fields for the specified pool_id.
+ * Also handles blk_sz_limited flag set/clear logic:
+ *   - Sets blk_sz_limited when all_used=true but used_count < pool_size
+ *     (CMM block free-list exhausted before records ran out).
+ *   - Clears blk_sz_limited when blk_sz_recovered=true, allowing the pool
+ *     to re-enter the available rotation.
  *
  * @param[in] cpm
  *  Pointer to the CPM instance
@@ -181,11 +201,18 @@ int tfc_cpm_get_avail_pool(struct tfc_cpm *cpm, uint16_t *pool_id);
  * @param[in] all_used
  *  Set if all pool entries are used
  *
+ * @param[in] blk_sz_recovered
+ *  Pass true on free paths when cfa_mm_free_blk_count() returns a value
+ *  >= TFC_CPM_BLK_RECOVERY_THRESHOLD, indicating the CMM free-block pool
+ *  has recovered enough capacity for blk_sz_limited to be cleared.
+ *  Pass false on alloc paths and on free paths when the threshold is not met.
+ *
  * Returns:
  * 0 - Success
  * -EINVAL - Invalid argument
  */
-int tfc_cpm_set_usage(struct tfc_cpm *cpm, uint16_t pool_id, uint32_t used_count, bool all_used);
+int tfc_cpm_set_usage(struct tfc_cpm *cpm, uint16_t pool_id, uint32_t used_count,
+		      bool all_used, bool blk_sz_recovered);
 
 /**
  * int tfc_cpm_srchm_by_configured_pool
diff --git a/drivers/net/bnxt/tf_core/v3/tfc_em.c b/drivers/net/bnxt/tf_core/v3/tfc_em.c
index 3fe4dbe3fe..5577eb6e8d 100644
--- a/drivers/net/bnxt/tf_core/v3/tfc_em.c
+++ b/drivers/net/bnxt/tf_core/v3/tfc_em.c
@@ -108,6 +108,99 @@ static int tfc_em_insert_response(struct cfa_bld_mpcinfo *mpc_info,
 	return rc;
 }
 
+/*
+ * Select or create a LKUP pool and return its pool_id and CMM instance.
+ *
+ * If the CPM has an available pool, its CMM is returned directly.
+ * Otherwise a new pool is allocated from the TPM, a fresh CMM is opened
+ * for it, and it is registered with the CPM before returning.
+ *
+ * Returns 0 on success, -ENOMEM if no pools remain (non-shared scope),
+ * -EINVAL on any other error.
+ */
+static int em_get_or_alloc_pool(struct tfc *tfcp,
+				uint8_t tsid,
+				enum cfa_dir dir,
+				struct tfc_cpm *cpm_lkup,
+				enum cfa_scope_type scope_type,
+				uint16_t max_pools,
+				struct tfc_ts_mem_cfg *mem_cfg,
+				struct tfc_ts_pool_info *pi,
+				uint16_t *pool_id,
+				struct tfc_cmm **cmm)
+{
+	int rc;
+	struct cfa_mm_query_parms qparms;
+	struct cfa_mm_open_parms oparms;
+	uint16_t fid;
+
+	rc = tfc_cpm_get_avail_pool(cpm_lkup, pool_id);
+	if (!rc) {
+		rc = tfc_cpm_get_cmm_inst(cpm_lkup, *pool_id, cmm);
+		if (unlikely(rc)) {
+			PMD_DRV_LOG_LINE(ERR, "tfc_cpm_get_cmm_inst() failed: %s", strerror(-rc));
+			return -EINVAL;
+		}
+		return 0;
+	}
+
+	/* No pool available — allocate a new one from TPM */
+	if (scope_type == CFA_SCOPE_TYPE_NON_SHARED) {
+		PMD_DRV_LOG_LINE(ERR, "no records remain");
+		return -ENOMEM;
+	}
+
+	rc = tfc_get_fid(tfcp, &fid);
+	if (unlikely(rc))
+		return rc;
+
+	rc = tfc_tbl_scope_pool_alloc(tfcp, fid, tsid, CFA_REGION_TYPE_LKUP,
+				      dir, NULL, pool_id);
+	if (unlikely(rc)) {
+		PMD_DRV_LOG_LINE(ERR, "table scope pool alloc failed: %s", strerror(-rc));
+		return -EINVAL;
+	}
+
+	/*
+	 * rec_cnt includes static buckets; subtract lkup_rec_start_offset to
+	 * get the number of usable lookup records for this pool.
+	 */
+	qparms.max_records = (mem_cfg->rec_cnt - mem_cfg->lkup_rec_start_offset) / max_pools;
+	qparms.max_contig_records = 1U << next_pow2((uint32_t)pi->lkup_max_contig_rec);
+	rc = cfa_mm_query(&qparms);
+	if (unlikely(rc)) {
+		PMD_DRV_LOG_LINE(ERR, "cfa_mm_query() failed: %s", strerror(-rc));
+		return -EINVAL;
+	}
+
+	*cmm = rte_zmalloc("tf", qparms.db_size, 0);
+	if (unlikely(*cmm == NULL)) {
+		PMD_DRV_LOG_LINE(ERR, "rte_zmalloc() failed for CMM instance");
+		return -ENOMEM;
+	}
+	oparms.db_mem_size = qparms.db_size;
+	oparms.max_contig_records = qparms.max_contig_records;
+	oparms.max_records = qparms.max_records;
+	rc = cfa_mm_open(*cmm, &oparms);
+	if (unlikely(rc)) {
+		PMD_DRV_LOG_LINE(ERR, "cfa_mm_open() failed: %s", strerror(-rc));
+		rte_free(*cmm);
+		*cmm = NULL;
+		return -EINVAL;
+	}
+
+	rc = tfc_cpm_set_cmm_inst(cpm_lkup, *pool_id, *cmm);
+	if (unlikely(rc)) {
+		PMD_DRV_LOG_LINE(ERR, "tfc_cpm_set_cmm_inst() failed: %s", strerror(-rc));
+		rte_free(*cmm);
+		*cmm = NULL;
+		return -EINVAL;
+	}
+
+	tfo_ts_set_pool_info(tfcp->tfo, tsid, dir, pi);
+	return 0;
+}
+
 int tfc_em_insert(struct tfc *tfcp, uint8_t tsid,
 		  struct tfc_em_insert_parms *parms)
 {
@@ -189,92 +282,36 @@ int tfc_em_insert(struct tfc *tfcp, uint8_t tsid,
 
 	tfo_ts_get_pool_info(tfcp->tfo, tsid, parms->dir, &pi);
 
-	rc = tfc_cpm_get_avail_pool(cpm_lkup, &pool_id);
-
-	/* if no pool available locally or all pools full */
-	if (rc) {
-		/* Allocate a pool */
-		struct cfa_mm_query_parms qparms;
-		struct cfa_mm_open_parms oparms;
-		uint16_t fid;
-
-		/* There is only 1 pool for a non-shared table scope and
-		 * it is full.
-		 */
-		if (scope_type == CFA_SCOPE_TYPE_NON_SHARED) {
-			PMD_DRV_LOG_LINE(ERR, "%s: no records remain",
-					 __func__);
-			return -ENOMEM;
-		}
-
-		rc = tfc_get_fid(tfcp, &fid);
-		if (unlikely(rc))
-			return rc;
-
-		rc = tfc_tbl_scope_pool_alloc(tfcp,
-					      fid,
-					      tsid,
-					      CFA_REGION_TYPE_LKUP,
-					      parms->dir,
-					      NULL,
-					      &pool_id);
-
-		if (unlikely(rc)) {
-			PMD_DRV_LOG_LINE(ERR, "table scope pool alloc failed: %s",
-					 strerror(-rc));
-			return -EINVAL;
-		}
+	/* Select an available pool or allocate a new one from TPM */
+	rc = em_get_or_alloc_pool(tfcp, tsid, parms->dir, cpm_lkup, scope_type,
+				  max_pools, &mem_cfg, &pi, &pool_id, &cmm);
+	if (unlikely(rc))
+		return rc;
 
+	aparms.num_contig_records = num_contig_records;
+	rc = cfa_mm_alloc(cmm, &aparms);
+	if (unlikely(rc == -ENOMEM)) {
 		/*
-		 * Create pool CMM instance.
-		 * rec_cnt is the total number of records which includes static buckets,
+		 * The pool cannot serve this allocation, either its block
+		 * free-list is exhausted (fragmented) or the pool is nearly
+		 * full.  Mark it unavailable and rotate to a fresh pool so
+		 * the caller does not see a spurious failure.
 		 */
-		qparms.max_records = (mem_cfg.rec_cnt - mem_cfg.lkup_rec_start_offset) / max_pools;
-		qparms.max_contig_records = pi.lkup_max_contig_rec;
-		rc = cfa_mm_query(&qparms);
-		if (unlikely(rc)) {
-			PMD_DRV_LOG_LINE(ERR, "cfa_mm_query() failed: %s", strerror(-rc));
-			rte_free(cmm);
-			return -EINVAL;
-		}
-
-		cmm = rte_zmalloc("tf", qparms.db_size, 0);
-		oparms.db_mem_size = qparms.db_size;
-		oparms.max_contig_records = qparms.max_contig_records;
-		oparms.max_records = qparms.max_records;
-		rc = cfa_mm_open(cmm, &oparms);
-		if (unlikely(rc)) {
-			PMD_DRV_LOG_LINE(ERR, "cfa_mm_open() failed: %s", strerror(-rc));
-			rte_free(cmm);
-			return -EINVAL;
-		}
-
-		/* Store CMM instance in the CPM */
-		rc = tfc_cpm_set_cmm_inst(cpm_lkup, pool_id, cmm);
-		if (unlikely(rc)) {
-			PMD_DRV_LOG_LINE(ERR, "tfc_cpm_set_cmm_inst() failed: %s",
-					 strerror(-rc));
-			return -EINVAL;
-		}
+		tfc_cpm_set_usage(cpm_lkup, pool_id, aparms.used_count, true, false);
 
-		/* Store the updated pool information */
-		tfo_ts_set_pool_info(tfcp->tfo, tsid, parms->dir, &pi);
-
-	} else {
-		/* Get the pool instance and allocate an lkup rec index from the pool */
-		rc = tfc_cpm_get_cmm_inst(cpm_lkup, pool_id, &cmm);
+		rc = em_get_or_alloc_pool(tfcp, tsid, parms->dir, cpm_lkup,
+					  scope_type, max_pools, &mem_cfg,
+					  &pi, &pool_id, &cmm);
 		if (unlikely(rc)) {
-			PMD_DRV_LOG_LINE(ERR, "tfc_cpm_get_cmm_inst() failed: %s",
+			PMD_DRV_LOG_LINE(ERR, "no pool available after rotation: %s",
 					 strerror(-rc));
-			return -EINVAL;
+			return rc;
 		}
+		rc = cfa_mm_alloc(cmm, &aparms);
 	}
-
-	aparms.num_contig_records = num_contig_records;
-	rc = cfa_mm_alloc(cmm, &aparms);
 	if (unlikely(rc)) {
 		PMD_DRV_LOG_LINE(ERR, "cfa_mm_alloc() failed: %s", strerror(-rc));
-		return -EINVAL;
+		return rc;
 	}
 
 #if TFC_EM_DYNAMIC_BUCKET_EN
@@ -381,8 +418,11 @@ int tfc_em_insert(struct tfc *tfcp, uint8_t tsid,
 						     entry_offset,
 						     hash);
 
-	/* Update CPM info so it will determine best pool to use next alloc */
-	rc = tfc_cpm_set_usage(cpm_lkup, pool_id, aparms.used_count, aparms.all_used);
+	/* Update CPM info so it will determine best pool to use next alloc.
+	 * Recovery (blk_sz_recovered) is not possible on the alloc path —
+	 * the free-block pool only replenishes when records are freed.
+	 */
+	rc = tfc_cpm_set_usage(cpm_lkup, pool_id, aparms.used_count, aparms.all_used, false);
 	if (unlikely(rc)) {
 		PMD_DRV_LOG_LINE(ERR,
 				 "EM insert tfc_cpm_set_usage() failed: %d",
@@ -416,7 +456,10 @@ int tfc_em_insert(struct tfc *tfcp, uint8_t tsid,
 	if (cleanup_rc != 0)
 		PMD_DRV_LOG_LINE(ERR, "failed to free entry: %s", strerror(-rc));
 
-	cleanup_rc = tfc_cpm_set_usage(cpm_lkup, pool_id, fparms.used_count, false);
+	cleanup_rc = tfc_cpm_set_usage(cpm_lkup, pool_id, fparms.used_count,
+				       false,
+				       cfa_mm_free_blk_count(cmm) >=
+				       TFC_CPM_BLK_RECOVERY_THRESHOLD);
 	if (cleanup_rc != 0)
 		PMD_DRV_LOG_LINE(ERR, "failed to set usage: %s", strerror(-rc));
 
@@ -692,10 +735,10 @@ int tfc_em_delete(struct tfc *tfcp, struct tfc_em_delete_parms *parms)
 		return -EINVAL;
 	}
 
-	rc = tfc_cpm_set_usage(cpm_lkup, pool_id, fparms.used_count, false);
+	rc = tfc_cpm_set_usage(cpm_lkup, pool_id, fparms.used_count, false,
+			       cfa_mm_free_blk_count(cmm) >= TFC_CPM_BLK_RECOVERY_THRESHOLD);
 	if (rc != 0)
-		PMD_DRV_LOG_LINE(ERR, "failed to set usage: %s",
-				 strerror(-rc));
+		PMD_DRV_LOG_LINE(ERR, "failed to set usage: %s", strerror(-rc));
 
 	return rc;
 }
-- 
2.31.1

