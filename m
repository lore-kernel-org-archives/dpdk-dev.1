Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AF74CC6B1D
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Oct 2026 15:01:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6968D40A6D;
	Wed, 14 Oct 2026 17:01:05 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 81ADE4064A
 for <dev@dpdk.org>; Wed, 14 Oct 2026 17:01:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791990064;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oiE75aF6bNmB0g8wNH8ZzWkWfEvl155+jPGgm0/5Z5w=;
 b=ONNq1j0rG6N7A96/54Klq+ZDh5zP8voY3Pu4p/pgX90lC8UhvZ7zDamBWl+WsjC21qjJsb
 je6oVADfvkc1AP08ZJJYq2kaDplXm/D9HT1QkoON5lPuQZtO9fxq/C6jA0aF9rifdbFjA8
 gG5s+hSH6kVV4m+DU3njNIVirBvAx2c=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-591-kXpm2ESSNEe80PoTPeK50A-1; Wed,
 14 Oct 2026 15:01:02 +0000
X-MC-Unique: kXpm2ESSNEe80PoTPeK50A-1
X-Mimecast-MFC-AGG-ID: kXpm2ESSNEe80PoTPeK50A_1791990061
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B457D1955F0D; Wed, 14 Oct 2026 15:01:01 +0000 (UTC)
Received: from max-p1.redhat.corp (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6FEA31800495; Wed, 14 Oct 2026 15:01:00 +0000 (UTC)
From: Maxime Coquelin <maxime.coquelin@redhat.com>
To: dev@dpdk.org
Cc: Maxime Coquelin <maxime.coquelin@redhat.com>, stable@dpdk.org,
 David Marchand <david.marchand@redhat.com>
Subject: [PATCH 06/14] vhost: fix header copy to multiple descriptors
Date: Wed, 14 Oct 2026 17:00:41 +0200
Message-ID: <20261014150049.2540538-6-maxime.coquelin@redhat.com>
In-Reply-To: <20261014150049.2540538-1-maxime.coquelin@redhat.com>
References: <20261014150049.2540538-1-maxime.coquelin@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ymeSqAnOJfC7U-2oc5Odjc74xPzHfAng1TkT7fFkJMQ_1791990061
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

A guest could race and craft shorter descriptors than what the vhost
library previously evaluated as necessary.
This would then break the rest of the descriptor filling for the packet
data.

Prepare the vhost net header in a temporary buffer, then copy to the
descriptors ensuring we are still under the nr_vec limit.

Additionally, we can't expect the iova address of the descriptors to be
contiguous.

CVE-2026-86566
Bugzilla ID: 2020

Cc: stable@dpdk.org

Acked-by: Maxime Coquelin <maxime.coquelin@redhat.com>
Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 lib/vhost/virtio_net.c | 83 ++++++++++++++++++++++--------------------
 1 file changed, 43 insertions(+), 40 deletions(-)

diff --git a/lib/vhost/virtio_net.c b/lib/vhost/virtio_net.c
index 0658b81de5..ff4613df68 100644
--- a/lib/vhost/virtio_net.c
+++ b/lib/vhost/virtio_net.c
@@ -1014,21 +1014,24 @@ fill_vec_buf_packed(struct virtio_net *dev, struct vhost_virtqueue *vq,
 	return 0;
 }
 
-static __rte_noinline void
+static __rte_noinline int
 copy_vnet_hdr_to_desc(struct virtio_net *dev, struct vhost_virtqueue *vq,
-		struct buf_vector *buf_vec,
-		struct virtio_net_hdr_mrg_rxbuf *hdr)
+		struct buf_vector *buf_vec, uint16_t nr_vec,
+		struct virtio_net_hdr_mrg_rxbuf *hdr,
+		uint32_t *vec_idx, uint32_t *buf_offset)
 	__rte_requires_shared_capability(&vq->iotlb_lock)
 {
-	uint64_t len;
+	uint64_t len = 0;
 	uint64_t remain = dev->vhost_hlen;
-	uint64_t src = (uint64_t)(uintptr_t)hdr, dst;
-	uint64_t iova = buf_vec->buf_iova;
+	uint64_t src = (uint64_t)(uintptr_t)hdr;
+	uint32_t idx = 0;
 
 	while (remain) {
+		uint64_t iova = buf_vec->buf_iova;
+		uint64_t dst = buf_vec->buf_addr;
+
 		len = RTE_MIN(remain,
 				buf_vec->buf_len);
-		dst = buf_vec->buf_addr;
 		rte_memcpy((void *)(uintptr_t)dst,
 				(void *)(uintptr_t)src,
 				len);
@@ -1039,10 +1042,21 @@ copy_vnet_hdr_to_desc(struct virtio_net *dev, struct vhost_virtqueue *vq,
 				iova, len);
 
 		remain -= len;
-		iova += len;
 		src += len;
-		buf_vec++;
+
+		if (remain) {
+			if (unlikely(idx + 1 >= nr_vec))
+				return -1;
+
+			buf_vec++;
+			idx++;
+		}
 	}
+
+	*vec_idx = idx;
+	*buf_offset = (uint32_t)len;
+
+	return 0;
 }
 
 static __rte_always_inline int
