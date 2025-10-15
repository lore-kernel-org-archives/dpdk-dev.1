Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A9E3CCD193
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 09:02:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C30F140E0A;
	Wed, 15 Oct 2025 11:01:35 +0200 (CEST)
Received: from mail-io1-f100.google.com (mail-io1-f100.google.com
 [209.85.166.100])
 by mails.dpdk.org (Postfix) with ESMTP id CA6D440B90
 for <dev@dpdk.org>; Wed, 15 Oct 2025 11:01:33 +0200 (CEST)
Received: by mail-io1-f100.google.com with SMTP id
 ca18e2360f4ac-917be46c59bso671929639f.1
 for <dev@dpdk.org>; Wed, 15 Oct 2025 02:01:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760518893; x=1761123693;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7vcsu5eeZiTwOGdUdWMzqVi/r+TkYGRKIFM/I1MGqY0=;
 b=XIS6ZnpEGm2+XBEBuSDjFaqbEvfaR2B2SEMprDkPc4g9krtL0XDCmzBhvQeo9dTSMA
 RvYKBb3xcLoX+rKiW92Xipw1UzenGOepTHl3Hu0dL53lRXd5Ai/ve+70kYxlSxU/Nn0G
 WFWiwEnJDTFVxiUR/f4A9TmnOq4XitwdyMN+Z+ofMKT1tIG5zihFAu3dQW1DvKqkGNYf
 O3WdWhDrrApDYEmICcPF68G6/YMs4gTjfV287gYNzLA/IdQdiIlh6ddZ1l9tTUMuKgmc
 XgbJrxm7fgFYf/+qC7dyZUKF0d7Bo9xVIR9CCo8dA2aeH7HRlXxlwEfTnq251KjNaZ/a
 AhHQ==
X-Gm-Message-State: AOJu0Yw6vmnK+zvECAhVU1HgrRvCleUJ/9pubVpoD1jijSWhlKH6qNiG
 ZFZX6mhL7vEO5dfDi/UQcWqgaNYQBbphNICnQDmcFfAreDsAEa+pwG60rvmrBrYRVdFxWyOXob7
 yAIKwUNxOdTKbVI0ro9ykI8qYAx3HLfbm9uY9HOADlnYfoPmgj3oUy2J3NM8UneYz9/+t1ZExOq
 TTZbRjUn8yobVsDFXs9+zz+msSpt9nVxJJZCZesIi3cVyWd5XpTkBxi6BpooKbtCZ3subjiA==
X-Gm-Gg: ASbGncvUQ1+6NKUCPLpwzmcPdNRi3CxI/3DMTlmaZ3jh4mKCGfuw0K1KSxt5syKaEMK
 MKL6jfc/Zixx7mXl1kJTgz6RE963zQxWtkqAnXv+92r4n2+7kZdc5fUUJUUo5uQB9tWljQRpip7
 3YwkLL54QNXbObtAM8g0VSQrvtY9P6eu0TAS7/uIUVJZrdVTkGFod5UwEAKfQxS+GF5gpat8jGj
 awHt3DFf2V4jAD4Y2LrvPMQBVyDkUDMAI++7P1fQDZ17Bj+VMhV7iOk13vKKq3fkeIQDr7Jqus6
 8fnWrdvWgUYToZ3KCD2gLsN5ZFM7hIC3UmNMIXO5EXXSnJYRWloRjji/Ko+nDaT/rruzBCTW2NJ
 bn0S8W41MotZls/r5t3eY4Ox8DKygSCSE886Qf7XXuIFHqq2B1NApMDiGiMjbekbH4hOZ8ZKs6v
 VbDw==
