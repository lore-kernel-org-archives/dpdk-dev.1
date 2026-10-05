Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FF8BCA5FF5
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 Oct 2026 20:25:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0611C40DDE;
	Mon,  5 Oct 2026 22:25:41 +0200 (CEST)
Received: from mail-pj1-f99.google.com (mail-pj1-f99.google.com
 [209.85.216.99]) by mails.dpdk.org (Postfix) with ESMTP id 4B71040E3F
 for <dev@dpdk.org>; Mon,  5 Oct 2026 22:25:39 +0200 (CEST)
Received: by mail-pj1-f99.google.com with SMTP id
 98e67ed59e1d1-3a0aaa0fd13so612700a91.2
 for <dev@dpdk.org>; Mon, 05 Oct 2026 13:25:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791231938; x=1791836738;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=GmvSffvdIS1p7GlkEqDC3oUlP7jx0CEDdA3efahqgIw=;
 b=GalWnNCGkizYTgYogQTAamEGXqqgWKEpHoAZQZI5r2SGNqWODtiK/2XPm8U/wkZWiv
 zSMrNqy+JHOOszwemU0u07Dn0hwqgnnJFD+Ze+Y/uzjRa8F5aDtkXV48r5enlYKrRm1O
 g2ESXTiIjuqRkfYCXQ2NpITxfP/RYob97gkX0Z8lZJxRozHgSMGo9QXOYa8EHpM4d6CZ
 t6J0tKAcMNFqtyIxRWhm5B0GYi4X6BU+/JugfwXkBRLZs+hksIWkO00ZJ5ZlW10VXh6H
 CAj2F+8hHK41BwlIBgPLCH7kMRaIwblE/vRo9slOgWWesTfUFZGyBEL/+/LyVA9KZPx4
 gjkA==
X-Gm-Message-State: AFq9FYIXuIDBeeuEE3R077Xu3i5W2haRv72WLyk6culrQMSzeNWWKxjj
 Vu/ybjNZTubOlVJ01YVO1gx3mqFuMI9sW6BvFgeWBQin3x5DxOP9OcvsGQccX3eRvAYwYcnkJ93
 O7v1cVRO0iusPX8nrsrm5wddfNpMPZrEzQwqxQAmevonqSvCHlWAOqA8ztOayNeCkiWDvQMZRsv
 L3yePFQsjcSNpGT3ZKfJ/Zu1lDJf+qqTBDoA2H/B9hkzUS18LMFhUsMV3sOgriAHPUv3rr7A==
X-Gm-Gg: AYBFou0N77vHuKrexwjSYJvTOe3fa5IfKRyg02lcH+g6lQwU2+CPCm3gV+KB9ZGiIWF
 psp+FhkTuwmfbSipZS+zh5H0t2pItYrDKg9Ar/C2tMwA11gw+cxslk9tkUv2aEaPqjFrguunasI
 BW43e1+6zwgBN0MKkt5JDadQtvNPPiJWH4t0zJDTVA1+152QqOoyst2FXLWbvdXeMN+G4zevuOR
 I+IPWCk5rE3sh2xlDWwb0OmVAzMFvMafZ41jWWwHn5tJU9dKz16vMSW8HNqib6Od5UyUtek4+Hd
 wW3QqcMnVIszdOIsv9p4+Hcc89K3Qw8HqZpgsl8JYdSsCoXf7oUs+XgbvTr098GS0XcFLPgDYWQ
 K+9GzhQsYk7Y4aM6qJza2mgEZFRSd6zKfQKUnGZLF4hir5iFoa0np2uHf127PS5GVDCFx0kZGQz
 aQ3//dRm6bc7ae8WXKvEsYQz4FWqEDBhxiVwI=
X-Received: by 2002:a17:90b:39ac:b0:3a4:a5db:7ea3 with SMTP id
 98e67ed59e1d1-3a6cec13af2mr10869125a91.23.1791231938281; 
 Mon, 05 Oct 2026 13:25:38 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-25.dlp.protect.broadcom.com. [144.49.247.25])
 by smtp-relay.gmail.com with ESMTPS id
 98e67ed59e1d1-3a8543792c8sm289752a91.8.2026.10.05.13.25.36
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 05 Oct 2026 13:25:38 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-5345ded3f6dso47275731cf.3
 for <dev@dpdk.org>; Mon, 05 Oct 2026 13:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1791231936; x=1791836736; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=GmvSffvdIS1p7GlkEqDC3oUlP7jx0CEDdA3efahqgIw=;
 b=T+grz6FfHUyd889LQilZ0OdWXKnLsYhrmz/LsFdni2tPBdyWgceUoyqoGKogbrp+Cm
 FsClaUWAe5CG38ETnki5FjFTpH8clTih+zkUGFZTqV7W55Rz5dzq5lHEcz0f6+5TNlWY
 0On5OKxO+jl6nxJxPsgkLBkhernySXBQBbsws=
X-Received: by 2002:a05:620a:1a03:b0:93e:4594:f5bb with SMTP id
 af79cd13be357-93e4595079dmr1934539485a.59.1791231936241; 
 Mon, 05 Oct 2026 13:25:36 -0700 (PDT)
X-Received: by 2002:a05:620a:1a03:b0:93e:4594:f5bb with SMTP id
 af79cd13be357-93e4595079dmr1934533885a.59.1791231935548; 
 Mon, 05 Oct 2026 13:25:35 -0700 (PDT)
