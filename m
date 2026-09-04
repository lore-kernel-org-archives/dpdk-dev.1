Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 767CFC624DE
	for <dpdk-dev@archiver.kernel.org>; Fri,  4 Sep 2026 07:47:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0CA174279D;
	Fri,  4 Sep 2026 09:47:18 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 9F1E440297
 for <dev@dpdk.org>; Fri,  4 Sep 2026 09:47:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788508036;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b3JtLAECQOQqhdzAOpM8P9JAvVgaR/tFcWPnNZkxsh4=;
 b=iztodavDsC6XVcNQJrQa4Ybfa2Vw6Xw6BtQnsiuwg+60cRJFbGIPfgEvrud4NN4iLXX1wm
 Gcx61Dmj+Z5N0FK2icBN+21uYaMix5QhEGDmPCJrOO/MI/vEmOW4ZjvvTK8mR0GFUdbZvr
 xnxu93GsQVqDDocgPd59qi04zhlJ7K0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-30-DYvtp7-AMGGxcaciBWC0AA-1; Fri,
 04 Sep 2026 03:47:14 -0400
X-MC-Unique: DYvtp7-AMGGxcaciBWC0AA-1
X-Mimecast-MFC-AGG-ID: DYvtp7-AMGGxcaciBWC0AA_1788508033
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9022618D62FD; Fri,  4 Sep 2026 07:47:13 +0000 (UTC)
Received: from dmarchan.home (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3310230001A2; Fri,  4 Sep 2026 07:47:11 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: maxime.coquelin@redhat.com,
	dev@dpdk.org
Cc: bruce.richardson@intel.com,
	Chenbo Xia <chenbox@nvidia.com>
Subject: [PATCH v2 5/6] vhost: rename packed layout helpers for batches
Date: Fri,  4 Sep 2026 09:46:47 +0200
Message-ID: <20260904074649.1979166-6-david.marchand@redhat.com>
In-Reply-To: <20260904074649.1979166-1-david.marchand@redhat.com>
References: <20260723153111.3943368-1-david.marchand@redhat.com>
 <20260904074649.1979166-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: I2IR14J4GEYtQtiBvZnkqrhGsC5JKFzSj8eKo2Bosxc_1788508033
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
 lib/vhost/virtio_net.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/lib/vhost/virtio_net.c b/lib/vhost/virtio_net.c
index 9ad7fa3295..79034ae036 100644
--- a/lib/vhost/virtio_net.c
+++ b/lib/vhost/virtio_net.c
@@ -1111,7 +1111,7 @@ virtio_dev_rx_split(struct virtio_net *dev, struct vhost_virtqueue *vq,
 }
 
 static __rte_always_inline int
-virtio_dev_rx_sync_batch_check(struct virtio_net *dev,
+virtio_dev_rx_batch_check(struct virtio_net *dev,
 			   struct vhost_virtqueue *vq,
 			   struct rte_mbuf **pkts,
 			   uint64_t *desc_addrs,
@@ -1213,7 +1213,7 @@ virtio_dev_rx_batch_packed_copy(struct virtio_net *dev,
 }
 
 static __rte_always_inline int
-virtio_dev_rx_sync_batch_packed(struct virtio_net *dev,
+virtio_dev_rx_batch_packed(struct virtio_net *dev,
 			   struct vhost_virtqueue *vq,
 			   struct rte_mbuf **pkts)
 	__rte_requires_shared_capability(&vq->iotlb_lock)
@@ -1221,7 +1221,7 @@ virtio_dev_rx_sync_batch_packed(struct virtio_net *dev,
 	uint64_t desc_addrs[PACKED_BATCH_SIZE];
 	uint64_t lens[PACKED_BATCH_SIZE];
 
-	if (virtio_dev_rx_sync_batch_check(dev, vq, pkts, desc_addrs, lens) == -1)
+	if (virtio_dev_rx_batch_check(dev, vq, pkts, desc_addrs, lens) == -1)
 		return -1;
 
 	if (vq->shadow_used_idx) {
@@ -1273,8 +1273,7 @@ virtio_dev_rx_packed(struct virtio_net *dev,
 		rte_prefetch0(&vq->desc_packed[vq->last_avail_idx]);
 
 		if (count - pkt_idx >= PACKED_BATCH_SIZE) {
-			if (!virtio_dev_rx_sync_batch_packed(dev, vq,
-							&pkts[pkt_idx])) {
+			if (!virtio_dev_rx_batch_packed(dev, vq, &pkts[pkt_idx])) {
 				pkt_idx += PACKED_BATCH_SIZE;
 				continue;
 			}
@@ -1971,7 +1970,7 @@ virtio_dev_tx_split_compliant(struct virtio_net *dev,
 }
 
 static __rte_always_inline int
-vhost_reserve_avail_batch_packed(struct virtio_net *dev,
+virtio_dev_tx_batch_packed_check(struct virtio_net *dev,
 				 struct vhost_virtqueue *vq,
 				 struct rte_mbuf **pkts,
 				 uint16_t avail_idx,
@@ -2055,8 +2054,7 @@ virtio_dev_tx_batch_packed(struct virtio_net *dev,
 	uint16_t ids[PACKED_BATCH_SIZE];
 	uint16_t i;
 
-	if (vhost_reserve_avail_batch_packed(dev, vq, pkts, avail_idx,
-					     desc_addrs, ids))
+	if (virtio_dev_tx_batch_packed_check(dev, vq, pkts, avail_idx, desc_addrs, ids))
 		return -1;
 
 	vhost_for_each_try_unroll(i, 0, PACKED_BATCH_SIZE)
-- 
2.54.0

