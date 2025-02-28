Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3084C19776
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Feb 2025 13:47:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BF0E640E49;
	Fri, 28 Feb 2025 14:47:36 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 1C9C540609
 for <dev@dpdk.org>; Fri, 28 Feb 2025 14:47:35 +0100 (CET)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51SB10qJ021859;
 Fri, 28 Feb 2025 05:47:34 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=s
 DQWI0Bz1vBgpXKlLweOAiWU6TjT3rIXB3IsdANx4Qg=; b=OqM5c0MJnpQtOhOBP
 6WdLsafuNIiKs8C4whWmDtOVyVSX72gZ1mz05KlAiYodct1pqZDSBlUOqmR+fCX2
 VxPMbVwo4XLSNPbo49cCsuDzAnje8o4VB0gRHyeWnWaMuXlW3Pe2FrynqKhdoS4r
 V/QISSEvehBrthyE1GHVjyOKECfs1wpl81vda5QSRuJ0LRPzUkmlENnmHBvsJOSp
 F/j8mSKOguLw7qqFo0+nkpSTwQog7g86OdYvf0ZUzf7+U5uOmm7TSbkcviD8aZYn
 O+VJTYqZ6y4RLoHVpIYzS2G0ogzXhSMbSECdeMuaYLwDDdrkrHHTGbPMt+gjYVVZ
 EGc4g==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 453bgw884x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 28 Feb 2025 05:47:34 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 28 Feb 2025 05:47:33 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 28 Feb 2025 05:47:33 -0800
Received: from IN-lckQE5Rwctls.marvell.com (unknown [10.28.163.68])
 by maili.marvell.com (Postfix) with ESMTP id 9F4C45B692E;
 Fri, 28 Feb 2025 05:47:30 -0800 (PST)
From: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
To: <dev@dpdk.org>, <maxime.coquelin@redhat.com>, Chenbo Xia
 <chenbox@nvidia.com>
CC: <anoobj@marvell.com>, Akhil Goyal <gakhil@marvell.com>, David Marchand
 <david.marchand@redhat.com>, Gowrishankar Muthukrishnan
 <gmuthukrishn@marvell.com>
Subject: [v9 1/6] vhost: fix thread safety checks for vhost crypto data req
Date: Fri, 28 Feb 2025 19:17:08 +0530
Message-ID: <7aff12586d4a2091e983e7d434bbb0d7b1957ae1.1740749809.git.gmuthukrishn@marvell.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <cover.1740749809.git.gmuthukrishn@marvell.com>
References: <cover.1740749809.git.gmuthukrishn@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=ZMQtmW7b c=1 sm=1 tr=0 ts=67c1be76 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=T2h4t0Lz3GQA:10 a=M5GUcnROAAAA:8 a=Ikwak4bsxmfBAixrw6QA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: -Y817qHlozCYY1RHH-4JV7nYJGwU_MxO
X-Proofpoint-GUID: -Y817qHlozCYY1RHH-4JV7nYJGwU_MxO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-28_03,2025-02-27_01,2024-11-22_01
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

For thread safety check to succeed (as in clang), calling function
should ensure vq->iotlb_lock locked before passing vq to a function
that has thread safety attribute, in vhost crypto implementation.

When vhost_crypto_data_req is local and its vq is pointer to a
locked vq, clang does not recognise this inherited lock and
stops compilation. This patch explicitly uses vhost_virtqueue
where ever required and fulfills thread safety checks.

Signed-off-by: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
---
 lib/vhost/vhost_crypto.c | 76 ++++++++++++++++++++++------------------
 1 file changed, 41 insertions(+), 35 deletions(-)

diff --git a/lib/vhost/vhost_crypto.c b/lib/vhost/vhost_crypto.c
index 3dc41a3bd5..4c36df9cb2 100644
--- a/lib/vhost/vhost_crypto.c
+++ b/lib/vhost/vhost_crypto.c
@@ -43,8 +43,8 @@ RTE_LOG_REGISTER_SUFFIX(vhost_crypto_logtype, crypto, INFO);
 		(1ULL << VIRTIO_F_VERSION_1) |				\
 		(1ULL << VHOST_USER_F_PROTOCOL_FEATURES))
 
