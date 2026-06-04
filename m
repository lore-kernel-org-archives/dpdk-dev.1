Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8209ECD6E75
	for <dpdk-dev@archiver.kernel.org>; Thu,  4 Jun 2026 19:34:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 91ECE40696;
	Thu,  4 Jun 2026 21:33:41 +0200 (CEST)
Received: from fout-a8-smtp.messagingengine.com
 (fout-a8-smtp.messagingengine.com [103.168.172.151])
 by mails.dpdk.org (Postfix) with ESMTP id 7998F40689;
 Thu,  4 Jun 2026 21:33:40 +0200 (CEST)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfout.phl.internal (Postfix) with ESMTP id 276EAEC0109;
 Thu,  4 Jun 2026 15:33:40 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-03.internal (MEProxy); Thu, 04 Jun 2026 15:33:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1780601620; x=
 1780688020; bh=PApFKN/EM/1VqqJ0s7RfjM6nlLnmW/GNEZXlVqsUtNY=; b=b
 j9geXXaxN0sTYvPHPFwY3XV98sM8sLDCR55Poo+F6u2RRwnmQsRVFHR0s9TWyGTI
 mf95FwxDuYwcJjq+MRnNRH110v0juwAjS5GoQlGdrXy/9D3WUi0vywOEzrytjYOc
 5LFkjJ4WIzzmKLQWKY9KqmjXNwhau58bqWj6cTxligx9bu1kvCmgXbfBhlElTZaP
 z90jSSIXsrMe5ddT44NDHDxTOlcX9VqTlhMEJ+RyDjfr6wTWwXVv1vBgKhNwAFYz
 BXF+UbWMFqiFUDF59rGALC2Knmq8yMFBf1OoahYyM8esPp6RPPMU9KNTR+OCk7xv
 7RAp6fk5rPLXAhYGey5cQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm1; t=1780601620; x=1780688020; bh=P
 ApFKN/EM/1VqqJ0s7RfjM6nlLnmW/GNEZXlVqsUtNY=; b=Y7TNJF9YUTMQsOLOm
 a7UqSFA9FCfvBQesDWXROz9zHYhSI0ePskZF/rtHeSzeBZgJ7HDF0SP/wbz77ICc
 Lm6j3diykpap7kvqQdCRvcPz6wUwy9FcFMggSlYniVMDgDTVbbdmCqxoKVN3sTFx
 2RYXJj/u5MDNsRTLJxfCk4XqNnyHq3UXeWowYu8L7QRdhSd5kvk68X+jCJHIK7l5
 xLebhNjF5XR2VNrO/IAGX9gCWaIESOA2/xLpnKi6yH6L3Rq7Yzmm4DJ5qY7bntbi
 pfqugWwxgm6WULDUgr5Grzkdo/vrh0M2/bBUbQM8g/WLbX7El6AocOq3dbAXnTwt
 n/+VA==
X-ME-Sender: <xms:E9MhasAPMhAtsck6-BPaMC3hlx8qN7qcVBvvTUz6HezUSEs2UxhxNA>
 <xme:E9MhaqgyL8XUafRmchRw4K3TQiS77KkGMiYiiIIvDHNaWBbDhStGRXf20vxnv4z6C
 K6OnwE-9t1r60rADB4g3d9V6u5bpt_m2kyJBiOUNLXj40oRqYct>
X-ME-Received: <xmr:E9MhahzSPkIF68VicNWRVQmtuBB54Yh4pV-2KXE8qSOQAimDnUhGcL7HArfGr9uIRnHMrnTOhCJmb9fNOUDoyKDJ0nkvuoE>
X-ME-Proxy-Cause: dmFkZTGndLKCXAiaDl/jhplh6YPXoYXVKhP6lo8DXje1e6TOQ4ltXhEU0a6VWbNcrA2Baf
 g8HbQ402DdrmTes5FtmtTTchkr//XUzaIRPdqjYALp3VSQJRnzQUjsUgoRKGFABPr6GQ/C
 L2tfKcFuA3+NFj+/1qs/YjaXP6DUMEm8GwtcnPU1U2CnOjZhrcBb96db7Vwz3m4IJoVxFb
 D7XeSkauYJW3bCMCozlPRv1motCkaP6zFgaffH5mRehH7mY8RXS4jOKc1xKM7zWHZhZevt
 6jzGvgUI9WZrFncFePrMp3e5JQp6a201If6MMkAmAJfApvLP0VEHNWjbpLrPA+id+z0RBw
 5hVoPI7+0k5JDbQ9Sqnz+WecMTMYYTe8qiscbv+x8MhLZYsuUTdIPN4wl7Bi4pTBCgRHzv
 sTzDfhR1/qGNZhA1haOj2uw83D0MjUwgmNTDFYmELgKFW1fYH/yGxushFc3cG/7HvpIXWa
 S8ZR9RDLMkTe6/9nnWkakt6581mlkaNPAVJZhvOxb7JmyU4thjt5jnmdCC9DZhsmNnqZrk
 cwNW9t5Ii2mtfrUG363K2HB95wGxBm1iVTVVnMXx5VZg9EWnP7YZNRFBH2qrzyeX54SiHw
 WTGcI1zAMQVzsOGqo4vliSPKf55v8jcJzuaihrw/Vks5B4k9WftXNybaoVAQ
X-ME-Proxy: <xmx:E9Mhaj1-CNI3IJoiO-A9g1ztKG_SmKtwz3oHmtzzehYC9Fcm3Wgvew>
 <xmx:FNMhau9iYtyIFxj9d3idmLFxPXAS4IUkfSd1H3w-lDonzmsq4lW6ZQ>
 <xmx:FNMhajqPp75ttLxyU32jiJ7IImPnF2LyRFIkccvw83sE2MkdT4j40A>
 <xmx:FNMhaoRH_o5kR5F4FXPuF9oOwjevmIPWIoNhyvfvTwX6USjCy_8yUA>
 <xmx:FNMhas5qJ_DQbQ_GmuVNTp9-LXZeGu0hRc-qGrUeGglQLW3EHFZQMiW_>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Jun 2026 15:33:38 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
Subject: [PATCH v8 5/9] net/mlx5: fix Rx split segment counter type
Date: Thu,  4 Jun 2026 21:30:57 +0200
Message-ID: <20260604193324.1996141-6-thomas@monjalon.net>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260604193324.1996141-1-thomas@monjalon.net>
References: <20260202160903.254621-1-getelson@nvidia.com>
 <20260604193324.1996141-1-thomas@monjalon.net>
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

