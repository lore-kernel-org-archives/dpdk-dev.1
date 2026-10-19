Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6417BCCF2E6
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 Oct 2026 13:58:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7524140611;
	Mon, 19 Oct 2026 15:58:19 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id B074A4028E;
 Mon, 19 Oct 2026 15:58:17 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 5514920678;
 Mon, 19 Oct 2026 15:58:17 +0200 (CEST)
Received: from dkrd4.smartsharesys.local ([192.168.4.26]) by
 smartserver.smartsharesystems.com with Microsoft SMTPSVC(6.0.3790.4675); 
 Mon, 19 Oct 2026 15:58:16 +0200
From: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
To: dev@dpdk.org, Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>
Cc: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>,
 stable@dpdk.org
Subject: [PATCH] vhost: fix checksum offset check in Rx path
Date: Mon, 19 Oct 2026 13:58:14 +0000
Message-ID: <20261019135814.3146545-1-mb@smartsharesystems.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 19 Oct 2026 13:58:16.0296 (UTC)
 FILETIME=[E3A3F680:01DD5FD1]
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

Fixes: ca7036b4af3a ("vhost: fix offload flags in Rx path")
Cc: stable@dpdk.org

Signed-off-by: Morten Brørup <mb@smartsharesystems.com>
---
 lib/vhost/virtio_net.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/vhost/virtio_net.c b/lib/vhost/virtio_net.c
index 8bdddedccf..eb099d206b 100644
--- a/lib/vhost/virtio_net.c
+++ b/lib/vhost/virtio_net.c
@@ -2848,7 +2848,7 @@ vhost_dequeue_offload(struct virtio_net *dev, struct virtio_net_hdr *hdr,
 			if (likely(csum != 0xffff))
 				csum = ~csum;
 			off = hdr->csum_offset + hdr->csum_start;
-			if (rte_pktmbuf_data_len(m) >= off + 1)
+			if (rte_pktmbuf_data_len(m) >= off + sizeof(uint16_t))
 				*rte_pktmbuf_mtod_offset(m, uint16_t *, off) = csum;
 		}
 	}
-- 
2.43.0