-#define IOVA_TO_VVA(t, r, a, l, p)					\
-	((t)(uintptr_t)vhost_iova_to_vva(r->dev, r->vq, a, l, p))
+#define IOVA_TO_VVA(t, dev, vq, a, l, p)				\
+	((t)(uintptr_t)vhost_iova_to_vva(dev, vq, a, l, p))
 
 /*
  * vhost_crypto_desc is used to copy original vring_desc to the local buffer
@@ -488,10 +488,10 @@ find_write_desc(struct vhost_crypto_desc *head, struct vhost_crypto_desc *desc,
 }
 
 static __rte_always_inline struct virtio_crypto_inhdr *
-reach_inhdr(struct vhost_crypto_data_req *vc_req,
+reach_inhdr(struct virtio_net *dev, struct vhost_virtqueue *vq,
 		struct vhost_crypto_desc *head,
 		uint32_t max_n_descs)
-	__rte_requires_shared_capability(&vc_req->vq->iotlb_lock)
+	__rte_requires_shared_capability(vq->iotlb_lock)
 {
 	struct virtio_crypto_inhdr *inhdr;
 	struct vhost_crypto_desc *last = head + (max_n_descs - 1);
@@ -500,8 +500,8 @@ reach_inhdr(struct vhost_crypto_data_req *vc_req,
 	if (unlikely(dlen != sizeof(*inhdr)))
 		return NULL;
 
-	inhdr = IOVA_TO_VVA(struct virtio_crypto_inhdr *, vc_req, last->addr,
-			&dlen, VHOST_ACCESS_WO);
+	inhdr = IOVA_TO_VVA(struct virtio_crypto_inhdr *, dev, vq,
+			last->addr, &dlen, VHOST_ACCESS_WO);
 	if (unlikely(!inhdr || dlen != last->len))
 		return NULL;
 
@@ -543,7 +543,8 @@ get_data_ptr(struct vhost_crypto_data_req *vc_req,
 	void *data;
 	uint64_t dlen = cur_desc->len;
 
-	data = IOVA_TO_VVA(void *, vc_req, cur_desc->addr, &dlen, perm);
+	data = IOVA_TO_VVA(void *, vc_req->dev, vc_req->vq,
+			cur_desc->addr, &dlen, perm);
 	if (unlikely(!data || dlen != cur_desc->len)) {
 		VC_LOG_ERR("Failed to map object");
 		return NULL;
@@ -553,9 +554,9 @@ get_data_ptr(struct vhost_crypto_data_req *vc_req,
 }
 
 static __rte_always_inline uint32_t
-copy_data_from_desc(void *dst, struct vhost_crypto_data_req *vc_req,
-	struct vhost_crypto_desc *desc, uint32_t size)
-	__rte_requires_shared_capability(&vc_req->vq->iotlb_lock)
+copy_data_from_desc(void *dst, struct virtio_net *dev,
+	struct vhost_virtqueue *vq, struct vhost_crypto_desc *desc, uint32_t size)
+	__rte_requires_shared_capability(vq->iotlb_lock)
 {
 	uint64_t remain;
 	uint64_t addr;
@@ -567,7 +568,8 @@ copy_data_from_desc(void *dst, struct vhost_crypto_data_req *vc_req,
 		void *src;
 
 		len = remain;
-		src = IOVA_TO_VVA(void *, vc_req, addr, &len, VHOST_ACCESS_RO);
+		src = IOVA_TO_VVA(void *, dev, vq,
+				addr, &len, VHOST_ACCESS_RO);
 		if (unlikely(src == NULL || len == 0))
 			return 0;
 
@@ -583,10 +585,10 @@ copy_data_from_desc(void *dst, struct vhost_crypto_data_req *vc_req,
 
 
 static __rte_always_inline int
-copy_data(void *data, struct vhost_crypto_data_req *vc_req,
+copy_data(void *data, struct virtio_net *dev, struct vhost_virtqueue *vq,
 	struct vhost_crypto_desc *head, struct vhost_crypto_desc **cur_desc,
 	uint32_t size, uint32_t max_n_descs)
-	__rte_requires_shared_capability(&vc_req->vq->iotlb_lock)
+	__rte_requires_shared_capability(vq->iotlb_lock)
 {
 	struct vhost_crypto_desc *desc = *cur_desc;
 	uint32_t left = size;
@@ -594,7 +596,7 @@ copy_data(void *data, struct vhost_crypto_data_req *vc_req,
 	do {
 		uint32_t copied;
 
-		copied = copy_data_from_desc(data, vc_req, desc, left);
+		copied = copy_data_from_desc(data, dev, vq, desc, left);
 		if (copied == 0)
 			return -1;
 		left -= copied;
@@ -689,8 +691,8 @@ prepare_write_back_data(struct vhost_crypto_data_req *vc_req,
 	if (likely(desc->len > offset)) {
 		wb_data->src = src + offset;
 		dlen = desc->len;
-		dst = IOVA_TO_VVA(uint8_t *, vc_req, desc->addr,
-			&dlen, VHOST_ACCESS_RW);
+		dst = IOVA_TO_VVA(uint8_t *, vc_req->dev, vc_req->vq,
+			desc->addr, &dlen, VHOST_ACCESS_RW);
 		if (unlikely(!dst || dlen != desc->len)) {
 			VC_LOG_ERR("Failed to map descriptor");
 			goto error_exit;
@@ -731,8 +733,8 @@ prepare_write_back_data(struct vhost_crypto_data_req *vc_req,
 		}
 
 		dlen = desc->len;
-		dst = IOVA_TO_VVA(uint8_t *, vc_req, desc->addr, &dlen,
-				VHOST_ACCESS_RW) + offset;
+		dst = IOVA_TO_VVA(uint8_t *, vc_req->dev, vc_req->vq,
+				desc->addr, &dlen, VHOST_ACCESS_RW) + offset;
 		if (unlikely(dst == NULL || dlen != desc->len)) {
 			VC_LOG_ERR("Failed to map descriptor");
 			goto error_exit;
@@ -804,7 +806,7 @@ prepare_sym_cipher_op(struct vhost_crypto *vcrypto, struct rte_crypto_op *op,
 
 	/* prepare */
 	/* iv */
