Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C5D2C43458
	for <dpdk-dev@archiver.kernel.org>; Fri,  3 Jul 2026 13:13:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9233240647;
	Fri,  3 Jul 2026 15:13:14 +0200 (CEST)
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com
 [209.85.215.201])
 by mails.dpdk.org (Postfix) with ESMTP id 9F80D402C5
 for <dev@dpdk.org>; Fri,  3 Jul 2026 15:13:12 +0200 (CEST)
Received: by mail-pg1-f201.google.com with SMTP id
 41be03b00d2f7-c889d1eebafso1403372a12.0
 for <dev@dpdk.org>; Fri, 03 Jul 2026 06:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1783084392; x=1783689192; darn=dpdk.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=8QGqPuGtxlfrXkOjFjhUwi6yiW21B1UHyxjELSZSr+I=;
 b=RPwQL6N6Z8YTJsALiGu7nq2X2Ja13Z6mvYosiqAcXMCChwFZ58f3rNXOtNM154/cGV
 hc8+ciJA9TSI1WZI9SZc//0u3fJ8z+SSQga5D3QzBgVjTsCMwPL4A3ndzUa45B49wLFR
 qGviS+WmXwa89mxYVYfJTDqUO6k22zS4vFPwD8lxJ9huEEib/5KNUvawXoxl0RFOioPx
 Fxanag+7dqbtSwT1fu2ZZR35QXbNjWipp+fdxgCb+qDP3rJn+fsTIEzv4eqGqXusDX4t
 Oq8O5XL84CAXHdSldSDkszbkK3J6iWfRJ4dtqrFrV/J0S4Sd8C14P3+Mwk9I/quFCfge
 dhDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783084392; x=1783689192;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8QGqPuGtxlfrXkOjFjhUwi6yiW21B1UHyxjELSZSr+I=;
 b=Dm8I8gkcGc6a3GOwm24P5mroHmQyECuG0tDjjgOd3c51TfpRsHJhvcd2QL8xnwb/z9
 sr5QNQCnn1ch6Chlg2fjfmXalnCMsHpT4zA/z170gVX/DQD1pf7KCmCgM4XUUQkQosFp
 5xpq5f8kV9GYderX6YAiCHT2OR6rVWB2AHx47KseJbAjWNnzqZCfe9tvCFiSW5BXplZk
 HRgATLkmSlgAl54g2nkfQPyQ5yJPs7ziVQpuZz8l5h0oMLfthrcaKUZZfRaZWUIOLwVd
 QLQnAX7VrpCHNSp9gBczzVGeS01RbbCAW6MioqQWQVBG93DlIk7uMxDOLZvHXrJcmILy
 LyEQ==
X-Gm-Message-State: AOJu0Yzh9r6r9bTdY5GyLMIBCCjfIQf9xAj6m2ZYemwHOZ/+uvokO9Lz
 uHb5qRBB4h52IxByVdMRlFxUt5/ncyNy5JVMUMQeeRQHa/DFLatNwcCU3+Ie8VyCpMQ2DrSHnja
 bSlHKLo+2Zh3NnA==
X-Received: from pgbcp8.prod.google.com ([2002:a05:6a02:4008:b0:c9a:4ffc:3456])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:bea6:b0:3bf:6c08:2848 with SMTP id
 adf61e73a8af0-3bff42f8287mr11535575637.55.1783084391574; 
 Fri, 03 Jul 2026 06:13:11 -0700 (PDT)
Date: Fri,  3 Jul 2026 06:12:58 -0700
In-Reply-To: <20260703131308.2507403-1-joshwash@google.com>
Mime-Version: 1.0
References: <20260703131308.2507403-1-joshwash@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260703131308.2507403-2-joshwash@google.com>
Subject: [PATCH v2 1/9] net/gve: clear out shared memory region for stats
 report
From: Joshua Washington <joshwash@google.com>
To: Jeroen de Borst <jeroendb@google.com>,
 Joshua Washington <joshwash@google.com>, 
 Ferruh Yigit <ferruh.yigit@amd.com>, Rushil Gupta <rushilg@google.com>
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

