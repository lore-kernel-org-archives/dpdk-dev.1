Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C66D7CD6E7E
	for <dpdk-dev@archiver.kernel.org>; Fri,  5 Jun 2026 23:35:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 91D2E4067A;
	Sat,  6 Jun 2026 01:35:21 +0200 (CEST)
Received: from fout-a5-smtp.messagingengine.com
 (fout-a5-smtp.messagingengine.com [103.168.172.148])
 by mails.dpdk.org (Postfix) with ESMTP id CBF144065B;
 Sat,  6 Jun 2026 01:35:20 +0200 (CEST)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfout.phl.internal (Postfix) with ESMTP id 7A471EC01A5;
 Fri,  5 Jun 2026 19:35:20 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-03.internal (MEProxy); Fri, 05 Jun 2026 19:35:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1780702520; x=
 1780788920; bh=PApFKN/EM/1VqqJ0s7RfjM6nlLnmW/GNEZXlVqsUtNY=; b=w
 fD8GVaNFCxB4pbg+SmvzgBT+P9j0tLyMrbEXhgpHrPx18mbbhxAhaXWiAkq8IE6M
 rSW9+LhGIjJszsJeiXVEQ+lWUpMvupoBq29q0qiPJjz7cBDKqU7IbO06hmn0R4/c
 Ol6hSBSAlP8jO3bDgmIZXJbU70nsnFbDNDlzV088gJzjRIzS6pyTPMSodq8v+nEA
 +hCbt/13ozB4PkS+yg8fMBw+w71JPLMx5fKAO3z/8TEGK2nrhRsauaQpQGPVAAV+
 P/IJykizQpcTY9USty5i+j+P6bt6S4gSJU+hxAlZXLfEXxSjnLMaNkWbSdTi5sZM
 9hsbRU0/WeBiV5ayqgY0w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm1; t=1780702520; x=1780788920; bh=P
 ApFKN/EM/1VqqJ0s7RfjM6nlLnmW/GNEZXlVqsUtNY=; b=dyBT66Y/Nu15GKeIC
 3v7fMLlvyyrqi2rOERDOSgeFyENCChzOnyGv+chcjsXJYGm5O/4i3Qt2LE2UVsm2
 XOKkCd4PjmdGtDHB2h5vjjBlEl7AJ8DGI/ajih9QFCi/PL5aGIwS+gohnoOZdCsB
 DKsWmhJIfzoyY21+0NccwZUZt8O3TP5SG+GO5Krx+9kJkgdS9ujKZTdb7iQUXYI4
 4MJuU2iGYKPsfQaQdQKrtY7CWQxdKJkLxKUfCyKD4srAe6D9EwaOWtMs0s6LjC2E
 bJC8zAhdWrmKsn1ECGa064vbIIMXjbdZP6ELhxyJf1V1FlchBwDyhzQ24ATrrYk/
 6ZZVQ==
X-ME-Sender: <xms:OF0jalj0kfJ1dAG4Z2RQThyu7_0y0OWdCc0nNRZCOjvKBTH0RcnFoQ>
 <xme:OF0jamAXhNtcDu9oDwJaciClRQEZB73KpnMBE4_bqZAuSAX04ylIblyPOMxJFZV23
 OzAFUa_dlGP_DVXSzJiz8qyxtnD2H8Su2HNhIgtxv3pOjacZYFXbA>
X-ME-Received: <xmr:OF0janSEgXMid59gb0TZVAnrs1KR3OFvk30yz5cDJgRCHTCrNRnBkO-dV7U4JiXIyUBrytUXJ3E8tnlgVNcRtlYHTsHMfF0>
X-ME-Proxy-Cause: dmFkZTGd3xDUVFhwSpw4F6uqdu/WAU1G3RNTpKG+DxTI8R7cf9OPBCUQTZI1aI70ur+beV
 SEzaxoFYxUEPgGdFat/nLbvwtf6p2EIVPCL0jcpCsimYYA54kBH/AhVoEUbuBNrXEOB0M6
 XJy8wUCeS0P8VbOQ5zjazzPrNBt0ZPqCr77gnhfDYpxZP7clf1azQ2WSFnIrISy2YwD/j7
 4tKcOsJvzUEKUjwwC8EeOTDFWTkY3AQXr7aeBRNUXNLnrN2UyhGHhhiRoN7p78ULDtGl1R
 Fhn6vXC23U5MT8l0EMWpBhBza8AUUwy00tE26DEf7ROVH+p9UuCs/XwKdxAH/aFzvs67V9
 bCsKo1fzkaqj2gmwJkiirBsUmHg12qTgMBMSaAeXfSw2Dr2ecyOQTq0kV+Bjg3S06fSGOH
 eDiC/lMByHPb4S1PGN7jITtymDVsBRErMwCu6Pwk0uKZlp7E38B1UPtDBqAvTSOuwZAwsz
 11j+a+GWy+pACy1+kFeOcu4KrHcZGClZ305fneu2bvcqxOCi/d7XL61foqCHpgYl4PvCaW
 TpCSmNaIXlPnwF4uoP+VaE9hCHpqfWy3j5JHP+7bbyR9pAKlHojkAfAX3ssSZ7/sIfu8a9
 8fqYIinVT+85q5VFfhKV2MsmF2T2Z1M2XEKFA8JkCe7rInqF2opL3bKJi3Kg
