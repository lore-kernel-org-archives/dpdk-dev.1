Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96361CCF9EB
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Oct 2025 16:23:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ECF1D40A70;
	Wed, 29 Oct 2025 17:23:09 +0100 (CET)
Received: from mail-oa1-f98.google.com (mail-oa1-f98.google.com
 [209.85.160.98]) by mails.dpdk.org (Postfix) with ESMTP id 9D229402A6
 for <dev@dpdk.org>; Wed, 29 Oct 2025 17:23:08 +0100 (CET)
Received: by mail-oa1-f98.google.com with SMTP id
 586e51a60fabf-3d2ea93836bso69361fac.3
 for <dev@dpdk.org>; Wed, 29 Oct 2025 09:23:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761754988; x=1762359788;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YvMAO88MadcyF1PwEMgonv0jZSIGfh/Nw2MW8Hb9JCU=;
 b=q5ffA0qtw94AHLk+fIxviFX35z/+26cKxlXquSfF4bb+u40DOhCP6gfjkEbMZp6Q9P
 Hk2fw1R9ijAPlKPy072fNg+rUWLMmYhF3PhSOmXfPUJ6w3WScAodV4eMxwduG6dpK3Ey
 6bk7WZcz8z0qp9Jwn2+s/9Ge5l7OnZXC3KinGfFJYwSRWC0SjTgf6xhoW5qPLU1J9m1D
 rDRCvr9t64tyRCb/BqxGFQXIlTJ5DsRqpEV9voX/zPs5P7eE2xDHObJ1l4iechArH95d
 f+1cuCMbRBdrIoiGmpepToaga82md3Nbmv/QeQJJFfjC6kJoxgSSS9yfyQsAeyU27hxj
 lDIA==
X-Gm-Message-State: AOJu0Yx9sGR+B54v6VuZcGhkl/HvasUIY0UE9xmH5BpYEugsoK1UmkIG
 T2ahHVSgdm5pATFVtj2Ygj0aC6IboGhYTCuNfRCbijWr1ZBUda8yagUz47yG4OwiqjLzwQbThro
 5uw1e4+jJhYCeo703p7XuLDXkElTNwyXwAdWGbfLDwFhKYkkmHn1Z8q+dWJtRm+uAgL+fOy8sCG
 +ArxpNco8miC9iVpoM00YkfRaiP2zLwvs6rStg6kKm/E/S4cbpHdGMMTBEvmffA3acsja7oQ==
X-Gm-Gg: ASbGncsByiOHmeSLF6RL6gtw9n/IwGsUBSqG45JK+8UThv92wo35T6ueMzuCe8M5r3v
 gOdwwrUGS9YJpRkW4TdBiiY7PgWHuGvSLFjZNcnguT6iTqOoK8oL8euSX9Cu5er35F11ta8nboX
 yKuZprnosQXjoJUruYdst0to+zodR7KLPD/u3zS9Y+Y8eC14uD6yDIOIAsQaXeh0alvGCkkzwe8
 1e+pZdyubBTXDXA+ec7gPykIcW5VHB0WELdVTDUU5J+RQAchuIXIEyxh7WN8CC+LXenDW5fu157
 Z2aFg8d5aW7bjCJheOJVxSYo+somYPG6SEhgOsob5GMA3I3UtoP0GNAfuHk/qPLi/MD2rylROZJ
 jeFpznPOtTHWLQqmnEE770YBGM0FCuUyUvJegDoBS9HeHCT6nd6wHCJvbnK4A59uN3dXJrZDuLh
 wneKWs4wWT5AC2bVKwhhZ4RorMFHEaDUlScu3T
X-Google-Smtp-Source: AGHT+IHFJH45kIqZR5rN424ri9zRhQdIpEusBhM3j7R7oReyTTiC7E8Cz3JH5Mph8PT9TiiPweQIx3BzpLVx
X-Received: by 2002:a05:6870:8a0f:b0:319:be1e:9dce with SMTP id
 586e51a60fabf-3d7496f7b85mr1487007fac.5.1761754987747; 
 Wed, 29 Oct 2025 09:23:07 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-101.dlp.protect.broadcom.com. [144.49.247.101])
 by smtp-relay.gmail.com with ESMTPS id
 586e51a60fabf-3d1e344793dsm1312634fac.13.2025.10.29.09.23.07
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 29 Oct 2025 09:23:07 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-88f7eff9d5fso2627985a.0
 for <dev@dpdk.org>; Wed, 29 Oct 2025 09:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1761754986; x=1762359786; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YvMAO88MadcyF1PwEMgonv0jZSIGfh/Nw2MW8Hb9JCU=;
 b=Qcd3pm1v3HTey+AuwVIsVDSaa6hOK3cjV1ROkw74Uf9Lxb3uQw5yei55YFMnpcd94a
 +S/112lgp/DNCJgLTZYxyzFSP2J4Gtv6P5StMk9P7Y1prki30Hp2ZK98gnKgJForvtgA
 vfCEy6eXJC/v/0zaIV/tY93e7/yQQUaBPGKvQ=
X-Received: by 2002:a05:620a:4726:b0:88f:c0e1:ec2 with SMTP id
 af79cd13be357-8aa2e346f40mr21296385a.60.1761754986400; 
 Wed, 29 Oct 2025 09:23:06 -0700 (PDT)
