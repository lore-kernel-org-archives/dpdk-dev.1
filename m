Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB856C43458
	for <dpdk-dev@archiver.kernel.org>; Tue,  7 Jul 2026 16:41:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3A00D40BA0;
	Tue,  7 Jul 2026 18:40:41 +0200 (CEST)
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com
 [209.85.210.201])
 by mails.dpdk.org (Postfix) with ESMTP id 9F0BB40B9D
 for <dev@dpdk.org>; Tue,  7 Jul 2026 18:40:40 +0200 (CEST)
Received: by mail-pf1-f201.google.com with SMTP id
 d2e1a72fcca58-847ac21582cso4884186b3a.2
 for <dev@dpdk.org>; Tue, 07 Jul 2026 09:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1783442440; x=1784047240; darn=dpdk.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=Ryp7y+oLO4ky4lllciGgojIB/3V7i6yUVUwpH3Un2p0=;
 b=Ax/wYZGBENSr5rwIM03/0hKW8MVwf/YK67P1fqz0UefipUHcpqelPB72pTSQZhr8TH
 lT3ySTMIyqPCd9XvPPl+0wz72wiutZs1QwsHkhpgOnODZCfpGuWGZMKHamJbePF5THWD
 r+VVy0UzZhT6YpttJxhTRxro4o5cQAxsia1OSo0Tyod2DhxfOSNuW8y7X4DhiKjHDcPg
 hAcYKNz1QxiuwTD4EOEcz/ewwQkPuBGUPlckjKrq31nTjdVb6vX4AWWUBJmL1bLu5uUF
 PZwlLc0fvsBRmTEHYtEff1dNj96PY0DYdhLEN/RwYzc7Lnv3eNxvAtZSAy/oTaTM6Kyz
 1nLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783442440; x=1784047240;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ryp7y+oLO4ky4lllciGgojIB/3V7i6yUVUwpH3Un2p0=;
 b=JN/VRzXLIPQjvAyl2Wdsp4jxGHL5SFadvoL47k4cNTkFYc7ytdvJTe/ojWlIGFxCeX
 XTddNueCsFXd0ANTuuTXYDP5+OdJQpo8OsXMJaPIijxwml2d4Z28LJ8df2G/iz4jDcZA
 IyF7yA9mKOf8czKO2fr+cpxN7qnSdw6KZWZIq7ltPxBB+xHZ2CLhF1GPM2CDaoVAT6sn
 dsx4uai6RhxkWnPD67oycRFvfv9YfGpRZ5/K/WYI3PjfPY6jaCTsAUOPMPsepRtDOEly
 gGhLZH52GGOySsPlBp+tLFr2SfWT4Cb8udSOqppv38S+gVCm7bPCtqkHDbv4EDe6PCdh
 Br7w==
X-Gm-Message-State: AOJu0YzpzmGGjLipJhyOfM3MiyNTZuUmRRzMGv8JBBLBjyCvq1zaco5h
 3kjaUKxSklXP6CgxNj+qx6DB11iCddYbAPFDLb0hMTyLQbbGVvnmYZOzzsjkpjQgp7PI5KIq7Ht
 dbu5rfxWsY8ciTw==
X-Received: from pfaw8.prod.google.com ([2002:a05:6a00:ab88:b0:848:333a:b7e0])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:298a:b0:847:8449:2bb6 with SMTP id
 d2e1a72fcca58-84826c1dfa3mr5990592b3a.4.1783442439500; 
 Tue, 07 Jul 2026 09:40:39 -0700 (PDT)
Date: Tue,  7 Jul 2026 09:40:19 -0700
In-Reply-To: <20260707164020.2936476-1-joshwash@google.com>
Mime-Version: 1.0
References: <20260703131308.2507403-1-joshwash@google.com>
 <20260707164020.2936476-1-joshwash@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260707164020.2936476-10-joshwash@google.com>
