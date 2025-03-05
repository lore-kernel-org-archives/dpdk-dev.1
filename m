Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B8C1C19F32
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Mar 2025 09:12:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2CB4240279;
	Wed,  5 Mar 2025 10:12:38 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 1450C400EF
 for <dev@dpdk.org>; Wed,  5 Mar 2025 10:12:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741165956;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=6ScyjLdb8sj2ynHyzoOGxU/ZD6aY/kVxFrva01Esmos=;
 b=gEiIewF0rr7YBrxz/h35W6+S5sjHZFiaPXreHwEXRVOO1loG/6FOnLB7q9JGHy96puMI/h
 vaG15pFve6lA0y5aC8ErM8ApEs7oVdoo77DVZGsf0BtJe5PY00/OijDGo7yHE/wOUfEo8H
 Lu4ukLmZHyKTtPdrl6b/iT7jCnC0SII=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-38-VRNPlAiyP6yfj56pdnCQsw-1; Wed,
 05 Mar 2025 04:12:30 -0500
X-MC-Unique: VRNPlAiyP6yfj56pdnCQsw-1
X-Mimecast-MFC-AGG-ID: VRNPlAiyP6yfj56pdnCQsw_1741165949
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5D98D1800262; Wed,  5 Mar 2025 09:12:29 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.45.224.74])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 74758180035E; Wed,  5 Mar 2025 09:12:27 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>,
 Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
Subject: [PATCH] vhost/crypto: fix locking
Date: Wed,  5 Mar 2025 10:12:16 +0100
Message-ID: <20250305091217.590887-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: lg2abC6DlIH2fVsogiGOXeO9N8Pq_ZIH7KEDhgG5mKw_1741165949
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

vc_req_out->vq->iotlb_lock is taken twice on the same thread:
vc_req_out->vq refers to vc_req->vq (after a memcpy), which itself
is a reference to the vq.

clang probably does not detect that the same object is already locked as
it does not track object referencies.

Finish the incomplete and incorrect cleanup and only refer to the
&vq->iotlb_lock capability (required by vhost_iova_to_vva).

Fixes: 88c73b5434e6 ("vhost/crypto: fix thread safety check")

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 lib/vhost/vhost_crypto.c | 95 +++++++++++++++++++---------------------
 1 file changed, 46 insertions(+), 49 deletions(-)

diff --git a/lib/vhost/vhost_crypto.c b/lib/vhost/vhost_crypto.c
index 55f137aae3..8dd1806a39 100644
--- a/lib/vhost/vhost_crypto.c
+++ b/lib/vhost/vhost_crypto.c
@@ -739,7 +739,7 @@ static __rte_always_inline struct virtio_crypto_inhdr *
 reach_inhdr(struct virtio_net *dev, struct vhost_virtqueue *vq,
 		struct vhost_crypto_desc *head,
 		uint32_t max_n_descs)
