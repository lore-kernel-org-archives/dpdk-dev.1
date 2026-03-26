Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BD5F10A3D8E
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Mar 2026 12:46:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 90E004069F;
	Thu, 26 Mar 2026 13:46:30 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id EC9D34026A
 for <dev@dpdk.org>; Thu, 26 Mar 2026 13:46:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774529188;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=nAYKcHRapX0i1xd8R9SxuLEOJlCW42Z8VvdnWILS7WY=;
 b=LiR3s/SGoWV4x6jRzNs8agmhaxWqSXAyoO1uygAF7zANxVdQ4saHEBuvQIU2xQKCqmXqiu
 Ob1SgpUe9ZFr37UdFFmdBNqFRJn8Ph3qvvMZmoxY86CU64K6IXLXvYiwnivtO6EmdnN5eL
 szc7+WaVed5midROdvmCr1RYiYxSNb0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-527-ywfXuRedP4Cx69Z9X3y5Iw-1; Thu,
 26 Mar 2026 08:46:26 -0400
X-MC-Unique: ywfXuRedP4Cx69Z9X3y5Iw-1
X-Mimecast-MFC-AGG-ID: ywfXuRedP4Cx69Z9X3y5Iw_1774529185
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1D2681954B22; Thu, 26 Mar 2026 12:46:24 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.33.173])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 14E0C19560B1; Thu, 26 Mar 2026 12:46:22 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH] net/tap: fix close for partially configured port
Date: Thu, 26 Mar 2026 13:46:11 +0100
Message-ID: <20260326124612.2580985-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 68UMRBKYq7kwVLvLs_aJRHfS81wzFpH1KznHunkC-mw_1774529185
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
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

In case no rxq has been set up (like when starting testpmd with no mempool
drivers), a crash happens in tap_dev_close:

Thread 1 "dpdk-testpmd" received signal SIGSEGV, Segmentation fault.
0x00007ffff7fad68b in tap_dev_close (dev=dev@entry=0x4c4a80
	<rte_eth_devices@INTERNAL>) at ../drivers/net/tap/rte_eth_tap.c:1111
1111			struct rx_queue *rxq = dev->data->rx_queues[i];

(gdb) p dev->data->rx_queues
$4 = (void **) 0x0

Fixes: 23e2387b49a1 ("net/tap: allocate queue structures dynamically")

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 drivers/net/tap/rte_eth_tap.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/tap/rte_eth_tap.c b/drivers/net/tap/rte_eth_tap.c
index 64b359914b..6d710131e8 100644
--- a/drivers/net/tap/rte_eth_tap.c
+++ b/drivers/net/tap/rte_eth_tap.c
@@ -1108,17 +1108,22 @@ tap_dev_close(struct rte_eth_dev *dev)
 #endif
 
 	for (i = 0; i < RTE_PMD_TAP_MAX_QUEUES; i++) {
-		struct rx_queue *rxq = dev->data->rx_queues[i];
+		struct rx_queue *rxq = NULL;
+		struct rx_queue *txq = NULL;
 
 		tap_queue_close(process_private, i);
 
+		if (dev->data->rx_queues != NULL)
+			rxq = dev->data->rx_queues[i];
 		if (rxq != NULL) {
 			tap_rxq_pool_free(rxq->pool);
 			rte_free(rxq);
 			dev->data->rx_queues[i] = NULL;
 		}
 
-		if (dev->data->tx_queues[i] != NULL) {
+		if (dev->data->tx_queues != NULL)
+			txq = dev->data->tx_queues[i];
+		if (txq != NULL) {
 			rte_free(dev->data->tx_queues[i]);
 			dev->data->tx_queues[i] = NULL;
 		}
-- 
2.53.0

