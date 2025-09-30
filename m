Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8ECBCAC5B9
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Sep 2025 07:11:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A03A340EF1;
	Tue, 30 Sep 2025 09:06:21 +0200 (CEST)
Received: from mail-pf1-f228.google.com (mail-pf1-f228.google.com
 [209.85.210.228])
 by mails.dpdk.org (Postfix) with ESMTP id CCF08402A2
 for <dev@dpdk.org>; Tue, 30 Sep 2025 02:37:39 +0200 (CEST)
Received: by mail-pf1-f228.google.com with SMTP id
 d2e1a72fcca58-76e4fc419a9so5470457b3a.0
 for <dev@dpdk.org>; Mon, 29 Sep 2025 17:37:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759192659; x=1759797459;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LSIjNApd9Nkw+fs6CduYC6akGiAmnRNol514g3YNUQI=;
 b=qaLEestxn6RvTyQ84fH8iq9wJlikA16b9XM02cIIEe2aOB4ctidrLrIy1Buf5rNHTC
 gMU4HvZfyS0tLUyn2yLVQJcpHbmC3v/VHoOEHXNhNWrDurTCRgGaZ5xvqRD3CLPE+U1z
 A2pLvJ9ewP1BtS7yJLXzA+vTJazUNs4jYkgjmYVaLh38wy9MSN7+TZKXlBib/N8v8J4Z
 uQjzcUjCNer1PY8tpdm1cyEo++hT4OStxSxv5XpgOke6TC6fvTvgyVX5a0fIgUNewVjz
 ANTwD4Zrl/WdgJgUeEfx4uPnNPexH52f4AdrCPn1Xve3Mg97p6COc8W7i4Fz0ryVIi+C
 N1PQ==
X-Gm-Message-State: AOJu0YyRClOUuVWxq5fssxkuYL2jLQrNHBCuWsYbcNIujp8Fl9MatTzq
 Am2EOsfZ4LzSUIN13AKMlUo7tVo4kJxa6IidZiTRz5lLP5c09fL8ofmKqGZnS5yVez1Z89PoNeZ
 idV2Wm9OMJ/OyeqQvZZs1AwWhpnCkXBqPxFqki/CJxB1vYSxw0tnZtJ4+oY9aj7OQaLZUjsRYvu
 1bF6zJItXZ5mbJWg7N0kU66AMK5awDSHZE4SY/VSp5SMUtSGX9iMJG0mrC23Z64Y8cdFCsMQ==
X-Gm-Gg: ASbGnctYznvivrzD6mKAfPSsc3tgKpeNOzyGVs7cCNUGeoyCUJZD4oyr+wwI3nVvZY/
 nKX/K86kg3tOmCTi712tv/gs08LmDx2Fm4LZpiVl1d02FD4PX64H+dwFpWu0KqWm2NQds1AOvo1
 8KKeHgbXr9+fuCuiS4vrtz3kthaGcuacA94U9EQX/hzRAwhYmVbEj1ZXvc9/AYFaxZIQRoH7LI5
 PG7xAVqKP5MT7Xv5RLXqjtw/jz/DX0OgWfUdV1TKkSA7AHhJUQVQlHC/AZtNF1pd5Rh5myPK5xt
 As/thcUimYE32ou7UdigfL5bNOuUd5T4IQLEcP9BxhK1EGvl3jxlp7VssPjXeZhuF9h1xsfwxDO
 P7XvkAlz9X8xsOcdAHMoEbgVxe32uN7gGealFVRDu5xxCKQSYxdKbzRS1Bv9lD52r58zwSbwZKf
 zF/g==
X-Google-Smtp-Source: AGHT+IEWpUXf7rCXffVNhXPiQK9AwUspMKw0vlH0fO1CffY95TLdqsG5II7WRolHTs/m2g+Jrodjwu3DpoVU
X-Received: by 2002:a05:6a20:320c:b0:2f4:abe3:2c94 with SMTP id
 adf61e73a8af0-2f4abe32f54mr12668033637.50.1759192658939; 
 Mon, 29 Sep 2025 17:37:38 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-116.dlp.protect.broadcom.com. [144.49.247.116])
 by smtp-relay.gmail.com with ESMTPS id
 41be03b00d2f7-b57cfef9738sm589713a12.6.2025.09.29.17.37.38
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 29 Sep 2025 17:37:38 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-33428befbbaso6328125a91.0
 for <dev@dpdk.org>; Mon, 29 Sep 2025 17:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1759192657; x=1759797457; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LSIjNApd9Nkw+fs6CduYC6akGiAmnRNol514g3YNUQI=;
 b=NOiDtsC3VdtVtoT1HTXCC79Nks2+piOLGsvEbf+ybEPVzqliKN1+LE3tUKk0RujvlQ
 pICSdHx8EY2mHUkkO150rRWKus2rLHG+X79IKNESUqzGg8PN0LCix0PMnVRH3QkkDeiK
 Vob4olWxDtAgU12Hrdj1YJk/TG9KfU88Rd62A=
X-Received: by 2002:a17:90b:4d04:b0:32e:a60d:93e2 with SMTP id
 98e67ed59e1d1-3342a260e49mr19146435a91.11.1759192656771; 
 Mon, 29 Sep 2025 17:37:36 -0700 (PDT)
X-Received: by 2002:a17:90b:4d04:b0:32e:a60d:93e2 with SMTP id
 98e67ed59e1d1-3342a260e49mr19146409a91.11.1759192656175; 
 Mon, 29 Sep 2025 17:37:36 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b57c53bb97dsm12234825a12.9.2025.09.29.17.37.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Sep 2025 17:37:35 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com,
 Sangtani Parag Satishbhai <parag-satishbhai.sangtani@broadcom.com>
Subject: [PATCH 44/54] net/bnxt: truflow remove RTE devarg processing for mpc=1
Date: Mon, 29 Sep 2025 20:35:54 -0400
Message-Id: <20250930003604.87108-45-manish.kurup@broadcom.com>
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