Received: from r740-105-132.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93e457a4e20sm842665385a.40.2026.10.05.13.25.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 13:25:34 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com, Dakota Sicher <dakota.sicher@broadcom.com>
Subject: [PATCH] net/bnxt: fix compiler warnings
Date: Mon,  5 Oct 2026 15:25:30 -0500
Message-Id: <20261005202530.18031-1-manish.kurup@broadcom.com>
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

From: Dakota Sicher <dakota.sicher@broadcom.com>

Fix a compiler warning in bnxt_tf_pmd_shim for comparison of
differently signed values. Fix compiler warnings for array
out-of-bounds in ulp_bs_pull_lsb and ulp_bs_pull_msb.

Fixes: 1993b267dbcb ("net/bnxt: cleanup ULP parser and mapper")

Signed-off-by: Dakota Sicher <dakota.sicher@broadcom.com>
Signed-off-by: Manish Kurup <manish.kurup@broadcom.com>
---
 drivers/net/bnxt/tf_ulp/bnxt_tf_pmd_shim.c | 14 +++++++++++---
 drivers/net/bnxt/tf_ulp/ulp_utils.h        | 14 +++++++-------
 2 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/drivers/net/bnxt/tf_ulp/bnxt_tf_pmd_shim.c b/drivers/net/bnxt/tf_ulp/bnxt_tf_pmd_shim.c
index bfd5f4b230..9a7b9bfe34 100644
--- a/drivers/net/bnxt/tf_ulp/bnxt_tf_pmd_shim.c
+++ b/drivers/net/bnxt/tf_ulp/bnxt_tf_pmd_shim.c
@@ -140,10 +140,14 @@ static int32_t ulp_pmd_get_mac_by_pci(const char *pci_name, uint8_t *mac)
 	glob_t gres;
 	FILE *fp;
 	int32_t rc = -EINVAL;
+	int32_t pr;
 
 	memset(path, 0, sizeof(path));
-	sprintf(path, PARENT_PHY_INTF_PATH, pci_name);
-
+	pr = snprintf(path, sizeof(path), PARENT_PHY_INTF_PATH, pci_name);
+	if (unlikely((size_t)pr >= sizeof(path) || pr < 0)) {
+		BNXT_DRV_DBG(ERR, "Error writing path: %s", path);
+		return rc;
+	}
 	/* There can be only one, no more, no less */
 	if (glob(path, 0, glob_error_fn, &gres) == 0) {
 		if (gres.gl_pathc != 1)
@@ -151,7 +155,11 @@ static int32_t ulp_pmd_get_mac_by_pci(const char *pci_name, uint8_t *mac)
 
 		/* Replace the PCI address with interface name and get index */
 		intf_name = basename(gres.gl_pathv[0]);
-		sprintf(path, ULP_PRT_MAC_PATH, pci_name, intf_name);
+		pr = snprintf(path, sizeof(path), ULP_PRT_MAC_PATH, pci_name, intf_name);
+		if (unlikely((size_t)pr >= sizeof(path) || pr < 0)) {
+			BNXT_DRV_DBG(ERR, "Error writing path: %s", path);
+			return rc;
+		}
 
 		fp = fopen(path, "r");
 		if (!fp) {
diff --git a/drivers/net/bnxt/tf_ulp/ulp_utils.h b/drivers/net/bnxt/tf_ulp/ulp_utils.h
index ce20f1916f..354217abc6 100644
--- a/drivers/net/bnxt/tf_ulp/ulp_utils.h
+++ b/drivers/net/bnxt/tf_ulp/ulp_utils.h
@@ -699,18 +699,18 @@ ulp_bs_pull_lsb(uint8_t *src, uint8_t *dst, uint32_t size,
 {
 	uint32_t idx;
 	uint32_t cnt = ULP_BITS_2_BYTE_NR(len);
+	uint32_t rem = len % ULP_BLOB_BYTE;
 
 	/* iterate bytewise to get data */
-	for (idx = 0; idx < cnt; idx++) {
+	for (idx = 0; idx < cnt && idx < size; idx++) {
 		ulp_bs_get_lsb(src, offset, ULP_BLOB_BYTE,
 			       &dst[size - 1 - idx]);
 		offset += ULP_BLOB_BYTE;
-		len -= ULP_BLOB_BYTE;
 	}
 
 	/* Extract the last reminder data that is not 8 byte boundary */
-	if (len)
-		ulp_bs_get_lsb(src, offset, len, &dst[size - 1 - idx]);
+	if (rem && idx < size)
+		ulp_bs_get_lsb(src, offset, rem, &dst[size - 1 - idx]);
 }
 
 /*
@@ -764,17 +764,17 @@ ulp_bs_pull_msb(uint8_t *src, uint8_t *dst,
 {
 	uint32_t idx;
 	uint32_t cnt = ULP_BITS_2_BYTE_NR(len);
+	uint32_t rem = len % ULP_BLOB_BYTE;
 
 	/* iterate bytewise to get data */
 	for (idx = 0; idx < cnt; idx++) {
 		ulp_bs_get_msb(src, offset, ULP_BLOB_BYTE, &dst[idx]);
 		offset += ULP_BLOB_BYTE;
-		len -= ULP_BLOB_BYTE;
 	}
 
 	/* Extract the last reminder data that is not 8 byte boundary */
-	if (len)
-		ulp_bs_get_msb(src, offset, len, &dst[idx]);
+	if (rem)
+		ulp_bs_get_msb(src, offset, rem, &dst[idx]);
 }
 
 /*
-- 
2.31.1

