Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C7C606A320
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Nov 2026 11:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=peresvet.it header.i=@peresvet.it header.a=rsa-sha256 header.s=mail header.b=kS8uEP2x
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A20A3402F2;
	Fri, 20 Nov 2026 12:13:34 +0100 (CET)
Received: from forward103d.mail.yandex.net (forward103d.mail.yandex.net
 [51.250.60.163])
 by mails.dpdk.org (Postfix) with ESMTPS id C375D40151;
 Fri, 20 Nov 2026 12:13:32 +0100 (CET)
Received: from mail-nwsmtp-smtp-production-main-53
 (mail-nwsmtp-smtp-production-main-53.yp-c.yandex.net)
 by forward103d.mail.yandex.net (postfix) with ESMTPS id 8CA0DC00B5;
 Fri, 20 Nov 2026 14:13:29 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-53 with ESMTPSA id
 SDagr3JcdKo0-V2D8JUmC; Fri, 20 Nov 2026 14:13:29 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=peresvet.it; s=mail;
 t=1795173209; bh=G3A84yg28N2qhRS39CqRr03fchYl+WnvZmVOOgcBs6Q=;
 h=Subject:Message-ID:Date:Cc:To:From;
 b=kS8uEP2x22uvVmmJo0EKnNXh0KiUCIm1ulwm9ILz72Ow1tMij6LS9SsbV63rK5aQh
 x7OoSpf59rzzHLEg9HB5eKHG5vb81ceF5H7xBOZQP7N9+U88kZM69G6TuA9Q/PRQ8S
 D1o8lR2u0ZQWAbi/YpNvyYaoLBIUxHjyhX/YLQhI=
Authentication-Results: mail-nwsmtp-smtp-production-main-53;
 dkim=pass header.i=@peresvet.it
From: "Daniil Bobryshev (daniil@peresvet.it)" <daniil@peresvet.it>
To: dev@dpdk.org
Cc: stable@dpdk.org, Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Ori Kam <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>,
 Matan Azrad <matan@nvidia.com>
Date: Fri, 20 Nov 2026 14:12:44 +0300
Message-ID: <179517316488.3655.8104203747001839155@peresvet.it>
Subject: [PATCH] net/mlx5: fix MPRQ title packet flags in vector Rx
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Daniil Bobryshev <daniil@peresvet.it>

With the enhanced CQE compression layout the vectorized Multi-Packet
RQ burst keeps a copy of the title packet in rxq->title_pkt, and
rxq_cq_decompress_v() stores its rearm data and offload flags (one
16-byte store) into every packet of the compressed session.

rxq_burst_mprq_v() takes that copy after rxq_copy_mprq_mbuf_v(). By
then mprq_buf_to_pkt() has attached a title packet longer than
mprq_max_memcpy_len to its stride, so the copy carries
RTE_MBUF_F_EXTERNAL (and nb_segs 2 if a headroom overlap was chained).
Every packet of the session inherits the flag. A packet that is
then attached gets a valid shinfo, but a packet that is copied into
its own buffer (short frames, out of MPRQ buffers, filler CQEs) keeps
RTE_MBUF_F_EXTERNAL with the shinfo of a fresh mbuf (NULL) or a stale
one. Freeing it crashes in rte_mbuf_ext_refcnt_update(), or decrements
the reference count of a stride that is still in use.

Seen on ConnectX-6 Dx with rxq_cqe_comp_en=129 and mprq_en=1: 1514-byte
traffic with occasional 60-byte ARP frames between the long ones
segfaults within a second in rte_pktmbuf_free() of a 60-byte mbuf whose
buf_addr is its own data room and whose ol_flags are
0x2000000000000182 with shinfo NULL. 64-byte traffic, which is always
copied, and the basic layout, where the title is taken before the
stride attach, do not hit it.

MPRQ is never enabled for pools with pinned external buffers, so in
this burst RTE_MBUF_F_EXTERNAL can only come from the stride attach.
Clear it and reset nb_segs in the title copy. Moving the copy before
rxq_copy_mprq_mbuf_v() is not simpler: the check that decides whether
to take it reads rxq->cq_ci, which rxq_copy_mprq_mbuf_v() advances.

Fixes: fc3e1798eba2 ("net/mlx5: support enhanced CQE zipping in vector Rx burst")
Cc: stable@dpdk.org

Signed-off-by: Daniil Bobryshev <daniil@peresvet.it>
---
Depends-on: patch-173059 ("net/mlx5: fix Rx queue count with enhanced CQE compression")

 drivers/net/mlx5/mlx5_rxtx_vec.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/net/mlx5/mlx5_rxtx_vec.c b/drivers/net/mlx5/mlx5_rxtx_vec.c
index 228ff2bfc..a2c2db7ca 100644
--- a/drivers/net/mlx5/mlx5_rxtx_vec.c
+++ b/drivers/net/mlx5/mlx5_rxtx_vec.c
@@ -553,9 +553,21 @@ rxq_burst_mprq_v(struct mlx5_rxq_data *rxq, struct rte_mbuf **pkts,
 			next = &(*rxq->cqes)[rxq->cq_ci & q_mask];
 			ret = check_cqe_iteration(next,	rxq->cqe_n, rxq->cq_ci);
 			if (MLX5_CQE_FORMAT(next->op_own) == MLX5_COMPRESSED ||
-			    ret != MLX5_CQE_STATUS_SW_OWN)
+			    ret != MLX5_CQE_STATUS_SW_OWN) {
 				rte_memcpy(&rxq->title_pkt, elts[nocmp_n - 1],
 					   sizeof(struct rte_mbuf));
+				/*
+				 * The title mbuf went through
+				 * rxq_copy_mprq_mbuf_v() above and may be
+				 * attached to its stride or chained. The
+				 * decompressed packets take rearm data and
+				 * flags from this copy, and the ones the PMD
+				 * then copies into their own buffer must not
+				 * be marked external or multi-segment.
+				 */
+				rxq->title_pkt.ol_flags &= ~RTE_MBUF_F_EXTERNAL;
+				rxq->title_pkt.nb_segs = 1;
+			}
 		}
 	}
 decompress:
-- 
2.56.0

