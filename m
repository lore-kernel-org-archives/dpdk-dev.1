Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA6F5C43458
	for <dpdk-dev@archiver.kernel.org>; Tue,  7 Jul 2026 16:40:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 545614068A;
	Tue,  7 Jul 2026 18:40:26 +0200 (CEST)
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com
 [209.85.210.201])
 by mails.dpdk.org (Postfix) with ESMTP id 048924067B
 for <dev@dpdk.org>; Tue,  7 Jul 2026 18:40:25 +0200 (CEST)
Received: by mail-pf1-f201.google.com with SMTP id
 d2e1a72fcca58-845bc2e658aso4130390b3a.3
 for <dev@dpdk.org>; Tue, 07 Jul 2026 09:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1783442424; x=1784047224; darn=dpdk.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=DqUu3RQgNLV7VkPBILUAmO9nSpS4tPJ7xHXnCPWCqcA=;
 b=aj9WgdPOKrywkxAFf5bv/9JWgfRSG9FvJmQ2agD3T9TxAESkcFevBJ1zIoCqg5vbB3
 /LVpomNGMHOmiMynZBqLbfue5FrjrHLCXU+HgR8LTd1fphX2JL5leC2AY+/4HgsBzNTz
 9Ps0GA72nUlRXcItfgRt6zCg0tn0koLv8sz8j1tKxOQvyUx5ytj3PUHXOhf95LdWLtyo
 PLpL3gloCKB18LJzCpiU93A2UKu7l7NOAqKg5LkosfnqnjFX6RMZZ3CqsWIdLcXRsXAq
 echtmQJeoHkiApUktCkGCo6KjudqeA+saDitdM+N8d1FXNGckZED80F91XyYWiWkFirk
 01BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783442424; x=1784047224;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DqUu3RQgNLV7VkPBILUAmO9nSpS4tPJ7xHXnCPWCqcA=;
 b=MPbsAjwiAdGaVkWYAHuROJwmgPaK4zZDeb54U8f2XDLyi0kWFU34LQSTO1tzQLZ1Z+
 Atqff98C3lL746OtA3dJRN5+wTaQA9FoGlSngZHP6xImNlRI0N9oqEJIyfU9Nvu2udhU
 cA/WRvqG8czfMR2OCsnFOf0R1nNOZVWX0q5c7wYxMWBwnxEuU5VAZET6jAC0fZCjNRNL
 cXysT4EKm1rvyTWD53MvajIZqkZxwwC6FKAbGdJuXV8Rt8b481swibfZOOCKJ7l4wdhV
 TfLPhuK78NTrJ50p3G+R25I3T61KYN6RHh2T2coShMfhmcBcpNc4zAqdWSJ8v3l+f7DR
 OnKw==
X-Gm-Message-State: AOJu0YyCYilpjaXPla61n+kA1y2YHMnLLx3YFnmHudXC/vDU7kR2tIy4
 OmxpvZWRHbNSIMhc7aBsxIAIc2Zmwv1R5awQNUgHWGN+fBlOHURjfdpk50Mi0Ar4SMeoQLALcoa
 cMXD3YIsVcEBkPA==
X-Received: from pfbhm3.prod.google.com ([2002:a05:6a00:6703:b0:847:8fa5:76bc])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:6f60:b0:848:2eac:bfb9 with SMTP id
 d2e1a72fcca58-8482eacc4a7mr2850310b3a.59.1783442423601; 
 Tue, 07 Jul 2026 09:40:23 -0700 (PDT)
Date: Tue,  7 Jul 2026 09:40:11 -0700
In-Reply-To: <20260707164020.2936476-1-joshwash@google.com>
Mime-Version: 1.0
References: <20260703131308.2507403-1-joshwash@google.com>
 <20260707164020.2936476-1-joshwash@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260707164020.2936476-2-joshwash@google.com>
Subject: [PATCH v3 1/9] net/gve: clear out shared memory region for stats
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
2.55.0.rc2.803.g1fd1e6609c-goog

