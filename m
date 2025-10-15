Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A04C9CCD195
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 09:05:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 05CE040E8A;
	Wed, 15 Oct 2025 11:04:33 +0200 (CEST)
Received: from mail-yw1-f225.google.com (mail-yw1-f225.google.com
 [209.85.128.225])
 by mails.dpdk.org (Postfix) with ESMTP id 3B6DD40E12
 for <dev@dpdk.org>; Wed, 15 Oct 2025 11:04:32 +0200 (CEST)
Received: by mail-yw1-f225.google.com with SMTP id
 00721157ae682-73b4e3d0756so69631077b3.3
 for <dev@dpdk.org>; Wed, 15 Oct 2025 02:04:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760519071; x=1761123871;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zQypKgosCXtF4IM1chdw1BB6umpmW3GaVef1IH0hd7k=;
 b=W/VdrfFaN8ga9E8fhzPrW1NLEXIEvb214HRvGXnwEEGriSlD9A4qo5o9h3h1CGcLFL
 82wIO4tufu4q5E390hXtXfUAXpReaZJRTzGfHnbBKLdNJt8s8EdwPXnUeODi5snHvY32
 KEnVIpEdEqdf12spKC9ZR6WQ1jrx738kMb1EU8Ru/tJYH7NRbBfCCS50RVHGpNmNs2S+
 tQXCHAP5KY/wFOvFzrpaVFbeShQeJw93E5W8JlMcmMrSPpde+7Ari71JlimvFl/qRG0B
 +22vF/dw0cv8DSJmEicH9ujw1i/OU48Ru2RWxKqibruzvsr2L3JRuksQh04Zebn835TY
 3njg==
X-Gm-Message-State: AOJu0YzOGST9KeChMFGt0TREwMRaV93PL8Qnevv1DLgXEaehcCk6K1cs
 M9kkrBo9F16WQg6cAcYj/gQ28kfi/LF2cP5B4l0/XzQb/6gDVSp5L38Pg7hNYe/G0XwskG5tfQc
 6C/4b3tERbBXB9CzBrV8ZXx6bFHXPbhWEwgkG3v4kh/JtRol2haCdpzH+S719y9G4PCbiLKIYPB
 UAOZWhS/6/YTbyIxw1I+r3lQL3HK1eXGkpPbEBj2CoBNIFw32ppKcMCDQ8mDLK+AjSsG9JaA==
X-Gm-Gg: ASbGncsvap2t7c+v1wyssVScwiUg2/5N1nbsrM+2pu8jAPEg+JiVyg2abUPHoVHfp6w
 ONqyyLB7wHgzIsbMIP8Y/0SJL8NP/iXkTQGFe9jfpwTwRV1w3+zw7/45ZelVZd38jvRwOD8JQSp
 dDxr9YG2NMHfbFZNFuxzV3oaOd1uygatzowWaY3m+aCQsHFoog0ucRkf1iCJTHJH0aTC9hxKNS/
 PFCQIxhkmug2qC1vVF40ikOnv3g1zkG8plNFvQobQ8K5o6YL8+y5K5CCL79P65HW4wtPbQ5duka
 DdozOt53Vnx+9OmeUWClF5GdckpHy1yTp7VP3+x1FdpwSBhd6MJ87GORzZSe6d4Wry1oSSOyMPr
 i0nPF5L5GpT7knQEgfKNnp+OKpDiYbEO5bxmQ7Mi8s3RFgcR7Mut+OfYm7/NvxL7zK8Jnh2EJ
X-Google-Smtp-Source: AGHT+IEk4QX2HfHQH+oz5aS8A2ICuT8j86zRx+2u93vVYOfw2cZqOcli9Q1hs8ZO5rD31g6B495xsGMb9YfH
X-Received: by 2002:a05:690c:c8b:b0:781:64f:3153 with SMTP id
 00721157ae682-781064f7501mr174380697b3.63.1760519071318; 
 Wed, 15 Oct 2025 02:04:31 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-1.dlp.protect.broadcom.com. [144.49.247.1])
 by smtp-relay.gmail.com with ESMTPS id
 00721157ae682-7814c5a941esm2842927b3.4.2025.10.15.02.04.31
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 15 Oct 2025 02:04:31 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-76e2eb787f2so8832926b3a.3
 for <dev@dpdk.org>; Wed, 15 Oct 2025 02:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1760519070; x=1761123870; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zQypKgosCXtF4IM1chdw1BB6umpmW3GaVef1IH0hd7k=;
 b=EL2KFWGy82iDmZc1XagFgHXmaBKZgDqLxnXvIc4pGWQC90HhYRg0ZozbZvZ0JtUrBV
 tZ/LAmqQdbq7nlAND0ANZZhtxT7bCQea5CoPx7UepE3NW038Q3/OJJIwIauRdMAAganh
 luDq9SKJIP5XcGNg1sQxD84RmF7XcutT7Klno=