-	if (unlikely(copy_data(iv_data, vc_req, head, &desc,
+	if (unlikely(copy_data(iv_data, vcrypto->dev, vc_req->vq, head, &desc,
 			cipher->para.iv_len, max_n_descs))) {
 		VC_LOG_ERR("Incorrect virtio descriptor");
 		ret = VIRTIO_CRYPTO_BADMSG;
@@ -835,8 +837,8 @@ prepare_sym_cipher_op(struct vhost_crypto *vcrypto, struct rte_crypto_op *op,
 		vc_req->wb_pool = vcrypto->wb_pool;
 		m_src->data_len = cipher->para.src_data_len;
 		if (unlikely(copy_data(rte_pktmbuf_mtod(m_src, uint8_t *),
-				vc_req, head, &desc, cipher->para.src_data_len,
-				max_n_descs) < 0)) {
+				vcrypto->dev, vc_req->vq, head, &desc,
+				cipher->para.src_data_len, max_n_descs) < 0)) {
 			VC_LOG_ERR("Incorrect virtio descriptor");
 			ret = VIRTIO_CRYPTO_BADMSG;
 			goto error_exit;
@@ -960,7 +962,7 @@ prepare_sym_chain_op(struct vhost_crypto *vcrypto, struct rte_crypto_op *op,
 
 	/* prepare */
 	/* iv */
-	if (unlikely(copy_data(iv_data, vc_req, head, &desc,
+	if (unlikely(copy_data(iv_data, vcrypto->dev, vc_req->vq, head, &desc,
 			chain->para.iv_len, max_n_descs) < 0)) {
 		VC_LOG_ERR("Incorrect virtio descriptor");
 		ret = VIRTIO_CRYPTO_BADMSG;
@@ -992,8 +994,8 @@ prepare_sym_chain_op(struct vhost_crypto *vcrypto, struct rte_crypto_op *op,
 		vc_req->wb_pool = vcrypto->wb_pool;
 		m_src->data_len = chain->para.src_data_len;
 		if (unlikely(copy_data(rte_pktmbuf_mtod(m_src, uint8_t *),
-				vc_req, head, &desc, chain->para.src_data_len,
-				max_n_descs) < 0)) {
+				vcrypto->dev, vc_req->vq, head, &desc,
+				chain->para.src_data_len, max_n_descs) < 0)) {
 			VC_LOG_ERR("Incorrect virtio descriptor");
 			ret = VIRTIO_CRYPTO_BADMSG;
 			goto error_exit;
@@ -1076,8 +1078,8 @@ prepare_sym_chain_op(struct vhost_crypto *vcrypto, struct rte_crypto_op *op,
 			goto error_exit;
 		}
 
-		if (unlikely(copy_data(digest_addr, vc_req, head, &digest_desc,
-				chain->para.hash_result_len,
+		if (unlikely(copy_data(digest_addr, vcrypto->dev, vc_req->vq, head,
+				&digest_desc, chain->para.hash_result_len,
 				max_n_descs) < 0)) {
 			VC_LOG_ERR("Incorrect virtio descriptor");
 			ret = VIRTIO_CRYPTO_BADMSG;
@@ -1131,7 +1133,7 @@ vhost_crypto_process_one_req(struct vhost_crypto *vcrypto,
 		struct vhost_virtqueue *vq, struct rte_crypto_op *op,
 		struct vring_desc *head, struct vhost_crypto_desc *descs,
 		uint16_t desc_idx)
-	__rte_no_thread_safety_analysis /* FIXME: requires iotlb_lock? */
+	__rte_requires_shared_capability(vq->iotlb_lock)
 {
 	struct vhost_crypto_data_req *vc_req = rte_mbuf_to_priv(op->sym->m_src);
 	struct rte_cryptodev_sym_session *session;
@@ -1154,8 +1156,8 @@ vhost_crypto_process_one_req(struct vhost_crypto *vcrypto,
 	}
 
 	dlen = head->len;
-	src_desc = IOVA_TO_VVA(struct vring_desc *, vc_req, head->addr,
-			&dlen, VHOST_ACCESS_RO);
+	src_desc = IOVA_TO_VVA(struct vring_desc *, vc_req->dev, vq,
+			head->addr, &dlen, VHOST_ACCESS_RO);
 	if (unlikely(!src_desc || dlen != head->len)) {
 		VC_LOG_ERR("Invalid descriptor");
 		return -1;
@@ -1175,8 +1177,8 @@ vhost_crypto_process_one_req(struct vhost_crypto *vcrypto,
 			}
 			if (inhdr_desc->len != sizeof(*inhdr))
 				return -1;
-			inhdr = IOVA_TO_VVA(struct virtio_crypto_inhdr *,
-					vc_req, inhdr_desc->addr, &dlen,
+			inhdr = IOVA_TO_VVA(struct virtio_crypto_inhdr *, vc_req->dev,
+					vq, inhdr_desc->addr, &dlen,
 					VHOST_ACCESS_WO);
 			if (unlikely(!inhdr || dlen != inhdr_desc->len))
 				return -1;
@@ -1213,7 +1215,7 @@ vhost_crypto_process_one_req(struct vhost_crypto *vcrypto,
 		goto error_exit;
 	}
 
-	if (unlikely(copy_data(&req, vc_req, descs, &desc, sizeof(req),
+	if (unlikely(copy_data(&req, vcrypto->dev, vq, descs, &desc, sizeof(req),
 			max_n_descs) < 0)) {
 		err = VIRTIO_CRYPTO_BADMSG;
 		VC_LOG_ERR("Invalid descriptor");
@@ -1257,14 +1259,18 @@ vhost_crypto_process_one_req(struct vhost_crypto *vcrypto,
 			err = VIRTIO_CRYPTO_NOTSUPP;
 			break;
 		case VIRTIO_CRYPTO_SYM_OP_CIPHER:
-			err = prepare_sym_cipher_op(vcrypto, op, vc_req,
+			vhost_user_iotlb_rd_lock(vc_req_out->vq);
+			err = prepare_sym_cipher_op(vcrypto, op, vc_req_out,
 					&req.u.sym_req.u.cipher, desc,
 					max_n_descs);
+			vhost_user_iotlb_rd_unlock(vc_req_out->vq);
 			break;
 		case VIRTIO_CRYPTO_SYM_OP_ALGORITHM_CHAINING:
-			err = prepare_sym_chain_op(vcrypto, op, vc_req,
+			vhost_user_iotlb_rd_lock(vc_req_out->vq);
+			err = prepare_sym_chain_op(vcrypto, op, vc_req_out,
 					&req.u.sym_req.u.chain, desc,
 					max_n_descs);
+			vhost_user_iotlb_rd_unlock(vc_req_out->vq);
 			break;
 		}
 		if (unlikely(err != 0)) {
@@ -1283,7 +1289,7 @@ vhost_crypto_process_one_req(struct vhost_crypto *vcrypto,
 
 error_exit:
 
-	inhdr = reach_inhdr(vc_req, descs, max_n_descs);
+	inhdr = reach_inhdr(vc_req->dev, vq, descs, max_n_descs);
 	if (likely(inhdr != NULL))
 		inhdr->status = (uint8_t)err;
 
-- 
2.25.1

