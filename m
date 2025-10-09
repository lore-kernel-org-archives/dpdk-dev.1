Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C04CCCD183
	for <dpdk-dev@archiver.kernel.org>; Thu,  9 Oct 2025 22:12:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 84C8540655;
	Fri, 10 Oct 2025 00:12:03 +0200 (CEST)
Received: from mail-il1-f226.google.com (mail-il1-f226.google.com
 [209.85.166.226])
 by mails.dpdk.org (Postfix) with ESMTP id B291F4027A
 for <dev@dpdk.org>; Fri, 10 Oct 2025 00:12:02 +0200 (CEST)
Received: by mail-il1-f226.google.com with SMTP id
 e9e14a558f8ab-42f94689e73so8625765ab.0
 for <dev@dpdk.org>; Thu, 09 Oct 2025 15:12:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760047922; x=1760652722;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4UvrD8t42B5aNAtBGuLV4siWpgjMlcU40vV7uz9gj64=;
 b=mZ45JIIzOui/sTSqrWk90TeJIdlGfRkMNnEIvDolxGUtBqgMpFcdLLQBaHbx8zx7+H
 8tnIdtDuTNUAa0uenzQtPwVidlakLRLSwcklEUUSWVQkDtUE7zfMAkHyMMpRu4Fy2zLx
 Xu7gBRnS34nyvMTfdZPW/uMR5Qo+ZBDz/6CH3eg6rKSDc1DckiAzLMi3/05NMHe5nJ3v
 Lv4wInfI9nQzcooVFzM8CZagMZUjC7TMP/k44KbIR9sEnj7x5zhfuikbQu0ZUTA5hdRn
 ZKsHHMMXtW1wd+zhqcmE8JQ3zgmOuH/K6STnfVyAZmeJds5l/WRAxdqhcSEgrDYDqoes
 JNsg==
X-Gm-Message-State: AOJu0YyCSo6V8kGEUDXtSSFOeLILwLqJ71I+rhNsWVCttxSHhBcWsKAz
 FwBnswL5qufiHFXqv2b8V6r6BBhm6f4fq+IDMB880MZdqPgsj/AmiEScg5+UohX0Ajlpe5eH4Dc
 FMEja0l8qgayKj7XhYR5VuvEQxAbffxw6F6khTdo9FiZd+Kzyg3eGiU3KuCIvwPJi74AL6Bje4k
 +s0lcPuIn4p7seJ8ygs+bXdfhRaJVoGtAj4MPTZh4dBnwb3TZr64KATS12mpIIcEXIkSJMKQ==
X-Gm-Gg: ASbGncupl7EYKxRwpp25SVx7Mv/BalOf3m93Z3w4uESH7s/lJrqKRy9kXbXf5/dO/R3
 cFNq3iuUlRt4XcO+A8OYxzBC+UDNy93BRueKLzAfy+nPD7g+M6GRc2q7KyxI3upnmEdQLpvJaqa
 7hxKFFfGRqtQrRgwK2uNLTFGkpfCrDRTm/LllZ9AgeYaxAtrsc/tfOaEGeMtu0dpuzvhGHXFAnS
 cLD59KtIUvGKXbhNGSQb1pxUjmT3z5L4PSEGafnsMAvEn4ytm158tnZVXsCvYMesySzULWxTQLu
 LtR4+rYG07bQrxGoXi6+uibRR2ZpqTkEAZRwL0jsjgbucqLgbBCAq5rDyYLbMIgUw+MbvVaKr5a
 hXh9SkQ1pAVA1ZTpUJLsGjbArElvUiZQpJC1vxQHzEloZyx2kzjaDOZWnvv3pufDl2VmjZ8Cdww
 prQLQl
X-Google-Smtp-Source: AGHT+IFl4STDmd+AU5g7eFFabzxnOidcVXT4OVlM2x08TjFppCHNaLoVU7Idc5cQ7zJRRhwdQuc25UUfCeWz
X-Received: by 2002:a05:6e02:16cf:b0:42e:7444:b019 with SMTP id
 e9e14a558f8ab-42f8741dc6bmr92474295ab.32.1760047921651; 
 Thu, 09 Oct 2025 15:12:01 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-19.dlp.protect.broadcom.com. [144.49.247.19])
 by smtp-relay.gmail.com with ESMTPS id
 e9e14a558f8ab-42f90360596sm2508515ab.31.2025.10.09.15.12.01
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 09 Oct 2025 15:12:01 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-7e90f268f62so38667286d6.0
 for <dev@dpdk.org>; Thu, 09 Oct 2025 15:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1760047920; x=1760652720; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4UvrD8t42B5aNAtBGuLV4siWpgjMlcU40vV7uz9gj64=;
 b=Zy0HCubkrQ8I4cCpmKHkDj/ywLGDWownYFNr6zutwPNR6D7U8a6+DOUAkeA3QFNyrX
 DhpeLBec6GD2LHSmX9LOlIXtHGL1B+aVh+G5GPemv+BK4/mxD32ejEJ6imCKJyQD6Uit
 Kb1MfuzZkij9f+mLPAZrdtKROl1Pgly2PTWUQ=
X-Received: by 2002:ad4:5ccc:0:b0:79c:f4b0:6813 with SMTP id
 6a1803df08f44-87b21065472mr119211906d6.21.1760047920171; 
 Thu, 09 Oct 2025 15:12:00 -0700 (PDT)
X-Received: by 2002:ad4:5ccc:0:b0:79c:f4b0:6813 with SMTP id
 6a1803df08f44-87b21065472mr119211526d6.21.1760047919557; 
 Thu, 09 Oct 2025 15:11:59 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-87bc3479344sm4189986d6.17.2025.10.09.15.11.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 09 Oct 2025 15:11:59 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com,
 Kishore Padmanabha <kishore.padmanabha@broadcom.com>,
 Shuanglin Wang <shuanglin.wang@broadcom.com>
Subject: [PATCH v2 03/54] net/bnxt: enable vector mode processing
Date: Thu,  9 Oct 2025 18:10:38 -0400
Message-Id: <20251009221129.28256-4-manish.kurup@broadcom.com>
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

