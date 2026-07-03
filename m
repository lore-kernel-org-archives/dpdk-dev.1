Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E80FC43458
	for <dpdk-dev@archiver.kernel.org>; Fri,  3 Jul 2026 13:14:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0ABD840DC9;
	Fri,  3 Jul 2026 15:13:29 +0200 (CEST)
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com
 [209.85.214.202])
 by mails.dpdk.org (Postfix) with ESMTP id 03C5A40B94
 for <dev@dpdk.org>; Fri,  3 Jul 2026 15:13:28 +0200 (CEST)
Received: by mail-pl1-f202.google.com with SMTP id
 d9443c01a7336-2c354050c34so7454745ad.3
 for <dev@dpdk.org>; Fri, 03 Jul 2026 06:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1783084407; x=1783689207; darn=dpdk.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=ub93N5Eh/15anJYj/KJIFjy3RP6xhlUT8JAmGiHxu6s=;
 b=hxzLGrE+S95fQMArxlspbSR4mN61O9pNZeXcVjFWDmr5S/1F2lyEnTacx2vbYHS32T
 YHrVuGiZjQFBXC3jVyb0BW05W1hHLvzm1dbBNghwgs5YgnCMgIoiJ0oXnJW+wYIxcvuG
 ovCbzvA09d5RHPh8d1g7S9Ni/1LxhYQx7QcNDvYHuituRSTdmBuhR53lgR4Sh3VLMFus
 sGY8QXzkRoNyh+jjj81Yf5GfsYXMpPw0PSKlsSHDgh9OAGnIM/B/m0m2graelMATxu9o
 LfVVWE94tA6XuVzSzO4I4YojROUUztQwd4PloOj0wou4NflQxXHGw7pnSRtSZLw7b0sH
 63uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783084407; x=1783689207;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ub93N5Eh/15anJYj/KJIFjy3RP6xhlUT8JAmGiHxu6s=;
 b=Ze7OHxJ9I74FX5G7CsIUd/9euuehbt6myFwzP6D6gucRMiHdkFaMiW4sP0x9ALFFjR
 ky/r8tZPGq7JGLh1KeK3nsEnw34r9FRU06tFMfXlj2QeAHzuwSbEaHwGRe0jL4RI9Ot2
 BVJKXSWQdKhCjryP8qLZML1LXdcXyrGeMIKdiC9wcfl32B7Yq6B7FFLPUaxwNFbIHcEs
 f0AVCTMUH4ZDBUxzOjuQvv70mMzuQDgG9pq8Fd6zQHX0wd2+X8A1FLrXCIBdhDRj0sL/
 XWfK/0ExW1crxGmx6EgwnrqZWC+bJdZutlrKukOYF5z/4Ip4xjypKxCE8hoTIL0hLDQ1
 X69w==
X-Gm-Message-State: AOJu0Yw7LXvl5hH+COlhfRHL5E9wQBVjeK9Wd00YmR1H3zBjoSoQcE/n
 QMmwUZEppfJ4sIbYQscnxM4wB3LWOx0UYIf/Ggn8ot61efxt17617SpTOjH2/0zHOGpYJegl2FJ
 w4gSKdkyZr1ADWA==
X-Received: from plau3.prod.google.com ([2002:a17:903:3043:b0:2ca:e496:5f17])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:3883:b0:2c9:97a7:b1ec with SMTP id
 d9443c01a7336-2ca7e9348f2mr120625065ad.43.1783084406960; 
 Fri, 03 Jul 2026 06:13:26 -0700 (PDT)
Date: Fri,  3 Jul 2026 06:13:06 -0700
In-Reply-To: <20260703131308.2507403-1-joshwash@google.com>
Mime-Version: 1.0
References: <20260703131308.2507403-1-joshwash@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260703131308.2507403-10-joshwash@google.com>
Subject: [PATCH v2 9/9] net/gve: restrict max ring size in GQ QPL to 2K
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
2.55.0.rc0.799.gd6f94ed593-goog

