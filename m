Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1372CCA5FF5
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 Oct 2026 23:50:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E3F1E402DD;
	Tue,  6 Oct 2026 01:50:44 +0200 (CEST)
Received: from mail-pj1-f100.google.com (mail-pj1-f100.google.com
 [209.85.216.100])
 by mails.dpdk.org (Postfix) with ESMTP id 69DB9402DA
 for <dev@dpdk.org>; Tue,  6 Oct 2026 01:50:43 +0200 (CEST)
Received: by mail-pj1-f100.google.com with SMTP id
 98e67ed59e1d1-3a80e169311so224978a91.1
 for <dev@dpdk.org>; Mon, 05 Oct 2026 16:50:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791244242; x=1791849042;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ec3sqeQZYnX3M3GhEUIC3PoBSlGWOEHpwrukX7SzvZQ=;
 b=aJ6UNFFmeEBLqMCut4HIaf3nw2YumHO3mzn6ZHxRZl4h5UdY7pWic+P2ahF1q6e89m
 +/KOvPTD3TeAx19AjhHIiRO7tUwsDIl8be44efwsSNY4rVT8c37jeY1ozcep8mdzRmHm
 sySVJqIVVwnTOJjdK6kXqvEyGOlY0jaZc1SHuvATrXVuEmzehyd0kQp91QCB3Z6BETJT
 rIXSUS+1yZtlU5nD6J047lnN89T/syhpmd9CPCKO1AHcmtg1yQsiF0Tq3YmD95+/2Kjo
 AqPrRiPnhIdnhu3zm8efoWTYlUSq7D//uXiznXxULb8/IEIkUbupmysXJhFKAci50RIz
 G22w==
X-Gm-Message-State: AFq9FYJCl112cEa4S7FdKLPdHgfx3v3oUN5Wgz/K3e85nMc8XmncjhAU
 pu/3IhA7YAv/pemO8nH1IOHgGPWMMkr7ruSWaJBpSKGIfdb76p6a3seNoqrd9fJR4nitwUMukWb
 8yY8Lcfak00Q5aE/mXCBbSHRMqYxKZS26rXuE0d5tGCNHLudGdPA/q6ljWOHuO+mSqa4tn0Ct0Y
 WP4ZhuDOo6qJdvMJTdZ8gcBgn36u72W8lLux1k+7S4dne1aI6v55eOzYdTHXsvydNYa62Okw==
X-Gm-Gg: AYBFou0QQaGAYRpxfQtXrA8RZ3MG+ksC/IsFmGUna74zr5h9+EOU1pNn/iGz07OQmZI
 bRpo8kjbqhtNv3QpFAKlXIBL3GPq9GaensYUNEkhjBu5CboQKLQKHj3ALhHMHvYR9lIfj84kKo0
 cV9dSXmXXGVO+lPjonCh8fRUBzGyc9wk2BpyJDKwENotbcn/NzAWm5jyquMRxXN1XHOkzZyPpQh
 D4EWKXrgi97OT+SO3UDP1ZvdvzHzdTNIaR9pVD2+LAfa143hCoVBur5acIfEUPMVrJfVfX9N3Z2
 EfBo1tWQY1yO8QdlZod15we2cTgi+LGFpaDf9fV7GUCQsjfNJTYibfGEpi+BBdPtPgc9cusGf0D
 lm59XrFBCCAyp1kJOkjRybOJIL+c77biD0pECiJQtGBzlVxfP7ibkZunI87tDZuc2H6lXh88yyA
 tUTreDIV3A+01cyMEYytsf0R52Gm3z+a+IEjHVuQ==
X-Received: by 2002:a17:90a:d2d0:b0:3a4:dbda:9934 with SMTP id
 98e67ed59e1d1-3a6ce983199mr4687394a91.63.1791244242236; 
 Mon, 05 Oct 2026 16:50:42 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-125.dlp.protect.broadcom.com. [144.49.247.125])
 by smtp-relay.gmail.com with ESMTPS id
 98e67ed59e1d1-3a853e5e392sm490436a91.4.2026.10.05.16.50.41
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 05 Oct 2026 16:50:42 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93cbacbb996so361103885a.2
 for <dev@dpdk.org>; Mon, 05 Oct 2026 16:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1791244241; x=1791849041; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ec3sqeQZYnX3M3GhEUIC3PoBSlGWOEHpwrukX7SzvZQ=;
 b=M2ruKZAG2zfx9x90PQgGrP6ky5IuqCnh1Q+11tw8NffZ3PoKSIFrm9rup857yDdD8f
 aelMzmNOKW+8HAbMBli6PlJZuyZQDkrARR2jw8KH/63C4jwh525JY2eg2uDAP37TClDA
 um8QFSbqNtdDif6+7aUxbnkOInftLFBOMgh80=
