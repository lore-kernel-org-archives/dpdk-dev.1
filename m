Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2243BC43458
	for <dpdk-dev@archiver.kernel.org>; Wed,  1 Jul 2026 18:35:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 38DC14065A;
	Wed,  1 Jul 2026 20:35:35 +0200 (CEST)
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com
 [209.85.215.201])
 by mails.dpdk.org (Postfix) with ESMTP id B58E740279
 for <dev@dpdk.org>; Wed,  1 Jul 2026 20:35:33 +0200 (CEST)
Received: by mail-pg1-f201.google.com with SMTP id
 41be03b00d2f7-c85798977dcso744843a12.0
 for <dev@dpdk.org>; Wed, 01 Jul 2026 11:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1782930933; x=1783535733; darn=dpdk.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=8QGqPuGtxlfrXkOjFjhUwi6yiW21B1UHyxjELSZSr+I=;
 b=tX+Dmix68CahJz5lkBcwN0pGeYJyODz3Uty3tL2dQlSMa6pXHT1SwyNFZaEfryDRe4
 qC79wrq08TD+jn4e6gnDqmjNYg1oYTkhA8jTCIdNe5fFB9AKI4bEX6g157cbbe5GXhbv
 ePw6j73BqpkHJYvGlucwdgmJH3yoAZjnL2hqvSDqYUZ5swnhbRI+5DHP3nrKz/F2juku
 GWwLepXqXDeh2UjpXXNvCqif4VUY/Vk+BrHnzjOap2rHey38vn1mh2GCsN9TKNrSbbr7
 vwuyLb+6at0Twj7uVoMJpEkDtmTwWip0HDxL/jBmU8WNxqRG1FA02aKNpgHuquT8KUdD
 6Cig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782930933; x=1783535733;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8QGqPuGtxlfrXkOjFjhUwi6yiW21B1UHyxjELSZSr+I=;
 b=GtNr1bFAsokav/mtDNDCmO9SYY3XODjE4rMVjoWTCOI69BZX79e16eUe2hOU8/S/BS
 1WRO2HwhgFiRcZSFr5kDhn02JCdKx2X8Y+PnbyZBlakOSTlL2B/YqBwi26xgJ4aIj9R5
 TJ/wQlRZDWb1LPgIhWzrYGTqppXLP6JzeTgbxPHu6pMdXrvHMjB1Szn5acrRgQ08T8Fq
 inHb52IbEzF7s/P0V2y7BYMVk0OYUe3ViPj5Imujw54/m0YgYm4NkWpUwB1Ffi+uIKBN
 2/Ip39lIBC3JObSm+AlZFxP6G+3LXqcmV2M2kuyBS1paDkSbR96D7FdpsldYxy+0vcl7
 1ojw==
X-Gm-Message-State: AOJu0YzNSfWbtOTDEzVruq25/aUcA+IgTOFYghguIpp9wwUnTifQQ5n6
 5wNFCUYYYNfqwPJwmE/GAdDrh1xwhyVRpgBoN63noDngHkX3fsboQpncF4tuv505MM6Kh+UmVJp
 WjMSCWnwBfNbiGg==
X-Received: from pfbly24.prod.google.com
 ([2002:a05:6a00:7598:b0:847:93d8:2813])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:420d:b0:846:2f5c:dc39 with SMTP id
 d2e1a72fcca58-847c0a39468mr2615575b3a.42.1782930932533; 
 Wed, 01 Jul 2026 11:35:32 -0700 (PDT)
Date: Wed,  1 Jul 2026 11:35:19 -0700
In-Reply-To: <20260701183528.2443032-1-joshwash@google.com>
Mime-Version: 1.0
References: <20260701183528.2443032-1-joshwash@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260701183528.2443032-2-joshwash@google.com>
Subject: [PATCH 1/9] net/gve: clear out shared memory region for stats report
From: Joshua Washington <joshwash@google.com>
To: Jeroen de Borst <jeroendb@google.com>,
 Joshua Washington <joshwash@google.com>, 
 Rushil Gupta <rushilg@google.com>, Ferruh Yigit <ferruh.yigit@amd.com>
Cc: dev@dpdk.org, stable@dpdk.org, Mark Blasko <blasko@google.com>
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

The stats report memzone is allocated from hugepage memory which could
possibly have had sensitive data from a previous DPDK invocation.

Clear out the buffer before sharing the memory region with the virtual
device to protect guest memory.

Fixes: 458b53dec01e ("net/gve: enable imissed stats for GQ format")
Cc: stable@dpdk.org
Signed-off-by: Joshua Washington <joshwash@google.com>
Reviewed-by: Mark Blasko <blasko@google.com>
---
 drivers/net/gve/gve_ethdev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/gve/gve_ethdev.c b/drivers/net/gve/gve_ethdev.c
index 0b02dcb3ad..f73784a109 100644
--- a/drivers/net/gve/gve_ethdev.c
+++ b/drivers/net/gve/gve_ethdev.c
@@ -306,6 +306,8 @@ gve_alloc_stats_report(struct gve_priv *priv,
 	if (!priv->stats_report_mem)
 		return -ENOMEM;
 
+	memset(priv->stats_report_mem->addr, 0, priv->stats_report_mem->len);
+
 	/* offset by skipping stats written by gve. */
 	priv->stats_start_idx = (GVE_TX_STATS_REPORT_NUM * nb_tx_queues) +
 		(GVE_RX_STATS_REPORT_NUM * nb_rx_queues);
-- 
2.55.0.rc0.799.gd6f94ed593-goog

