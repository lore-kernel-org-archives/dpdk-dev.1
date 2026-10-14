Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBFB2CC6B1A
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Oct 2026 15:02:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8BBAF40DDD;
	Wed, 14 Oct 2026 17:01:20 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 3861B40BA2
 for <dev@dpdk.org>; Wed, 14 Oct 2026 17:01:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791990076;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lMNttUSzKFZ/+ie6BUqw1mNs4QsIeaqNkeh8Xnkr4Ic=;
 b=FWg78rHsLFHJYQ0SHQervQaL46s4Z3rgAIg8rJ6eQKApd/ijsoYvN8pl4oiXpDtzLuhe4E
 z8ggaKL30ecVdNNCeXFSJo6trysg8Ipj96x2NGmgAm/w1Hpy/dNr82MkBn4x6WeLQZhPSk
 WhvDLtkf57OQdSu15aEvCtwYzqoi4nw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-160-9kakMY-8NlKXYXYhBhatgg-1; Wed,
 14 Oct 2026 15:01:13 +0000
X-MC-Unique: 9kakMY-8NlKXYXYhBhatgg-1
X-Mimecast-MFC-AGG-ID: 9kakMY-8NlKXYXYhBhatgg_1791990072
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B05591800772; Wed, 14 Oct 2026 15:01:12 +0000 (UTC)
Received: from max-p1.redhat.corp (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 989A51800495; Wed, 14 Oct 2026 15:01:11 +0000 (UTC)
From: Maxime Coquelin <maxime.coquelin@redhat.com>
To: dev@dpdk.org
Cc: Maxime Coquelin <maxime.coquelin@redhat.com>,
 Naseeb Dangi <naseebdangi100@gmail.com>,
 Kevin Traynor <ktraynor@redhat.com>
Subject: [PATCH 13/14] vhost: fix indirect descriptor table double fetch
Date: Wed, 14 Oct 2026 17:00:48 +0200
Message-ID: <20261014150049.2540538-13-maxime.coquelin@redhat.com>
In-Reply-To: <20261014150049.2540538-1-maxime.coquelin@redhat.com>
References: <20261014150049.2540538-1-maxime.coquelin@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: hjlQAwuADrelFJdKs2tMKx6snmwka0SRiw1SAhfZagM_1791990072
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

The virtio descriptor length field was read multiple times from
guest-controlled memory, creating a TOCTOU (time-of-check-time-of-use)
vulnerability. A malicious guest could exploit this by modifying
desc->len between reads, causing the host to allocate a buffer of
one size but iterate over a different number of descriptors, leading
to an out-of-bounds read.

Affected functions:
- fill_vec_buf_packed_indirect(): desc->len read for allocation at
  one point, then re-read for loop bound calculation
- fill_vec_buf_split(): vq->desc[idx].len re-read for allocation
  after being captured in a local variable
- vdpa.c indirect descriptor handling: same pattern

Fix by capturing the descriptor length once in a local variable
and using that for all subsequent operations.

Also fix a memory leak in fill_vec_buf_packed_indirect() where
free_ind_table() was not called on the map_one_desc() error path.

CVE: CVE-2026-93683
Bugzilla ID: 2046

Fixes: d0c24508e1f ("vhost: add support for non-contiguous indirect descs tables")
Fixes: 2f3225a7d69 ("vhost: add vector filling support for packed ring")

Reported-by: Naseeb Dangi <naseebdangi100@gmail.com>
Acked-by: Kevin Traynor <ktraynor@redhat.com>
Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
---
 lib/vhost/vdpa.c       |  8 +++++---
 lib/vhost/virtio_net.c | 22 +++++++++++++---------
 2 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/lib/vhost/vdpa.c b/lib/vhost/vdpa.c
index bc2dd8d2e1..ff3b4379aa 100644
--- a/lib/vhost/vdpa.c
+++ b/lib/vhost/vdpa.c
@@ -195,7 +195,9 @@ rte_vdpa_relay_vring_used(int vid, uint16_t qid, void *vring_m)
 			return -1;
 
 		if (vq->desc[desc_id].flags & VRING_DESC_F_INDIRECT) {
-			dlen = vq->desc[desc_id].len;
+			uint64_t desc_len = vq->desc[desc_id].len;
+
+			dlen = desc_len;
 			nr_descs = dlen / sizeof(struct vring_desc);
 			if (unlikely(nr_descs > vq->size))
 				return -1;
@@ -209,11 +211,11 @@ rte_vdpa_relay_vring_used(int vid, uint16_t qid, void *vring_m)
 			if (unlikely(!desc_ring))
 				return -1;
 
-			if (unlikely(dlen < vq->desc[desc_id].len)) {
+			if (unlikely(dlen < desc_len)) {
 				vhost_user_iotlb_rd_lock(vq);
 				idesc = vhost_alloc_copy_ind_table(dev, vq,
 						vq->desc[desc_id].addr,
-						vq->desc[desc_id].len);
+						desc_len);
 				vhost_user_iotlb_rd_unlock(vq);
 				if (unlikely(!idesc))
 					return -1;
diff --git a/lib/vhost/virtio_net.c b/lib/vhost/virtio_net.c
index ff4613df68..8bdddedccf 100644
--- a/lib/vhost/virtio_net.c
+++ b/lib/vhost/virtio_net.c
@@ -775,7 +775,9 @@ fill_vec_buf_split(struct virtio_net *dev, struct vhost_virtqueue *vq,
 	*desc_chain_head = idx;
 
 	if (vq->desc[idx].flags & VRING_DESC_F_INDIRECT) {
-		dlen = vq->desc[idx].len;
+		uint64_t desc_len = vq->desc[idx].len;
+
+		dlen = desc_len;
 		nr_descs = dlen / sizeof(struct vring_desc);
 		if (unlikely(nr_descs > vq->size))
 			return -1;
@@ -787,13 +789,13 @@ fill_vec_buf_split(struct virtio_net *dev, struct vhost_virtqueue *vq,
 		if (unlikely(!descs))
 			return -1;
 
-		if (unlikely(dlen < vq->desc[idx].len)) {
+		if (unlikely(dlen < desc_len)) {
 			/*
 			 * The indirect desc table is not contiguous
 			 * in process VA space, we have to copy it.
 			 */
 			idesc = vhost_alloc_copy_ind_table(dev, vq,
-					vq->desc[idx].addr, vq->desc[idx].len);
+					vq->desc[idx].addr, desc_len);
 			if (unlikely(!idesc))
 				return -1;
 
@@ -898,29 +900,29 @@ fill_vec_buf_packed_indirect(struct virtio_net *dev,
 	uint16_t i;
 	uint32_t nr_descs;
 	uint16_t vec_id = *vec_idx;
-	uint64_t dlen;
+	uint64_t desc_len = desc->len;
+	uint64_t dlen = desc_len;
 	struct vring_packed_desc *descs, *idescs = NULL;
 
-	dlen = desc->len;
 	descs = (struct vring_packed_desc *)(uintptr_t)
 		vhost_iova_to_vva(dev, vq, desc->addr, &dlen, VHOST_ACCESS_RO);
 	if (unlikely(!descs))
 		return -1;
 
-	if (unlikely(dlen < desc->len)) {
+	if (unlikely(dlen < desc_len)) {
 		/*
 		 * The indirect desc table is not contiguous
 		 * in process VA space, we have to copy it.
 		 */
 		idescs = vhost_alloc_copy_ind_table(dev,
-				vq, desc->addr, desc->len);
+				vq, desc->addr, desc_len);
 		if (unlikely(!idescs))
 			return -1;
 
 		descs = idescs;
 	}
 
-	nr_descs =  desc->len / sizeof(struct vring_packed_desc);
+	nr_descs = desc_len / sizeof(struct vring_packed_desc);
 	if (unlikely(nr_descs >= vq->size)) {
 		free_ind_table(idescs);
 		return -1;
@@ -936,8 +938,10 @@ fill_vec_buf_packed_indirect(struct virtio_net *dev,
 		*len += dlen;
 		if (unlikely(map_one_desc(dev, vq, buf_vec, &vec_id,
 						descs[i].addr, dlen,
-						perm)))
+						perm))) {
+			free_ind_table(idescs);
 			return -1;
+		}
 	}
 	*vec_idx = vec_id;
 
-- 
2.56.0

