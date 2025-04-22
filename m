Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DCC5C369D3
	for <dpdk-dev@archiver.kernel.org>; Tue, 22 Apr 2025 15:52:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3246040616;
	Tue, 22 Apr 2025 17:52:07 +0200 (CEST)
Received: from mail-wm1-f97.google.com (mail-wm1-f97.google.com
 [209.85.128.97]) by mails.dpdk.org (Postfix) with ESMTP id 927AE40395
 for <dev@dpdk.org>; Tue, 22 Apr 2025 17:52:05 +0200 (CEST)
Received: by mail-wm1-f97.google.com with SMTP id
 5b1f17b1804b1-43cf034d4abso48325405e9.3
 for <dev@dpdk.org>; Tue, 22 Apr 2025 08:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=6wind.com; s=google; t=1745337125; x=1745941925; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vgCelfETtI+N4Z68aWSWsog/0E0r97+wH2F9cVJMXj4=;
 b=CQuj7nI1uGcNYPIjBG1wjYkaXW5pX4D60IZSFSeT2dUpQGNMLxTiD259luJ+stQv+x
 jpI0RXEqsq3fjTK11wowiMfBEXB+d0+XEr8Okn48riiJsq59l9ha/ZUUyburS1Z+Uo6I
 WGxNVmkLxV+R/ycBjY2v6igZHmFskzmLeCupeNTxWReHL71Ic8Pr841UH84Z3Db5boAp
 3/KBo8dRbzygwV3STE+tmSnfw/JAQvQXcRJx5NVffUECCeatblY0lb051afsDSKwI9zm
 Xzl/Uwi5drqeyd2w9MNGOQz2dACjma4OxPdCDwnYvZN4VW4ZcBVQzPnwXZXNb8tRqyeY
 D+fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745337125; x=1745941925;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vgCelfETtI+N4Z68aWSWsog/0E0r97+wH2F9cVJMXj4=;
 b=OXDOgmiHVXDNFZBMMEXzEJVZIXhuE+KZ9wM7W5Zh08Z/GKIhpW2MIyoeDs+Xj7Et2X
 dXo2VeisfbX5V71+nJGhSGc0PipotrMMBg3B8QwbgYPV14vo1kXb74fQsZwD+6kwjk1p
 DrDjfEtkv8deGl07TKPvfh54U0+1WoZG4jFv6vDiDulILfKZFKa034rqCPvzktOwwe72
 12IPmoUFUoRLyh4EUiy6kVmnT7D4aGf1CYRaJy9gXQq8GRXAuluuthQrNThyqR94Za56
 WrSg9TwP0lh7JQ/5AYzKv7DkxecQp1RT9BPr4W17kI5983POA30I+93mUyF8A2KnGXbV
 nbDw==
X-Gm-Message-State: AOJu0YwUC1TXezPEE+i2ef7BSLtqKL6D7WFzI4q18ZEptVMK70SsAt+5
 HJ79uBG1J3iGtBnQ4exn2V8k+7QomLbkPKIzq6DaAta81LN5TS3QANG13C30/ZoLCXu8k911h/p
 XpDK3Z8PTtGBNBYMexILtWKxqIRXj1/FyFlSM4uAj
X-Gm-Gg: ASbGncs67N/aeUG/SPBZGAnjr1kBa7TKylKIl6l37/UxRF2Zlh1ZUp2AHm0m7/FuSmd
 zrYVSb5t366NaqqqcoawR/YbvD/j+QzxD94PsEMA5VXEnA8fc0dAU1Fh01RVCg9c3BhJ79GA6pm
 mww+GQcXXpvZ7dAXINhIsrG6lyIhcxkANcHd0X042sSz7WpWvGgdmPFuN4jC35i3xpwBU9VDqBd
 fZWSoIrig26DDaCUTOKdIFBEeoztyWKQMQ2X/Qf6Pp5iazqf8qtgR9aMI02kmnXfKOa+swZLe/X
 mHpb8K2AUT/cKXPZGWYasdi7EJgYKiMzRoBVg2cO2vtnKr3dK7qncUIVwGxCv99IPKE=
X-Google-Smtp-Source: AGHT+IGay0Sv+hETrcj2JpT5aS32hUeteVQXmge4ltF3ThLSLip1n1iNxEZ2oN+eLaOCOrrVzSCLrPCBZ275
X-Received: by 2002:a05:600c:3c8d:b0:440:6a37:be09 with SMTP id
 5b1f17b1804b1-4406abb1f63mr148939295e9.16.1745337125138; 
 Tue, 22 Apr 2025 08:52:05 -0700 (PDT)