X-Google-Smtp-Source: AGHT+IEpN5J7Ca9mYKcDTPQ1rhW20mvA96e3KRfDAg2cEPs3ccBC3/5W1XncKTHtr4irvndnC2uGq5FPGnYu
X-Received: by 2002:a05:6e02:3c04:b0:42e:712c:b15 with SMTP id
 e9e14a558f8ab-42f87351fefmr292650725ab.1.1760518890810; 
 Wed, 15 Oct 2025 02:01:30 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
 by smtp-relay.gmail.com with ESMTPS id
 8926c6da1cb9f-58f6d042b5dsm1247853173.6.2025.10.15.02.01.30
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 15 Oct 2025 02:01:30 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-7810af03a63so17890447b3a.3
 for <dev@dpdk.org>; Wed, 15 Oct 2025 02:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1760518889; x=1761123689; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7vcsu5eeZiTwOGdUdWMzqVi/r+TkYGRKIFM/I1MGqY0=;
 b=ecNG7yD71UJ4u39T3bnaLCEdNu2fcEhKIULt6pOwrwJOonj1C0CMyn6v8yXr9lFHXs
 UVxvTAlS19kPWkAfxqgH5Izvt2tTkP+3Gh+7mP0NJ2YKZWxS0A5zgMzL75MiztLlIYIl
 oVJFXA3UJdjMwG9r0mQ4KPtrE2a3f+mEU8i/Q=
X-Received: by 2002:a05:6a00:2e96:b0:781:2290:e7e7 with SMTP id
 d2e1a72fcca58-79387146b8dmr37887313b3a.18.1760518888271; 
 Wed, 15 Oct 2025 02:01:28 -0700 (PDT)
X-Received: by 2002:a05:6a00:2e96:b0:781:2290:e7e7 with SMTP id
 d2e1a72fcca58-79387146b8dmr37887160b3a.18.1760518886599; 
 Wed, 15 Oct 2025 02:01:26 -0700 (PDT)
Received: from localhost.localdomain ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7992bc12a8asm17832412b3a.34.2025.10.15.02.01.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 15 Oct 2025 02:01:26 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com,
 Kishore Padmanabha <kishore.padmanabha@broadcom.com>,
 Farah Smith <farah.smith@broadcom.com>
Subject: [PATCH v3 09/54] net/bnxt/tf_core: add support for multi instance
Date: Wed, 15 Oct 2025 04:59:39 -0400
Message-Id: <20251015090024.32250-10-manish.kurup@broadcom.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20251015090024.32250-1-manish.kurup@broadcom.com>
References: <20251009221129.28256-1-manish.kurup@broadcom.com>
 <20251015090024.32250-1-manish.kurup@broadcom.com>
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

Added support for multi instances of applications to
exist at same time. Added shared scope fixes to enable
shared table scope between applications. Integrated the
support for global ids to allow dynamic allocation and
freeing of the shared identifiers.

Signed-off-by: Kishore Padmanabha <kishore.padmanabha@broadcom.com>
Reviewed-by: Farah Smith <farah.smith@broadcom.com>
---
 drivers/net/bnxt/tf_core/v3/tfc.h           | 45 +++++++---
 drivers/net/bnxt/tf_core/v3/tfc_act.c       |  3 +-
 drivers/net/bnxt/tf_core/v3/tfc_em.c        |  2 +
 drivers/net/bnxt/tf_core/v3/tfc_em.h        |  3 +
 drivers/net/bnxt/tf_core/v3/tfc_global_id.c |  5 +-
 drivers/net/bnxt/tf_core/v3/tfc_msg.c       | 95 +++++++++------------
 drivers/net/bnxt/tf_core/v3/tfc_msg.h       |  7 +-
 drivers/net/bnxt/tf_core/v3/tfc_tbl_scope.c | 13 ++-
 drivers/net/bnxt/tf_ulp/bnxt_ulp_tfc.c      | 16 ++--
 drivers/net/bnxt/tf_ulp/ulp_mapper.c        |  9 +-
 drivers/net/bnxt/tf_ulp/ulp_mapper.h        |  2 +
 drivers/net/bnxt/tf_ulp/ulp_mapper_tfc.c    | 20 ++++-
 12 files changed, 129 insertions(+), 91 deletions(-)

