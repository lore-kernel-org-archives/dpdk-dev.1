Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42677CC6B0E
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Oct 2026 17:16:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7E4EF4069D;
	Tue, 13 Oct 2026 19:16:10 +0200 (CEST)
Received: from mail-qv1-f100.google.com (mail-qv1-f100.google.com
 [209.85.219.100])
 by mails.dpdk.org (Postfix) with ESMTP id A73C240687
 for <dev@dpdk.org>; Tue, 13 Oct 2026 19:16:08 +0200 (CEST)
Received: by mail-qv1-f100.google.com with SMTP id
 6a1803df08f44-917d595138fso24441966d6.3
 for <dev@dpdk.org>; Tue, 13 Oct 2026 10:16:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791911768; x=1792516568;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6c1EtAwXDroh+HZzSC3oMtmMC2vvvCl2CLrfxGufbL0=;
 b=FFUOrvtqC8wVJiC4WnnT4r/TooewaolN79di5msVAMVMhVsSAV9xz9hNrS488t5DpH
 l88vYUtbZJ1tMjmsH7FMwqTZV9/U3ypafs/gc6RTGdHhoDPULnLinSbivB+glyr/Q9eU
 qdWt/mTEKE2MZWSgEeOnUooOgUa4PT5BJx1r7e1bTaHZwOsUpjQuQZuuSshQWhryT/xX
 VGIzgCsmdS95p8jR+WOyB0Q0I2aVIe8QW++KqOmknYdFq7ADGo2gtLm7K1Qtxg+N+ZKd
 3tKZ1I9s7X+GNQ5f1+LWkFDg4jXl3qjMGDjAxly2l2ZmbBx2NaioEfjB27SQslW/YYq1
 1T5w==
X-Gm-Message-State: AFq9FYLQJFg+WhSuTLYtXPXTea5j30mOWRwX7qkf2reNIIQmtRCRI5+j
 +8y+cxSLA5Pk5WsYS65Pkle3l9hc80UUWQJ+sBQfxM/tuOLWXHPuZorwAFT40rpRF0HXWDmHaOH
 jqFaSjjHHh0uA0JeIUucS6mxeXZyy7yr/N2XTQnaes9S49pRod1SF5KTcnG25cYbIjdKDDNaAEN
 2TciZqVVVlOqTE9+HO5S6yCtVsFET6EONMGMt6crsP+LRVTTKmW4BmL1Hc1tnpNPqxsrhGBCEBV
 R99t/u265Xu
X-Gm-Gg: AYBFou0w6q5TpaAk8vsgmipRDNLJLORRG/WaiRScDzOfwFCCA9p6Sy4Rstyy2Lgi67t
 VWOfit4cz5qqgmBc+YttocJI8dft42adhCw8SipQ6kqwjcGbAWtAhetaUSWv/DutF4QH4TdSEap
 0/FL8xG6otZsNwFt1972asn4y0tKqjXM3Ev7X/gyY+qYqouWtgnKstq63awIfU1m/pdmpgnprMe
 p6ViVUoRP87jkQvIA1/JA+hxZCh+XfLgA5G07dt7RLgaacLRUxfFdl1vkNpXP6d3BlxkSHh4Lfx
 tOxFsZLQ4nveiWNgd9krNCODrV2PVoPKjuvJAzyUmB4MnVQDluhRG2G1fIX6yWtYy7lCZdTiKnN
 gexQQiqlPEQ41YIMYY4zzj0B75WDkZvTSFhM/67c3n8wYB6oNirrSTqbULzZvH+LR+oV6Uqqxen
 c0bUrT7pghwzjkUGLGYxH/i9ggjlkPCmSPwj6EI5Kz7dbgWUo43hQM
X-Received: by 2002:a05:620a:7117:b0:93c:68f0:f09b with SMTP id
 af79cd13be357-93ebd0bd251mr2036057885a.5.1791911767701; 
 Tue, 13 Oct 2026 10:16:07 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
 by smtp-relay.gmail.com with ESMTPS id
 af79cd13be357-93ef506e2a5sm71533785a.10.2026.10.13.10.16.07
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 13 Oct 2026 10:16:07 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-533928ef33aso43218321cf.1
 for <dev@dpdk.org>; Tue, 13 Oct 2026 10:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1791911767; x=1792516567; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6c1EtAwXDroh+HZzSC3oMtmMC2vvvCl2CLrfxGufbL0=;
 b=TtS/uLP0k1otLDWHEb2W9zECD7DWfJfS4wCoHWmsMb+aY2knQ2YgPKHdNa9c2jsABi
 NylLnmh9vh1MpQ+AMya8K6Ood/ehbm9B3Wo09WVbyR2N219OXL36c8yOpAI00h26Cx4V
 pPekBrYeEnepXXWKTFyy3mbsCOW+kOmSRNdUQ=