X-Received: by 2002:a05:620a:4726:b0:88f:c0e1:ec2 with SMTP id
 af79cd13be357-8aa2e346f40mr21291485a.60.1761754985811; 
 Wed, 29 Oct 2025 09:23:05 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-89f2421fba6sm1089026785a.4.2025.10.29.09.23.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 29 Oct 2025 09:23:05 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com,
 Sangtani Parag Satishbhai <parag-satishbhai.sangtani@broadcom.com>
Subject: [PATCH v5 47/57] net/bnxt: truflow remove RTE devarg processing for
 mpc=1
Date: Wed, 29 Oct 2025 12:07:02 -0400
Message-Id: <20251029160712.58519-48-manish.kurup@broadcom.com>
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

From: Sangtani Parag Satishbhai <parag-satishbhai.sangtani@broadcom.com>

Now as the mpc is initialized for P7 platform regardless
of mpc=1 devarg, RTE and bnxt argument processing APIs
for mpc devarg are redundant. This patch removes such RTE
and bnxt APIs. The "mpc=1" devarg is now invalid and should
not be used while launching an application.

Before:
     ./dpdk-testpmd -c 0xff -a 0000:0a:00.0,mpc=1,app-id=0
After:
     ./dpdk-testpmd -c 0xff -a 0000:0a:00.0,app-id=0

Signed-off-by: Sangtani Parag Satishbhai <parag-satishbhai.sangtani@broadcom.com>
Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
---
 drivers/net/bnxt/bnxt.h        |  3 ---
 drivers/net/bnxt/bnxt_ethdev.c | 19 ++++---------------
 2 files changed, 4 insertions(+), 18 deletions(-)

diff --git a/drivers/net/bnxt/bnxt.h b/drivers/net/bnxt/bnxt.h
index 90352d537c..83ae151066 100644
--- a/drivers/net/bnxt/bnxt.h
+++ b/drivers/net/bnxt/bnxt.h
@@ -854,9 +854,6 @@ struct bnxt {
 	((bp)->flags2 & BNXT_FLAGS2_MULTIROOT_EN)
 
 #define	BNXT_FLAGS2_COMPRESSED_RX_CQE		BIT(5)
-#define	BNXT_FLAGS2_USE_MPC			BIT(6)
-#define BNXT_USE_MPC(bp)			\
-	((bp)->flags2 & BNXT_FLAGS2_USE_MPC)
 #define	BNXT_FLAGS2_REP_MODE			BIT(7)
 #define BNXT_REP_MODE_EN(bp)			\
 	((bp)->flags2 & BNXT_FLAGS2_REP_MODE)
diff --git a/drivers/net/bnxt/bnxt_ethdev.c b/drivers/net/bnxt/bnxt_ethdev.c
index 50bc0f1f9e..7a2dd08951 100644
--- a/drivers/net/bnxt/bnxt_ethdev.c
+++ b/drivers/net/bnxt/bnxt_ethdev.c
@@ -152,11 +152,6 @@ static const struct rte_eth_speed_lanes_capa speed_lanes_capa_tbl[] = {
  */
 #define BNXT_DEVARG_CQE_MODE_INVALID(val)		((val) > 1)
 
-/*
- * mpc = an non-negative 8-bit number
- */
-#define BNXT_DEVARG_MPC_INVALID(val)			((val) > 1)
-
 /*
  * app-id = an non-negative 8-bit number
  */
@@ -207,7 +202,6 @@ static const struct rte_eth_speed_lanes_capa speed_lanes_capa_tbl[] = {
 #define BNXT_DEVARG_REP_FC_F2R_INVALID(rep_fc_f2r)	((rep_fc_f2r) > 1)
 
 int bnxt_cfa_code_dynfield_offset = -1;
-unsigned long mpc;
 
 /*
  * max_num_kflows must be >= 32
@@ -1759,8 +1753,7 @@ static int bnxt_dev_stop(struct rte_eth_dev *eth_dev)
 	/* Process any remaining notifications in default completion queue */
 	bnxt_int_handler(eth_dev);
 
-	if (mpc != 0)
-		bnxt_mpc_close(bp);
+	bnxt_mpc_close(bp);
 
 	bnxt_shutdown_nic(bp);
 	bnxt_hwrm_if_change(bp, false);
@@ -1856,11 +1849,9 @@ int bnxt_dev_start_op(struct rte_eth_dev *eth_dev)
 	if (rc)
 		goto error;
 
-	if (mpc != 0) {
-		rc = bnxt_mpc_open(bp);
-		if (rc != 0)
-			PMD_DRV_LOG_LINE(DEBUG, "MPC open failed");
-	}
+	rc = bnxt_mpc_open(bp);
+	if (rc != 0)
+		PMD_DRV_LOG_LINE(DEBUG, "MPC open failed");
 
 	rc = bnxt_alloc_prev_ring_stats(bp);
 	if (rc)
@@ -7208,8 +7199,6 @@ static bool bnxt_enable_ulp(struct bnxt *bp)
 	/* not enabling ulp for cli and no truflow apps */
 	if (BNXT_TRUFLOW_EN(bp) && bp->app_id != 254 &&
 	    bp->app_id != 255) {
-		if (BNXT_CHIP_P7(bp) && !mpc)
-			return false;
 		return true;
 	}
 	return false;
-- 
2.39.5 (Apple Git-154)

