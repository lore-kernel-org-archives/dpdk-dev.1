Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AEA3CAC5B9
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Sep 2025 07:09:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D6F3540E45;
	Tue, 30 Sep 2025 09:05:58 +0200 (CEST)
Received: from mail-qk1-f225.google.com (mail-qk1-f225.google.com
 [209.85.222.225])
 by mails.dpdk.org (Postfix) with ESMTP id 7B561402A2
 for <dev@dpdk.org>; Tue, 30 Sep 2025 02:37:12 +0200 (CEST)
Received: by mail-qk1-f225.google.com with SMTP id
 af79cd13be357-86420079b01so319835585a.1
 for <dev@dpdk.org>; Mon, 29 Sep 2025 17:37:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759192632; x=1759797432;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zQypKgosCXtF4IM1chdw1BB6umpmW3GaVef1IH0hd7k=;
 b=HI6MRWKWGNwook+Vaibk3O0ZzoY5egII933A9JVBERx97mfNfpXvhsce17X7UrFB7V
 pf+oQbNMOHZYOYvqxNTXkE2B7rT3m8qdr2GJ4bmLZ8+I2DCA1ld+YUSti8vbxvaj3Zkk
 YY1ELE5pNulaFc2+snT0ve6Z9qJby9fMoBpkh/NbkktTYfTKPUyxHqHDs+V10XnNcskU
 RZVwGIVNipYg0q+NJ1cOmvJ+fBzzPGTGu0VCHHMUw4UMNf9LcnOIyVT0V6f2ycSgnDdw
 QkkIUFBNIn/VTpwJWEtBOkpHQ24MxzI0UKOLo94mEaasjxnxVlpOVf9LIbLNsXt1Sn8Z
 i/lw==
X-Gm-Message-State: AOJu0YwBWumFa8ja7vudhYLPW1M1h+YkyHpuiQUPqzGr70VuL5X6/C2j
 Epd+RahS/4Lf78S0mq+GNIBAvZ3Bm5z3+c2uSEoq94SPF9WpesFSQgn+h56bBfK4C6DJSxbb3n3
 gExbNVsmeBveXBYsh8o5v63U1zgOxR2M2DY3/mt0gSq7XQfo30qmPI7+lI9zVU6TTcSuOquZmaE
 rGQri99Ig10Q9Y1VatoqgzJ8U5jnBNoj2PfnFPkBNHerOl96W90QCFVaQq2HBWgzFkn6nrRg==
X-Gm-Gg: ASbGnctI69y/HiXXt/3MFv6hZWFCYjE1AmfSrt3yLWxWPKO8B93l+umBlCvKJuH3ew3
 O1/jll4PdzxkG4RO/JkX6d1bRPV63htl/I6cUSbus7AMmc9w7ct2dbqkmtyTTJXTRO/Rpgno1AB
 /UsBZkazHiOAu8JjeyKr5K2MzX0WtLvdtV2FaBPLWZ039EbnDWulD97yPSB43SL/8X+4JlxTotd
 kkRe3CMOoUvvpWc1p0JoawTPnG8x43dhV348gvCv/MmqIh3c7N3s/uKyb6tESQYKwKNXtxHltpi
 48v5PxWpNR83vBplcEh0kVIiWmwNAUVEYyt0UMbt5QSimo35kNz0+Ppxb/zOOgwxQq25fsMFdJW
 XsK2FeqQmqv/wl+bi13lDAfDQP4pXyP//alqoJial79iRFxL+Q2IHcXzBAH4hn88I9IW+M0T0S3
 AFj0ttTvE=
X-Google-Smtp-Source: AGHT+IGJkPZtW2tU3dM4ZEYHNA9Zanf0LccGApxUVM8AqsMY+j1KruZkvJax3mgYA3ctl6A/Yq3id+5Wifh2
X-Received: by 2002:a05:6214:ca3:b0:765:619f:6412 with SMTP id
 6a1803df08f44-7fc443da007mr256358896d6.63.1759192631735; 
 Mon, 29 Sep 2025 17:37:11 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-101.dlp.protect.broadcom.com. [144.49.247.101])
 by smtp-relay.gmail.com with ESMTPS id
 6a1803df08f44-8016193c3afsm9219526d6.22.2025.09.29.17.37.10
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 29 Sep 2025 17:37:11 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-269af520712so57729435ad.2
 for <dev@dpdk.org>; Mon, 29 Sep 2025 17:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1759192629; x=1759797429; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zQypKgosCXtF4IM1chdw1BB6umpmW3GaVef1IH0hd7k=;
 b=hePfIrFW28sTnAxmnBpXQJQWz4V7FvExD7c1w/w2aDthXcbHjB5BKcm25pcUMTgfZz
 ZKSIgEXU5mUNtDFupO75sl+TgW5hVLeseOvVeGwxBCmHAYITO1W2TYhxWbn2Av2DKTyj
 Vl9x+3f74pKIvoMxbIAQJlIPrr6l215A71i1A=
X-Received: by 2002:a17:902:d48c:b0:248:a642:eec6 with SMTP id
 d9443c01a7336-27ed4ad2dabmr180762615ad.50.1759192629519; 
 Mon, 29 Sep 2025 17:37:09 -0700 (PDT)
X-Received: by 2002:a17:902:d48c:b0:248:a642:eec6 with SMTP id
 d9443c01a7336-27ed4ad2dabmr180762295ad.50.1759192628979; 
 Mon, 29 Sep 2025 17:37:08 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b57c53bb97dsm12234825a12.9.2025.09.29.17.37.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Sep 2025 17:37:08 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com, Farah Smith <farah.smith@broadcom.com>,
 Kishore Padmanabha <kishore.padmanabha@broadcom.com>
Subject: [PATCH 27/54] net/bnxt/tf_core: thor2 hot upgrade ungraceful quit
 crash
Date: Mon, 29 Sep 2025 20:35:37 -0400
Message-Id: <20250930003604.87108-28-manish.kurup@broadcom.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250930003604.87108-1-manish.kurup@broadcom.com>
References: <20250930003604.87108-1-manish.kurup@broadcom.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Mailman-Approved-At: Tue, 30 Sep 2025 09:05:07 +0200
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