diff --git a/drivers/net/bnxt/tf_core/v3/tfc.h b/drivers/net/bnxt/tf_core/v3/tfc.h
index 1c7eb51c8c..0ede8f04a8 100644
--- a/drivers/net/bnxt/tf_core/v3/tfc.h
+++ b/drivers/net/bnxt/tf_core/v3/tfc.h
@@ -240,7 +240,9 @@ struct tfc_global_id_req {
 	enum cfa_resource_type rtype; /**< Resource type */
 	uint8_t rsubtype; /**< Resource subtype */
 	enum cfa_dir dir; /**< Direction */
-	uint16_t cnt; /**< Number of resources to allocate of this type */
+	uint8_t *context_id;
+	uint16_t context_len;
+	uint16_t resource_id;
 };
 
 /** Global id resource definition
@@ -268,18 +270,9 @@ struct tfc_global_id {
  * @param[in] fid
  *   FID - Function ID to be used
  *
- * @param[in] domain_id
- *   The domain id to associate.
- *
- * @param[in] req_cnt
- *   The number of total resource requests
- *
  * @param[in] glb_id_req
  *   The list of global id requests
  *
- * @param[in,out] rsp_cnt
- *   The number of items in the response buffer
- *
  * @param[out] glb_id_rsp
  *   The number of items in the response buffer
  *
@@ -289,10 +282,36 @@ struct tfc_global_id {
  * @returns
  *   0 for SUCCESS, negative error value for FAILURE (errno.h)
  */
