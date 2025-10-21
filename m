Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1497CCD184
	for <dpdk-dev@archiver.kernel.org>; Tue, 21 Oct 2025 17:54:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8A1A3410FC;
	Tue, 21 Oct 2025 19:53:14 +0200 (CEST)
Received: from mail-qv1-f97.google.com (mail-qv1-f97.google.com
 [209.85.219.97]) by mails.dpdk.org (Postfix) with ESMTP id EE58441140
 for <dev@dpdk.org>; Tue, 21 Oct 2025 19:53:08 +0200 (CEST)
Received: by mail-qv1-f97.google.com with SMTP id
 6a1803df08f44-81fdd5d7b59so83499546d6.3
 for <dev@dpdk.org>; Tue, 21 Oct 2025 10:53:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761069188; x=1761673988;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=B52fhcvvKdNkFuCPwtsJjCH9RYlndSIvJEyAeQzGlnk=;
 b=VkZgTLcbOQXxlx0X+yiTDtLuTwjT4QLG6k3wlb2OAfsbs9aE76Q9ytQsmZhxA+VXcT
 PZEMghW74JT3xfc52LnCD29LEfV/WzbjN0WmcqAVLD7BLwR1XE+A7Mg9KKLNqBevVWxk
 NLJkGoxPVU287urGunUtx7nW5475KQdapjai70O70jDApNVoB0UQSNJzlK3zOuSNeO1n
 pYoNUl7F9z3RE9ZQLRgaSXEB2ucUyjPx0hr1fliP/ab7qoGJmw1BhRt35B9C6485CbRk
 CnioY/SQaSJhmrj9UMtZLut2HbMfCY8r9BvYKp9HYKDsk7BPAjCXcQdqqjb8nnknOtEH
 wexQ==
X-Gm-Message-State: AOJu0Yz6aDY8e/efJ5VgEoN1jwkEf/DzHVTY+XNf7dtSAo09O9cwfypf
 /BVLwH3Fozy87+3sFeD0I0Q2sZY2bAlyJC9Opk6115q5PsihA382UVfzRdfMCrof1GAQQFUaF99
 bkz1xh738b7gq684cmYM1ua4zM0/d0ppxeqFjOh16f9uburE1j+TFiMUzMOuSRv/7JOMT9zRrOV
 7dv14Ow75R/4LLff9Vy1lR9Y9ZjvHY30p4QwL34uTdHNWK/wDBtyfGBTNDAElIoeBAngwdAQ==
X-Gm-Gg: ASbGncua1ait3Mg/yuf+5ZzV4RqMGirS1H3GGWV20QQfVnUYG5bopvMcyigNMiXR+Mn
 9EtoapBjDU63a4tC0C5F48EVrKt1EtEbpm53/L7CJSqBB0OlGsJ8wjeq+AOq04z7wfVdJZ28Rdq
 ELtcNOqR/lp6RajGpTj8+B3/thOpp77UYP0HFvNBcpPrzKq3pefANDeRV1HTRD5QSmq+A8wp0oZ
 xDNDE/r3uUU1qcXluMUtXqTvzAl7XsipKBZ1C2Iq13y3MTqcpoS3kNdUxNqp+PvPEPBZckFW5QL
 vMOfKNa0h/C/681k/AHbja2QihedZuSIYQhHjKCnuf7hm03kmG49Phz9PERF6RcmpNIgy3h+qWi
 oV870pPmKXEsRSfMYg6bxOSwkqveaumrTJvroeGxzaZGGoRdwYTQj0YCiOoXReZTveQci4gdopu
 y60Ov7gZBj4BwreuFsX/t6+m7NewXlYcxHyjTI
X-Google-Smtp-Source: AGHT+IFwKX18EtqC61hc+TOL5nfLoL87yhvwUj7tIOBoc8J+gHMpnqiNTZ9dLaV5SSV7jtySf13Dzhq7fVby
X-Received: by 2002:a05:6214:f63:b0:81d:8926:a9d8 with SMTP id
 6a1803df08f44-87c205ed12cmr231315636d6.36.1761069188264; 
 Tue, 21 Oct 2025 10:53:08 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
 by smtp-relay.gmail.com with ESMTPS id
 6a1803df08f44-87cf547d956sm13199256d6.17.2025.10.21.10.53.07
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 21 Oct 2025 10:53:08 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-290c9724deeso50092475ad.2
 for <dev@dpdk.org>; Tue, 21 Oct 2025 10:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1761069187; x=1761673987; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B52fhcvvKdNkFuCPwtsJjCH9RYlndSIvJEyAeQzGlnk=;
 b=MRLiCXpipnNwjNuwBPreEDLWTglhi83wTTrwYE5khmEKZYVDaHqLhTb5xezEDO+YoL
 HCxijWniekol6fBR/46ow34Kzgr8vWLBjX9Q8/y8eHUW/DPsHOJnFcOtZQiOweBy7JqC
 FqPsqpyMIR6rmH9rHivkF1xijrqw1It6MeYmk=
X-Received: by 2002:a17:902:d510:b0:25c:46cd:1dc1 with SMTP id
 d9443c01a7336-290ca216346mr216880885ad.33.1761069186605; 
 Tue, 21 Oct 2025 10:53:06 -0700 (PDT)
X-Received: by 2002:a17:902:d510:b0:25c:46cd:1dc1 with SMTP id
 d9443c01a7336-290ca216346mr216880465ad.33.1761069185936; 
 Tue, 21 Oct 2025 10:53:05 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-292472193c2sm115441495ad.104.2025.10.21.10.53.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Oct 2025 10:53:05 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com, Farah Smith <farah.smith@broadcom.com>,
 Kishore Padmanabha <kishore.padmanabha@broadcom.com>
Subject: [PATCH v4 30/57] net/bnxt/tf_core: thor2 hot upgrade ungraceful quit
 crash
Date: Tue, 21 Oct 2025 13:50:22 -0400
Message-Id: <20251021175049.46092-31-manish.kurup@broadcom.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20251021175049.46092-1-manish.kurup@broadcom.com>
References: <20251015090024.32250-1-manish.kurup@broadcom.com>
 <20251021175049.46092-1-manish.kurup@broadcom.com>
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
index 167f2dcc1e..281c32dff8 100644
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

