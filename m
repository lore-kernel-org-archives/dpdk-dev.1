Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67CCFCCD18E
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 09:07:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9810A40E49;
	Wed, 15 Oct 2025 11:05:23 +0200 (CEST)
Received: from mail-pl1-f228.google.com (mail-pl1-f228.google.com
 [209.85.214.228])
 by mails.dpdk.org (Postfix) with ESMTP id E63CE4113C
 for <dev@dpdk.org>; Wed, 15 Oct 2025 11:05:21 +0200 (CEST)
Received: by mail-pl1-f228.google.com with SMTP id
 d9443c01a7336-27ee41e074dso73000325ad.1
 for <dev@dpdk.org>; Wed, 15 Oct 2025 02:05:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760519121; x=1761123921;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LSIjNApd9Nkw+fs6CduYC6akGiAmnRNol514g3YNUQI=;
 b=jchHnwA8JV+3Yh23u94DqOg8MZbXFVLV1pkywSAZY18xq31vpK9cewrOpTEWD3oS70
 uHilvIaxUhwRJD5wvTOYJEuGjsrafBfCr0bHGIVZxp1zZHR/WIp4X0Wn+ggNbGT3iXhL
 HXrL2TXkAGIwoK7GNM0oeZPSE9xXUqO5hcf3f9m7DFXH/R+yU4JgH7249jTfZKMnRXrG
 k6I6iDtwLiKFow402WauRVGkiHCki8oHl/vGu3ZNZZz5N2qF94r5JcMudV9r8oG3M0RW
 4lEF7CXxahufVS21kzu1yOhAtxmReF8oW9odH7sDHfvkcSWB8xnLT+l2/PGkJXLMA2Kt
 1z+A==
X-Gm-Message-State: AOJu0YwRwbhediRZIaRCctbK1vK1tOst8H+dZaigzoxV3mVKvxCRtCUK
 iuTwGtmJzBXu5cambY5gQvUF8Tn/5cfl1vqEPIILvH1PB4JvSYLZnzKajo1aKiC+0TQCxHbYJCa
 XMmCcyQKmHoHjdn1tx6rWhWzBqngslgnZdk6xV5PxpMnJWV22ayKbLbEv7jFuz4V+6kEjxRUk7U
 tgfDb0zqk7wkUECheEWHlYmiYmrE5YIJ3AqJfxZ1EtAqHEZjzSC/Nr+pZG+Ut2MOD3cjw6hA==
X-Gm-Gg: ASbGncvqAEIrUBatV+K9vOfGbp3spH9HjAHK+yDCqWZUNmwo6TWa5vTV/UVobJAsrBY
 6cypcZQo/uRxn3SGj1Jw9cFHt5PZuAw++VRH3gGWF5kkjf13XmhS2Ol9A2fUuXU/g/XCeLMezeE
 P9ALCwDMGhRtYklaW4bS3IjtuY/dpXKrFDeqtmA50Gpl51TC0XsTbW2qpTa/BDGNLHsrBbngf4w
 Fkxg8Lr0DX9EzCsxbWHOz0kDSmuWj4PlrteKPbNgcn4cpgi7S+Z1gfs6dxZGrmbQlDMoZBwKy9N
 xvDMZVCDpZns57YVv0tEJqps6dugSc+4zxud59DAshIYSAH+RUdINKyHA6nqO/0GHM2yV7uOFT5
 86B1MoKzo4xbyVGUmplZadJ08nIEV9MgHqYNz0X60BBc/wQ4UKg+7NiaSW/gwyOKtK0036fPO
X-Google-Smtp-Source: AGHT+IGR41jNkJxa6rwI2ddBdPEpLJUlMpwdXeGd1BS5iMOk8P3MEj601diS1bDsvazmuoPYC0wnVtVh2bi2
X-Received: by 2002:a17:903:1a2b:b0:268:5892:6a2e with SMTP id
 d9443c01a7336-290272ff539mr348166855ad.56.1760519120844; 
 Wed, 15 Oct 2025 02:05:20 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-1.dlp.protect.broadcom.com. [144.49.247.1])
 by smtp-relay.gmail.com with ESMTPS id
 d9443c01a7336-29034e2bec7sm16100965ad.29.2025.10.15.02.05.20
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 15 Oct 2025 02:05:20 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-b67e14415dfso1514635a12.0
 for <dev@dpdk.org>; Wed, 15 Oct 2025 02:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1760519118; x=1761123918; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LSIjNApd9Nkw+fs6CduYC6akGiAmnRNol514g3YNUQI=;
 b=AWihz7I2DBxOGAPvLVmgRwciMUMZ10YLAJLM5aJDlwYlRhDKsIszAuIkfhn4emhebD
 VHpQc49H538oIu7YTrR1m07ComIIhLRDKxrScmxJV8/YpYTXvl7BTvcFtDlgG7c3YPAY
 PTmiUkeNnEKGWNqXFYHzzlO/NfSd/BLtr13PE=
X-Received: by 2002:a05:6a21:9999:b0:32b:7001:6601 with SMTP id
 adf61e73a8af0-32da814f674mr37537150637.25.1760519118479; 
 Wed, 15 Oct 2025 02:05:18 -0700 (PDT)
X-Received: by 2002:a05:6a21:9999:b0:32b:7001:6601 with SMTP id
 adf61e73a8af0-32da814f674mr37537098637.25.1760519117723; 
 Wed, 15 Oct 2025 02:05:17 -0700 (PDT)
Received: from localhost.localdomain ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7992bc12a8asm17832412b3a.34.2025.10.15.02.05.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 15 Oct 2025 02:05:17 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com,
 Sangtani Parag Satishbhai <parag-satishbhai.sangtani@broadcom.com>
Subject: [PATCH v3 44/54] net/bnxt: truflow remove RTE devarg processing for
 mpc=1
Date: Wed, 15 Oct 2025 05:00:14 -0400
Message-Id: <20251015090024.32250-45-manish.kurup@broadcom.com>
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
index c92e335a51..854c8b7371 100644
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
@@ -7213,8 +7204,6 @@ static bool bnxt_enable_ulp(struct bnxt *bp)
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