Received: from smtpservice.6wind.com ([185.13.181.2])
 by smtp-relay.gmail.com with ESMTP id
 5b1f17b1804b1-4406d6e5560sm9701265e9.36.2025.04.22.08.52.04; 
 Tue, 22 Apr 2025 08:52:05 -0700 (PDT)
X-Relaying-Domain: 6wind.com
Received: from localhost (dio.dev.6wind.com [10.17.1.86])
 by smtpservice.6wind.com (Postfix) with ESMTP id D6E86360DC;
 Tue, 22 Apr 2025 17:52:04 +0200 (CEST)
From: edwin.brossette@6wind.com
To: dev@dpdk.org
Cc: olivier.matz@6wind.com, didier.pallard@6wind.com, lauren.hardy@6wind.com,
 dsinghrawat@marvell.com, palok@marvell.com,
 Edwin Brossette <edwin.brossette@6wind.com>, stable@dpdk.org
Subject: [PATCH 5/5] net/qede: fix rx_buf_size calculation
Date: Tue, 22 Apr 2025 17:51:43 +0200
Message-Id: <20250422155143.3893525-5-edwin.brossette@6wind.com>
X-Mailer: git-send-email 2.35.0.4.g44a5d4affccf
In-Reply-To: <20250422155143.3893525-1-edwin.brossette@6wind.com>
References: <CANDF9xDNq9Yy+FujvGcc3r1ycjbJDJmnP4_ih+LEm-07=jHDcA@mail.gmail.com>
 <20250422155143.3893525-1-edwin.brossette@6wind.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Edwin Brossette <edwin.brossette@6wind.com>

When the MTU configured is lower than maximum mbuf size (all packet data
can be stored in a single mbuf), then rx buffer size is configured with
MTU + some overhead. A flooring is applied to this value to align it,
meaning its actual value is going to be lower than expected.

This is a considerable design flaw, because a data packet fitting
exactly the MTU might not fit in the rx buffer. What is observed in this
case is that the nic splits the datagram in two segments, essentially
doing Rx scatter. However, the qede pmd does not expect gather scatter
in this case and does not use the required function: it uses
qede_recv_pkts_regular() which is not capable of handling this case.

Thus, we end up with malformed packet with m->nb_segs = 2 and
m->next = NULL. This means the last part of the data is missing.

CEIL max_rx_pktlen instead of FLOORing it. Also change the check on
max_rx_pktlen > bufsz in qede_rx_queue_setup(): if this ceiling would
make max_rx_pktlen exceed mbuf size, then force enable scatter-gather
mode.

Fixes: 318d7da3122b ("net/qede: fix Rx buffer size calculation")
CC: stable@dpdk.org

Signed-off-by: Edwin Brossette <edwin.brossette@6wind.com>
Acked-by: Didier Pallard <didier.pallard@6wind.com>
---
 drivers/net/qede/qede_rxtx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/qede/qede_rxtx.c b/drivers/net/qede/qede_rxtx.c
index ea77f09e18be..2a6f1290ad4a 100644
--- a/drivers/net/qede/qede_rxtx.c
+++ b/drivers/net/qede/qede_rxtx.c
@@ -111,7 +111,7 @@ qede_calc_rx_buf_size(struct rte_eth_dev *dev, uint16_t mbufsz,
 		rx_buf_size = max_frame_size;
 
 	/* Align to cache-line size if needed */
-	return QEDE_FLOOR_TO_CACHE_LINE_SIZE(rx_buf_size);
+	return QEDE_CEIL_TO_CACHE_LINE_SIZE(rx_buf_size);
 }
 
 static struct qede_rx_queue *
@@ -237,7 +237,7 @@ qede_rx_queue_setup(struct rte_eth_dev *dev, uint16_t qid,
 	/* cache align the mbuf size to simplify rx_buf_size calculation */
 	bufsz = QEDE_FLOOR_TO_CACHE_LINE_SIZE(bufsz);
 	if ((rxmode->offloads & RTE_ETH_RX_OFFLOAD_SCATTER)	||
-	    max_rx_pktlen > bufsz) {
+	    QEDE_CEIL_TO_CACHE_LINE_SIZE(max_rx_pktlen) > bufsz) {
 		if (!dev->data->scattered_rx) {
 			DP_INFO(edev, "Forcing scatter-gather mode\n");
 			dev->data->scattered_rx = 1;
-- 
2.35.0.4.g44a5d4affccf

