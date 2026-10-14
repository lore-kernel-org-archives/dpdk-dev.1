Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00468CC6B1D
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Oct 2026 15:01:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 41E7840656;
	Wed, 14 Oct 2026 17:01:01 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id BEDF640612
 for <dev@dpdk.org>; Wed, 14 Oct 2026 17:00:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791990059;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=k7yWxC5AbdcAFqsB82RwAkc7gDQGN9TFig9GraBZe+E=;
 b=IOJgqaefSHz761RAPt+tFL3qdsJMCaZPuTlFcj4dVXAfr2fluK2cjyC0giiYjcybwQLRac
 bpqOdZ2h1xuIYyBxGDhe0p5kNAdQ5EK3tUI7vxKVOJmefSb3B94Gev9z0l/DTpKBOJVm/g
 dAywHX0YJ2Ypccwx+dw0ut/e1RvshwQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-422-OHSB456iPt6lDs4IVxnWZg-1; Wed,
 14 Oct 2026 15:00:54 +0000
X-MC-Unique: OHSB456iPt6lDs4IVxnWZg-1
X-Mimecast-MFC-AGG-ID: OHSB456iPt6lDs4IVxnWZg_1791990053
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7419C18001E3; Wed, 14 Oct 2026 15:00:53 +0000 (UTC)
Received: from max-p1.redhat.corp (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 352531800642; Wed, 14 Oct 2026 15:00:52 +0000 (UTC)
From: Maxime Coquelin <maxime.coquelin@redhat.com>
To: dev@dpdk.org
Cc: Kai Ji <kai.ji@intel.com>, stable@dpdk.org,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH 01/14] vhost/crypto: fix TOCTOU OOB write in finalize path
Date: Wed, 14 Oct 2026 17:00:36 +0200
Message-ID: <20261014150049.2540538-1-maxime.coquelin@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 4nQgqz5biRnUA-iLOZ_UQ3YySQ7YQ2-pXX--d0rM7hM_1791990053
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

From: Kai Ji <kai.ji@intel.com>

When finalizing a crypto request, the descriptor index was
re-read from the guest-writable available ring (vq->avail->ring)
instead of using the value saved at request fetch time. A malicious
guest can modify this index between fetch and finalization, causing
an out-of-bounds write to vq->used->ring[desc_idx] with a
guest-controlled index up to 0xFFFF (max ~512 KB past the ring).

Fix by using the desc_idx saved in vc_req->desc_idx directly at
finalization time, eliminating the re-read from guest memory. Add
bounds checks on desc_idx against vq->size in both the fetch loops
and the finalize function to prevent out-of-bounds access.

CVE-2026-86848
CVE-2026-86846
Bugzilla ID: 2001
Bugzilla ID: 2026

Fixes: 939066d96563 ("vhost/crypto: add public function implementation")
Cc: stable@dpdk.org

Acked-by: Bruce Richardson <bruce.richardson@intel.com>
Signed-off-by: Kai Ji <kai.ji@intel.com>
---
 lib/vhost/vhost_crypto.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/lib/vhost/vhost_crypto.c b/lib/vhost/vhost_crypto.c
index 648e2d731b..351fa241c8 100644
--- a/lib/vhost/vhost_crypto.c
+++ b/lib/vhost/vhost_crypto.c
@@ -1707,7 +1707,7 @@ vhost_crypto_finalize_one_request(struct rte_crypto_op *op,
 	struct rte_mbuf *m_src = NULL, *m_dst = NULL;
 	struct vhost_crypto_data_req *vc_req;
 	struct vhost_virtqueue *vq;
-	uint16_t used_idx, desc_idx;
+	uint16_t desc_idx;
 
 	if (op->type == RTE_CRYPTO_OP_TYPE_SYMMETRIC) {
 		m_src = op->sym->m_src;
@@ -1725,11 +1725,16 @@ vhost_crypto_finalize_one_request(struct rte_crypto_op *op,
 		return NULL;
 	}
 	vq = vc_req->vq;
-	used_idx = vc_req->desc_idx;
+	desc_idx = vc_req->desc_idx;
 
 	if (old_vq && (vq != old_vq))
 		return vq;
 
+	if (unlikely(desc_idx >= vq->size)) {
+		VC_LOG_ERR("Invalid descriptor index %u", desc_idx);
+		return NULL;
+	}
+
 	if (unlikely(op->status != RTE_CRYPTO_OP_STATUS_SUCCESS))
 		vc_req->inhdr->status = VIRTIO_CRYPTO_ERR;
 	else {
@@ -1737,8 +1742,7 @@ vhost_crypto_finalize_one_request(struct rte_crypto_op *op,
 			write_back_data(vc_req);
 	}
 
-	desc_idx = vq->avail->ring[used_idx];
-	vq->used->ring[desc_idx].id = vq->avail->ring[desc_idx];
+	vq->used->ring[desc_idx].id = desc_idx;
 	vq->used->ring[desc_idx].len = vc_req->len;
 
 	if (op->type == RTE_CRYPTO_OP_TYPE_SYMMETRIC) {
@@ -2044,16 +2048,20 @@ rte_vhost_crypto_fetch_requests(int vid, uint32_t qid,
 		for (i = 0; i < count; i++) {
 			uint16_t used_idx = (start_idx + i) & (vq->size - 1);
 			uint16_t desc_idx = vq->avail->ring[used_idx];
-			struct vring_desc *head = &vq->desc[desc_idx];
+			struct vring_desc *head;
 			struct rte_crypto_op *op = ops[i];
 
+			if (unlikely(desc_idx >= vq->size))
+				break;
+
+			head = &vq->desc[desc_idx];
 			op->sym->m_src = mbufs[i * 2];
 			op->sym->m_dst = mbufs[i * 2 + 1];
 			op->sym->m_src->data_off = 0;
 			op->sym->m_dst->data_off = 0;
 
 			if (unlikely(vhost_crypto_process_one_req(vcrypto, vq,
-					op, head, descs, used_idx) < 0))
+					op, head, descs, desc_idx) < 0))
 				break;
 		}
 
@@ -2074,9 +2082,13 @@ rte_vhost_crypto_fetch_requests(int vid, uint32_t qid,
 		for (i = 0; i < count; i++) {
 			uint16_t used_idx = (start_idx + i) & (vq->size - 1);
 			uint16_t desc_idx = vq->avail->ring[used_idx];
-			struct vring_desc *head = &vq->desc[desc_idx];
+			struct vring_desc *head;
 			struct rte_crypto_op *op = ops[i];
 
+			if (unlikely(desc_idx >= vq->size))
+				break;
+
+			head = &vq->desc[desc_idx];
 			op->sym->m_src = mbufs[i];
 			op->sym->m_dst = NULL;
 			op->sym->m_src->data_off = 0;
-- 
2.56.0