X-Received: by 2002:a05:620a:43a5:b0:93a:13aa:1b9 with SMTP id
 af79cd13be357-93cf16fcca5mr2129068785a.30.1791244241017; 
 Mon, 05 Oct 2026 16:50:41 -0700 (PDT)
X-Received: by 2002:a05:620a:43a5:b0:93a:13aa:1b9 with SMTP id
 af79cd13be357-93cf16fcca5mr2129065785a.30.1791244240394; 
 Mon, 05 Oct 2026 16:50:40 -0700 (PDT)
Received: from r740-105-132.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93e457a4e20sm877944585a.40.2026.10.05.16.50.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 16:50:39 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com, Joseph Wong <joseph.wong@broadcom.com>,
 stable@dpdk.org
Subject: [PATCH] net/bnxt: add bounds checks for FW-supplied IDs
Date: Mon,  5 Oct 2026 18:50:34 -0500
Message-Id: <20261005235034.26923-1-manish.kurup@broadcom.com>
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

From: Joseph Wong <joseph.wong@broadcom.com>

In ulp_port_db_port_update(), firmware supplies IDs (drv_func_id,
vf_func_id, phy_port_id) which are used as array indices. Add
strict bounds checking to prevent out of bounds memory accesses.

Fixes: ad9eed0248ad ("net/bnxt: support flow template for Thor")
Fixes: 1993b267dbcb ("net/bnxt: cleanup ULP parser and mapper")
Fixes: ddaf0afae48a ("net/bnxt: refactor ULP mapper")
Cc: stable@dpdk.org

Signed-off-by: Joseph Wong <joseph.wong@broadcom.com>
Signed-off-by: Manish Kurup <manish.kurup@broadcom.com>
---
 drivers/net/bnxt/tf_ulp/ulp_port_db.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/net/bnxt/tf_ulp/ulp_port_db.c b/drivers/net/bnxt/tf_ulp/ulp_port_db.c
index 6907771725..aad66fd8ab 100644
--- a/drivers/net/bnxt/tf_ulp/ulp_port_db.c
+++ b/drivers/net/bnxt/tf_ulp/ulp_port_db.c
@@ -159,6 +159,11 @@ int32_t	ulp_port_db_port_update(struct bnxt_ulp_context *ulp_ctxt,
 	intf->drv_func_id = bnxt_pmd_get_fw_func_id(port_id,
 						BNXT_ULP_INTF_TYPE_INVALID);
 
+	if (intf->drv_func_id >= BNXT_PORT_DB_MAX_FUNC) {
+		BNXT_DRV_DBG(ERR, "Invalid drv_func_id %d", intf->drv_func_id);
+		return -EINVAL;
+	}
+
 	func = &port_db->ulp_func_id_tbl[intf->drv_func_id];
 	if (!func->func_valid) {
 		func->func_svif = bnxt_pmd_get_svif(port_id, true,
@@ -180,6 +185,11 @@ int32_t	ulp_port_db_port_update(struct bnxt_ulp_context *ulp_ctxt,
 		intf->vf_func_id =
 			bnxt_pmd_get_fw_func_id(port_id, BNXT_ULP_INTF_TYPE_VF_REP);
 
+		if (intf->vf_func_id >= BNXT_PORT_DB_MAX_FUNC) {
+			BNXT_DRV_DBG(ERR, "Invalid vf_func_id %d", intf->vf_func_id);
+			return -EINVAL;
+		}
+
 		func = &port_db->ulp_func_id_tbl[intf->vf_func_id];
 		func->func_svif =
 			bnxt_pmd_get_svif(port_id, true, BNXT_ULP_INTF_TYPE_VF_REP);
@@ -206,6 +216,11 @@ int32_t	ulp_port_db_port_update(struct bnxt_ulp_context *ulp_ctxt,
 	bnxt_pmd_get_iface_mac(port_id, intf->type, func->func_mac,
 			   func->func_parent_mac);
 
+	if (func->phy_port_id >= port_db->phy_port_cnt) {
+		BNXT_DRV_DBG(ERR, "Invalid phy_port_id %d", func->phy_port_id);
+		return -EINVAL;
+	}
+
 	port_data = &port_db->phy_port_list[func->phy_port_id];
 	if (!port_data->port_valid) {
 		port_data->port_svif =
-- 
2.31.1

