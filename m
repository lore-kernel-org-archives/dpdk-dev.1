Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28736CCF9F0
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Oct 2025 16:18:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7735C4067A;
	Wed, 29 Oct 2025 17:18:54 +0100 (CET)
Received: from mail-il1-f228.google.com (mail-il1-f228.google.com
 [209.85.166.228])
 by mails.dpdk.org (Postfix) with ESMTP id 2D48240665
 for <dev@dpdk.org>; Wed, 29 Oct 2025 17:18:53 +0100 (CET)
Received: by mail-il1-f228.google.com with SMTP id
 e9e14a558f8ab-430cd27de3eso32632365ab.1
 for <dev@dpdk.org>; Wed, 29 Oct 2025 09:18:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761754732; x=1762359532;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=B52fhcvvKdNkFuCPwtsJjCH9RYlndSIvJEyAeQzGlnk=;
 b=NHewlysBX3AJgZVxZSJr55ZIQmmknoJzc8AW/tJ4IZJYxF8Dyp9Fv8pG+5vqUvh6Ep
 6cLKGPV21uFQ9/vn9X7y65C7E/0N0YSWn7zCcQ7R0J0onEhIeFFhJqKjFlkY+OALlmH/
 jqUr40KxKNB6RvSBUDl9/6bwGMBWktcMl10TbDUJybkVxvrdfX9kmyntfABsd5OvsMqd
 elbQbmTCSjDK1LXPCjPplVjSDugqx29GycXKLjRv7dPn1S7gI4cWmGBcCMsK2lY6OPC8
 JK2hoMUG7LFvF870hf2quSYBVRdBKd6ymORdFtQfyTZhckRFzxpyFrDc3fiy4ABvTrs4
 6ayQ==
X-Gm-Message-State: AOJu0Yz1qmZPvyJLxzJkT8p4oWdVJzPJxxrVMhN7XY5L+NBq7CunAlXP
 Ubj3uQKJRrDXxJy5UM7UYDVIcZzbridzygmrQG2TkvhajFTPVzi5FwIqQuHNaxmPk3uoN9l61kE
 zKdeiLJHyp5yvr6l64fAp1sRMKUUHrCByBCaflSfnErwTrqLXD/T9UnPpu3NJFjeazt411CEfT6
 4UTIsHKQpJELh6weaqV0ABaMJJPVcOVmlThMqc0FcL/zl1uTIF6IPxAY2VL7U87wv1ELdhUQ==
X-Gm-Gg: ASbGnctv7leohYr4RhRZhMw/MkU3Whd42/IZpbeEyfqPs+IHsPWL/TTFUYyG7yu1LDm
 VBZQWvEqO1aFh/zg2U2g67cLEYEmePYOQUWE0RoZ6B21/zGGPZxleoPejiImdVp4wuHDw8VrRVb
 MngxDRkewdzFpdbSDfKR1H+IQZwYKUG8Ytme+e/uGfpiN4HcZRfx11MloT53SA7XQ4g77vLjcGc
 7vG+f78Ho8HJhpUbp4csEDqpd9RcWjEr4GeOaZX3ZP0d0T5WQVqgltPzgY8xRRjt29Y6qc7S3pg
 GNoPOC3PjGJ3I507KMewRq0zeaBEKIgbl+yFDbnGuY01ZHxTu+1FgE1guqW/1yl5mCLR1banMKd
 ygs8uh8vaJ5pBwmhOUT97sZlwp/H8zPNdqH2QkZijfq8PUV82OEXnz+ESzWHS8QWXHch6WSPaC9
 SWEXb6+tgwgHkLO/r7KG5WkhkUEa2DkGldag==
X-Google-Smtp-Source: AGHT+IGUP/wMCLgNav5FXp8SuaVLJhvFUSl9HCN8WvABgx95mNjenXSvSW+hcCPxOhnY3p/GOjsGzWmrwI6n
X-Received: by 2002:a05:6e02:2183:b0:42e:7ab6:ec89 with SMTP id
 e9e14a558f8ab-4330156ea21mr136385ab.32.1761754732362; 
 Wed, 29 Oct 2025 09:18:52 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-19.dlp.protect.broadcom.com. [144.49.247.19])
 by smtp-relay.gmail.com with ESMTPS id
 e9e14a558f8ab-431f689a695sm14007945ab.29.2025.10.29.09.18.52
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 29 Oct 2025 09:18:52 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-89ee646359cso1682591285a.1
 for <dev@dpdk.org>; Wed, 29 Oct 2025 09:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1761754731; x=1762359531; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B52fhcvvKdNkFuCPwtsJjCH9RYlndSIvJEyAeQzGlnk=;
 b=MkMZSIjAQ2VgMPl92R4jh+Ki6DgkeOO5ybEfyIJKd0ktwDZF6OFgmidmAl0XZ/R7N2
 mzY3gU4zWK6isrokNe/jeQJduEOErC4SU76h3yH9nR+txxyM34z8VEOC/Jzap9CbBb3p
 MqyD8SnRIFaQ0YCvOOwXmR6FCcgj09gzeSaUQ=
X-Received: by 2002:a05:620a:1aa2:b0:85f:89:e0f7 with SMTP id
 af79cd13be357-8aa2c08edf3mr25604285a.16.1761754731168; 
 Wed, 29 Oct 2025 09:18:51 -0700 (PDT)
X-Received: by 2002:a05:620a:1aa2:b0:85f:89:e0f7 with SMTP id
 af79cd13be357-8aa2c08edf3mr25597785a.16.1761754730548; 
 Wed, 29 Oct 2025 09:18:50 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-89f2421fba6sm1089026785a.4.2025.10.29.09.18.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 29 Oct 2025 09:18:50 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com, Farah Smith <farah.smith@broadcom.com>,
 Kishore Padmanabha <kishore.padmanabha@broadcom.com>
Subject: [PATCH v5 30/57] net/bnxt/tf_core: thor2 hot upgrade ungraceful quit
 crash
Date: Wed, 29 Oct 2025 12:06:45 -0400
Message-Id: <20251029160712.58519-31-manish.kurup@broadcom.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20251029160712.58519-1-manish.kurup@broadcom.com>
References: <20251021175049.46092-1-manish.kurup@broadcom.com>
 <20251029160712.58519-1-manish.kurup@broadcom.com>
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

