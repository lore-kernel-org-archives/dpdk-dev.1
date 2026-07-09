Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01D71C43458
	for <dpdk-dev@archiver.kernel.org>; Thu,  9 Jul 2026 04:08:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 111A040B9F;
	Thu,  9 Jul 2026 06:08:02 +0200 (CEST)
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com
 [209.85.215.201])
 by mails.dpdk.org (Postfix) with ESMTP id 1671940B9B
 for <dev@dpdk.org>; Thu,  9 Jul 2026 06:08:00 +0200 (CEST)
Received: by mail-pg1-f201.google.com with SMTP id
 41be03b00d2f7-c892143db7fso1267482a12.1
 for <dev@dpdk.org>; Wed, 08 Jul 2026 21:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1783570079; x=1784174879; darn=dpdk.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=++7eU1/DQkT0xamn9DnuiQtj4HmOTXu/YC04hsV8M1I=;
 b=Vi6gcmjt7woQ+x0Ei5621neQ06YUPBNmph8Na6pFtd0xeV5oYH7WWb0fHBL6Vc6cFN
 PFLx7Ix7dCcR7Vi7g31z2jD+SaoTpgmtG0mcaaNAYPx9zxlaFnsUgDJisfKosxj1cak7
 a5nY4p3KB53WFaNI0I8TKSPiKJFgMMG8hzv0etoopN1ULeM+42TIiVaYkD5sdHBrZBpH
 YE5kA2YVL6qw9VT6sXUAUPm4GEGyYwN0RNZncQRY5jHd1q1YazmnPUH5TiSCkD9g72I/
 FKX5PFNPLaIGE9ScV1pwR25W2aCAreLhaWj1WkzZSKamo25myKN1w2Jqd+84Z+ZZx3tw
 RkJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783570079; x=1784174879;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=++7eU1/DQkT0xamn9DnuiQtj4HmOTXu/YC04hsV8M1I=;
 b=iOOoyQeNd+UdaviREMMhQLll6i5pG1EO+WMr5XDBOEK+9xF6zL/XM7loTVDI1J4HPu
 yq3Mx37HPH6r1JrKtuJZp/TslhIqu3PKuP+EGBNU2iJ8/koRMPgUuSfVlKFjx1SLza1W
 eu0WRn1lblT2FWAh1UPaxYoeU2NnDnK+s5B10A64TlqyQCJ4xQ87HPdVMvy6zLqwROji
 cLFr45y6R90ADyL0SMKfOBojQIzi3DmG9Za0a06G/EEdTSP9YerMhVnZTA34hErzhTTx
 T/xHwlHwsVFqMJwZe03qPk7lOqADrg5vmRmByWEojG9hvEy9jWaZNSR/9HMbdiqM8cUz
 wj8Q==
X-Gm-Message-State: AOJu0YwjnegxLHtfDBssfrWLnLVgdBd5i+xco412ECTO6y+C6J9N27Oz
 DH6XDETvOCrSnWEfrs/28aPjSQB7lwLutOYQS4Zl+Rpdvwu/a7EG0r9KbiYTxvPa8lDKtSopgm/
 +eH7uAallTdlytA==
X-Received: from pgvz16.prod.google.com ([2002:a65:6650:0:b0:c99:3b68:c9d7])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:a8a:b0:3bf:9fe1:c24 with SMTP id
 adf61e73a8af0-3c0bceb74a7mr5843139637.2.1783570078899; 
 Wed, 08 Jul 2026 21:07:58 -0700 (PDT)
Date: Wed,  8 Jul 2026 21:07:37 -0700
In-Reply-To: <20260709040739.3184955-1-joshwash@google.com>
Mime-Version: 1.0
References: <20260707164020.2936476-1-joshwash@google.com>
 <20260709040739.3184955-1-joshwash@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260709040739.3184955-10-joshwash@google.com>
Subject: [PATCH v4 9/9] net/gve: restrict max ring size in GQ QPL to 2K
From: Joshua Washington <joshwash@google.com>
To: Jeroen de Borst <jeroendb@google.com>,
 Joshua Washington <joshwash@google.com>, 
 Rushil Gupta <rushilg@google.com>,
 Harshitha Ramamurthy <hramamurthy@google.com>
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
v4
- Remove unnecesary include
---
 drivers/net/gve/base/gve_adminq.c | 11 ++++++++---
 drivers/net/gve/gve_ethdev.h      |  1 +
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/net/gve/base/gve_adminq.c b/drivers/net/gve/base/gve_adminq.c
index 2b25c7f390..89bf669c24 100644
--- a/drivers/net/gve/base/gve_adminq.c
+++ b/drivers/net/gve/base/gve_adminq.c
@@ -946,15 +946,20 @@ static void
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
2.55.0.795.g602f6c329a-goog

