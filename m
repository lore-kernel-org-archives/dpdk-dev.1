Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40BE5CCD1A7
	for <dpdk-dev@archiver.kernel.org>; Tue, 21 Oct 2025 17:51:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6FB4340A71;
	Tue, 21 Oct 2025 19:51:50 +0200 (CEST)
Received: from mail-pf1-f227.google.com (mail-pf1-f227.google.com
 [209.85.210.227])
 by mails.dpdk.org (Postfix) with ESMTP id 6258E40A4B
 for <dev@dpdk.org>; Tue, 21 Oct 2025 19:51:49 +0200 (CEST)
Received: by mail-pf1-f227.google.com with SMTP id
 d2e1a72fcca58-79ef9d1805fso5439462b3a.1
 for <dev@dpdk.org>; Tue, 21 Oct 2025 10:51:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761069108; x=1761673908;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3Dkoerd0y2cIl1/KCscMEHHJw2rYSz/WOozRRZp//U0=;
 b=OtiyoL09F3ZSBUIVlDfVC+p9BTkjn82Fi4t7s7NIfObie/3NmjiINqWOjuw1BO77Tl
 237OeZ5U5WkHQRzOSym1AUFtMQlYSuLZAWpXxAviIxsTJJx0kndXc8GrA0RlzQdZ+9r9
 76FpzOhgFKbM4VnzmrSTfsk46CBAVGnBeZgIjZwCK7EMX7p8PdiylZSzvb8RRrEIGSGl
 73b+0aQzdlVXJoHvj0gcFA2YRaHB9ZYB1wOdSz9AZvrFAZa2y8K4xa7cLylNF9WK6WSh
 BJkEf1JP8VRhsf2JxKC1K7ANBypYOtcKCUtfO+tHj4dDSRPnYMRBIC/3w7N/yZT+phPp
 4unA==
X-Gm-Message-State: AOJu0Yyz13A1g0asjjLB4614Prukcf2QB9gOsV5c0SkS6THNKG/bLKqK
 CXa2UY4b7dwicXt/eb7b9JwIel697h+nFI1Q3R4QmutqrtMLHt3s4lQLCVtnocj1J0zW+12oP/z
 QbM+QDahcdxhz+8QfGIxsghGvbDAkEdotbtCr37C4aYseGvrB1vWy4ZrPOlzOFZ41dsq/tq9wZM
 nsNOzZegPHdgSWS2LRXMurpPqY9rnFDB0eBFu+f83FeslVpqOht0WozvS6ddbj0g0Vbebrjg==
X-Gm-Gg: ASbGncsre3PTQr226XqmpiKR0rgEqaW/C3TtmF+qGaGtspEvr959JPKRz/N4NbDxXPX
 m1uR/07E+SSaJBBfOcdBHDLNT8XKSRBuRkXVajE114FkNo7kkWUTb7IwEEhz01VzWpSWyaxCfFx
 McI3l496wKhw9NPIHY4Glwlgn6P9+rbhQo6QkRRBF+ggqIycCcLpqr1KxEUUSr/I5zlA6tgOZNq
 wIcG2i1VqnZQRiwdZ3k/AHrXqu3JGOJDRYQ5LFPv7s3spsXU6bqO4/8gERMVihLrj6QkswqNgOr
 YTMXamkmLdtsEq83tsUxPZx7//lNOvoe6bs5qkx87ivZ2BVUcKqVufs9RjbaMRRn9kwlDNrQM+Y
 X26HWwRPWcKIG5GaHl3k+KkqifaPDGhJQkPK4jqpeuGL3/rvr2+4fnwH/hAqsknprcRIdvmIl6C
 oOaVxOlt+RdxzggsdqanhFSlGgevHIOtGShQ==
X-Google-Smtp-Source: AGHT+IGlDGsF4qAJdFCY4V2VmpzZz8eiDm7MlHFwLOFKzwnjdBmXc1+01B7f5R8YlUBcnceE25yYp+TLoRx6
X-Received: by 2002:a05:6300:8052:b0:334:a916:8b4 with SMTP id
 adf61e73a8af0-334a9160985mr21351120637.8.1761069108545; 
 Tue, 21 Oct 2025 10:51:48 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-19.dlp.protect.broadcom.com. [144.49.247.19])
 by smtp-relay.gmail.com with ESMTPS id
 d2e1a72fcca58-7a22fef0a39sm1460317b3a.2.2025.10.21.10.51.48
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 21 Oct 2025 10:51:48 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-b57c2371182so4966494a12.1
 for <dev@dpdk.org>; Tue, 21 Oct 2025 10:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1761069106; x=1761673906; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3Dkoerd0y2cIl1/KCscMEHHJw2rYSz/WOozRRZp//U0=;
 b=K5rBokdxlsa2y8BQP8/7bhPXb18zrP35jj63U56Cob2k13IBKaZNRA7fezFlA70y6/
 3chcGtOs8OpNxAEXcWIiVHKSOhh9IgnIXN+yb8pOebKIBIhi3Bd+12uwzDiuvaPF1qLC
 DWVbrLkmIASdCimRqQYLo8YXj6UXnM5BHKacU=