Subject: [PATCH v3 9/9] net/gve: restrict max ring size in GQ QPL to 2K
From: Joshua Washington <joshwash@google.com>
To: Jeroen de Borst <jeroendb@google.com>,
 Joshua Washington <joshwash@google.com>, 
 Harshitha Ramamurthy <hramamurthy@google.com>,
 Rushil Gupta <rushilg@google.com>
Cc: dev@dpdk.org, stable@dpdk.org, 
 "Jasper Tran O'Leary" <jtranoleary@google.com>
Content-Type: text/plain; charset="UTF-8"
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

The GQ QPL queue format has a maximum supported ring size of 2k.
However, it is possible in some cases for the device to pass a larger
ring size as the max ring size. Restrict the ring size in the driver to
ensure that rings with invalid queue depths are not created.

Fixes: cde01d164f8f ("net/gve: support modifying ring size in GQ format")
Cc: stable@dpdk.org
Signed-off-by: Joshua Washington <joshwash@google.com>
Reviewed-by: Jasper Tran O'Leary <jtranoleary@google.com>
---
 drivers/net/gve/base/gve_adminq.c | 12 +++++++++---
 drivers/net/gve/gve_ethdev.h      |  1 +
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/net/gve/base/gve_adminq.c b/drivers/net/gve/base/gve_adminq.c
index 2b25c7f390..315e2456fd 100644
--- a/drivers/net/gve/base/gve_adminq.c
+++ b/drivers/net/gve/base/gve_adminq.c
@@ -6,6 +6,7 @@
 #include "../gve_ethdev.h"
 #include "gve_adminq.h"
 #include "gve_register.h"
+#include "rte_common.h"
 
 #define GVE_MAX_ADMINQ_RELEASE_CHECK	500
 #define GVE_ADMINQ_SLEEP_LEN		20
@@ -946,15 +947,20 @@ static void
 gve_set_max_desc_cnt(struct gve_priv *priv,
 	const struct gve_device_option_modify_ring *modify_ring)
 {
+	priv->max_rx_desc_cnt = be16_to_cpu(modify_ring->max_ring_size.rx);
+	priv->max_tx_desc_cnt = be16_to_cpu(modify_ring->max_ring_size.tx);
+
 	if (priv->queue_format == GVE_DQO_RDA_FORMAT) {
 		PMD_DRV_LOG(DEBUG, "Overriding max ring size from device for DQ "
 			    "queue format to 4096.");
 		priv->max_rx_desc_cnt = GVE_MAX_QUEUE_SIZE_DQO;
 		priv->max_tx_desc_cnt = GVE_MAX_QUEUE_SIZE_DQO;
-		return;
+	} else if (priv->queue_format == GVE_GQI_QPL_FORMAT) {
+		priv->max_rx_desc_cnt = RTE_MIN(priv->max_rx_desc_cnt,
+						GVE_MAX_RING_SIZE_GQ_QPL);
+		priv->max_tx_desc_cnt = RTE_MIN(priv->max_tx_desc_cnt,
+						GVE_MAX_RING_SIZE_GQ_QPL);
 	}
-	priv->max_rx_desc_cnt = be16_to_cpu(modify_ring->max_ring_size.rx);
-	priv->max_tx_desc_cnt = be16_to_cpu(modify_ring->max_ring_size.tx);
 }
 
 static void gve_enable_supported_features(struct gve_priv *priv,
diff --git a/drivers/net/gve/gve_ethdev.h b/drivers/net/gve/gve_ethdev.h
index 4a7e5ecdf3..c9a176ff17 100644
--- a/drivers/net/gve/gve_ethdev.h
+++ b/drivers/net/gve/gve_ethdev.h
@@ -21,6 +21,7 @@
 #define DQO_TX_MULTIPLIER 4
 
 #define GVE_DEFAULT_MAX_RING_SIZE	1024
+#define GVE_MAX_RING_SIZE_GQ_QPL	2048
 #define GVE_DEFAULT_MIN_RX_RING_SIZE	512
 #define GVE_DEFAULT_MIN_TX_RING_SIZE	256
 
-- 
2.55.0.rc2.803.g1fd1e6609c-goog

