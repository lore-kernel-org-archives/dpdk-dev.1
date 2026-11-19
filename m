Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BBAA606A320
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Nov 2026 10:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=peresvet.it header.i=@peresvet.it header.a=rsa-sha256 header.s=mail header.b=nqMAWaI9
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CE7A14060F;
	Fri, 20 Nov 2026 11:13:19 +0100 (CET)
Received: from forward102d.mail.yandex.net (forward102d.mail.yandex.net
 [51.250.60.162])
 by mails.dpdk.org (Postfix) with ESMTPS id 4B3DA400D7;
 Thu, 19 Nov 2026 21:36:09 +0100 (CET)
Received: from mail-nwsmtp-smtp-production-main-83
 (mail-nwsmtp-smtp-production-main-83.yp-c.yandex.net)
 by forward102d.mail.yandex.net (postfix) with ESMTPS id AEB24C0014;
 Thu, 19 Nov 2026 23:36:06 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-83 with ESMTPSA id
 VZikR9DdXiE0-z5WwhCjw; Thu, 19 Nov 2026 23:36:05 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=peresvet.it; s=mail;
 t=1795120566; bh=yvoo2wHXPpgRQTvqa+C5ZW+wL3dZvsYl792JHGFS/4k=;
 h=Message-ID:Date:Cc:Subject:To:From;
 b=nqMAWaI9l8Mi+lFJ/UPAnAh2cF4PxUVJRxh4oqU5g3eh1bQJ0SOcU2lt7uYT/pEUc
 DJdLqKKPi+cYFcwpGD1yDfOyqmMD6+y931FXihWTY6B+yIfba7bl3qqhvFNEs/jgoz
 E7/NsqVo9RxgVgm1unRx9zmphS8UfEXpLmswQmzY=
Authentication-Results: mail-nwsmtp-smtp-production-main-83;
 dkim=pass header.i=@peresvet.it
From: Daniil Bobryshev <daniil@peresvet.it>
To: dev@dpdk.org
Cc: dsosnowski@nvidia.com, viacheslavo@nvidia.com, bingz@nvidia.com,
 orika@nvidia.com, suanmingm@nvidia.com, matan@nvidia.com,
 Daniil Bobryshev <daniil@peresvet.it>, stable@dpdk.org
Subject: [PATCH] net/mlx5: fix Rx queue count with enhanced CQE compression
Date: Thu, 19 Nov 2026 23:34:48 +0300
Message-ID: <20261119203447.41203-2-daniil@peresvet.it>
X-Mailer: git-send-email 2.54.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 20 Nov 2026 11:13:15 +0100
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

With the enhanced CQE compression layout (bit 7 of the rxq_cqe_comp_en
devarg) the Rx burst checks CQE ownership with the validity iteration
count and takes the number of packets of a compressed session from
op_own (MLX5_CQE_NUM_MINIS() + 1). rx_queue_count() was not updated:
it still checks the owner bit and reads the session size from byte_cnt
of the title CQE, as in the basic layout.

In the enhanced layout byte_cnt of a compressed CQE holds mini-CQE data
(a packet length), so the walk moves the consumer index by an arbitrary
amount, and since consumed CQEs are not invalidated in this layout the
owner bit check keeps accepting stale entries. rte_eth_rx_queue_count()
and rte_eth_rx_descriptor_status() return wrong values, and datapath
threads that poll the queue depth were observed stuck inside
rx_queue_count() on ConnectX-6 Dx.

When the enhanced layout is enabled, check the CQE with
check_cqe_iteration() and count MLX5_CQE_NUM_MINIS() + 1 packets per
compressed CQE, the same way the Rx burst does.

Fixes: 02a6195cbeaa ("net/mlx5: support enhanced CQE compression in Rx burst")
Cc: stable@dpdk.org

Signed-off-by: Daniil Bobryshev <daniil@peresvet.it>
---
 .mailmap                   | 1 +
 drivers/net/mlx5/mlx5_rx.c | 8 ++++++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/.mailmap b/.mailmap
index a0096fb97..f7d683ee6 100644
--- a/.mailmap
+++ b/.mailmap
@@ -348,6 +348,7 @@ Daniel Shelepov <dashel@microsoft.com>
 Daniel Verkamp <daniel.verkamp@intel.com>
 Daniele Di Proietto <ddiproietto@vmware.com>
 Daniil Agalakov <ade@amicon.ru>
+Daniil Bobryshev <daniil@peresvet.it>
 Daniil Iskhakov <dish@amicon.ru>
 Daniil Ushkov <daniil.ushkov@yandex.ru>
 Danny Patel <dannyp@marvell.com>
diff --git a/drivers/net/mlx5/mlx5_rx.c b/drivers/net/mlx5/mlx5_rx.c
index c0ad8d670..f55b96aeb 100644
--- a/drivers/net/mlx5/mlx5_rx.c
+++ b/drivers/net/mlx5/mlx5_rx.c
@@ -94,13 +94,17 @@ rx_queue_count(struct mlx5_rxq_data *rxq)
 		cq_ci = rxq->cq_ci;
 	}
 	cqe = &(*rxq->cqes)[cq_ci & cqe_cnt];
-	while (check_cqe(cqe, cqe_n, cq_ci) != MLX5_CQE_STATUS_HW_OWN) {
+	while ((rxq->cqe_comp_layout ?
+		check_cqe_iteration(cqe, rxq->cqe_n, cq_ci) :
+		check_cqe(cqe, cqe_n, cq_ci)) != MLX5_CQE_STATUS_HW_OWN) {
 		int8_t op_own;
 		unsigned int n;
 
 		op_own = cqe->op_own;
 		if (MLX5_CQE_FORMAT(op_own) == MLX5_COMPRESSED)
-			n = rte_be_to_cpu_32(cqe->byte_cnt);
+			n = rxq->cqe_comp_layout ?
+			    MLX5_CQE_NUM_MINIS(op_own) + 1U :
+			    rte_be_to_cpu_32(cqe->byte_cnt);
 		else
 			n = 1;
 		cq_ci += n;
-- 
2.56.0

