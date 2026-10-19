Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8FA9CCF2E3
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 Oct 2026 13:56:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0CEC140611;
	Mon, 19 Oct 2026 15:56:50 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 2AE8E40611;
 Mon, 19 Oct 2026 15:56:48 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 10CE620678;
 Mon, 19 Oct 2026 15:56:48 +0200 (CEST)
Received: from dkrd4.smartsharesys.local ([192.168.4.26]) by
 smartserver.smartsharesystems.com with Microsoft SMTPSVC(6.0.3790.4675); 
 Mon, 19 Oct 2026 15:56:44 +0200
From: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
To: dev@dpdk.org, Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>
Cc: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>,
 stable@dpdk.org
Subject: [PATCH] net/virtio: fix checksum offset check in Rx path
Date: Mon, 19 Oct 2026 13:56:43 +0000
Message-ID: <20261019135643.3146303-1-mb@smartsharesystems.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 19 Oct 2026 13:56:44.0986 (UTC)
 FILETIME=[AD3729A0:01DD5FD1]
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

Writing the checksum in the packet needs room for 2 bytes, not 1 byte.

Fixes: 96cb6711939e ("net/virtio: support Rx checksum offload")
Fixes: 0eaf7fc2fe8e ("net/virtio: separate AVX Rx/Tx")
Cc: stable@dpdk.org

Signed-off-by: Morten Brørup <mb@smartsharesystems.com>
---
 drivers/net/virtio/virtio_rxtx.c        | 2 +-
 drivers/net/virtio/virtio_rxtx_packed.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/virtio/virtio_rxtx.c b/drivers/net/virtio/virtio_rxtx.c
index edecd2011f..1afb68bc69 100644
--- a/drivers/net/virtio/virtio_rxtx.c
+++ b/drivers/net/virtio/virtio_rxtx.c
@@ -955,7 +955,7 @@ virtio_rx_offload(struct rte_mbuf *m, struct virtio_net_hdr *hdr)
 			if (likely(csum != 0xffff))
 				csum = ~csum;
 			off = hdr->csum_offset + hdr->csum_start;
-			if (rte_pktmbuf_data_len(m) >= off + 1)
+			if (rte_pktmbuf_data_len(m) >= off + sizeof(uint16_t))
 				*rte_pktmbuf_mtod_offset(m, uint16_t *,
 					off) = csum;
 		}
diff --git a/drivers/net/virtio/virtio_rxtx_packed.h b/drivers/net/virtio/virtio_rxtx_packed.h
index f7cc60bb51..6501ede3f0 100644
--- a/drivers/net/virtio/virtio_rxtx_packed.h
+++ b/drivers/net/virtio/virtio_rxtx_packed.h
@@ -185,7 +185,7 @@ virtio_vec_rx_offload(struct rte_mbuf *m, struct virtio_net_hdr *hdr)
 			if (likely(csum != 0xffff))
 				csum = ~csum;
 			off = hdr->csum_offset + hdr->csum_start;
-			if (rte_pktmbuf_data_len(m) >= off + 1)
+			if (rte_pktmbuf_data_len(m) >= off + sizeof(uint16_t))
 				*rte_pktmbuf_mtod_offset(m, uint16_t *,
 					off) = csum;
 		}
-- 
2.43.0

