Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 595CECCD193
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 09:01:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3DB9540B97;
	Wed, 15 Oct 2025 11:01:15 +0200 (CEST)
Received: from mail-il1-f225.google.com (mail-il1-f225.google.com
 [209.85.166.225])
 by mails.dpdk.org (Postfix) with ESMTP id 3037C40276
 for <dev@dpdk.org>; Wed, 15 Oct 2025 11:01:14 +0200 (CEST)
Received: by mail-il1-f225.google.com with SMTP id
 e9e14a558f8ab-430aff9ab30so1075925ab.0
 for <dev@dpdk.org>; Wed, 15 Oct 2025 02:01:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760518873; x=1761123673;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4UvrD8t42B5aNAtBGuLV4siWpgjMlcU40vV7uz9gj64=;
 b=j5nWNt6vjyYfbt1O26fOulLatkD6rYDGAVFWkI/Q6NVwn6siAbIhlyXSutdkBR+Ptz
 s0bw0TAz72pm1hJ85ucLLyTv+24rfQQ5MuO7h/9ckrTKLqbnEBANVWCaUCpzMt1yC5sD
 MZ0FG27ZUSCeGuR/ijWlF+qWm6HQ7lvJD756hH/9FqFxWr4IAyiUXZ52jIIo9k+Zv3yq
 UmS0OzTIRrdSv3hwKRueRTJMzDiPqjoStuN2m8qw39aGV1tU0gAZ8tiU6g8UYYMxQa1I
 vWUTRFx/OqO+Xdgn602C25F2SBaMDEBeLhwVBmW3OBBs0tMi3LBTG0DzGxKiA8xEsQvF
 H7bw==
X-Gm-Message-State: AOJu0YykOYx2OMvBCs4FQijHe3K5seiSFGo6K0uoRjp5LSUAOFpz0Fhv
 PKr78kQWOwq4Iol9kQUTQVcnkHhf/4oyLSNY+PS30aMh+F/NLw6fTa5STv5JFTaRC85gZgh4OGN
 X0AStyuDrNnxlyG3a3uplFPnff9YTScmR/5hEiJbBF+Qo+GBuJ5qJPCOjgkL8+UCvpeZbaivP+F
 OIXmCS3suKQTUwSwqcH7XK43ti0Dj1Z386H4gHg9lH58CxiwapGu4CJA0DuKLfJKWHNJXSOw==
X-Gm-Gg: ASbGnct5RyrtMJmQIo/qkTI5xxt1o0ryzt11o3H+sJRZYATAgvUtoEWKRjLISRKxgXl
 9yhLtT4nHDI5Q3luGqstr45KVp2WdOV1W8HppBZLRfEjTgjuTK6qtokuKJ/E8nrM/aJ611ibiQd
 qnvpVN2e0AoKlb7lCTbpQ3eWoBfc7eS4iz+fl+THWGMKXYKBXueXVkx2Ue8gdKYJa6cT9nogzTL
 3IRsQTChXuARkDQxasfoXf6BCprEItwJRbH/TSe060HzsmftJDmAdKGvZtatb60vWiv3xWTxvF7
 7wgc/6VaupQU7D9yF2wxYh1bvOcowR5S3ROFoRhwNdTCWh39jehcnAy5Qp1E8Y5SVq8eCYv4l39
 JbMQWXpHdWSfcsyTd4gpAM1N9pr/G3qtV8OGRAj8UTisATlIGXHiXCwShKv7xkQ2+Fg06O6OP
X-Google-Smtp-Source: AGHT+IGJn4aGg9BpOd4RdbbVmxwAGOQPSePL18/XjOb3QKHxNHd3rdVYzWXGVF5PUSR+r7iMfGlJuUXjAPZt
X-Received: by 2002:a05:6e02:4412:b0:42f:9187:f6e0 with SMTP id
 e9e14a558f8ab-42f9187f8edmr270249995ab.13.1760518873405; 
 Wed, 15 Oct 2025 02:01:13 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-1.dlp.protect.broadcom.com. [144.49.247.1])
 by smtp-relay.gmail.com with ESMTPS id
 e9e14a558f8ab-42f9034daa7sm12571095ab.30.2025.10.15.02.01.12
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 15 Oct 2025 02:01:13 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-782063922ceso8843764b3a.0
 for <dev@dpdk.org>; Wed, 15 Oct 2025 02:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1760518870; x=1761123670; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4UvrD8t42B5aNAtBGuLV4siWpgjMlcU40vV7uz9gj64=;
 b=XBC5xavJ9KzRLEOzKDIoDb+UE5Ln+Mv5VtYUHu/UhlMCUq43YTFlHjx0R+sYTKIuWL
 PXvV/Kz07DbIYDplHFol4tSUcuXJOeCi91f3uffvgjy6R2rli6U62NZqRqkramdUV5xm
 ILsXIRmQmMcfxPKZKZhi8w+erKKpihJVoZcYU=
X-Received: by 2002:a05:6a00:182a:b0:781:275a:29d9 with SMTP id
 d2e1a72fcca58-7938742c7aemr36456509b3a.18.1760518870304; 
 Wed, 15 Oct 2025 02:01:10 -0700 (PDT)
X-Received: by 2002:a05:6a00:182a:b0:781:275a:29d9 with SMTP id
 d2e1a72fcca58-7938742c7aemr36456370b3a.18.1760518868595; 
 Wed, 15 Oct 2025 02:01:08 -0700 (PDT)
Received: from localhost.localdomain ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7992bc12a8asm17832412b3a.34.2025.10.15.02.01.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 15 Oct 2025 02:01:08 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com,
 Kishore Padmanabha <kishore.padmanabha@broadcom.com>,
 Shuanglin Wang <shuanglin.wang@broadcom.com>
Subject: [PATCH v3 03/54] net/bnxt: enable vector mode processing
Date: Wed, 15 Oct 2025 04:59:33 -0400
Message-Id: <20251015090024.32250-4-manish.kurup@broadcom.com>
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

