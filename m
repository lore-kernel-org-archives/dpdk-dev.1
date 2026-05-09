Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 557B7CD37B2
	for <dpdk-dev@archiver.kernel.org>; Sat,  9 May 2026 22:04:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 856D540665;
	Sun, 10 May 2026 00:04:42 +0200 (CEST)
Received: from fout-b4-smtp.messagingengine.com
 (fout-b4-smtp.messagingengine.com [202.12.124.147])
 by mails.dpdk.org (Postfix) with ESMTP id DE534402ED;
 Sun, 10 May 2026 00:04:40 +0200 (CEST)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfout.stl.internal (Postfix) with ESMTP id 408951D00061;
 Sat,  9 May 2026 18:04:40 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Sat, 09 May 2026 18:04:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1778364280; x=
 1778450680; bh=PApFKN/EM/1VqqJ0s7RfjM6nlLnmW/GNEZXlVqsUtNY=; b=Z
 FVMOyROa6XjgkpxheI+EQUNe1lKM/lDPK+JqQ4NyzbLlb/mWtBrYZk1m9rKBrj6y
 SCoRuJxup/Pk7sX+alzrRkfhvVNsLlGNgW/X0Wm0pSwMlCAkZ0dq9mBEaV3eXRrj
 w6grQ5ArhqGQQdtoa/TUtRfKFWkbc6UvvoCtg00SWsS8l6sXjZ/Bkkduiuh54xW1
 yn9/fChRkIRXwkMBUND0n9aswTbchwOEs5qas9MgXbEgHEnh8RYtH5P9FIbkLSHH
 kcyCjufyS/2F7jPhRDIzau4KJkdFvf2bbHDbnUc8QDOQmKdH4msQQwGK24+biMtM
 /7ZJOZHT3AgBVWHA4wMFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1778364280; x=1778450680; bh=P
 ApFKN/EM/1VqqJ0s7RfjM6nlLnmW/GNEZXlVqsUtNY=; b=UH1hfL/inO9WIUAzh
 DV67YgLGoBQfituUs/oF0OTbkJNETPGEKlj91bQ9Hkkt+8r4+y9UrFoRSVxlOYqp
 CfgALZNjeNb0usa7OeMR5fAkGLtKvTZ6t8/Ius22jct8Qz8USkzEHcdXTD1tv6AO
 uc6oYVJqDPzIW4zcKbgNIGypwL9QKP6TJ1RXe6PtKnjudl7Nq3jx85PEo7E2Ws3N
 1iFRF/daVuWQPfLoPBDoPRO/mcaEKddXwNQ+shont9dD2nUNSQwuyZGa6ojazPbH
 pTZs15A4djKGSzEkQIRYC9EWnD9KCFmeJ+PbA/RrsM1GhzBLrUxv0fh05XehkfVz
 168PA==
X-ME-Sender: <xms:d6__aWzs26p3qE6SGFK7MaHzYq2iC8QceOlc1Zoy9nR9Epji2fZRPQ>
 <xme:d6__aeSvVNJ6SYqr85239SbhQ6zDOoQw62IIDbGDc1Yd7M5q4LkhAH0IfbVh6lMcE
 8uRLmtj2QhA0KGo5bqS4YK11arjDFLszSgJfz66gbfFCvQl5-ZlYbc>
X-ME-Received: <xmr:d6__aagMCQUoWZvpatXm2-9NivZAG5i5Sl3OrNDsURFLXBcDuB10IUnueLIJ9iuWIU3IJFHxemiKF2TPc2wkWbRP3bpNHb0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduudegfeekucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpedvjefhudeghedvtdeijeeigeetuedugfejueekieeltdfhteevkeeh
 hfeilefhtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeelpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtph
 htthhopehsthgvphhhvghnsehnvghtfihorhhkphhluhhmsggvrhdrohhrghdprhgtphht
 thhopehsthgrsghlvgesughpughkrdhorhhgpdhrtghpthhtohepughsohhsnhhofihskh
 hisehnvhhiughirgdrtghomhdprhgtphhtthhopehvihgrtghhvghslhgrvhhosehnvhhi
 ughirgdrtghomhdprhgtphhtthhopegsihhnghiisehnvhhiughirgdrtghomhdprhgtph
 htthhopehorhhikhgrsehnvhhiughirgdrtghomhdprhgtphhtthhopehsuhgrnhhmihhn
 ghhmsehnvhhiughirgdrtghomhdprhgtphhtthhopehmrghtrghnsehnvhhiughirgdrtg
 homh
X-ME-Proxy: <xmx:d6__adkzzdM4SpBgmlXhYSN-NVgnkNMgVWEYfbcxahi-yqJPFJ9uQA>
 <xmx:d6__aVveHQw-pf78P367gURg2lBHoy8j3ZIwH2P9SE9pb5yUs-kvgQ>
 <xmx:d6__aTYk7vEbu8qJHzc3RfOkuUr78UXodIEzi_JD1kOrLRU6GIxB6A>
 <xmx:d6__adAeNq7kTP2a9qB1H-tY_gccN_v5DlHD_ZlyIUbNVOoPE29hqg>
 <xmx:eK__aeozQ0m837IS6US3y0VmcXirSQS1RvtLDKtg9c2m0Monutimcu2F>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 9 May 2026 18:04:38 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
Subject: [PATCH v2 05/10] net/mlx5: fix Rx split segment counter type
Date: Sat,  9 May 2026 23:56:56 +0200
Message-ID: <20260509220356.3679114-6-thomas@monjalon.net>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260509220356.3679114-1-thomas@monjalon.net>
References: <20260202160903.254621-1-getelson@nvidia.com>
 <20260509220356.3679114-1-thomas@monjalon.net>
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