X-Received: by 2002:a17:903:19cf:b0:275:7ee4:83bc with SMTP id
 d9443c01a7336-290c9c8ad4fmr212787755ad.2.1761069106264; 
 Tue, 21 Oct 2025 10:51:46 -0700 (PDT)
X-Received: by 2002:a17:903:19cf:b0:275:7ee4:83bc with SMTP id
 d9443c01a7336-290c9c8ad4fmr212787505ad.2.1761069105679; 
 Tue, 21 Oct 2025 10:51:45 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-292472193c2sm115441495ad.104.2025.10.21.10.51.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Oct 2025 10:51:45 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com,
 Kishore Padmanabha <kishore.padmanabha@broadcom.com>,
 Shuanglin Wang <shuanglin.wang@broadcom.com>
Subject: [PATCH v4 06/57] net/bnxt: enable vector mode processing
Date: Tue, 21 Oct 2025 13:49:58 -0400
Message-Id: <20251021175049.46092-7-manish.kurup@broadcom.com>
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

From: Kishore Padmanabha <kishore.padmanabha@broadcom.com>

When representors are not enabled, then truflow could be run in
vector mode processing to achieve higher throughput. Added logic
to check representors to enable or disable vector mode.

Signed-off-by: Kishore Padmanabha <kishore.padmanabha@broadcom.com>
Reviewed-by: Shuanglin Wang <shuanglin.wang@broadcom.com>
---
 drivers/net/bnxt/bnxt.h        |  7 +++
 drivers/net/bnxt/bnxt_ethdev.c | 88 +++++++++++++++++++++++++++++++++-
 2 files changed, 93 insertions(+), 2 deletions(-)

