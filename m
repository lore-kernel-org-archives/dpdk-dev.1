Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED70EC43458
	for <dpdk-dev@archiver.kernel.org>; Wed,  1 Jul 2026 18:35:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E392340685;
	Wed,  1 Jul 2026 20:35:40 +0200 (CEST)
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com
 [209.85.210.202])
 by mails.dpdk.org (Postfix) with ESMTP id 91FE340685
 for <dev@dpdk.org>; Wed,  1 Jul 2026 20:35:39 +0200 (CEST)
Received: by mail-pf1-f202.google.com with SMTP id
 d2e1a72fcca58-8478e603285so1891494b3a.0
 for <dev@dpdk.org>; Wed, 01 Jul 2026 11:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1782930939; x=1783535739; darn=dpdk.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=Lq41BhrjKl0hnBjxMqc7fvAIHPP5DWhlu9cMWncz6y8=;
 b=jDV7/r6Wa4XjoZDRn6J4vrzYznI5s3Pp3ljs/VLgpxIgi+nIWlyzLF4h1rXHiJf6L4
 tkPRKycdo6rjotUQB97WqKDFnA/s+SiT1fSujmrTy35XCigusQU54/hCbNZyCBi4FAAZ
 ZaTEf9HIY0gbLnAQ7Nwo036sN9bqiv4pn5KJUKuLZn4jbP/hFWd0nF3F66A/O+rWJV7a
 6czY7ElUulB6xBm4yNtCGxzzszq0HbPlkJkKL4G+1B1XqoJ1DG21Qe4nAifxMA6ICmEN
 aL2dgXKQ0tWtKnXkSyGjIzeewn+fi1OfZhdmb6dKx3QaXU5UfzG6EVKF7hO5kn9/V0P7
 0yOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782930939; x=1783535739;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Lq41BhrjKl0hnBjxMqc7fvAIHPP5DWhlu9cMWncz6y8=;
 b=IvMZEscCvY571Rt6cPXZtXg9G2SNyGzuysKXyrwIiqGrGLTxAAeevDnHTs+DZt9adZ
 WLoZKPcv/PUb16jejWrLNWnWhgRq1E75WIu1RHTo+q6dSsQ6bSQ9jpt0IX2ElbXOF7Hc
 JPUG1oqkDnTeN1T2+PrMszxmKG+WHHolbbBwkCyVQ0O6yoWxA+6ZE15ebyCXjQZclvzc
 9TrOZYkcruSPZjgO19c9DZLrmN6WD3oRi9vdVR+m+mwZFq8HQ9q1aBC8CImHjxHo3a3m
 kiOYrawAWAgxZJYqHjc72PPTANCm13U6hnCYjpGRWnNnDUNW+TGpnq6Ycg4f+gkUwUml
 RmHA==
X-Gm-Message-State: AOJu0Yx2e4teWS1X8NVBpljBJAMFONRXhutJdlfjIDMczFYGiJv28QjZ
 kKtX+RxD8FeNe7Kfx4WmxUBml7tQYpz5ZYeWqweXdf7PiXMGS5oSShj0RHvjNPpbpZHzzAjaQzm
 vvA+ovdQlmhDQtg==
X-Received: from pfbjs24.prod.google.com
 ([2002:a05:6a00:9198:b0:845:e1d9:7f94])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:2e18:b0:847:8704:1c57 with SMTP id
 d2e1a72fcca58-847bfaa89aemr2331726b3a.31.1782930938339; 
 Wed, 01 Jul 2026 11:35:38 -0700 (PDT)
Date: Wed,  1 Jul 2026 11:35:22 -0700
In-Reply-To: <20260701183528.2443032-1-joshwash@google.com>
Mime-Version: 1.0
References: <20260701183528.2443032-1-joshwash@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260701183528.2443032-5-joshwash@google.com>
Subject: [PATCH 4/9] net/gve: validate buf ID before processing Rx packet
From: Joshua Washington <joshwash@google.com>
To: Jeroen de Borst <jeroendb@google.com>,
 Joshua Washington <joshwash@google.com>, Ankit Garg <nktgrg@google.com>
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

The buffer id is part of the RX completion descriptor for packets in the
DQ format. This value can technically go up to 64K, while the max RX
ring size is 4K, meaning that there could similarly be an expected 4K RX
buffer IDs. Validate that the RX buffer ID is valid before attempting to
access it in the sw_ring to prevent a potential out of bounds in the
event of a hardware error.

Fixes: 1aed73b23ac0 ("net/gve: support out-of-order completions on DQ Rx")
Cc: stable@dpdk.org
Signed-off-by: Joshua Washington <joshwash@google.com>
Reviewed-by: Jasper Tran O'Leary <jtranoleary@google.com>
---
 drivers/net/gve/gve_rx_dqo.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/gve/gve_rx_dqo.c b/drivers/net/gve/gve_rx_dqo.c
index cc343f3fd8..c4e2d32067 100644
--- a/drivers/net/gve/gve_rx_dqo.c
+++ b/drivers/net/gve/gve_rx_dqo.c
@@ -200,6 +200,11 @@ gve_rx_burst_dqo(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t nb_pkts)
 		}
 
 		rx_buf_id = rte_le_to_cpu_16(rx_desc->buf_id);
+		if (unlikely(rx_buf_id >= rxq->nb_rx_desc)) {
+			PMD_DRV_DP_LOG(ERR, "Invalid buf_id %d", rx_buf_id);
+			continue;
+		}
+
 		rxm = rxq->sw_ring[rx_buf_id];
 		gve_completed_buf_list_push(rxq, rx_buf_id);
 
-- 
2.55.0.rc0.799.gd6f94ed593-goog

