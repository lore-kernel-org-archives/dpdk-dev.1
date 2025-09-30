Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9D5FCAC5BE
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Sep 2025 07:05:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 40DF540A6B;
	Tue, 30 Sep 2025 09:05:12 +0200 (CEST)
Received: from mail-pg1-f225.google.com (mail-pg1-f225.google.com
 [209.85.215.225])
 by mails.dpdk.org (Postfix) with ESMTP id 91FE1402D8
 for <dev@dpdk.org>; Tue, 30 Sep 2025 02:36:35 +0200 (CEST)
Received: by mail-pg1-f225.google.com with SMTP id
 41be03b00d2f7-b5241e51764so4511844a12.1
 for <dev@dpdk.org>; Mon, 29 Sep 2025 17:36:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759192595; x=1759797395;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4UvrD8t42B5aNAtBGuLV4siWpgjMlcU40vV7uz9gj64=;
 b=U9UHA6m8NxlgP1XYF4SnQR3oLaD7kGviR25jnq3QW1uo0Mse2GAkz+Q6sO1Dymnqmb
 Hrq8ZfLU/uloCKhgI52Lahc2L85CkRdyaxG7N9orge1Do+6K4p3O3c4eISRqE2PwUCOk
 JXLImjMNaYFVEit3sQAbW2ryZmWhqj6UgHDtTHgg9wvfYbDP8ynEQcsoYDoKt3F8b4V9
 Jmx2gHnc0g+gaWg7JLnKIZtaHFqKKHrFCuAAi3Zkr0tl6DtsCltXh+Tv94Zp4vPnQs7h
 ToPk3O4tg6llxpoy9B3ekrerInLtUnXTfgv1+j644ZcZPsJZEaNBLIcL0N+dvYgvrJLo
 YL+A==
X-Gm-Message-State: AOJu0Yy0zEQMIz5pQyYz/pdBPezbizfZznmQjZk/4yFeICaW+ndMCRJx
 dMvYkVZJ2NvzkmQdX22QHq3rSOCGRtSpXARv1vSd13cNZ9FU+4g5atq36DSSiG6i6t49v98zHq4
 FJz6kVCB2pKVYjYicQ6NL28nHlyZeFWCvse0rKGbICZjbm9RnMl5wMI+Ri3DitDzP+wURjpiN38
 hRc6JGRusgFByi6vDdv1U2ay9uetALOzdY+FUUp90bzzR8xxklNMWXK9nEYRCgYlbBtoPkKQ==
X-Gm-Gg: ASbGncvFRQbi+c4p1S4IEulvd2zkR97XeGxrYeleLfS+mMAYrzWXkr7BUqM0+k0A1xU
 QP85sWihRR0AFaSwmxLFpSLnhjcdDd4jmjc6AWgbn6qur5sNKLl4bS03tLPHVM3mWDdm5Jp52Yp
 JhCXqLsbSzz1EyqDpb6aJFtCgfvYlD0sFWBf+OtwrfKboEWGbxcfpfyJUgO7iw06M9ERcq3xH1v
 Ik04gFla8MaTKnW605rhsJWmM9pPQHGWW6dYFCLreF2Znee2Y56BJFOKQjYgtM4rMaeYGxGD+0U
 tqUQo6Cb346soAGwVHgU42vCQmUZ51nSNVcUmaV2KJC6soNoxjL6ZnP57UU5GLiG4/hGTU9cG0P
 bgdLquvsJEyBMnGNlUVyJx2Uaii1CDI16CfEo5KPCLkIlVSix7/D7mVSi1561VAqs7R/+g3W3gL
 oMpEFBwR8=
X-Google-Smtp-Source: AGHT+IG8NU3ZBSqe+kDh/SG52VSD0ixp/xJNK+MGpPmPL5AwDXvvU+Q8QjSXJ7T8BFW6F2KkB2d4uXFhxwTQ
X-Received: by 2002:a17:902:ea0a:b0:24b:62ef:9d38 with SMTP id
 d9443c01a7336-27ed49d2948mr207676235ad.19.1759192593993; 
 Mon, 29 Sep 2025 17:36:33 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-101.dlp.protect.broadcom.com. [144.49.247.101])
 by smtp-relay.gmail.com with ESMTPS id
 d9443c01a7336-27ed6827e1asm10198835ad.62.2025.09.29.17.36.33
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 29 Sep 2025 17:36:33 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-b549a25ade1so7064375a12.3
 for <dev@dpdk.org>; Mon, 29 Sep 2025 17:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1759192592; x=1759797392; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4UvrD8t42B5aNAtBGuLV4siWpgjMlcU40vV7uz9gj64=;
 b=BL94tpV7g0Bmag1iBGrppSN77lQu8Di700guwAaIWsIyOVfXC36sgDyjGLCs5aMTP9
 7IbYfj04JnrVtRDitH/oxzAk/3ujfQXnxzHGxm+1n1lNAGWyHkU85SyPiNBoCPuHm2TH
 kTLHTTsSJ5+UVysfgzTMUsXPf60D7wXn8vvig=
X-Received: by 2002:a05:6a21:998e:b0:319:b5a9:15fe with SMTP id
 adf61e73a8af0-319b5a91818mr1520361637.12.1759192591756; 
 Mon, 29 Sep 2025 17:36:31 -0700 (PDT)
X-Received: by 2002:a05:6a21:998e:b0:319:b5a9:15fe with SMTP id
 adf61e73a8af0-319b5a91818mr1520329637.12.1759192591259; 
 Mon, 29 Sep 2025 17:36:31 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b57c53bb97dsm12234825a12.9.2025.09.29.17.36.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Sep 2025 17:36:30 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com,
 Kishore Padmanabha <kishore.padmanabha@broadcom.com>,
 Shuanglin Wang <shuanglin.wang@broadcom.com>
Subject: [PATCH 03/54] net/bnxt: enable vector mode processing
Date: Mon, 29 Sep 2025 20:35:13 -0400
Message-Id: <20250930003604.87108-4-manish.kurup@broadcom.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250930003604.87108-1-manish.kurup@broadcom.com>
References: <20250930003604.87108-1-manish.kurup@broadcom.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Mailman-Approved-At: Tue, 30 Sep 2025 09:05:06 +0200
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
index cb0d99b9ee..0836be3b1e 100644
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
 
@@ -6385,6 +6389,64 @@ bnxt_parse_devarg_rep_fc_f2r(__rte_unused const char *key,
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
@@ -6445,6 +6507,28 @@ bnxt_parse_dev_args(struct bnxt *bp, struct rte_devargs *devargs)
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

