Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FF47CC6B27
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Oct 2026 15:58:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 36D5440DD0;
	Wed, 14 Oct 2026 17:58:26 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 6990840DCE
 for <dev@dpdk.org>; Wed, 14 Oct 2026 17:58:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791993502;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HQAp/fbTD1OUkszn5miLDIyV2lg8ON0gndjyH7qb9KI=;
 b=Y8ksssNzCG0fa40GCYOfZ5PGViNlOLiCYpHR6Jf7SNfRAlA5n678OIu2pcZ8mkHE2WvSek
 jWKhnwyhZ2l2xOq1jYcs/0dcLCb+DLI0uk6ipKhr43fCBvKjBYHIWGCn+m4k7Zl7U8tqKQ
 amCLVQJ2jfvENN17QsHq/6DXYbK/uzY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-675-sFl-CEGIPkGar0MQPvIDVQ-1; Wed,
 14 Oct 2026 15:58:19 +0000
X-MC-Unique: sFl-CEGIPkGar0MQPvIDVQ-1
X-Mimecast-MFC-AGG-ID: sFl-CEGIPkGar0MQPvIDVQ_1791993498
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 55CB01800666; Wed, 14 Oct 2026 15:58:18 +0000 (UTC)
Received: from dmarchan.redhat.corp
 (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2B5AC195608E; Wed, 14 Oct 2026 15:58:16 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: maxime.coquelin@redhat.com,
	dev@dpdk.org
Cc: bruce.richardson@intel.com,
	Chenbo Xia <chenbox@nvidia.com>
Subject: [PATCH v4 5/6] vhost: rename packed layout helpers for batches
Date: Wed, 14 Oct 2026 17:57:49 +0200
Message-ID: <20261014155750.1269862-6-david.marchand@redhat.com>
In-Reply-To: <20261014155750.1269862-1-david.marchand@redhat.com>
References: <20260723153111.3943368-1-david.marchand@redhat.com>
 <20261014155750.1269862-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _8YKU_3IxAMXlZtWL1x1NGnmGAJxjXZJdyBMzngSEuU_1791993498
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

Now that the async datapath has been removed, the _sync in function names
gives no useful information.

Besides, vhost_reserve_avail_batch_packed does not reserve anything and
its name is confusing, rename it following the other rx/tx split/packed
helpers convention.

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
Changes since v2:
- cleaned up indent,

---
 lib/vhost/virtio_net.c | 28 +++++++++-------------------
 1 file changed, 9 insertions(+), 19 deletions(-)

diff --git a/lib/vhost/virtio_net.c b/lib/vhost/virtio_net.c
index 10bb924a91..6d8d788524 100644
--- a/lib/vhost/virtio_net.c
+++ b/lib/vhost/virtio_net.c
@@ -1118,11 +1118,8 @@ virtio_dev_rx_split(struct virtio_net *dev, struct vhost_virtqueue *vq,
 }
 
 static __rte_always_inline int
-virtio_dev_rx_sync_batch_check(struct virtio_net *dev,
-			   struct vhost_virtqueue *vq,
-			   struct rte_mbuf **pkts,
-			   uint64_t *desc_addrs,
-			   uint64_t *lens)
+virtio_dev_rx_batch_check(struct virtio_net *dev, struct vhost_virtqueue *vq,
+		struct rte_mbuf **pkts, uint64_t *desc_addrs, uint64_t *lens)
 	__rte_requires_shared_capability(&vq->iotlb_lock)
 {
 	bool wrap_counter = vq->avail_wrap_counter;
@@ -1220,15 +1217,14 @@ virtio_dev_rx_batch_packed_copy(struct virtio_net *dev,
 }
 
 static __rte_always_inline int
-virtio_dev_rx_sync_batch_packed(struct virtio_net *dev,
-			   struct vhost_virtqueue *vq,
-			   struct rte_mbuf **pkts)
+virtio_dev_rx_batch_packed(struct virtio_net *dev, struct vhost_virtqueue *vq,
+		struct rte_mbuf **pkts)
 	__rte_requires_shared_capability(&vq->iotlb_lock)
 {
 	uint64_t desc_addrs[PACKED_BATCH_SIZE];
 	uint64_t lens[PACKED_BATCH_SIZE];
 
-	if (virtio_dev_rx_sync_batch_check(dev, vq, pkts, desc_addrs, lens) == -1)
+	if (virtio_dev_rx_batch_check(dev, vq, pkts, desc_addrs, lens) == -1)
 		return -1;
 
 	if (vq->shadow_used_idx) {
@@ -1280,8 +1276,7 @@ virtio_dev_rx_packed(struct virtio_net *dev,
 		rte_prefetch0(&vq->desc_packed[vq->last_avail_idx]);
 
 		if (count - pkt_idx >= PACKED_BATCH_SIZE) {
-			if (!virtio_dev_rx_sync_batch_packed(dev, vq,
-							&pkts[pkt_idx])) {
+			if (!virtio_dev_rx_batch_packed(dev, vq, &pkts[pkt_idx])) {
 				pkt_idx += PACKED_BATCH_SIZE;
 				continue;
 			}
@@ -1978,12 +1973,8 @@ virtio_dev_tx_split_compliant(struct virtio_net *dev,
 }
 
 static __rte_always_inline int
-vhost_reserve_avail_batch_packed(struct virtio_net *dev,
-				 struct vhost_virtqueue *vq,
-				 struct rte_mbuf **pkts,
-				 uint16_t avail_idx,
-				 uintptr_t *desc_addrs,
-				 uint16_t *ids)
+virtio_dev_tx_batch_packed_check(struct virtio_net *dev, struct vhost_virtqueue *vq,
+		struct rte_mbuf **pkts, uint16_t avail_idx, uintptr_t *desc_addrs, uint16_t *ids)
 	__rte_requires_shared_capability(&vq->iotlb_lock)
 {
 	bool wrap = vq->avail_wrap_counter;
@@ -2062,8 +2053,7 @@ virtio_dev_tx_batch_packed(struct virtio_net *dev,
 	uint16_t ids[PACKED_BATCH_SIZE];
 	uint16_t i;
 
-	if (vhost_reserve_avail_batch_packed(dev, vq, pkts, avail_idx,
-					     desc_addrs, ids))
+	if (virtio_dev_tx_batch_packed_check(dev, vq, pkts, avail_idx, desc_addrs, ids))
 		return -1;
 
 	vhost_for_each_try_unroll(i, 0, PACKED_BATCH_SIZE)
-- 
2.54.0