-	__rte_requires_shared_capability(vq->iotlb_lock)
+	__rte_requires_shared_capability(&vq->iotlb_lock)
 {
 	struct virtio_crypto_inhdr *inhdr;
 	struct vhost_crypto_desc *last = head + (max_n_descs - 1);
@@ -783,15 +783,15 @@ move_desc(struct vhost_crypto_desc *head,
 }
 
 static __rte_always_inline void *
-get_data_ptr(struct vhost_crypto_data_req *vc_req,
+get_data_ptr(struct vhost_virtqueue *vq, struct vhost_crypto_data_req *vc_req,
 		struct vhost_crypto_desc *cur_desc,
 		uint8_t perm)
-	__rte_requires_shared_capability(&vc_req->vq->iotlb_lock)
+	__rte_requires_shared_capability(&vq->iotlb_lock)
 {
 	void *data;
 	uint64_t dlen = cur_desc->len;
 
-	data = IOVA_TO_VVA(void *, vc_req->dev, vc_req->vq,
+	data = IOVA_TO_VVA(void *, vc_req->dev, vq,
 			cur_desc->addr, &dlen, perm);
 	if (unlikely(!data || dlen != cur_desc->len)) {
 		VC_LOG_ERR("Failed to map object");
@@ -804,7 +804,7 @@ get_data_ptr(struct vhost_crypto_data_req *vc_req,
 static __rte_always_inline uint32_t
 copy_data_from_desc(void *dst, struct virtio_net *dev,
 	struct vhost_virtqueue *vq, struct vhost_crypto_desc *desc, uint32_t size)
-	__rte_requires_shared_capability(vq->iotlb_lock)
+	__rte_requires_shared_capability(&vq->iotlb_lock)
 {
 	uint64_t remain;
 	uint64_t addr;
@@ -836,7 +836,7 @@ static __rte_always_inline int
 copy_data(void *data, struct virtio_net *dev, struct vhost_virtqueue *vq,
 	struct vhost_crypto_desc *head, struct vhost_crypto_desc **cur_desc,
 	uint32_t size, uint32_t max_n_descs)
-	__rte_requires_shared_capability(vq->iotlb_lock)
+	__rte_requires_shared_capability(&vq->iotlb_lock)
 {
 	struct vhost_crypto_desc *desc = *cur_desc;
 	uint32_t left = size;
@@ -912,7 +912,8 @@ free_wb_data(struct vhost_crypto_writeback_data *wb_data,
  *   The pointer to the start of the write back data linked list.
  */
 static __rte_always_inline struct vhost_crypto_writeback_data *
-prepare_write_back_data(struct vhost_crypto_data_req *vc_req,
+prepare_write_back_data(struct vhost_virtqueue *vq,
+		struct vhost_crypto_data_req *vc_req,
 		struct vhost_crypto_desc *head_desc,
 		struct vhost_crypto_desc **cur_desc,
 		struct vhost_crypto_writeback_data **end_wb_data,
@@ -920,7 +921,7 @@ prepare_write_back_data(struct vhost_crypto_data_req *vc_req,
 		uint32_t offset,
 		uint64_t write_back_len,
 		uint32_t max_n_descs)
-	__rte_requires_shared_capability(&vc_req->vq->iotlb_lock)
+	__rte_requires_shared_capability(&vq->iotlb_lock)
 {
 	struct vhost_crypto_writeback_data *wb_data, *head;
 	struct vhost_crypto_desc *desc = *cur_desc;
@@ -939,7 +940,7 @@ prepare_write_back_data(struct vhost_crypto_data_req *vc_req,
 	if (likely(desc->len > offset)) {
 		wb_data->src = src + offset;
 		dlen = desc->len;
-		dst = IOVA_TO_VVA(uint8_t *, vc_req->dev, vc_req->vq,
+		dst = IOVA_TO_VVA(uint8_t *, vc_req->dev, vq,
 			desc->addr, &dlen, VHOST_ACCESS_RW);
 		if (unlikely(!dst || dlen != desc->len)) {
 			VC_LOG_ERR("Failed to map descriptor");
@@ -981,7 +982,7 @@ prepare_write_back_data(struct vhost_crypto_data_req *vc_req,
 		}
 
 		dlen = desc->len;
-		dst = IOVA_TO_VVA(uint8_t *, vc_req->dev, vc_req->vq,
+		dst = IOVA_TO_VVA(uint8_t *, vc_req->dev, vq,
 				desc->addr, &dlen, VHOST_ACCESS_RW) + offset;
 		if (unlikely(dst == NULL || dlen != desc->len)) {
 			VC_LOG_ERR("Failed to map descriptor");
@@ -1037,11 +1038,12 @@ vhost_crypto_check_cipher_request(struct virtio_crypto_cipher_data_req *req)
 
 static __rte_always_inline uint8_t
 prepare_sym_cipher_op(struct vhost_crypto *vcrypto, struct rte_crypto_op *op,
+		struct vhost_virtqueue *vq,
 		struct vhost_crypto_data_req *vc_req,
 		struct virtio_crypto_cipher_data_req *cipher,
 		struct vhost_crypto_desc *head,
 		uint32_t max_n_descs)
-	__rte_requires_shared_capability(&vc_req->vq->iotlb_lock)
+	__rte_requires_shared_capability(&vq->iotlb_lock)
 {
 	struct vhost_crypto_desc *desc = head;
 	struct vhost_crypto_writeback_data *ewb = NULL;
@@ -1054,7 +1056,7 @@ prepare_sym_cipher_op(struct vhost_crypto *vcrypto, struct rte_crypto_op *op,
 
 	/* prepare */
 	/* iv */
-	if (unlikely(copy_data(iv_data, vcrypto->dev, vc_req->vq, head, &desc,
+	if (unlikely(copy_data(iv_data, vcrypto->dev, vq, head, &desc,
 			cipher->para.iv_len, max_n_descs))) {
 		VC_LOG_ERR("Incorrect virtio descriptor");
 		ret = VIRTIO_CRYPTO_BADMSG;
@@ -1066,7 +1068,7 @@ prepare_sym_cipher_op(struct vhost_crypto *vcrypto, struct rte_crypto_op *op,
 		m_src->data_len = cipher->para.src_data_len;
 		rte_mbuf_iova_set(m_src,
 				  gpa_to_hpa(vcrypto->dev, desc->addr, cipher->para.src_data_len));
-		m_src->buf_addr = get_data_ptr(vc_req, desc, VHOST_ACCESS_RO);
+		m_src->buf_addr = get_data_ptr(vq, vc_req, desc, VHOST_ACCESS_RO);
 		if (unlikely(rte_mbuf_iova_get(m_src) == 0 || m_src->buf_addr == NULL)) {
 			VC_LOG_ERR("zero_copy may fail due to cross page data");
 			ret = VIRTIO_CRYPTO_ERR;
@@ -1085,7 +1087,7 @@ prepare_sym_cipher_op(struct vhost_crypto *vcrypto, struct rte_crypto_op *op,
 		vc_req->wb_pool = vcrypto->wb_pool;
 		m_src->data_len = cipher->para.src_data_len;
 		if (unlikely(copy_data(rte_pktmbuf_mtod(m_src, uint8_t *),
-				vcrypto->dev, vc_req->vq, head, &desc,
+				vcrypto->dev, vq, head, &desc,
 				cipher->para.src_data_len, max_n_descs) < 0)) {
 			VC_LOG_ERR("Incorrect virtio descriptor");
 			ret = VIRTIO_CRYPTO_BADMSG;
@@ -1109,7 +1111,7 @@ prepare_sym_cipher_op(struct vhost_crypto *vcrypto, struct rte_crypto_op *op,
 	case RTE_VHOST_CRYPTO_ZERO_COPY_ENABLE:
 		rte_mbuf_iova_set(m_dst,
 				  gpa_to_hpa(vcrypto->dev, desc->addr, cipher->para.dst_data_len));
-		m_dst->buf_addr = get_data_ptr(vc_req, desc, VHOST_ACCESS_RW);
+		m_dst->buf_addr = get_data_ptr(vq, vc_req, desc, VHOST_ACCESS_RW);
 		if (unlikely(rte_mbuf_iova_get(m_dst) == 0 || m_dst->buf_addr == NULL)) {
 			VC_LOG_ERR("zero_copy may fail due to cross page data");
 			ret = VIRTIO_CRYPTO_ERR;
@@ -1126,7 +1128,7 @@ prepare_sym_cipher_op(struct vhost_crypto *vcrypto, struct rte_crypto_op *op,
 		m_dst->data_len = cipher->para.dst_data_len;
 		break;
 	case RTE_VHOST_CRYPTO_ZERO_COPY_DISABLE:
-		vc_req->wb = prepare_write_back_data(vc_req, head, &desc, &ewb,
+		vc_req->wb = prepare_write_back_data(vq, vc_req, head, &desc, &ewb,
 				rte_pktmbuf_mtod(m_src, uint8_t *), 0,
 				cipher->para.dst_data_len, max_n_descs);
 		if (unlikely(vc_req->wb == NULL)) {
@@ -1147,7 +1149,7 @@ prepare_sym_cipher_op(struct vhost_crypto *vcrypto, struct rte_crypto_op *op,
 	op->sym->cipher.data.offset = 0;
 	op->sym->cipher.data.length = cipher->para.src_data_len;
 
-	vc_req->inhdr = get_data_ptr(vc_req, desc, VHOST_ACCESS_WO);
+	vc_req->inhdr = get_data_ptr(vq, vc_req, desc, VHOST_ACCESS_WO);
 	if (unlikely(vc_req->inhdr == NULL)) {
 		ret = VIRTIO_CRYPTO_BADMSG;
 		goto error_exit;
@@ -1191,11 +1193,12 @@ vhost_crypto_check_chain_request(struct virtio_crypto_alg_chain_data_req *req)
 
 static __rte_always_inline uint8_t
 prepare_sym_chain_op(struct vhost_crypto *vcrypto, struct rte_crypto_op *op,
+		struct vhost_virtqueue *vq,
 		struct vhost_crypto_data_req *vc_req,
 		struct virtio_crypto_alg_chain_data_req *chain,
 		struct vhost_crypto_desc *head,
 		uint32_t max_n_descs)
-	__rte_requires_shared_capability(&vc_req->vq->iotlb_lock)
+	__rte_requires_shared_capability(&vq->iotlb_lock)
 {
 	struct vhost_crypto_desc *desc = head, *digest_desc;
 	struct vhost_crypto_writeback_data *ewb = NULL, *ewb2 = NULL;
@@ -1210,7 +1213,7 @@ prepare_sym_chain_op(struct vhost_crypto *vcrypto, struct rte_crypto_op *op,
 
 	/* prepare */
 	/* iv */
-	if (unlikely(copy_data(iv_data, vcrypto->dev, vc_req->vq, head, &desc,
+	if (unlikely(copy_data(iv_data, vcrypto->dev, vq, head, &desc,
 			chain->para.iv_len, max_n_descs) < 0)) {
 		VC_LOG_ERR("Incorrect virtio descriptor");
 		ret = VIRTIO_CRYPTO_BADMSG;
@@ -1224,7 +1227,7 @@ prepare_sym_chain_op(struct vhost_crypto *vcrypto, struct rte_crypto_op *op,
 
 		rte_mbuf_iova_set(m_src,
 				  gpa_to_hpa(vcrypto->dev, desc->addr, chain->para.src_data_len));
-		m_src->buf_addr = get_data_ptr(vc_req, desc, VHOST_ACCESS_RO);
+		m_src->buf_addr = get_data_ptr(vq, vc_req, desc, VHOST_ACCESS_RO);
 		if (unlikely(rte_mbuf_iova_get(m_src) == 0 || m_src->buf_addr == NULL)) {
 			VC_LOG_ERR("zero_copy may fail due to cross page data");
 			ret = VIRTIO_CRYPTO_ERR;
@@ -1242,7 +1245,7 @@ prepare_sym_chain_op(struct vhost_crypto *vcrypto, struct rte_crypto_op *op,
 		vc_req->wb_pool = vcrypto->wb_pool;
 		m_src->data_len = chain->para.src_data_len;
 		if (unlikely(copy_data(rte_pktmbuf_mtod(m_src, uint8_t *),
-				vcrypto->dev, vc_req->vq, head, &desc,
+				vcrypto->dev, vq, head, &desc,
 				chain->para.src_data_len, max_n_descs) < 0)) {
 			VC_LOG_ERR("Incorrect virtio descriptor");
 			ret = VIRTIO_CRYPTO_BADMSG;
@@ -1267,7 +1270,7 @@ prepare_sym_chain_op(struct vhost_crypto *vcrypto, struct rte_crypto_op *op,
 	case RTE_VHOST_CRYPTO_ZERO_COPY_ENABLE:
 		rte_mbuf_iova_set(m_dst,
 				  gpa_to_hpa(vcrypto->dev, desc->addr, chain->para.dst_data_len));
-		m_dst->buf_addr = get_data_ptr(vc_req, desc, VHOST_ACCESS_RW);
+		m_dst->buf_addr = get_data_ptr(vq, vc_req, desc, VHOST_ACCESS_RW);
 		if (unlikely(rte_mbuf_iova_get(m_dst) == 0 || m_dst->buf_addr == NULL)) {
 			VC_LOG_ERR("zero_copy may fail due to cross page data");
 			ret = VIRTIO_CRYPTO_ERR;
@@ -1283,8 +1286,7 @@ prepare_sym_chain_op(struct vhost_crypto *vcrypto, struct rte_crypto_op *op,
 
 		op->sym->auth.digest.phys_addr = gpa_to_hpa(vcrypto->dev,
 				desc->addr, chain->para.hash_result_len);
-		op->sym->auth.digest.data = get_data_ptr(vc_req, desc,
-				VHOST_ACCESS_RW);
+		op->sym->auth.digest.data = get_data_ptr(vq, vc_req, desc, VHOST_ACCESS_RW);
 		if (unlikely(op->sym->auth.digest.phys_addr == 0)) {
 			VC_LOG_ERR("zero_copy may fail due to cross page data");
 			ret = VIRTIO_CRYPTO_ERR;
@@ -1301,7 +1303,7 @@ prepare_sym_chain_op(struct vhost_crypto *vcrypto, struct rte_crypto_op *op,
 
 		break;
 	case RTE_VHOST_CRYPTO_ZERO_COPY_DISABLE:
-		vc_req->wb = prepare_write_back_data(vc_req, head, &desc, &ewb,
+		vc_req->wb = prepare_write_back_data(vq, vc_req, head, &desc, &ewb,
 				rte_pktmbuf_mtod(m_src, uint8_t *),
 				chain->para.cipher_start_src_offset,
 				chain->para.dst_data_len -
@@ -1318,7 +1320,7 @@ prepare_sym_chain_op(struct vhost_crypto *vcrypto, struct rte_crypto_op *op,
 				digest_offset);
 
 		/** create a wb_data for digest */
-		ewb->next = prepare_write_back_data(vc_req, head, &desc,
+		ewb->next = prepare_write_back_data(vq, vc_req, head, &desc,
 				&ewb2, digest_addr, 0,
 				chain->para.hash_result_len, max_n_descs);
 		if (unlikely(ewb->next == NULL)) {
@@ -1326,7 +1328,7 @@ prepare_sym_chain_op(struct vhost_crypto *vcrypto, struct rte_crypto_op *op,
 			goto error_exit;
 		}
 
-		if (unlikely(copy_data(digest_addr, vcrypto->dev, vc_req->vq, head,
+		if (unlikely(copy_data(digest_addr, vcrypto->dev, vq, head,
 				&digest_desc, chain->para.hash_result_len,
 				max_n_descs) < 0)) {
 			VC_LOG_ERR("Incorrect virtio descriptor");
@@ -1344,7 +1346,7 @@ prepare_sym_chain_op(struct vhost_crypto *vcrypto, struct rte_crypto_op *op,
 	}
 
 	/* record inhdr */
-	vc_req->inhdr = get_data_ptr(vc_req, desc, VHOST_ACCESS_WO);
+	vc_req->inhdr = get_data_ptr(vq, vc_req, desc, VHOST_ACCESS_WO);
 	if (unlikely(vc_req->inhdr == NULL)) {
 		ret = VIRTIO_CRYPTO_BADMSG;
 		goto error_exit;
@@ -1375,11 +1377,12 @@ prepare_sym_chain_op(struct vhost_crypto *vcrypto, struct rte_crypto_op *op,
 
 static __rte_always_inline uint8_t
 prepare_asym_rsa_op(struct vhost_crypto *vcrypto, struct rte_crypto_op *op,
+		struct vhost_virtqueue *vq,
 		struct vhost_crypto_data_req *vc_req,
 		struct virtio_crypto_op_data_req *req,
 		struct vhost_crypto_desc *head,
 		uint32_t max_n_descs)
-	__rte_requires_shared_capability(&vc_req->vq->iotlb_lock)
+	__rte_requires_shared_capability(&vq->iotlb_lock)
 {
 	struct rte_crypto_rsa_op_param *rsa = &op->asym->rsa;
 	struct vhost_crypto_desc *desc = head;
@@ -1392,7 +1395,7 @@ prepare_asym_rsa_op(struct vhost_crypto *vcrypto, struct rte_crypto_op *op,
 		vc_req->wb_pool = vcrypto->wb_pool;
 		if (req->header.opcode == VIRTIO_CRYPTO_AKCIPHER_SIGN) {
 			rsa->op_type = RTE_CRYPTO_ASYM_OP_SIGN;
-			rsa->message.data = get_data_ptr(vc_req, desc, VHOST_ACCESS_RO);
+			rsa->message.data = get_data_ptr(vq, vc_req, desc, VHOST_ACCESS_RO);
 			rsa->message.length = req->u.akcipher_req.para.src_data_len;
 			rsa->sign.length = req->u.akcipher_req.para.dst_data_len;
 			wlen = rsa->sign.length;
@@ -1403,7 +1406,7 @@ prepare_asym_rsa_op(struct vhost_crypto *vcrypto, struct rte_crypto_op *op,
 				goto error_exit;
 			}
 
-			rsa->sign.data = get_data_ptr(vc_req, desc, VHOST_ACCESS_RW);
+			rsa->sign.data = get_data_ptr(vq, vc_req, desc, VHOST_ACCESS_RW);
 			if (unlikely(rsa->sign.data == NULL)) {
 				ret = VIRTIO_CRYPTO_ERR;
 				goto error_exit;
@@ -1412,15 +1415,15 @@ prepare_asym_rsa_op(struct vhost_crypto *vcrypto, struct rte_crypto_op *op,
 			desc += 1;
 		} else if (req->header.opcode == VIRTIO_CRYPTO_AKCIPHER_VERIFY) {
 			rsa->op_type = RTE_CRYPTO_ASYM_OP_VERIFY;
-			rsa->sign.data = get_data_ptr(vc_req, desc, VHOST_ACCESS_RO);
+			rsa->sign.data = get_data_ptr(vq, vc_req, desc, VHOST_ACCESS_RO);
 			rsa->sign.length = req->u.akcipher_req.para.src_data_len;
 			desc += 1;
-			rsa->message.data = get_data_ptr(vc_req, desc, VHOST_ACCESS_RO);
+			rsa->message.data = get_data_ptr(vq, vc_req, desc, VHOST_ACCESS_RO);
 			rsa->message.length = req->u.akcipher_req.para.dst_data_len;
 			desc += 1;
 		} else if (req->header.opcode == VIRTIO_CRYPTO_AKCIPHER_ENCRYPT) {
 			rsa->op_type = RTE_CRYPTO_ASYM_OP_ENCRYPT;
-			rsa->message.data = get_data_ptr(vc_req, desc, VHOST_ACCESS_RO);
+			rsa->message.data = get_data_ptr(vq, vc_req, desc, VHOST_ACCESS_RO);
 			rsa->message.length = req->u.akcipher_req.para.src_data_len;
 			rsa->cipher.length = req->u.akcipher_req.para.dst_data_len;
 			wlen = rsa->cipher.length;
@@ -1431,7 +1434,7 @@ prepare_asym_rsa_op(struct vhost_crypto *vcrypto, struct rte_crypto_op *op,
 				goto error_exit;
 			}
 
-			rsa->cipher.data = get_data_ptr(vc_req, desc, VHOST_ACCESS_RW);
+			rsa->cipher.data = get_data_ptr(vq, vc_req, desc, VHOST_ACCESS_RW);
 			if (unlikely(rsa->cipher.data == NULL)) {
 				ret = VIRTIO_CRYPTO_ERR;
 				goto error_exit;
@@ -1440,10 +1443,10 @@ prepare_asym_rsa_op(struct vhost_crypto *vcrypto, struct rte_crypto_op *op,
 			desc += 1;
 		} else if (req->header.opcode == VIRTIO_CRYPTO_AKCIPHER_DECRYPT) {
 			rsa->op_type = RTE_CRYPTO_ASYM_OP_DECRYPT;
-			rsa->cipher.data = get_data_ptr(vc_req, desc, VHOST_ACCESS_RO);
+			rsa->cipher.data = get_data_ptr(vq, vc_req, desc, VHOST_ACCESS_RO);
 			rsa->cipher.length = req->u.akcipher_req.para.src_data_len;
 			desc += 1;
-			rsa->message.data = get_data_ptr(vc_req, desc, VHOST_ACCESS_RO);
+			rsa->message.data = get_data_ptr(vq, vc_req, desc, VHOST_ACCESS_RO);
 			rsa->message.length = req->u.akcipher_req.para.dst_data_len;
 			desc += 1;
 		} else {
@@ -1459,7 +1462,7 @@ prepare_asym_rsa_op(struct vhost_crypto *vcrypto, struct rte_crypto_op *op,
 	op->type = RTE_CRYPTO_OP_TYPE_ASYMMETRIC;
 	op->sess_type = RTE_CRYPTO_OP_WITH_SESSION;
 
-	vc_req->inhdr = get_data_ptr(vc_req, desc, VHOST_ACCESS_WO);
+	vc_req->inhdr = get_data_ptr(vq, vc_req, desc, VHOST_ACCESS_WO);
 	if (unlikely(vc_req->inhdr == NULL)) {
 		ret = VIRTIO_CRYPTO_BADMSG;
 		goto error_exit;
@@ -1484,7 +1487,7 @@ vhost_crypto_process_one_req(struct vhost_crypto *vcrypto,
 		struct vhost_virtqueue *vq, struct rte_crypto_op *op,
 		struct vring_desc *head, struct vhost_crypto_desc *descs,
 		uint16_t desc_idx)
-	__rte_requires_shared_capability(vq->iotlb_lock)
+	__rte_requires_shared_capability(&vq->iotlb_lock)
 {
 	struct vhost_crypto_data_req *vc_req, *vc_req_out;
 	struct rte_cryptodev_asym_session *asym_session;
@@ -1617,18 +1620,14 @@ vhost_crypto_process_one_req(struct vhost_crypto *vcrypto,
 			err = VIRTIO_CRYPTO_NOTSUPP;
 			break;
 		case VIRTIO_CRYPTO_SYM_OP_CIPHER:
-			vhost_user_iotlb_rd_lock(vc_req_out->vq);
-			err = prepare_sym_cipher_op(vcrypto, op, vc_req_out,
+			err = prepare_sym_cipher_op(vcrypto, op, vq, vc_req_out,
 					&req.u.sym_req.u.cipher, desc,
 					max_n_descs);
-			vhost_user_iotlb_rd_unlock(vc_req_out->vq);
 			break;
 		case VIRTIO_CRYPTO_SYM_OP_ALGORITHM_CHAINING:
-			vhost_user_iotlb_rd_lock(vc_req_out->vq);
-			err = prepare_sym_chain_op(vcrypto, op, vc_req_out,
+			err = prepare_sym_chain_op(vcrypto, op, vq, vc_req_out,
 					&req.u.sym_req.u.chain, desc,
 					max_n_descs);
-			vhost_user_iotlb_rd_unlock(vc_req_out->vq);
 			break;
 		}
 		if (unlikely(err != 0)) {
@@ -1673,10 +1672,8 @@ vhost_crypto_process_one_req(struct vhost_crypto *vcrypto,
 
 		switch (req.header.algo) {
 		case VIRTIO_CRYPTO_AKCIPHER_RSA:
-			vhost_user_iotlb_rd_lock(vc_req_out->vq);
-			err = prepare_asym_rsa_op(vcrypto, op, vc_req_out,
+			err = prepare_asym_rsa_op(vcrypto, op, vq, vc_req_out,
 					&req, desc, max_n_descs);
-			vhost_user_iotlb_rd_unlock(vc_req_out->vq);
 			break;
 		}
 		if (unlikely(err != 0)) {
@@ -1750,7 +1747,7 @@ vhost_crypto_finalize_one_request(struct rte_crypto_op *op,
 			rte_mempool_put(m_dst->pool, (void *)m_dst);
 	}
 
-	return vc_req->vq;
+	return vq;
 }
 
 static __rte_always_inline uint16_t
-- 
2.48.1