X-ME-Proxy: <xmx:OF0jarV9yXAdK6v4fGGfDBNMtpnk85mesEzFCqokcNSUvtgAp3JTdw>
 <xmx:OF0jagf5tGyDYEwBtxdFMDt4Kn_bqRwJEnyUZ4vj5VSXwLJmCkFNDw>
 <xmx:OF0janIHy5KlUmIwaxqIwu_PrQ2oxNMz0ulAO6lrXi2C6MrIkfTIWg>
 <xmx:OF0jalzHuiMg2eYs8fpfvUB_0KgWxRSldP_NgacaGJWPUbp__5fo5w>
 <xmx:OF0jakYZs13Wh8R9kQVho2QWPq-iPd0130r3FAN_awxH9mcTfV8Gvtq0>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Jun 2026 19:35:18 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
Subject: [PATCH v9 05/10] net/mlx5: fix Rx split segment counter type
Date: Sat,  6 Jun 2026 01:33:45 +0200
Message-ID: <20260605233456.3017423-6-thomas@monjalon.net>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260605233456.3017423-1-thomas@monjalon.net>
References: <20260202160903.254621-1-getelson@nvidia.com>
 <20260605233456.3017423-1-thomas@monjalon.net>
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

In the API, rx_nseg and max_nseg are uint16_t.
In mlx5, MLX5_MAX_RXQ_NSEG is 32.
So there is no reason to have rxseg_n as uint32_t.
Reduce the fields to uint16_t and move them to avoid struct holes.

Fixes: 9f209b59c8b0 ("net/mlx5: support Rx buffer split description")
Fixes: 572c9d4bda08 ("net/mlx5: fix shared Rx queue segment configuration match")
Cc: stable@dpdk.org

Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
---
 drivers/net/mlx5/mlx5_rx.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/mlx5/mlx5_rx.h b/drivers/net/mlx5/mlx5_rx.h
index dffab3955b..01b563d981 100644
--- a/drivers/net/mlx5/mlx5_rx.h
+++ b/drivers/net/mlx5/mlx5_rx.h
@@ -164,9 +164,9 @@ struct __rte_cache_aligned mlx5_rxq_data {
 	uint64_t flow_meta_mask;
 	int32_t flow_meta_offset;
 	uint32_t flow_meta_port_mask;
-	uint32_t rxseg_n; /* Number of split segment descriptions. */
 	struct mlx5_eth_rxseg rxseg[MLX5_MAX_RXQ_NSEG];
 	/* Buffer split segment descriptions - sizes, offsets, pools. */
+	uint16_t rxseg_n; /* Number of split segment descriptions. */
 	uint16_t rq_win_cnt; /* Number of packets in the sliding window data. */
 	uint16_t rq_win_idx_mask; /* Sliding window index wrapping mask. */
 	uint16_t rq_win_idx; /* Index of the first element in sliding window. */
@@ -191,9 +191,9 @@ struct mlx5_rxq_ctrl {
 	unsigned int irq:1; /* Whether IRQ is enabled. */
 	uint32_t flow_tunnels_n[MLX5_FLOW_TUNNEL]; /* Tunnels counters. */
 	uint32_t wqn; /* WQ number. */
-	uint32_t rxseg_n; /* Number of split segment descriptions. */
 	struct rte_eth_rxseg_split rxseg[MLX5_MAX_RXQ_NSEG];
 	/* Saved original buffer split segment configuration. */
+	uint16_t rxseg_n; /* Number of split segment descriptions. */
 	uint16_t dump_file_n; /* Number of dump files. */
 };
 
-- 
2.54.0