X-Received: by 2002:a05:6a00:3cc6:b0:792:574d:b12 with SMTP id
 d2e1a72fcca58-793859f645dmr33454410b3a.10.1760519069714; 
 Wed, 15 Oct 2025 02:04:29 -0700 (PDT)
X-Received: by 2002:a05:6a00:3cc6:b0:792:574d:b12 with SMTP id
 d2e1a72fcca58-793859f645dmr33454360b3a.10.1760519068936; 
 Wed, 15 Oct 2025 02:04:28 -0700 (PDT)
Received: from localhost.localdomain ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7992bc12a8asm17832412b3a.34.2025.10.15.02.04.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 15 Oct 2025 02:04:28 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com, Farah Smith <farah.smith@broadcom.com>,
 Kishore Padmanabha <kishore.padmanabha@broadcom.com>
Subject: [PATCH v3 27/54] net/bnxt/tf_core: thor2 hot upgrade ungraceful quit
 crash
Date: Wed, 15 Oct 2025 04:59:57 -0400
Message-Id: <20251015090024.32250-28-manish.kurup@broadcom.com>
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

From: Farah Smith <farah.smith@broadcom.com>

Change table scope shutdown sequence in DPDK to remove the function
from the scope prior to requesting the memory being freed. The
firmware will delete the scope when the last fid is removed so
there is no need to issue the table scope deconfig HWRM.

Signed-off-by: Farah Smith <farah.smith@broadcom.com>
Reviewed-by: Kishore Padmanabha <kishore.padmanabha@broadcom.com>
---
 drivers/net/bnxt/tf_core/v3/tfc_tbl_scope.c | 24 ++++++++-------------
 drivers/net/bnxt/tf_ulp/bnxt_ulp_tfc.c      | 20 +++++++++++------
 2 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/drivers/net/bnxt/tf_core/v3/tfc_tbl_scope.c b/drivers/net/bnxt/tf_core/v3/tfc_tbl_scope.c
index 60b8289805..ac805916cc 100644
--- a/drivers/net/bnxt/tf_core/v3/tfc_tbl_scope.c
+++ b/drivers/net/bnxt/tf_core/v3/tfc_tbl_scope.c
@@ -1284,7 +1284,7 @@ int tfc_tbl_scope_mem_alloc(struct tfc *tfcp, uint16_t fid, uint8_t tsid,
 						tsid,
 						dir,
 						CFA_REGION_TYPE_LKUP,
-						true,
+						parms->local,
 						&lkup_mem_cfg[dir]);
 			if (rc)
 				goto cleanup;
@@ -1293,7 +1293,7 @@ int tfc_tbl_scope_mem_alloc(struct tfc *tfcp, uint16_t fid, uint8_t tsid,
 						tsid,
 						dir,
 						CFA_REGION_TYPE_ACT,
-						true,
+						parms->local,
 						&act_mem_cfg[dir]);
 			if (rc)
 				goto cleanup;
@@ -1388,9 +1388,13 @@ int tfc_tbl_scope_mem_free(struct tfc *tfcp, uint16_t fid, uint8_t tsid)
 			PMD_DRV_LOG_LINE(ERR, "tfc_vf2pf_mem_free failed");
 			/* continue cleanup regardless */
 		}
