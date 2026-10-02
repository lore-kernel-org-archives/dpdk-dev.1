Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05079CA5FC4
	for <dpdk-dev@archiver.kernel.org>; Fri,  2 Oct 2026 07:45:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9EBE242D7D;
	Fri,  2 Oct 2026 09:45:11 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 5230A40144
 for <dev@dpdk.org>; Fri,  2 Oct 2026 09:45:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790927109;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LZzbKPc6vistF9tHCGmlZURi5cHf0HPfUpPHEe63Y74=;
 b=A7PnBiF71m8ZurX5+O9dcVPFPHxEzvy72U4RMhATFUdNPEsp7rX9I6nP3epwcazEpYfRRY
 Fn10oBXhWr3w/fGxvx8Z7NdD1DzaSswsw5H4FgyJwD3XU0o2qZFxqza67DoIsQnr5prsC7
 NBgWS60BzPVHGN5036F+sOUXB3FeevI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-64-aFKuoRdiNESmUmQWhS_L2Q-1; Fri,
 02 Oct 2026 03:45:08 -0400
X-MC-Unique: aFKuoRdiNESmUmQWhS_L2Q-1
X-Mimecast-MFC-AGG-ID: aFKuoRdiNESmUmQWhS_L2Q_1790927107
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8FA941953944; Fri,  2 Oct 2026 07:45:07 +0000 (UTC)
Received: from dmarchan.redhat.corp
 (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 41DCD1800348; Fri,  2 Oct 2026 07:45:05 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: maxime.coquelin@redhat.com,
	dev@dpdk.org
Cc: bruce.richardson@intel.com,
	Chenbo Xia <chenbox@nvidia.com>
Subject: [PATCH v3 5/6] vhost: rename packed layout helpers for batches
Date: Fri,  2 Oct 2026 09:44:39 +0200
Message-ID: <20261002074440.2551536-6-david.marchand@redhat.com>
In-Reply-To: <20261002074440.2551536-1-david.marchand@redhat.com>
References: <20260723153111.3943368-1-david.marchand@redhat.com>
 <20261002074440.2551536-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: JVcBUg990RbM4r3ayOyr4l9zZTDCmKu8hPKqgMtQp78_1790927107
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
index 9ad7fa3295..3c9b4afb06 100644
--- a/lib/vhost/virtio_net.c
+++ b/lib/vhost/virtio_net.c
@@ -1111,11 +1111,8 @@ virtio_dev_rx_split(struct virtio_net *dev, struct vhost_virtqueue *vq,
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
@@ -1213,15 +1210,14 @@ virtio_dev_rx_batch_packed_copy(struct virtio_net *dev,
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
@@ -1273,8 +1269,7 @@ virtio_dev_rx_packed(struct virtio_net *dev,
 		rte_prefetch0(&vq->desc_packed[vq->last_avail_idx]);
 
 		if (count - pkt_idx >= PACKED_BATCH_SIZE) {
-			if (!virtio_dev_rx_sync_batch_packed(dev, vq,
-							&pkts[pkt_idx])) {
+			if (!virtio_dev_rx_batch_packed(dev, vq, &pkts[pkt_idx])) {
 				pkt_idx += PACKED_BATCH_SIZE;
 				continue;
 			}
@@ -1971,12 +1966,8 @@ virtio_dev_tx_split_compliant(struct virtio_net *dev,
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
@@ -2055,8 +2046,7 @@ virtio_dev_tx_batch_packed(struct virtio_net *dev,
 	uint16_t ids[PACKED_BATCH_SIZE];
 	uint16_t i;
 
-	if (vhost_reserve_avail_batch_packed(dev, vq, pkts, avail_idx,
-					     desc_addrs, ids))
+	if (virtio_dev_tx_batch_packed_check(dev, vq, pkts, avail_idx, desc_addrs, ids))
 		return -1;
 
 	vhost_for_each_try_unroll(i, 0, PACKED_BATCH_SIZE)
-- 
2.54.0