X-Received: by 2002:a05:622a:4d05:b0:535:ed1:cdbb with SMTP id
 d75a77b69052e-5359f46d560mr214415161cf.1.1791911766929; 
 Tue, 13 Oct 2026 10:16:06 -0700 (PDT)
X-Received: by 2002:a05:622a:4d05:b0:535:ed1:cdbb with SMTP id
 d75a77b69052e-5359f46d560mr214414231cf.1.1791911766315; 
 Tue, 13 Oct 2026 10:16:06 -0700 (PDT)
Received: from nic1-cos.dhcp.broadcom.net ([192.19.220.253])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91b978387f7sm30334656d6.6.2026.10.13.10.16.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 10:16:05 -0700 (PDT)
From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
X-Google-Original-From: Mohammad Shuab Siddique
 <Mohammad-Shuab.Siddique@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com, manish.kurup@broadcom.com,
 Dakota Sicher <dakota.sicher@broadcom.com>, stable@dpdk.org,
 Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
Subject: [PATCH v2] net/bnxt: fix parent MAC lookup path handling
Date: Tue, 13 Oct 2026 11:19:49 -0600
Message-ID: <20261013171949.452390-1-Mohammad-Shuab.Siddique@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261005202530.18031-1-manish.kurup@broadcom.com>
References: <20261005202530.18031-1-manish.kurup@broadcom.com>
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

ulp_pmd_get_mac_by_pci() builds sysfs paths with sprintf() into a
256 byte buffer from a PCI name and an interface name taken from
glob(). Use snprintf() and fail if the path is truncated.

The glob() result was also never released. Call globfree() on every
exit path once glob() has succeeded.

Fixes: 1993b267dbcb ("net/bnxt: cleanup ULP parser and mapper")
Cc: stable@dpdk.org

Signed-off-by: Dakota Sicher <dakota.sicher@broadcom.com>
Signed-off-by: Manish Kurup <manish.kurup@broadcom.com>
Signed-off-by: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
---
v2:
 - Also free the glob() result on every exit path; it was never released
 - Drop the ulp_utils.h hunks, they are covered by the -Warray-bounds patch
 - New subject and body, Cc: stable added

 drivers/net/bnxt/tf_ulp/bnxt_tf_pmd_shim.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/net/bnxt/tf_ulp/bnxt_tf_pmd_shim.c b/drivers/net/bnxt/tf_ulp/bnxt_tf_pmd_shim.c
index bfd5f4b230e..81e335da592 100644
--- a/drivers/net/bnxt/tf_ulp/bnxt_tf_pmd_shim.c
+++ b/drivers/net/bnxt/tf_ulp/bnxt_tf_pmd_shim.c
@@ -140,30 +140,38 @@ static int32_t ulp_pmd_get_mac_by_pci(const char *pci_name, uint8_t *mac)
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
-			return rc;
+			goto free_glob;
 
 		/* Replace the PCI address with interface name and get index */
 		intf_name = basename(gres.gl_pathv[0]);
-		sprintf(path, ULP_PRT_MAC_PATH, pci_name, intf_name);
+		pr = snprintf(path, sizeof(path), ULP_PRT_MAC_PATH, pci_name, intf_name);
+		if (unlikely((size_t)pr >= sizeof(path) || pr < 0)) {
+			BNXT_DRV_DBG(ERR, "Error writing path: %s", path);
+			goto free_glob;
+		}
 
 		fp = fopen(path, "r");
 		if (!fp) {
 			BNXT_DRV_DBG(ERR, "Error in getting bond mac address\n");
-			return rc;
+			goto free_glob;
 		}
 
 		memset(dev_str, 0, sizeof(dev_str));
 		if (fgets(dev_str, sizeof(dev_str), fp) == NULL) {
 			BNXT_DRV_DBG(ERR, "Error in reading %s\n", path);
 			fclose(fp);
-			return rc;
+			goto free_glob;
 		}
 
 		if (sscanf(dev_str, "%hhx:%hhx:%hhx:%hhx:%hhx:%hhx\n",
@@ -171,6 +179,8 @@ static int32_t ulp_pmd_get_mac_by_pci(const char *pci_name, uint8_t *mac)
 			   &mac[3], &mac[4], &mac[5]) == 6)
 			rc = 0;
 		fclose(fp);
+free_glob:
+		globfree(&gres);
 	}
 	return rc;
 }
-- 
2.47.3