diff --git a/drivers/net/bnxt/bnxt.h b/drivers/net/bnxt/bnxt.h
index c9fdd36d3e..72ac66b0db 100644
--- a/drivers/net/bnxt/bnxt.h
+++ b/drivers/net/bnxt/bnxt.h
@@ -852,6 +852,13 @@ struct bnxt {
 	((bp)->flags2 & BNXT_FLAGS2_MULTIROOT_EN)
 
 #define	BNXT_FLAGS2_COMPRESSED_RX_CQE		BIT(5)
+#define	BNXT_FLAGS2_USE_MPC			BIT(6)
+#define BNXT_USE_MPC(bp)			\
+	((bp)->flags2 & BNXT_FLAGS2_USE_MPC)
+#define	BNXT_FLAGS2_REP_MODE			BIT(7)
+#define BNXT_REP_MODE_EN(bp)			\
+	((bp)->flags2 & BNXT_FLAGS2_REP_MODE)
+
 	uint32_t		fw_cap;
 #define BNXT_FW_CAP_HOT_RESET		BIT(0)
 #define BNXT_FW_CAP_IF_CHANGE		BIT(1)
diff --git a/drivers/net/bnxt/bnxt_ethdev.c b/drivers/net/bnxt/bnxt_ethdev.c
index 0ec9ed8175..bf78f9dff5 100644
--- a/drivers/net/bnxt/bnxt_ethdev.c
+++ b/drivers/net/bnxt/bnxt_ethdev.c
@@ -107,6 +107,8 @@ static const struct rte_pci_id bnxt_pci_id_map[] = {
 #define BNXT_DEVARG_IEEE_1588	"ieee-1588"
 #define BNXT_DEVARG_CQE_MODE	"cqe-mode"
 #define BNXT_DEVARG_MPC		"mpc"
+#define BNXT_DEVARG_SCALAR_MODE	"scalar-mode"
+#define BNXT_DEVARD_APP_INST_ID "app-instance-id"
 
 static const char *const bnxt_dev_args[] = {
 	BNXT_DEVARG_REPRESENTOR,
@@ -122,6 +124,8 @@ static const char *const bnxt_dev_args[] = {
 	BNXT_DEVARG_IEEE_1588,
 	BNXT_DEVARG_CQE_MODE,
 	BNXT_DEVARG_MPC,
+	BNXT_DEVARG_SCALAR_MODE,
+	BNXT_DEVARD_APP_INST_ID,
 	NULL
 };
 
@@ -1447,7 +1451,7 @@ bnxt_receive_function(struct rte_eth_dev *eth_dev)
 	 * asynchronous completions and receive completions can be placed in
 	 * the same completion ring.
 	 */
-	if ((BNXT_TRUFLOW_EN(bp) && !BNXT_CHIP_P7(bp)) ||
+	if ((BNXT_TRUFLOW_EN(bp) && BNXT_REP_MODE_EN(bp)) ||
 	    !BNXT_NUM_ASYNC_CPR(bp))
 		goto use_scalar_rx;
 
@@ -1523,7 +1527,7 @@ bnxt_transmit_function(__rte_unused struct rte_eth_dev *eth_dev)
 	 */
 	if (eth_dev->data->scattered_rx ||
 	    (offloads & ~RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE) ||
-	    (BNXT_TRUFLOW_EN(bp) && !BNXT_CHIP_P7(bp)) ||
+	    (BNXT_TRUFLOW_EN(bp) && BNXT_REP_MODE_EN(bp)) ||
 	    bp->ieee_1588)
 		goto use_scalar_tx;
 
@@ -6380,6 +6384,64 @@ bnxt_parse_devarg_rep_fc_f2r(__rte_unused const char *key,
 	return 0;
 }
 
+static int
+bnxt_parse_devarg_representor_mode(__rte_unused const char *key,
+				   const char *value, void *opaque_arg)
+{
+	struct bnxt *bp = opaque_arg;
+	unsigned long rep;
+	char *end = NULL;
+
+	if (!value || !opaque_arg) {
+		PMD_DRV_LOG_LINE(ERR,
+				 "Invalid param passed to rep mode in devargs");
+		return -EINVAL;
+	}
+
+	rep = strtoul(value, &end, 10);
+	if (end == NULL || *end != '\0' ||
+	    (rep == ULONG_MAX && errno == ERANGE)) {
+		PMD_DRV_LOG_LINE(ERR,
+				 "Invalid param passed to rep mode in devargs");
+		return -EINVAL;
+	}
+
+	if (rep > 0)
+		bp->flags2 |= BNXT_FLAGS2_REP_MODE;
+	PMD_DRV_LOG_LINE(INFO, "representor feature enabled");
+
+	return 0;
+}
+
+static int
+bnxt_parse_devarg_scalar_mode(__rte_unused const char *key,
+			      const char *value, void *opaque_arg)
+{
+	struct bnxt *bp = opaque_arg;
+	unsigned long rep;
+	char *end = NULL;
+
+	if (!value || !opaque_arg) {
+		PMD_DRV_LOG_LINE(ERR,
+				 "Invalid param passed to scalar mode in devargs");
+		return -EINVAL;
+	}
+
+	rep = strtoul(value, &end, 10);
+	if (end == NULL || *end != '\0' ||
+	    (rep == ULONG_MAX && errno == ERANGE)) {
+		PMD_DRV_LOG_LINE(ERR,
+				 "Invalid param passed to scalar mode in devargs");
+		return -EINVAL;
+	}
+
+	if (rep > 0)
+		bp->flags2 |= BNXT_FLAGS2_REP_MODE;
+	PMD_DRV_LOG_LINE(INFO, "Scalar mode enabled");
+
+	return 0;
+}
+
 static int
 bnxt_parse_dev_args(struct bnxt *bp, struct rte_devargs *devargs)
 {
@@ -6440,6 +6502,28 @@ bnxt_parse_dev_args(struct bnxt *bp, struct rte_devargs *devargs)
 	rte_kvargs_process(kvlist, BNXT_DEVARG_CQE_MODE,
 			   bnxt_parse_devarg_cqe_mode, bp);
 
+	/*
+	 * Handler for "representor" devarg.
+	 * Invoked as for ex: "-a 000:00:0d.0,representor=1"
+	 */
+	rte_kvargs_process(kvlist, BNXT_DEVARG_REPRESENTOR,
+			   bnxt_parse_devarg_representor_mode, bp);
+
+	/*
+	 * Handler for "scalar-mode" devarg.
+	 * Invoked as for ex: "-a 000:00:0d.0,scalar-mode=1"
+	 */
+	rte_kvargs_process(kvlist, BNXT_DEVARG_SCALAR_MODE,
+			   bnxt_parse_devarg_scalar_mode, bp);
+
+	/*
+	 * Handler for "app-instance-id" devarg.
+	 * Invoked as for ex: "-a 000:00:0d.0,app-instance-id=1"
+	 * This argument is required for enabling truflow hot upgrade feature.
+	 */
+	rte_kvargs_process(kvlist, BNXT_DEVARD_APP_INST_ID,
+			   bnxt_parse_devarg_app_instance_id, bp);
+
 	rte_kvargs_free(kvlist);
 	return ret;
 }
-- 
2.39.5 (Apple Git-154)

