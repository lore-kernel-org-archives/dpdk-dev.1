Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88BB8CA5FC4
	for <dpdk-dev@archiver.kernel.org>; Fri,  2 Oct 2026 07:45:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C6D2840608;
	Fri,  2 Oct 2026 09:45:17 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 009FD40144
 for <dev@dpdk.org>; Fri,  2 Oct 2026 09:45:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790927115;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AosN/tUwcZW1qNlRxwuPWLfY1Yr1nQqpX4Oebje6QVM=;
 b=jT+2Yi15tmB1V4y+nWLzhB90f0C+GbRPN1UFijotRmhWZG2V476JlEo+slrQDhx0T+sv7H
 PbZPnwuqmsS4F1/3U6wqU7SdIS7I5iHrBcxKR048NBEozs9VzcIaxRsA39Oe0Rv/yPGolU
 3NlMG49xT2CX4P+Q9Vtrhd1PTERbiiw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-677-ME3qwwIiONW8GCgznImXIw-1; Fri,
 02 Oct 2026 03:45:12 -0400
X-MC-Unique: ME3qwwIiONW8GCgznImXIw-1
X-Mimecast-MFC-AGG-ID: ME3qwwIiONW8GCgznImXIw_1790927111
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 52D011955DE1; Fri,  2 Oct 2026 07:45:11 +0000 (UTC)
Received: from dmarchan.redhat.corp
 (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E80591800348; Fri,  2 Oct 2026 07:45:09 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: maxime.coquelin@redhat.com,
	dev@dpdk.org
Cc: bruce.richardson@intel.com,
	Chenbo Xia <chenbox@nvidia.com>
Subject: [PATCH v3 6/6] vhost: simplify some descriptor handling
Date: Fri,  2 Oct 2026 09:44:40 +0200
Message-ID: <20261002074440.2551536-7-david.marchand@redhat.com>
In-Reply-To: <20261002074440.2551536-1-david.marchand@redhat.com>
References: <20260723153111.3943368-1-david.marchand@redhat.com>
 <20261002074440.2551536-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 4i9Fz5mkSBa_3Innm72MST2CI-yXJNbe9HbmCnXbNKU_1790927111
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

Now that the async datapath has been removed, move back the descriptors
copy/filling code in desc_to_mbuf/mbuf_to_desc and eliminate an
intermediate helper.

Tracking buf_iova is not needed in the descriptor to mbuf case.

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
Changes since v2:
- used RTE_PTR_ADD for consistency,

---
 lib/vhost/virtio_net.c | 80 ++++++++++++++++--------------------------
 1 file changed, 31 insertions(+), 49 deletions(-)

diff --git a/lib/vhost/virtio_net.c b/lib/vhost/virtio_net.c
index 3c9b4afb06..1acaa81a1f 100644
--- a/lib/vhost/virtio_net.c
+++ b/lib/vhost/virtio_net.c
@@ -76,6 +76,12 @@ vhost_queue_stats_update(const struct virtio_net *dev, struct vhost_virtqueue *v
 	}
 }
 
+static __rte_always_inline bool
+vhost_can_batch_copy(struct vhost_virtqueue *vq, uint32_t cpy_len)
+{
+	return cpy_len <= MAX_BATCH_LEN && vq->batch_copy_nb_elems < vq->size;
+}
+
 static inline void
 do_data_copy_enqueue(struct virtio_net *dev, struct vhost_virtqueue *vq)
 	__rte_requires_shared_capability(&vq->iotlb_lock)
@@ -843,44 +849,6 @@ copy_vnet_hdr_to_desc(struct virtio_net *dev, struct vhost_virtqueue *vq,
 	}
 }
 
