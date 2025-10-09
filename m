Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7C85CCD183
	for <dpdk-dev@archiver.kernel.org>; Thu,  9 Oct 2025 22:18:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5594F40E45;
	Fri, 10 Oct 2025 00:16:36 +0200 (CEST)
Received: from mail-yx1-f99.google.com (mail-yx1-f99.google.com
 [74.125.224.99]) by mails.dpdk.org (Postfix) with ESMTP id CFCC740E44
 for <dev@dpdk.org>; Fri, 10 Oct 2025 00:16:34 +0200 (CEST)
Received: by mail-yx1-f99.google.com with SMTP id
 956f58d0204a3-6353e91a04aso1528301d50.2
 for <dev@dpdk.org>; Thu, 09 Oct 2025 15:16:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760048194; x=1760652994;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LSIjNApd9Nkw+fs6CduYC6akGiAmnRNol514g3YNUQI=;
 b=AYgN9kskWNcstu3nsb84h3SnnZSoa0K7Zqx6oSbW2N7rfSEnKH4KkU2VdcoCUlDUsR
 3xi+fAJIrdTjSuWeKQ3KoZlHI57OWVqaEqVmmui+1fUbGLhm7bXtpGQuE9coDTdWUG8q
 dEYpDcDdFP9/jRI9I7pjGZKQ0HhXzdkTNM2qhXCbq2iZY1o0FHioTHNPvBUZWD3Q8E8V
 RTS0Wt5evTjx0I8jXN0cGaBV9AQhjq95egbZ+XFW/JfDBZSCg+sxN87MJQrYz1KFx9MK
 aR3BX+ZFlNVUyYMFgP8vGPAPlWYX2+/JdeZBgPkSazhl0/LDaCv3a1A2c/g87dMOu1UD
 79sw==
X-Gm-Message-State: AOJu0YzAgvslqfhxoY8fIDhFkqAqIkTxdHcmNijRW5U0tMrQY6c4820c
 AUVRievw4CAd8koapgLiurwpR5gk5BIviIZ/8ZMANLH8wJAO7mTyyycz8Qs7w28WwCPJiJd6lN6
 Tx/tJ+APRSL5DJe2lCUKro+7LsubhnUCEFZq7N+SoSrKrWiPoc+3lqCq132nXPPmKdbmhR2lhq7
 ohfm9rf6wv6mhY50+Ey3k5OdNmTwdnu0zvBr/FrdrCnXeyOGS7izgBe3ZcMBXyE8KcjB30rw==
X-Gm-Gg: ASbGnct2X2j6PsEo58UG8dqZBi18l1kJeDPZeUNwW/JckSbI8aqfgu/2Emxr99ynOhg
 MA20vYs/2kb4tXse4P/dvttXZ9aYndZEA+v3VrzGM3b9X4CK8e7kSIG+R7xPmu0vQKZT3uts6VO
 4Z9Fv65bLTsWDDtm1bOcrbzB3t29OlzEqrmkp5WSIXLTNV1JM3d9lM3TS5g3Lu0qclTN7xjyswp
 /RhjeMbIR/mN4YYj5jxsgLCicvG4M8eOvaIlPQcQff2X0WmJIeT/PiLwsWcrroGBs/sqfjtPY0k
 JcTMx5c7aLbmWasnsRc/aR+8V5592SF28+5FH6hgiiLJYsq4+DYq48B6WKkTeDa/ChAaKSDChFy
 NgfATXLnNHTpHyM5W0qEFJvW+/rnUhtrtFNOd6wnZOZqPlQggWlJCjt1pmzKEj8fstiDuuXyQSo
 Ao7lVw
X-Google-Smtp-Source: AGHT+IHpDoiy9CAaC/GwkfkiiR7oSQ0MV+Ui8684ZhX+WvCZtgSjsCFa5iVdLbdq7FYA8/ybgV3TsOrbCKkC
X-Received: by 2002:a05:690c:a088:10b0:781:64f:2b22 with SMTP id
 00721157ae682-781064f3620mr17020987b3.68.1760048193924; 
 Thu, 09 Oct 2025 15:16:33 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-19.dlp.protect.broadcom.com. [144.49.247.19])
 by smtp-relay.gmail.com with ESMTPS id
 00721157ae682-78106cf9a95sm372557b3.4.2025.10.09.15.16.32
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 09 Oct 2025 15:16:33 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-4e002f413e4so27458801cf.2
 for <dev@dpdk.org>; Thu, 09 Oct 2025 15:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1760048192; x=1760652992; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LSIjNApd9Nkw+fs6CduYC6akGiAmnRNol514g3YNUQI=;
 b=Y7InhGVsw4Fssr35peA64g6IrAV9eAoth5LcFhFPUsXRX7hqjI2EUXSgVbEJano0LH
 C7PIRRxjUf9Mc5DF5RSufQ5tMd4q2I966bGEYFEqG5UqhbLdimR2Fhze+X/0r4vo/OjO
 Ci4yQV+Diye431ACitDy1ID2u2RwVbZ+hGC7s=
X-Received: by 2002:ac8:740d:0:b0:4e4:8c6e:4945 with SMTP id
 d75a77b69052e-4e6ead57f9cmr91446931cf.40.1760048192211; 
 Thu, 09 Oct 2025 15:16:32 -0700 (PDT)
X-Received: by 2002:ac8:740d:0:b0:4e4:8c6e:4945 with SMTP id
 d75a77b69052e-4e6ead57f9cmr91446651cf.40.1760048191550; 
 Thu, 09 Oct 2025 15:16:31 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-87bc3479344sm4189986d6.17.2025.10.09.15.16.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 09 Oct 2025 15:16:31 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com,
 Sangtani Parag Satishbhai <parag-satishbhai.sangtani@broadcom.com>
Subject: [PATCH v2 44/54] net/bnxt: truflow remove RTE devarg processing for
 mpc=1
Date: Thu,  9 Oct 2025 18:11:19 -0400
Message-Id: <20251009221129.28256-45-manish.kurup@broadcom.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20251009221129.28256-1-manish.kurup@broadcom.com>
References: <20250930003604.87108-1-manish.kurup@broadcom.com>
 <20251009221129.28256-1-manish.kurup@broadcom.com>
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