@@ -1209,9 +1223,6 @@ mbuf_to_desc(struct virtio_net *dev, struct vhost_virtqueue *vq,
 	uint32_t buf_offset, buf_avail;
 	uint64_t buf_addr, buf_iova, buf_len;
 	uint32_t cpy_len;
-	uint64_t hdr_addr;
-	struct rte_mbuf *hdr_mbuf;
-	struct virtio_net_hdr_mrg_rxbuf tmp_hdr, *hdr = NULL;
 	struct vhost_async *async = vq->async;
 
 	if (unlikely(m == NULL))
@@ -1224,24 +1235,35 @@ mbuf_to_desc(struct virtio_net *dev, struct vhost_virtqueue *vq,
 	if (unlikely(buf_len < dev->vhost_hlen && nr_vec <= 1))
 		return -1;
 
-	hdr_mbuf = m;
-	hdr_addr = buf_addr;
+	VHOST_DATA_LOG(dev->ifname, DEBUG, "RX: num merge buffers %d", num_buffers);
+
 	if (unlikely(buf_len < dev->vhost_hlen)) {
+		struct virtio_net_hdr_mrg_rxbuf tmp_hdr;
+
 		memset(&tmp_hdr, 0, sizeof(struct virtio_net_hdr_mrg_rxbuf));
-		hdr = &tmp_hdr;
-	} else
-		hdr = (struct virtio_net_hdr_mrg_rxbuf *)(uintptr_t)hdr_addr;
+		virtio_enqueue_offload(m, &tmp_hdr.hdr);
+		if (rxvq_is_mergeable(dev))
+			ASSIGN_UNLESS_EQUAL(tmp_hdr.num_buffers, num_buffers);
 
-	VHOST_DATA_LOG(dev->ifname, DEBUG, "RX: num merge buffers %d", num_buffers);
+		if (copy_vnet_hdr_to_desc(dev, vq, buf_vec, nr_vec,
+				&tmp_hdr, &vec_idx, &buf_offset) < 0)
+			return -1;
 
-	if (unlikely(buf_len < dev->vhost_hlen)) {
-		buf_offset = dev->vhost_hlen - buf_len;
-		vec_idx++;
 		buf_addr = buf_vec[vec_idx].buf_addr;
 		buf_iova = buf_vec[vec_idx].buf_iova;
 		buf_len = buf_vec[vec_idx].buf_len;
 		buf_avail = buf_len - buf_offset;
 	} else {
+		struct virtio_net_hdr_mrg_rxbuf *hdr;
+
+		hdr = (struct virtio_net_hdr_mrg_rxbuf *)(uintptr_t)buf_addr;
+		virtio_enqueue_offload(m, &hdr->hdr);
+		if (rxvq_is_mergeable(dev))
+			ASSIGN_UNLESS_EQUAL(hdr->num_buffers, num_buffers);
+
+		PRINT_PACKET(dev, (uintptr_t)buf_addr, dev->vhost_hlen, 0);
+		vhost_log_cache_write_iova(dev, vq, buf_iova, dev->vhost_hlen);
+
 		buf_offset = dev->vhost_hlen;
 		buf_avail = buf_len - dev->vhost_hlen;
 	}
@@ -1277,25 +1299,6 @@ mbuf_to_desc(struct virtio_net *dev, struct vhost_virtqueue *vq,
 			mbuf_avail  = rte_pktmbuf_data_len(m);
 		}
 
-		if (hdr_addr) {
-			virtio_enqueue_offload(hdr_mbuf, &hdr->hdr);
-			if (rxvq_is_mergeable(dev))
-				ASSIGN_UNLESS_EQUAL(hdr->num_buffers,
-						num_buffers);
-
-			if (unlikely(hdr == &tmp_hdr)) {
-				copy_vnet_hdr_to_desc(dev, vq, buf_vec, hdr);
-			} else {
-				PRINT_PACKET(dev, (uintptr_t)hdr_addr,
-						dev->vhost_hlen, 0);
-				vhost_log_cache_write_iova(dev, vq,
-						buf_vec[0].buf_iova,
-						dev->vhost_hlen);
-			}
-
-			hdr_addr = 0;
-		}
-
 		cpy_len = RTE_MIN(buf_avail, mbuf_avail);
 
 		if (is_async) {
-- 
2.56.0

