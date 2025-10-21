Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 626A5CCD1A5
	for <dpdk-dev@archiver.kernel.org>; Tue, 21 Oct 2025 18:58:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AD2F740E39;
	Tue, 21 Oct 2025 20:58:24 +0200 (CEST)
Received: from mail-pl1-f226.google.com (mail-pl1-f226.google.com
 [209.85.214.226])
 by mails.dpdk.org (Postfix) with ESMTP id 7DCB840E39
 for <dev@dpdk.org>; Tue, 21 Oct 2025 20:58:23 +0200 (CEST)
Received: by mail-pl1-f226.google.com with SMTP id
 d9443c01a7336-292322d10feso1904475ad.0
 for <dev@dpdk.org>; Tue, 21 Oct 2025 11:58:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761073103; x=1761677903;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YvMAO88MadcyF1PwEMgonv0jZSIGfh/Nw2MW8Hb9JCU=;
 b=De1wbEZ1aqMwRBSsMz0UFqwLVAllynrbDkrUq2d4lxnfEXDaY+1g+955j6IayvVCjS
 gUdhMK7Xc25avhmclFoW3pEDVXOWTFAWVl9kjDI7IDrocytvALf6vgwPLIVmJzcE+g/k
 PsFq064qjUDfEFNPzXOq9gUiQm4fMThAlmE6dDB9BxpE59R9WL/ANYHaBrUVeZZz8G7f
 8DFspvpqLeYeAh8Yjwpe+Wh7sVagCdgfZC7G0YXxuPsyByqcQ9EWu/K1gyFrBOYUDhYP
 xzmabVwHCRbPbSG5JF+qVZqQfgRIVnoDuFoVurNJ3CCJwbcjog+oCy1sKP7scZs6qx/U
 oSNQ==
X-Gm-Message-State: AOJu0Yww5EjP9smva16FqGq9sWF7/YIaebgH/7XlT56LJLyN8r15W7F3
 M+Kn1Q8IXQ/0U0/P3GuyURbKksf+Ak7LwCVmJnsxZekWtouYaQtCyUTrLV8ULga14USQbkw9Kkr
 HkYgAlqB1sMqvZDw39UUzM8OHd+QvUJL2BS+z8WdMIlbIVgeXhG0iguSdH5My2/vm9iVgVa1Z1Y
 3FkbAnQnsgl/oFSkP3P7RqkilZRkJfUJbSq+t0VvTXTQMPWAy8OwO8b+IXzEQguS35/agE6g==
X-Gm-Gg: ASbGnctrzMXk9EGi6sQyGOCmWiffXNwixVTsxMmDA/cnMktnzS2ry3pHxhR9B16J5/F
 AGx/SCW9+cWGqyKPq1DRuT08dmdjB0G7k36zL0w95wxtf4fXgsykTUjB8ZWKdpTLyYgaDX8rtlc
 2adYgLKyuRVEveo12dy+ED7F1OY331KjMjzowLMFrrT66VVcOOt9oWIMd3dqS4bFeembjbbKV7z
 zlp6hnuZ7d76YfngAVMG6I2pCabZLDsdYfNvZ9uRxoM7GvjLb+DrCXOUGRzIPzaVSU3dNf62pkc
 pOQXE45ekGbIRGAiNqXJPrZEx4zD4TYCCgniWyCZjIf7Zm2z7wnqJWrf/4F36wUGhPHqH9Y0sVP
 bd7SpMNydhyyZqCon6gmhxRT9fM6y5DydmVofIXO95SZZbgedqyk/R3OcPIiY1SPwwnZW4hebe7
 491KsLIVUt9f6nhZz6+EzUNoH7Gtv7n+OEBg==
X-Google-Smtp-Source: AGHT+IEiD6sUrMqDKHS+krGiCRONhSac9CBf/UJ2QQKiFTHQkznrQd1SIl3JpJJJPcPiHvXdSi7hjg41BjyE
X-Received: by 2002:a17:902:ccce:b0:267:99be:628e with SMTP id
 d9443c01a7336-292ff7fc81fmr10699555ad.2.1761073102613; 
 Tue, 21 Oct 2025 11:58:22 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-72.dlp.protect.broadcom.com. [144.49.247.72])
 by smtp-relay.gmail.com with ESMTPS id
 d9443c01a7336-292470185a3sm13472345ad.25.2025.10.21.11.58.22
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 21 Oct 2025 11:58:22 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-b6cd4d3a441so161109a12.0
 for <dev@dpdk.org>; Tue, 21 Oct 2025 11:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1761073101; x=1761677901; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YvMAO88MadcyF1PwEMgonv0jZSIGfh/Nw2MW8Hb9JCU=;
 b=QJNOzvRDEC3U5AD97eqFYwpRrzbDLHrwc5x6xFVM09ls70O/qxxgNoCMt+9lDLIjKg
 3ghbdxqtUP39/tUuxNyxSKnOurYPURL3+3zATBajY+GLrPWG1Wl7XxdsqmpTQ+Lekyb+
 OF7KxoZijbX7P9Cx/ebf7pHV+bD/uBZyHTjTE=
X-Received: by 2002:a17:903:2346:b0:24c:db7c:bc34 with SMTP id
 d9443c01a7336-292ffc0b817mr10283995ad.13.1761073100696; 
 Tue, 21 Oct 2025 11:58:20 -0700 (PDT)
X-Received: by 2002:a17:903:2346:b0:24c:db7c:bc34 with SMTP id
 d9443c01a7336-292ffc0b817mr10283655ad.13.1761073100106; 
 Tue, 21 Oct 2025 11:58:20 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29246fdc9cfsm116598155ad.45.2025.10.21.11.58.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Oct 2025 11:58:19 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com,
 Sangtani Parag Satishbhai <parag-satishbhai.sangtani@broadcom.com>
Subject: [PATCH v4 47/57] net/bnxt: truflow remove RTE devarg processing for
 mpc=1
Date: Tue, 21 Oct 2025 14:56:51 -0400
Message-Id: <20251021185701.71881-16-manish.kurup@broadcom.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20251021185701.71881-1-manish.kurup@broadcom.com>
References: <20251021185701.71881-1-manish.kurup@broadcom.com>
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