-int tfc_global_id_alloc(struct tfc *tfcp, uint16_t fid, enum tfc_domain_id domain_id,
-			uint16_t req_cnt, const struct tfc_global_id_req *glb_id_req,
-			struct tfc_global_id *glb_id_rsp, uint16_t *rsp_cnt,
+int tfc_global_id_alloc(struct tfc *tfcp, uint16_t fid,
+			const struct tfc_global_id_req *glb_id_req,
+			struct tfc_global_id *glb_id_rsp,
 			bool *first);
+
+/**
+ * Free global Identifier TFC resources
+ *
+ * Some resources are not owned by a single session.  They are "global" in that
+ * they will be in use as long as any associated session exists.  Once all
+ * sessions/functions have been removed, all associated global ids are freed.
+ * There are currently up to 4 global id domain sets.
+ *
+ * TODO: REDUCE PARAMETERS WHEN IMPLEMENTING API
+ *
+ * @param[in] tfcp
+ *   Pointer to TFC handle
+ *
+ * @param[in] fid
+ *   FID - Function ID to be used
+ *
+ * @param[in] glb_id_req
+ *   The list of global id requests
+ *
+ * @returns
+ *   0 for SUCCESS, negative error value for FAILURE (errno.h)
+ */
+int tfc_global_id_free(struct tfc *tfcp, uint16_t fid,
+		       const struct tfc_global_id_req *glb_id_req);
+
 /**
  * @page Identifiers
  *
diff --git a/drivers/net/bnxt/tf_core/v3/tfc_act.c b/drivers/net/bnxt/tf_core/v3/tfc_act.c
index 0e98bd30d7..7b1f82b842 100644
--- a/drivers/net/bnxt/tf_core/v3/tfc_act.c
+++ b/drivers/net/bnxt/tf_core/v3/tfc_act.c
@@ -787,7 +787,8 @@ int tfc_act_free(struct tfc *tfcp,
 		return -EINVAL;
 	}
 
-	fparms.record_offset = record_offset;
+	fparms.record_offset = REMOVE_POOL_FROM_OFFSET(pi.act_pool_sz_exp,
+						       record_offset);
 	fparms.num_contig_records = 1 << next_pow2(record_size);
 	rc = cfa_mm_free(cmm, &fparms);
 	if (unlikely(rc)) {
diff --git a/drivers/net/bnxt/tf_core/v3/tfc_em.c b/drivers/net/bnxt/tf_core/v3/tfc_em.c
index d460ff2ee0..feb6e899f6 100644
--- a/drivers/net/bnxt/tf_core/v3/tfc_em.c
+++ b/drivers/net/bnxt/tf_core/v3/tfc_em.c
@@ -662,6 +662,8 @@ int tfc_em_delete(struct tfc *tfcp, struct tfc_em_delete_parms *parms)
 #endif
 			       );
 
+	record_offset = REMOVE_POOL_FROM_OFFSET(pi.lkup_pool_sz_exp,
+						record_offset);
 #if TFC_EM_DYNAMIC_BUCKET_EN
 	/* If the dynamic bucket is unused then free it */
 	if (db_unused) {
diff --git a/drivers/net/bnxt/tf_core/v3/tfc_em.h b/drivers/net/bnxt/tf_core/v3/tfc_em.h
index 837678cea1..9ad3ef9fd2 100644
--- a/drivers/net/bnxt/tf_core/v3/tfc_em.h
+++ b/drivers/net/bnxt/tf_core/v3/tfc_em.h
@@ -124,6 +124,9 @@ struct bucket_info_t {
 #define CREATE_OFFSET(result, pool_sz_exp, pool_id, record_offset) \
 	(*(result) = (((pool_id) << (pool_sz_exp)) | (record_offset)))
 
+#define REMOVE_POOL_FROM_OFFSET(pool_sz_exp, record_offset) \
+	(((1 << (pool_sz_exp)) - 1) & (record_offset))
+
 int tfc_em_delete_raw(struct tfc *tfcp,
 		      uint8_t tsid,
 		      enum cfa_dir dir,
diff --git a/drivers/net/bnxt/tf_core/v3/tfc_global_id.c b/drivers/net/bnxt/tf_core/v3/tfc_global_id.c
index ec1b2f728f..107a29cfc5 100644
--- a/drivers/net/bnxt/tf_core/v3/tfc_global_id.c
+++ b/drivers/net/bnxt/tf_core/v3/tfc_global_id.c
@@ -9,9 +9,8 @@
 #include "tfc_msg.h"
 
 int tfc_global_id_alloc(struct tfc *tfcp, uint16_t fid,
-			enum tfc_domain_id domain_id, uint16_t req_cnt,
 			const struct tfc_global_id_req *req,
-			struct tfc_global_id *rsp, uint16_t *rsp_cnt,
+			struct tfc_global_id *rsp,
 			bool *first)
 {
 	int rc = 0;
@@ -86,7 +85,7 @@ int tfc_global_id_free(struct tfc *tfcp, uint16_t fid,
 	rc = tfo_sid_get(tfcp->tfo, &sid);
 	if (rc) {
 		PMD_DRV_LOG_LINE(ERR, "%s: Failed to retrieve SID, rc:%s",
-			    __func__, strerror(-rc));
+				 __func__, strerror(-rc));
 		return rc;
 	}
 
diff --git a/drivers/net/bnxt/tf_core/v3/tfc_msg.c b/drivers/net/bnxt/tf_core/v3/tfc_msg.c
index 2ad0b386fa..fb007a66f6 100644
--- a/drivers/net/bnxt/tf_core/v3/tfc_msg.c
+++ b/drivers/net/bnxt/tf_core/v3/tfc_msg.c
@@ -735,56 +735,35 @@ tfc_msg_idx_tbl_free(struct tfc *tfcp, uint16_t fid,
 }
 
 int tfc_msg_global_id_alloc(struct tfc *tfcp, uint16_t fid, uint16_t sid,
-			    enum tfc_domain_id domain_id, uint16_t req_cnt,
 			    const struct tfc_global_id_req *glb_id_req,
-			    struct tfc_global_id *rsp, uint16_t *rsp_cnt,
+			    struct tfc_global_id *rsp,
 			    bool *first)
 {
 	int rc = 0;
-	int i = 0;
 	struct bnxt *bp = tfcp->bp;
 	struct hwrm_tfc_global_id_alloc_input hwrm_req;
 	struct hwrm_tfc_global_id_alloc_output hwrm_resp;
-	struct tfc_global_id_hwrm_req *req_data;
-	struct tfc_global_id_hwrm_rsp *rsp_data;
-	struct tfc_msg_dma_buf req_buf = { 0 };
-	struct tfc_msg_dma_buf rsp_buf = { 0 };
-	int dma_size;
-	int resp_cnt = 0;
-
-	/* Prepare DMA buffers */
-	dma_size = req_cnt * sizeof(struct tfc_global_id_req);
-	rc = tfc_msg_alloc_dma_buf(&req_buf, dma_size);
-	if (rc)
-		return rc;
-
-	for (i = 0; i < req_cnt; i++)
-		resp_cnt += glb_id_req->cnt;
-	dma_size = resp_cnt * sizeof(struct tfc_global_id);
-	*rsp_cnt = resp_cnt;
-	rc = tfc_msg_alloc_dma_buf(&rsp_buf, dma_size);
-	if (rc) {
-		tfc_msg_free_dma_buf(&req_buf);
-		return rc;
-	}
 
 	/* Populate the request */
 	rc = tfc_msg_set_fid(bp, fid, &hwrm_req.fid);
 	if (rc)
-		goto cleanup;
+		return rc;
 
 	hwrm_req.sid = rte_cpu_to_le_16(sid);
-	hwrm_req.global_id = rte_cpu_to_le_16(domain_id);
-	hwrm_req.req_cnt = req_cnt;
-	hwrm_req.req_addr = rte_cpu_to_le_64(req_buf.pa_addr);
-	hwrm_req.resc_addr = rte_cpu_to_le_64(rsp_buf.pa_addr);
-	req_data = (struct tfc_global_id_hwrm_req *)req_buf.va_addr;
-	for (i = 0; i < req_cnt; i++) {
-		req_data[i].rtype = rte_cpu_to_le_16(glb_id_req[i].rtype);
-		req_data[i].dir = rte_cpu_to_le_16(glb_id_req[i].dir);
-		req_data[i].subtype = rte_cpu_to_le_16(glb_id_req[i].rsubtype);
-		req_data[i].cnt = rte_cpu_to_le_16(glb_id_req[i].cnt);
-	}
+	hwrm_req.rtype = rte_cpu_to_le_16(glb_id_req->rtype);
+	hwrm_req.subtype = glb_id_req->rsubtype;
+
+	if (glb_id_req->dir == CFA_DIR_RX)
+		hwrm_req.flags = HWRM_TFC_GLOBAL_ID_ALLOC_INPUT_FLAGS_DIR_RX;
+	else
+		hwrm_req.flags = HWRM_TFC_GLOBAL_ID_ALLOC_INPUT_FLAGS_DIR_TX;
+
+	/* check the destination length before copy */
+	if (glb_id_req->context_len > sizeof(hwrm_req.context_id))
+		return -EINVAL;
+
+	memcpy(hwrm_req.context_id, glb_id_req->context_id,
+	       glb_id_req->context_len);
 
 	rc = bnxt_hwrm_tf_message_direct(bp, false, HWRM_TFC_GLOBAL_ID_ALLOC,
 					 &hwrm_req, sizeof(hwrm_req), &hwrm_resp,
@@ -796,29 +775,33 @@ int tfc_msg_global_id_alloc(struct tfc *tfcp, uint16_t fid, uint16_t sid,
 			else
 				*first = false;
 		}
+		rsp->id = hwrm_resp.global_id;
 	}
+	return rc;
+}
+int tfc_msg_global_id_free(struct tfc *tfcp, uint16_t fid, uint16_t sid,
+			   const struct tfc_global_id_req *glb_id_req)
+{
+	int rc = 0;
+	struct bnxt *bp = tfcp->bp;
 
-	/* Process the response
-	 * Should always get expected number of entries
-	 */
-	if (rte_le_to_cpu_32(hwrm_resp.rsp_cnt) != *rsp_cnt) {
-		PMD_DRV_LOG_LINE(ERR, "Alloc message size error, rc:%s",
-				 strerror(-EINVAL));
-		rc = -EINVAL;
-		goto cleanup;
-	}
+	struct hwrm_tfc_global_id_free_input hwrm_req;
+	struct hwrm_tfc_global_id_free_output hwrm_resp;
 
-	rsp_data = (struct tfc_global_id_hwrm_rsp *)rsp_buf.va_addr;
-	for (i = 0; i < *rsp_cnt; i++) {
-		rsp[i].rtype = rte_le_to_cpu_32(rsp_data[i].rtype);
-		rsp[i].dir = rte_le_to_cpu_32(rsp_data[i].dir);
-		rsp[i].rsubtype = rte_le_to_cpu_32(rsp_data[i].subtype);
-		rsp[i].id = rte_le_to_cpu_32(rsp_data[i].id);
-	}
+	/* Populate the request */
+	rc = tfc_msg_set_fid(bp, fid, &hwrm_req.fid);
+	if (rc)
+		return rc;
 
-cleanup:
-	tfc_msg_free_dma_buf(&req_buf);
-	tfc_msg_free_dma_buf(&rsp_buf);
+	hwrm_req.sid = rte_cpu_to_le_16(sid);
+	hwrm_req.rtype = rte_cpu_to_le_16(glb_id_req->rtype);
+	hwrm_req.subtype = glb_id_req->rsubtype;
+	hwrm_req.dir = glb_id_req->dir;
+	hwrm_req.global_id = rte_cpu_to_le_16(glb_id_req->resource_id);
+
+	rc = bnxt_hwrm_tf_message_direct(bp, false, HWRM_TFC_GLOBAL_ID_FREE,
+					 &hwrm_req, sizeof(hwrm_req), &hwrm_resp,
+					 sizeof(hwrm_resp));
 	return rc;
 }
 
diff --git a/drivers/net/bnxt/tf_core/v3/tfc_msg.h b/drivers/net/bnxt/tf_core/v3/tfc_msg.h
index 635c656e8f..a03452f00a 100644
--- a/drivers/net/bnxt/tf_core/v3/tfc_msg.h
+++ b/drivers/net/bnxt/tf_core/v3/tfc_msg.h
@@ -76,10 +76,13 @@ tfc_msg_idx_tbl_free(struct tfc *tfcp, uint16_t fid,
 		     uint16_t id, enum cfa_resource_blktype_idx_tbl blktype);
 
 int tfc_msg_global_id_alloc(struct tfc *tfcp, uint16_t fid, uint16_t sid,
-			    enum tfc_domain_id domain_id, uint16_t req_cnt,
 			    const struct tfc_global_id_req *glb_id_req,
-			    struct tfc_global_id *rsp, uint16_t *rsp_cnt,
+			    struct tfc_global_id *rsp,
 			    bool *first);
+
+int tfc_msg_global_id_free(struct tfc *tfcp, uint16_t fid, uint16_t sid,
+			   const struct tfc_global_id_req *glb_id_req);
+
 int
 tfc_msg_session_id_alloc(struct tfc *tfcp, uint16_t fid, uint16_t *tsid);
 
diff --git a/drivers/net/bnxt/tf_core/v3/tfc_tbl_scope.c b/drivers/net/bnxt/tf_core/v3/tfc_tbl_scope.c
index e7b82eee49..b01bf8d42a 100644
--- a/drivers/net/bnxt/tf_core/v3/tfc_tbl_scope.c
+++ b/drivers/net/bnxt/tf_core/v3/tfc_tbl_scope.c
@@ -926,7 +926,8 @@ int tfc_tbl_scope_size_query(struct tfc *tfcp,
 		return -EINVAL;
 	}
 
-	if (parms->max_pools != next_pow2(parms->max_pools)) {
+	if (parms->max_pools != 1 && parms->max_pools !=
+	    (uint32_t)(1 << next_pow2(parms->max_pools))) {
 		PMD_DRV_LOG(ERR, "%s: Invalid max_pools %u not pow2\n",
 			    __func__, parms->max_pools);
 		return -EINVAL;
@@ -1042,9 +1043,11 @@ int tfc_tbl_scope_mem_alloc(struct tfc *tfcp, uint16_t fid, uint8_t tsid,
 		PMD_DRV_LOG_LINE(ERR, "tsid(%d) not allocated", tsid);
 		return -EINVAL;
 	}
-	if (parms->max_pools != next_pow2(parms->max_pools)) {
-		PMD_DRV_LOG(ERR, "%s: Invalid max_pools %u not pow2\n", __func__,
-			    parms->max_pools);
+
+	if (parms->max_pools != 1 && parms->max_pools !=
+	    (1 << next_pow2(parms->max_pools))) {
+		PMD_DRV_LOG(ERR, "%s: Invalid max_pools %u not pow2\n",
+			    __func__, parms->max_pools);
 		return -EINVAL;
 	}
 
@@ -1388,6 +1391,8 @@ int tfc_tbl_scope_mem_free(struct tfc *tfcp, uint16_t fid, uint8_t tsid)
 			/* continue cleanup regardless */
 		}
 		PMD_DRV_LOG_LINE(DEBUG, "tsid: %d, status %d", resp.tsid, resp.status);
+		if (shared)
+			return rc;
 	}
 
 	if (shared && is_pf) {
diff --git a/drivers/net/bnxt/tf_ulp/bnxt_ulp_tfc.c b/drivers/net/bnxt/tf_ulp/bnxt_ulp_tfc.c
index 508c194d04..55adceb59f 100644
--- a/drivers/net/bnxt/tf_ulp/bnxt_ulp_tfc.c
+++ b/drivers/net/bnxt/tf_ulp/bnxt_ulp_tfc.c
@@ -346,6 +346,7 @@ ulp_tfc_tbl_scope_init(struct bnxt *bp)
 	struct tfc_tbl_scope_cpm_alloc_parms cparms;
 	uint16_t fid, max_pools;
 	bool first = true, shared = false;
+	uint64_t feat_bits;
 	uint8_t tsid = 0;
 	struct tfc *tfcp;
 	int32_t rc = 0;
@@ -368,15 +369,14 @@ ulp_tfc_tbl_scope_init(struct bnxt *bp)
 
 	shared = bnxt_ulp_cntxt_shared_tbl_scope_enabled(bp->ulp_ctx);
 
-#if (TFC_SHARED_TBL_SCOPE_ENABLE == 1)
-	/* Temporary code for testing shared table scopes until ULP
-	 * usage defined.
-	 */
-	if (!BNXT_PF(bp)) {
-		shared = true;
-		max_pools = 8;
+	feat_bits = bnxt_ulp_feature_bits_get(bp->ulp_ctx);
+	if ((feat_bits & BNXT_ULP_FEATURE_BIT_MULTI_INSTANCE)) {
+		if (!BNXT_PF(bp)) {
+			shared = true;
+			max_pools = 8;
+		}
 	}
-#endif
+
 	/* Calculate the sizes for setting up memory */
 	qparms.shared = shared;
 	qparms.max_pools = max_pools;
diff --git a/drivers/net/bnxt/tf_ulp/ulp_mapper.c b/drivers/net/bnxt/tf_ulp/ulp_mapper.c
index d58899bdb1..d545bd2fda 100644
--- a/drivers/net/bnxt/tf_ulp/ulp_mapper.c
+++ b/drivers/net/bnxt/tf_ulp/ulp_mapper.c
@@ -729,7 +729,7 @@ ulp_mapper_tbl_ident_scan_ext(struct bnxt_ulp_mapper_parms *parms,
 static int32_t
 ulp_mapper_ident_process(struct bnxt_ulp_mapper_parms *parms,
 			 struct bnxt_ulp_mapper_tbl_info *tbl,
-			 struct ulp_blob *key __rte_unused,
+			 struct ulp_blob *key,
 			 struct bnxt_ulp_mapper_ident_info *ident,
 			 uint16_t *val)
 {
@@ -737,6 +737,8 @@ ulp_mapper_ident_process(struct bnxt_ulp_mapper_parms *parms,
 	struct ulp_flow_db_res_params fid_parms = { 0 };
 	bool global = false;
 	uint64_t id = 0;
+	uint8_t *context;
+	uint16_t tmplen = 0;
 	int32_t idx;
 	int rc;
 
@@ -757,10 +759,15 @@ ulp_mapper_ident_process(struct bnxt_ulp_mapper_parms *parms,
 							     tbl->track_type,
 							     &id);
 	} else {
+		context = ulp_blob_data_get(key, &tmplen);
+		tmplen = ULP_BITS_2_BYTE(tmplen);
 		rc = op->ulp_mapper_core_global_ident_alloc(parms->ulp_ctx,
 							    ident->ident_type,
 							    tbl->direction,
+							    context,
+							    tmplen,
 							    &id);
+		fid_parms.resource_func = tbl->resource_func;
 	}
 
 	if (unlikely(rc)) {
diff --git a/drivers/net/bnxt/tf_ulp/ulp_mapper.h b/drivers/net/bnxt/tf_ulp/ulp_mapper.h
index 2bcfc6ef1b..79052664dd 100644
--- a/drivers/net/bnxt/tf_ulp/ulp_mapper.h
+++ b/drivers/net/bnxt/tf_ulp/ulp_mapper.h
@@ -152,6 +152,8 @@ struct ulp_mapper_core_ops {
 	(*ulp_mapper_core_global_ident_alloc)(struct bnxt_ulp_context *ulp_ctx,
 					      uint16_t ident_type,
 					      uint8_t direction,
+					      uint8_t *context_id,
+					      uint16_t context_len,
 					      uint64_t *identifier_id);
 
 	int32_t
diff --git a/drivers/net/bnxt/tf_ulp/ulp_mapper_tfc.c b/drivers/net/bnxt/tf_ulp/ulp_mapper_tfc.c
index 3db98fa160..d4c03a2d74 100644
--- a/drivers/net/bnxt/tf_ulp/ulp_mapper_tfc.c
+++ b/drivers/net/bnxt/tf_ulp/ulp_mapper_tfc.c
@@ -1640,13 +1640,14 @@ static int32_t
 ulp_mapper_tfc_global_ident_alloc(struct bnxt_ulp_context *ulp_ctx,
 				  uint16_t ident_type,
 				  uint8_t direction,
+				  uint8_t *context_id,
+				  uint16_t context_len,
 				  uint64_t *identifier_id)
 {
 	struct tfc *tfcp = NULL;
 	struct tfc_global_id_req glb_req = { 0 };
 	struct tfc_global_id glb_rsp = { 0 };
 	uint16_t fw_fid = 0;
-	uint16_t rsp_cnt;
 	int32_t rc = 0;
 	bool first = false;
 
@@ -1663,10 +1664,11 @@ ulp_mapper_tfc_global_ident_alloc(struct bnxt_ulp_context *ulp_ctx,
 
 	glb_req.rtype = CFA_RTYPE_IDENT;
 	glb_req.dir = direction;
-	glb_req.cnt = 1;
 	glb_req.rsubtype = ident_type;
+	glb_req.context_len = context_len;
+	glb_req.context_id = context_id;
 
-	rc = tfc_global_id_alloc(tfcp, fw_fid, 1, 1, &glb_req, &glb_rsp, &rsp_cnt, &first);
+	rc = tfc_global_id_alloc(tfcp, fw_fid, &glb_req, &glb_rsp, &first);
 	if (unlikely(rc != 0)) {
 		BNXT_DRV_DBG(ERR, "alloc failed %d\n", rc);
 		return rc;
@@ -1680,6 +1682,7 @@ static int32_t
 ulp_mapper_tfc_global_ident_free(struct bnxt_ulp_context *ulp_ctx,
 				 struct ulp_flow_db_res_params *res)
 {
+	struct tfc_global_id_req glb_req = { 0 };
 	struct tfc *tfcp = NULL;
 	int32_t rc = 0;
 	uint16_t fw_fid = 0;
@@ -1695,6 +1698,17 @@ ulp_mapper_tfc_global_ident_free(struct bnxt_ulp_context *ulp_ctx,
 		return -EINVAL;
 	}
 
+	glb_req.rtype = CFA_RTYPE_IDENT;
+	glb_req.dir = (enum cfa_dir)res->direction;
+	glb_req.rsubtype = res->resource_type;
+	glb_req.resource_id = (uint16_t)res->resource_hndl;
+
+	rc = tfc_global_id_free(tfcp, fw_fid, &glb_req);
+	if (unlikely(rc != 0)) {
+		BNXT_DRV_DBG(ERR, "free failed %d\n", rc);
+		return rc;
+	}
+
 	return rc;
 }
 
-- 
2.39.5 (Apple Git-154)

