Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8455ECCF9F0
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Oct 2025 16:08:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B3ECB4066B;
	Wed, 29 Oct 2025 17:08:12 +0100 (CET)
Received: from mail-pg1-f227.google.com (mail-pg1-f227.google.com
 [209.85.215.227])
 by mails.dpdk.org (Postfix) with ESMTP id 9C8234028F
 for <dev@dpdk.org>; Wed, 29 Oct 2025 17:08:11 +0100 (CET)
Received: by mail-pg1-f227.google.com with SMTP id
 41be03b00d2f7-b6cf3174ca4so5211764a12.2
 for <dev@dpdk.org>; Wed, 29 Oct 2025 09:08:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761754091; x=1762358891;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3Dkoerd0y2cIl1/KCscMEHHJw2rYSz/WOozRRZp//U0=;
 b=nbKaGIZCyeDya/ilq++HZXTbKyEWbXwU8kvIYA2ZDlFEAxbUX0ppsH+GMGa4dVkbss
 98ZP7zRpSuIeIdtgLKicIKvCWq+CAvKcJla0PDzOE5B2Z5Y8Z8kZ9joUVxZoOetdbuHu
 PiEPlTU6M6XWB4XhAMLllAKPU0cni/0JTn69WIvEYrbUF38yQalzKsnvnnRLC59mhM+p
 ZVwyOcutRPXGDRogpb7vkEijD9daoIwa6kelpEbq3BX9juv1tbw8KL73CCiKRoWqslFo
 J35qdjD0EnPPqp5pcje0Ju1XJIohRKTSLbMHNOqa5iqgJx/lS0vt6SGg789RanXWrYWX
 35Eg==
X-Gm-Message-State: AOJu0Yy7qO5jQDSHvaXwQA3owfmmpchf3mrqLVa3cmRsmxDP4PGBdSaB
 UaUgiwbLFj/ENbJWqw+oFHSKYbRUUVNQs2SOSFCHKvQF8A9ClOKOrv3o1Hk9GYZoxDVB5zrDiXU
 sGsbVtDdacty/ew5115XQf6njLzW3wlrfVz8nNHnULlm7TmxQK/FrnWVj1uoIClwnumozVhdbM4
 dv1wdTpbAN3GfpSxmjiB2B4rLNSvn7uOrwx5lZBiVIPGGA83H974st8ZfPH9Diy7flghgp8A==
X-Gm-Gg: ASbGncskPms00mJjt624eH3ASEYC3mRZ3kYEYCGAXdcluVgXSuHTiDubayAsUS6tSG+
 5oCTPdzDHgZMGMhc/C+km7XLTbC5wKJoENFx0uZ+uS307OXUPmBGcFgtPp9MtdPTgtT8uh0336Z
 5UbUK69LbSvwTUxqb2YFiPt/+CeLK1fwTpJ1or/mbAyvc8b5lMR+w3Xnxlgwn0FGMQmgMZJoe/j
 hTJu/ROZ0KRjjf2+WM4TLYFSf/xcEfKDBpOs1uOcTpttHqkh/AEwPu8vuLanCQI3NyjwQCkOwyJ
 Ip77m84x5mUZKfS1lCfr6eTl/FI4mnZBmPg1VEL1IMdPLaH5BIFyctptd6uwrah+Q6AK8nxvdJS
 El6FMWuwnoKTtUzGAJvMgGGLv3uYISHRhpCG1uFvX39AgdeinEvCDXAZHfnGoKKSXJYHJigOrYw
 78UjSS+f840oAE+SiAmsY6cxt6avagB9xWkasD
X-Google-Smtp-Source: AGHT+IGcUOWWtMVmH3hEBtkuPmWWbr62/vilY2St6C+Q21w7qfCnYGMxQdv1eI8VHA9OG5KQXMBXPmTGARGr
X-Received: by 2002:a17:903:b48:b0:267:ba53:8bd3 with SMTP id
 d9443c01a7336-294deea30eemr40877265ad.28.1761754089776; 
 Wed, 29 Oct 2025 09:08:09 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-101.dlp.protect.broadcom.com. [144.49.247.101])
 by smtp-relay.gmail.com with ESMTPS id
 d9443c01a7336-29498e42ebdsm13862355ad.63.2025.10.29.09.08.09
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 29 Oct 2025 09:08:09 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-8908a248048so1766459685a.0
 for <dev@dpdk.org>; Wed, 29 Oct 2025 09:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1761754088; x=1762358888; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3Dkoerd0y2cIl1/KCscMEHHJw2rYSz/WOozRRZp//U0=;
 b=by+84qZgjBT1v13PGyiJpXt40QB/XkkHwoTz2jZIVp4Pm3bjdjg0fGrt0aMtEH9XbA
 h6cU9UZURcCAbmw2npCQ8T5DZz3GUkhFXsFwb0QmYjgDp0R/cafOSxD9rzJpTIX6+4KB
 y9sc4y5IZOC30e7XyZqFrvFZFFW5oSFGu+CJw=
X-Received: by 2002:a05:620a:370e:b0:7e8:46ff:baac with SMTP id
 af79cd13be357-8aa2c08edc4mr18656285a.1.1761754088118; 
 Wed, 29 Oct 2025 09:08:08 -0700 (PDT)
X-Received: by 2002:a05:620a:370e:b0:7e8:46ff:baac with SMTP id
 af79cd13be357-8aa2c08edc4mr18647285a.1.1761754087511; 
 Wed, 29 Oct 2025 09:08:07 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-89f2421fba6sm1089026785a.4.2025.10.29.09.08.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 29 Oct 2025 09:08:07 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com,
 Kishore Padmanabha <kishore.padmanabha@broadcom.com>,
 Shuanglin Wang <shuanglin.wang@broadcom.com>
Subject: [PATCH v5 06/57] net/bnxt: enable vector mode processing
Date: Wed, 29 Oct 2025 12:06:21 -0400
Message-Id: <20251029160712.58519-7-manish.kurup@broadcom.com>
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

