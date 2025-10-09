Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F35CCCD183
	for <dpdk-dev@archiver.kernel.org>; Thu,  9 Oct 2025 22:16:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5ECA540A7F;
	Fri, 10 Oct 2025 00:16:02 +0200 (CEST)
Received: from mail-ua1-f97.google.com (mail-ua1-f97.google.com
 [209.85.222.97]) by mails.dpdk.org (Postfix) with ESMTP id D51C140DD7
 for <dev@dpdk.org>; Fri, 10 Oct 2025 00:16:00 +0200 (CEST)
Received: by mail-ua1-f97.google.com with SMTP id
 a1e0cc1a2514c-930bd28d201so378243241.0
 for <dev@dpdk.org>; Thu, 09 Oct 2025 15:16:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760048160; x=1760652960;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zQypKgosCXtF4IM1chdw1BB6umpmW3GaVef1IH0hd7k=;
 b=TY7B5ALToTW9SzejCjXmfepUnD+up5oPFiLP7LsrDnnU1T4MZJwTUDuAwo0kFVDiwt
 R85uwA2oj4YaTxu7ZvGZlAHrFfR1HNFLPz+PGHi5Wu7VrAZybVYprrLBuAaLAUZziV+J
 on3+vZcKbzhopXl1OEBz7+1EZUTrqUJdZTOHe5Lc2auZuLKEHUcJY5Pdz+7A18wEsjzi
 1kiX52FUeaeGeIBeRHt58yNCZkU7XItpYYOOvLM8Uu/NJYkOIm6fM83ZbEmvOACzHdJC
 wcv7u/JagHyuIRvPOyH76IyQh3TbBzt6lRRG0lsbzp/rmMNlH7nzwsN2McN5G3jn1ths
 AOIw==
X-Gm-Message-State: AOJu0Yz8EPK5GKKNmrLmCW7JTy2viWkQEJLivhft5ldNFsTBxjqnkPv+
 mPNWa49fpvALHt/pEoQFyPz3kIUTuP7g5QqfLO6r+tyHwuz/YAjc2QgqnFe8V8u5qb0BkTPeEwX
 lKF81C5X/T3aoOKwU7byXA61nyQq+hXmp5oylrXDgI0BZ7rseko74JTmUnSDfXijNEH2t1EAfuN
 AkxcNaLr/PgSOXpItw4V2dpp/kPvYXlvKXRneWLYXG2gLfTQeQNomg++BlZruDmTiiLbtNeA==
X-Gm-Gg: ASbGncuaKqJHdxX/CQEDrRbrzDHqBh7bFmubJ78pqZWKy1xp8o+pWugUG9GQY62oFqU
 DQMXch02nzXi8F8Jw5pPoeexmHNgR1HaH9SZ45BZSCNlJTvI8KJdvltr2dD84+vs0yCEhF1nMSF
 NCZJDvqJpgOjulXQeqFN0d2YIQoX7d8+pw74DSMRBhs3v/HJfHZYQFD1YGK5w6KcqLcwr+ZIlcU
 oBvUGFaw7E5IysvCaFwcCTuCnmpgfZyIiA9f3Wh+vdMawymyzLpYbngiLW5HGF/PD98BJbjg87g
 oPv9c/CbDojjCuY0dPNoSOHtQ7AnGiGlQlzB0Wkn1tMaC971y2ZAeAQTALBOl9/9XugIkqsbxZ1
 fXKm4sj2FlLzp3UKfyOO1JHpXgvjYsGnV4LytltYgsLiIf3iH5MIXzkS/RK8let2azqB8yykWSY
 7f0cmR
X-Google-Smtp-Source: AGHT+IF0rBUo5WV7ORZzS94Bd2DV0jYaCqf2esuc7jF4qpTkadS7+NpSrMaCmSWA2EqiccwIBqkXn93K4yMV
X-Received: by 2002:a05:6102:3e8e:b0:5d5:f6ae:38fa with SMTP id
 ada2fe7eead31-5d5f6ae3e9bmr1625907137.39.1760048160134; 
 Thu, 09 Oct 2025 15:16:00 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-72.dlp.protect.broadcom.com. [144.49.247.72])
 by smtp-relay.gmail.com with ESMTPS id
 a1e0cc1a2514c-930bf7bd4c4sm15353241.9.2025.10.09.15.15.59
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 09 Oct 2025 15:16:00 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-4e6e51d9dd9so53782681cf.1
 for <dev@dpdk.org>; Thu, 09 Oct 2025 15:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1760048158; x=1760652958; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zQypKgosCXtF4IM1chdw1BB6umpmW3GaVef1IH0hd7k=;
 b=QE8QH5PNbymasru4qGLJ++cFGAnpm+y2QqIbSZjvUxC0LY/MhSOdU8pYeqHUvMSFuF
 BN7mlp/gbq+3VoPuvVHQyGzamZQV0+PKByXW6NfJiNFSudWtSCcCy4C5Xa9OzshdUjjw
 57W1uL3rx2AVCTtZwu7hhxhuxj1iD4hmGQcLw=
X-Received: by 2002:a05:622a:4c12:b0:4b5:ea1f:77ec with SMTP id
 d75a77b69052e-4e6eabeaaecmr130223871cf.0.1760048158442; 
 Thu, 09 Oct 2025 15:15:58 -0700 (PDT)
X-Received: by 2002:a05:622a:4c12:b0:4b5:ea1f:77ec with SMTP id
 d75a77b69052e-4e6eabeaaecmr130223431cf.0.1760048157881; 
 Thu, 09 Oct 2025 15:15:57 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-87bc3479344sm4189986d6.17.2025.10.09.15.15.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 09 Oct 2025 15:15:56 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com, Farah Smith <farah.smith@broadcom.com>,
 Kishore Padmanabha <kishore.padmanabha@broadcom.com>
Subject: [PATCH v2 27/54] net/bnxt/tf_core: thor2 hot upgrade ungraceful quit
 crash
Date: Thu,  9 Oct 2025 18:11:02 -0400
Message-Id: <20251009221129.28256-28-manish.kurup@broadcom.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20251009221129.28256-1-manish.kurup@broadcom.com>
References: <20250930003604.87108-1-manish.kurup@broadcom.com>
 <20251009221129.28256-1-manish.kurup@broadcom.com>
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

