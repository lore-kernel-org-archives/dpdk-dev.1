Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AD45FD88CF
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Mar 2026 23:29:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C694440E30;
	Wed, 11 Mar 2026 00:29:40 +0100 (CET)
Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
 by mails.dpdk.org (Postfix) with ESMTP id 1597D40E30
 for <dev@dpdk.org>; Wed, 11 Mar 2026 00:29:40 +0100 (CET)
Received: from localhost.localdomain (unknown [82.65.104.223])
 (Authenticated sender: vjardin@free.fr)
 by smtp6-g21.free.fr (Postfix) with ESMTPSA id 1D80378035B;
 Wed, 11 Mar 2026 00:29:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1773185380;
 bh=vfy+zuoAvg6UEpsoFkvzXwMN5m9f72+F8v7zNyQW8YU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ih1LN+O8mFDADIJRilk3sJ3JCIXxIBTuFuDcCkFFLDhXLWCMf5x2MRWvp4ajKvACN
 graaP78g/8ZObQD08c/5yBSLwJqBndgAJDW80eBXKfQSgOD0P+tZbdHBzxZP7cjiGq
 OwtBt4I+F0HOU+j4QtO2bzRbumUtjZTNgFGL1gyDod3C9ZmHwYAcX0cx1RfBrJAi/+
 hPw/y7Z31GogDbfWPvZnvLO09Ra/mrp7puNC0tJB/eFmlXdzZ/A2KhskdwUcbVXSVo
 nwuSUHhbsJrcsGpiSwBs7YuZArXySe0fJ9nf4YUu/LxQSxgXMGyqI/Y2aL5Q2hn0tv
 yfHveU4dZRZow==
From: Vincent Jardin <vjardin@free.fr>
To: dev@dpdk.org
Cc: rasland@nvidia.com, thomas@monjalon.net, andrew.rybchenko@oktetlabs.ru,
 dsosnowski@nvidia.com, viacheslavo@nvidia.com, bingz@nvidia.com,
 orika@nvidia.com, suanmingm@nvidia.com, matan@nvidia.com,
 stephen@networkplumber.org, Vincent Jardin <vjardin@free.fr>
Subject: [PATCH v2 09/10] net/mlx5: share pacing rate table entries across
 queues
Date: Wed, 11 Mar 2026 00:26:52 +0100
Message-ID: <20260310232653.2935764-10-vjardin@free.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260310232653.2935764-1-vjardin@free.fr>
References: <20260310092014.2762894-1-vjardin@free.fr>
 <20260310232653.2935764-1-vjardin@free.fr>
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

Allocating PP contexts with MLX5DV_PP_ALLOC_FLAGS_DEDICATED_INDEX
forces one HW rate table entry per TX queue. On ConnectX-6 Dx the
rate table is small (typically 128 entries), so setting the same rate
on many queues exhausts it quickly and returns ENOSPC.

Without the dedicated flag, the kernel mlx5 driver shares a single
rate table entry across all PP contexts with identical parameters
(rate, burst, packet size) using internal refcounting. Each queue
still gets its own PP handle for proper cleanup, but the underlying
HW index is shared.

Signed-off-by: Vincent Jardin <vjardin@free.fr>
---
 drivers/net/mlx5/mlx5_txpp.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/mlx5/mlx5_txpp.c b/drivers/net/mlx5/mlx5_txpp.c
index b87565778e..a377406e66 100644
--- a/drivers/net/mlx5/mlx5_txpp.c
+++ b/drivers/net/mlx5/mlx5_txpp.c
@@ -185,8 +185,7 @@ mlx5_txq_alloc_pp_rate_limit(struct mlx5_dev_ctx_shared *sh,
 		MLX5_SET(set_pp_rate_limit_context, &pp,
 			 typical_packet_size, sh->config.tx_typical_pkt_sz);
 	rl->pp = mlx5_glue->dv_alloc_pp
-				(sh->cdev->ctx, sizeof(pp), &pp,
-				 MLX5DV_PP_ALLOC_FLAGS_DEDICATED_INDEX);
+				(sh->cdev->ctx, sizeof(pp), &pp, 0);
 	if (rl->pp == NULL) {
 		DRV_LOG(ERR, "Failed to allocate PP index for rate %u Mbps.",
 			rate_mbps);
-- 
2.43.0