-static __rte_always_inline void
-sync_fill_seg(struct virtio_net *dev, struct vhost_virtqueue *vq,
-		struct rte_mbuf *m, uint32_t mbuf_offset,
-		uint64_t buf_addr, uint64_t buf_iova, uint32_t cpy_len, bool to_desc)
-	__rte_requires_shared_capability(&vq->iotlb_lock)
-{
-	struct batch_copy_elem *batch_copy = vq->batch_copy_elems;
-
-	if (likely(cpy_len > MAX_BATCH_LEN || vq->batch_copy_nb_elems >= vq->size)) {
-		if (to_desc) {
-			rte_memcpy((void *)((uintptr_t)(buf_addr)),
-				rte_pktmbuf_mtod_offset(m, void *, mbuf_offset),
-				cpy_len);
-			vhost_log_cache_write_iova(dev, vq, buf_iova, cpy_len);
-			PRINT_PACKET(dev, (uintptr_t)(buf_addr), cpy_len, 0);
-		} else {
-			rte_memcpy(rte_pktmbuf_mtod_offset(m, void *, mbuf_offset),
-				(void *)((uintptr_t)(buf_addr)),
-				cpy_len);
-		}
-	} else {
-		if (to_desc) {
-			batch_copy[vq->batch_copy_nb_elems].dst =
-				(void *)((uintptr_t)(buf_addr));
-			batch_copy[vq->batch_copy_nb_elems].src =
-				rte_pktmbuf_mtod_offset(m, void *, mbuf_offset);
-			batch_copy[vq->batch_copy_nb_elems].log_addr = buf_iova;
-		} else {
-			batch_copy[vq->batch_copy_nb_elems].dst =
-				rte_pktmbuf_mtod_offset(m, void *, mbuf_offset);
-			batch_copy[vq->batch_copy_nb_elems].src =
-				(void *)((uintptr_t)(buf_addr));
-		}
-		batch_copy[vq->batch_copy_nb_elems].len = cpy_len;
-		vq->batch_copy_nb_elems++;
-	}
-}
-
 static __rte_always_inline int
 mbuf_to_desc(struct virtio_net *dev, struct vhost_virtqueue *vq,
 		struct rte_mbuf *m, struct buf_vector *buf_vec,
@@ -976,9 +944,22 @@ mbuf_to_desc(struct virtio_net *dev, struct vhost_virtqueue *vq,
 
 		cpy_len = RTE_MIN(buf_avail, mbuf_avail);
 
-		sync_fill_seg(dev, vq, m, mbuf_offset,
-			      buf_addr + buf_offset,
-			      buf_iova + buf_offset, cpy_len, true);
+		if (likely(!vhost_can_batch_copy(vq, cpy_len))) {
+			rte_memcpy(RTE_PTR_ADD(buf_addr, buf_offset),
+				rte_pktmbuf_mtod_offset(m, void *, mbuf_offset),
+				cpy_len);
+			vhost_log_cache_write_iova(dev, vq, buf_iova + buf_offset, cpy_len);
+			PRINT_PACKET(dev, RTE_PTR_ADD(buf_addr, buf_offset), cpy_len, 0);
+		} else {
+			vq->batch_copy_elems[vq->batch_copy_nb_elems].dst =
+				RTE_PTR_ADD(buf_addr, buf_offset);
+			vq->batch_copy_elems[vq->batch_copy_nb_elems].src =
+				rte_pktmbuf_mtod_offset(m, void *, mbuf_offset);
+			vq->batch_copy_elems[vq->batch_copy_nb_elems].log_addr =
+				buf_iova + buf_offset;
+			vq->batch_copy_elems[vq->batch_copy_nb_elems].len = cpy_len;
+			vq->batch_copy_nb_elems++;
+		}
 
 		mbuf_avail  -= cpy_len;
 		mbuf_offset += cpy_len;
@@ -1675,7 +1656,7 @@ desc_to_mbuf(struct virtio_net *dev, struct vhost_virtqueue *vq,
 	__rte_requires_shared_capability(&vq->iotlb_lock)
 {
 	uint32_t buf_avail, buf_offset, buf_len;
-	uint64_t buf_addr, buf_iova;
+	uint64_t buf_addr;
 	uint32_t mbuf_avail, mbuf_offset;
 	uint32_t hdr_remain = dev->vhost_hlen;
 	uint32_t cpy_len;
@@ -1706,7 +1687,6 @@ desc_to_mbuf(struct virtio_net *dev, struct vhost_virtqueue *vq,
 	}
 
 	buf_addr = buf_vec[vec_idx].buf_addr;
-	buf_iova = buf_vec[vec_idx].buf_iova;
 	buf_len = buf_vec[vec_idx].buf_len;
 	buf_offset = hdr_remain;
 	buf_avail = buf_vec[vec_idx].buf_len - hdr_remain;
@@ -1721,14 +1701,17 @@ desc_to_mbuf(struct virtio_net *dev, struct vhost_virtqueue *vq,
 	while (1) {
 		cpy_len = RTE_MIN(buf_avail, mbuf_avail);
 
-		if (likely(hdr && cur == m)) {
+		if (likely((hdr && cur == m) || !vhost_can_batch_copy(vq, cpy_len))) {
 			rte_memcpy(rte_pktmbuf_mtod_offset(cur, void *, mbuf_offset),
-				(void *)((uintptr_t)(buf_addr + buf_offset)),
+				RTE_PTR_ADD(buf_addr, buf_offset),
 				cpy_len);
 		} else {
-			sync_fill_seg(dev, vq, cur, mbuf_offset,
-				      buf_addr + buf_offset,
-				      buf_iova + buf_offset, cpy_len, false);
+			vq->batch_copy_elems[vq->batch_copy_nb_elems].dst =
+				rte_pktmbuf_mtod_offset(cur, void *, mbuf_offset);
+			vq->batch_copy_elems[vq->batch_copy_nb_elems].src =
+				RTE_PTR_ADD(buf_addr, buf_offset);
+			vq->batch_copy_elems[vq->batch_copy_nb_elems].len = cpy_len;
+			vq->batch_copy_nb_elems++;
 		}
 
 		mbuf_avail  -= cpy_len;
@@ -1742,7 +1725,6 @@ desc_to_mbuf(struct virtio_net *dev, struct vhost_virtqueue *vq,
 				break;
 
 			buf_addr = buf_vec[vec_idx].buf_addr;
-			buf_iova = buf_vec[vec_idx].buf_iova;
 			buf_len = buf_vec[vec_idx].buf_len;
 
 			buf_offset = 0;
-- 
2.54.0