-		PMD_DRV_LOG_LINE(DEBUG, "tsid: %d, status %d", resp.tsid, resp.status);
-		if (shared)
+		PMD_DRV_LOG_LINE(DEBUG, "%s: tsid: %d, status %d",
+				 __func__, resp.tsid, resp.status);
+		if (shared) {
+			/* reset scope */
+			tfo_ts_set(tfcp->tfo, tsid, false, CFA_APP_TYPE_INVALID, false, 0);
 			return rc;
+		}
 	}
 
 	if (shared && is_pf) {
@@ -1495,11 +1499,9 @@ int tfc_tbl_scope_fid_add(struct tfc *tfcp, uint16_t fid, uint8_t tsid,
 int tfc_tbl_scope_fid_rem(struct tfc *tfcp, uint16_t fid, uint8_t tsid,
 			  uint16_t *fid_cnt)
 {
-	struct tfc_ts_mem_cfg mem_cfg;
 	struct tfc_cpm *cpm_lkup;
 	struct tfc_cpm *cpm_act;
 	int rc = 0;
-	bool local;
 
 	if (tfcp == NULL) {
 		PMD_DRV_LOG_LINE(ERR, "Invalid tfcp pointer");
@@ -1536,15 +1538,7 @@ int tfc_tbl_scope_fid_rem(struct tfc *tfcp, uint16_t fid, uint8_t tsid,
 	if (rc == 0 && (cpm_lkup != NULL || cpm_act != NULL))
 		(void)tfc_tbl_scope_cpm_free(tfcp, tsid);
 
-	/*
-	 * Check if any table has memory configured and, if so, free it.
-	 */
-	(void)tfo_ts_get_mem_cfg(tfcp->tfo, tsid, CFA_DIR_RX,
-				 CFA_REGION_TYPE_LKUP, &local, &mem_cfg);
-
-	rc = tfo_ts_set(tfcp->tfo, tsid, false, CFA_APP_TYPE_INVALID,
-			false, 0);
-
+	/* tbl_scope_mem_free() will reset the remaining tsid state */
 	return rc;
 }
 
diff --git a/drivers/net/bnxt/tf_ulp/bnxt_ulp_tfc.c b/drivers/net/bnxt/tf_ulp/bnxt_ulp_tfc.c
index 385dd742d5..084a3db92d 100644
--- a/drivers/net/bnxt/tf_ulp/bnxt_ulp_tfc.c
+++ b/drivers/net/bnxt/tf_ulp/bnxt_ulp_tfc.c
@@ -320,20 +320,21 @@ ulp_tfc_tbl_scope_deinit(struct bnxt *bp)
 	else
 		BNXT_DRV_DBG(DEBUG, "Freed CPM TSID:%d FID: %d\n", tsid, fid);
 
-	rc = tfc_tbl_scope_mem_free(tfcp, fid, tsid);
+
+	rc = tfc_tbl_scope_fid_rem(tfcp, fid, tsid, &fid_cnt);
 	if (rc)
-		BNXT_DRV_DBG(ERR, "Failed freeing tscope mem TSID:%d FID:%d\n",
+		BNXT_DRV_DBG(ERR, "Failed removing FID from TSID:%d FID:%d",
 			     tsid, fid);
 	else
-		BNXT_DRV_DBG(DEBUG, "Freed tscope mem TSID:%d FID:%d\n",
+		BNXT_DRV_DBG(DEBUG, "Removed FID from TSID:%d FID:%d",
 			     tsid, fid);
 
-	rc = tfc_tbl_scope_fid_rem(tfcp, fid, tsid, &fid_cnt);
+	rc = tfc_tbl_scope_mem_free(tfcp, fid, tsid);
 	if (rc)
-		BNXT_DRV_DBG(ERR, "Failed removing FID from TSID:%d FID:%d\n",
+		BNXT_DRV_DBG(ERR, "Failed freeing tscope mem TSID:%d FID:%d",
 			     tsid, fid);
 	else
-		BNXT_DRV_DBG(DEBUG, "Removed FID from TSID:%d FID:%d\n",
+		BNXT_DRV_DBG(DEBUG, "Freed tscope mem TSID:%d FID:%d",
 			     tsid, fid);
 }
 
@@ -456,7 +457,12 @@ ulp_tfc_tbl_scope_init(struct bnxt *bp)
 		qparms.act_pool_sz_exp[CFA_DIR_RX];
 	mem_parms.act_pool_sz_exp[CFA_DIR_TX] =
 		qparms.act_pool_sz_exp[CFA_DIR_TX];
-	mem_parms.local = true;
+
+	if (shared)
+		mem_parms.local = false;
+	else
+		mem_parms.local = true;
+
 	rc = tfc_tbl_scope_mem_alloc(tfcp, fid, tsid, &mem_parms);
 	if (rc) {
 		BNXT_DRV_DBG(ERR,
-- 
2.39.5 (Apple Git-154)

