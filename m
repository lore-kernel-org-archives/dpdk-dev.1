Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBEAAC54F30
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 May 2025 11:04:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 294A940E13;
	Tue, 27 May 2025 13:02:59 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id C6DF840E0F
 for <dev@dpdk.org>; Tue, 27 May 2025 13:02:57 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54R5RoIw007252
 for <dev@dpdk.org>; Tue, 27 May 2025 04:02:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=Q
 ml/8TwvXOnvKq/mqVE2LKe+EvvLOP9Z2flRHsjSRWM=; b=VVvfqRO3GIzUGu2+N
 RtH3EEjk5P7s3drBg6NwwEMTFIB2GKxLy6ETh4aSo1yh4UebrZ7bY8mbhjtd6BTt
 LlZM9d3KTxIuDMUy9NJZ1ueR7jgMFXfx91KnlQxCW2IXGQZA0n5+Rp3NmkXKzPlZ
 A5V3ZiWcgOFw3lRrBLLpyRW/cew+nXDlXBt1UxbjzXqgjws9/0xfhtvuTxC0yziI
 Ga7SjJviMjx9A9mNetr23XjWYviQ+yghNAOhdBwWHsIn+6gYQjM8oDRKvC9aTrOI
 IDoPS4wMBWyDXwXwD/mNG9p1T8q0fh3uStOqhUf9205MJyKHXNWG9kwxKHEkAxG9
 OK1IA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 46w78q8jdb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Tue, 27 May 2025 04:02:56 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 27 May 2025 04:02:55 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 27 May 2025 04:02:55 -0700
Received: from hyd1554.caveonetworks.com (unknown [10.29.56.32])
 by maili.marvell.com (Postfix) with ESMTP id EB24C3F7061;
 Tue, 27 May 2025 04:02:53 -0700 (PDT)
From: Tejasree Kondoj <ktejasree@marvell.com>
To: Akhil Goyal <gakhil@marvell.com>
CC: Vidya Sagar Velumuri <vvelumuri@marvell.com>, Anoob Joseph
 <anoobj@marvell.com>, <dev@dpdk.org>
Subject: [PATCH 20/25] crypto/cnxk: add enq and dequeue support for TLS
Date: Tue, 27 May 2025 16:32:00 +0530
Message-ID: <20250527110205.2300800-21-ktejasree@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250527110205.2300800-1-ktejasree@marvell.com>
References: <20250527110205.2300800-1-ktejasree@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: Ovkz-rV1nCKN5qucF6nViYZJfGUdbP8A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI3MDA5MCBTYWx0ZWRfX6oV7F99rJuNW
 lVQesIMP1cgYwZ/ux5CH7j2v4cVGTkGRKzSZsS71c+g5goIj6ltLSk9O5s3FS2q8L79nCLDjth1
 UUwPvZxOi9G96vuDkYImmhma9WWbFFI0Z/r112QUqPx11tBY1a3uX4cCUyVu4hw968jOueA7aMy
 1BJOOsZ0OjAUT3XWTZfgGwkfD11YcQelt0N2ACxjqEaNTDSqvao+O+rk+ATr+VjQ7NMxMBzpYnx
 xYpIdMqZPbnEJ17nfuMRhAXpzEFpMk5JxLej33JAa/6HyK0eREm6mGSeklNqInY+5hLahWB0zNE
 K8nTjdNpNTzGealnsVL4IHAnOQc8jbTMBa9KMkDA8hth3aZSKO33oLeL0QhR3h4Rg5Pj80R0ROV
 f5cEkPB7qjZvSEV8LBoTtA7PtxzrF0o8UZ78nlznD8qhsXHo73ow+PyJV+IovEXpRljMXNyB
X-Proofpoint-ORIG-GUID: Ovkz-rV1nCKN5qucF6nViYZJfGUdbP8A
X-Authority-Analysis: v=2.4 cv=ZuLtK87G c=1 sm=1 tr=0 ts=68359be1 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=aWxl6RcaphiAd3Pw21cA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-27_05,2025-05-27_01,2025-03-28_01
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

From: Vidya Sagar Velumuri <vvelumuri@marvell.com>

Add enqueue and dequeue support for TLS for cn20k

Signed-off-by: Vidya Sagar Velumuri <vvelumuri@marvell.com>
---
 drivers/crypto/cnxk/cn20k_cryptodev_ops.c |  14 ++
 drivers/crypto/cnxk/cn20k_tls_ops.h       | 250 ++++++++++++++++++++++
 2 files changed, 264 insertions(+)
 create mode 100644 drivers/crypto/cnxk/cn20k_tls_ops.h

diff --git a/drivers/crypto/cnxk/cn20k_cryptodev_ops.c b/drivers/crypto/cnxk/cn20k_cryptodev_ops.c
index 60933c4305..7d8b17b418 100644
--- a/drivers/crypto/cnxk/cn20k_cryptodev_ops.c
+++ b/drivers/crypto/cnxk/cn20k_cryptodev_ops.c
@@ -16,6 +16,7 @@
 #include "cn20k_cryptodev_ops.h"
 #include "cn20k_cryptodev_sec.h"
 #include "cn20k_ipsec_la_ops.h"
+#include "cn20k_tls_ops.h"
 #include "cnxk_ae.h"
 #include "cnxk_cryptodev.h"
 #include "cnxk_cryptodev_ops.h"
@@ -86,6 +87,17 @@ cpt_sec_ipsec_inst_fill(struct cnxk_cpt_qp *qp, struct rte_crypto_op *op,
 	return ret;
 }
 
+static __rte_always_inline int __rte_hot
+cpt_sec_tls_inst_fill(struct cnxk_cpt_qp *qp, struct rte_crypto_op *op,
+		      struct cn20k_sec_session *sess, struct cpt_inst_s *inst,
+		      struct cpt_inflight_req *infl_req)
+{
+	if (sess->tls_opt.is_write)
+		return process_tls_write(&qp->lf, op, sess, &qp->meta_info, infl_req, inst);
+	else
+		return process_tls_read(op, sess, &qp->meta_info, infl_req, inst);
+}
+
 static __rte_always_inline int __rte_hot
 cpt_sec_inst_fill(struct cnxk_cpt_qp *qp, struct rte_crypto_op *op, struct cn20k_sec_session *sess,
 		  struct cpt_inst_s *inst, struct cpt_inflight_req *infl_req)
@@ -93,6 +105,8 @@ cpt_sec_inst_fill(struct cnxk_cpt_qp *qp, struct rte_crypto_op *op, struct cn20k
 
 	if (sess->proto == RTE_SECURITY_PROTOCOL_IPSEC)
 		return cpt_sec_ipsec_inst_fill(qp, op, sess, &inst[0], infl_req);
+	else if (sess->proto == RTE_SECURITY_PROTOCOL_TLS_RECORD)
+		return cpt_sec_tls_inst_fill(qp, op, sess, &inst[0], infl_req);
 
 	return 0;
 }
diff --git a/drivers/crypto/cnxk/cn20k_tls_ops.h b/drivers/crypto/cnxk/cn20k_tls_ops.h
new file mode 100644
index 0000000000..14f879f2a9
--- /dev/null
+++ b/drivers/crypto/cnxk/cn20k_tls_ops.h
@@ -0,0 +1,250 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(C) 2025 Marvell.
+ */
+
+#ifndef __CN20K_TLS_OPS_H__
+#define __CN20K_TLS_OPS_H__
+
+#include <rte_crypto_sym.h>
+#include <rte_security.h>
+
+#include "roc_ie.h"
+
+#include "cn20k_cryptodev.h"
+#include "cn20k_cryptodev_sec.h"
+#include "cnxk_cryptodev.h"
+#include "cnxk_cryptodev_ops.h"
+#include "cnxk_sg.h"
+
+static __rte_always_inline int
+process_tls_write(struct roc_cpt_lf *lf, struct rte_crypto_op *cop, struct cn20k_sec_session *sess,
+		  struct cpt_qp_meta_info *m_info, struct cpt_inflight_req *infl_req,
+		  struct cpt_inst_s *inst)
+{
+	struct cn20k_tls_opt tls_opt = sess->tls_opt;
+	struct rte_crypto_sym_op *sym_op = cop->sym;
+#ifdef LA_IPSEC_DEBUG
+	struct roc_ie_ow_tls_write_sa *write_sa;
+#endif
+	struct rte_mbuf *m_src = sym_op->m_src;
+	struct rte_mbuf *m_dst = sym_op->m_dst;
+	uint32_t pad_len, pad_bytes;
+	struct rte_mbuf *last_seg;
+	union cpt_inst_w4 w4;
+	void *m_data = NULL;
+	uint8_t *in_buffer;
+
+	pad_bytes = (cop->aux_flags * 8) > 0xff ? 0xff : (cop->aux_flags * 8);
+	pad_len = (pad_bytes >> tls_opt.pad_shift) * tls_opt.enable_padding;
+
+#ifdef LA_IPSEC_DEBUG
+	write_sa = &sess->tls_rec.write_sa;
+	if (write_sa->w2.s.iv_at_cptr == ROC_IE_OW_TLS_IV_SRC_FROM_SA) {
+
+		uint8_t *iv = PLT_PTR_ADD(write_sa->cipher_key, 32);
+
+		if (write_sa->w2.s.cipher_select == ROC_IE_OW_TLS_CIPHER_AES_GCM) {
+			uint32_t *tmp;
+
+			/* For GCM, the IV and salt format will be like below:
+			 * iv[0-3]: lower bytes of IV in BE format.
+			 * iv[4-7]: salt / nonce.
+			 * iv[12-15]: upper bytes of IV in BE format.
+			 */
+			memcpy(iv, rte_crypto_op_ctod_offset(cop, uint8_t *, sess->iv_offset), 4);
+			tmp = (uint32_t *)iv;
+			*tmp = rte_be_to_cpu_32(*tmp);
+
+			memcpy(iv + 12,
+			       rte_crypto_op_ctod_offset(cop, uint8_t *, sess->iv_offset + 4), 4);
+			tmp = (uint32_t *)(iv + 12);
+			*tmp = rte_be_to_cpu_32(*tmp);
+		} else if (write_sa->w2.s.cipher_select == ROC_IE_OW_TLS_CIPHER_AES_CBC) {
+			uint64_t *tmp;
+
+			memcpy(iv, rte_crypto_op_ctod_offset(cop, uint8_t *, sess->iv_offset), 16);
+			tmp = (uint64_t *)iv;
+			*tmp = rte_be_to_cpu_64(*tmp);
+			tmp = (uint64_t *)(iv + 8);
+			*tmp = rte_be_to_cpu_64(*tmp);
+		} else if (write_sa->w2.s.cipher_select == ROC_IE_OW_TLS_CIPHER_3DES) {
+			uint64_t *tmp;
+
+			memcpy(iv, rte_crypto_op_ctod_offset(cop, uint8_t *, sess->iv_offset), 8);
+			tmp = (uint64_t *)iv;
+			*tmp = rte_be_to_cpu_64(*tmp);
+		}
+
+		/* Trigger CTX reload to fetch new data from DRAM */
+		roc_cpt_lf_ctx_reload(lf, write_sa);
+		rte_delay_ms(1);
+	}
+#else
+	RTE_SET_USED(lf);
+#endif
+	/* Single buffer direct mode */
+	if (likely(m_src->next == NULL)) {
+		void *vaddr;
+
+		if (unlikely(rte_pktmbuf_tailroom(m_src) < sess->max_extended_len)) {
+			plt_dp_err("Not enough tail room");
+			return -ENOMEM;
+		}
+
+		vaddr = rte_pktmbuf_mtod(m_src, void *);
+		inst->dptr = (uint64_t)vaddr;
+		inst->rptr = (uint64_t)vaddr;
+
+		w4.u64 = sess->inst.w4;
+		w4.s.param1 = m_src->data_len;
+		w4.s.dlen = m_src->data_len;
+
+		w4.s.param2 = cop->param1.tls_record.content_type;
+		w4.s.opcode_minor = pad_len;
+
+		inst->w4.u64 = w4.u64;
+	} else {
+		struct roc_sg2list_comp *scatter_comp, *gather_comp;
+		union cpt_inst_w5 cpt_inst_w5;
+		union cpt_inst_w6 cpt_inst_w6;
+		uint32_t g_size_bytes;
+		int i;
+
+		last_seg = rte_pktmbuf_lastseg(m_src);
+
+		if (unlikely(rte_pktmbuf_tailroom(last_seg) < sess->max_extended_len)) {
+			plt_dp_err("Not enough tail room (required: %d, available: %d)",
+				   sess->max_extended_len, rte_pktmbuf_tailroom(last_seg));
+			return -ENOMEM;
+		}
+
+		m_data = alloc_op_meta(NULL, m_info->mlen, m_info->pool, infl_req);
+		if (unlikely(m_data == NULL)) {
+			plt_dp_err("Error allocating meta buffer for request");
+			return -ENOMEM;
+		}
+
+		in_buffer = (uint8_t *)m_data;
+		/* Input Gather List */
+		i = 0;
+		gather_comp = (struct roc_sg2list_comp *)((uint8_t *)in_buffer);
+		i = fill_sg2_comp_from_pkt(gather_comp, i, m_src);
+
+		cpt_inst_w5.s.gather_sz = ((i + 2) / 3);
+		g_size_bytes = ((i + 2) / 3) * sizeof(struct roc_sg2list_comp);
+
+		/* Output Scatter List */
+		last_seg->data_len += sess->max_extended_len + pad_bytes;
+		i = 0;
+		scatter_comp = (struct roc_sg2list_comp *)((uint8_t *)gather_comp + g_size_bytes);
+
+		if (m_dst == NULL)
+			m_dst = m_src;
+		i = fill_sg2_comp_from_pkt(scatter_comp, i, m_dst);
+
+		cpt_inst_w6.s.scatter_sz = ((i + 2) / 3);
+
+		cpt_inst_w5.s.dptr = (uint64_t)gather_comp;
+		cpt_inst_w6.s.rptr = (uint64_t)scatter_comp;
+
+		inst->w5.u64 = cpt_inst_w5.u64;
+		inst->w6.u64 = cpt_inst_w6.u64;
+		w4.u64 = sess->inst.w4;
+		w4.s.dlen = rte_pktmbuf_pkt_len(m_src);
+		w4.s.opcode_major &= (~(ROC_IE_OW_INPLACE_BIT));
+		w4.s.opcode_minor = pad_len;
+		w4.s.param1 = w4.s.dlen;
+		w4.s.param2 = cop->param1.tls_record.content_type;
+		inst->w4.u64 = w4.u64;
+	}
+
+	return 0;
+}
+
+static __rte_always_inline int
+process_tls_read(struct rte_crypto_op *cop, struct cn20k_sec_session *sess,
+		 struct cpt_qp_meta_info *m_info, struct cpt_inflight_req *infl_req,
+		 struct cpt_inst_s *inst)
+{
+	struct rte_crypto_sym_op *sym_op = cop->sym;
+	struct rte_mbuf *m_src = sym_op->m_src;
+	struct rte_mbuf *m_dst = sym_op->m_dst;
+	union cpt_inst_w4 w4;
+	uint8_t *in_buffer;
+	void *m_data;
+
+	if (likely(m_src->next == NULL)) {
+		void *vaddr;
+
+		vaddr = rte_pktmbuf_mtod(m_src, void *);
+
+		inst->dptr = (uint64_t)vaddr;
+		inst->rptr = (uint64_t)vaddr;
+
+		w4.u64 = sess->inst.w4;
+		w4.s.dlen = m_src->data_len;
+		w4.s.param1 = m_src->data_len;
+		inst->w4.u64 = w4.u64;
+	} else {
+		struct roc_sg2list_comp *scatter_comp, *gather_comp;
+		int tail_len = sess->tls_opt.tail_fetch_len * 16;
+		int pkt_len = rte_pktmbuf_pkt_len(m_src);
+		union cpt_inst_w5 cpt_inst_w5;
+		union cpt_inst_w6 cpt_inst_w6;
+		uint32_t g_size_bytes;
+		int i;
+
+		m_data = alloc_op_meta(NULL, m_info->mlen, m_info->pool, infl_req);
+		if (unlikely(m_data == NULL)) {
+			plt_dp_err("Error allocating meta buffer for request");
+			return -ENOMEM;
+		}
+
+		in_buffer = (uint8_t *)m_data;
+		/* Input Gather List */
+		i = 0;
+
+		/* First 32 bytes in m_data are rsvd for tail fetch.
+		 * SG list start from 32 byte onwards.
+		 */
+		gather_comp = (struct roc_sg2list_comp *)((uint8_t *)(in_buffer + 32));
+
+		/* Add the last blocks as first gather component for tail fetch. */
+		if (tail_len) {
+			const uint8_t *output;
+
+			output = rte_pktmbuf_read(m_src, pkt_len - tail_len, tail_len, in_buffer);
+			if (output != in_buffer)
+				rte_memcpy(in_buffer, output, tail_len);
+			i = fill_sg2_comp(gather_comp, i, (uint64_t)in_buffer, tail_len);
+		}
+
+		i = fill_sg2_comp_from_pkt(gather_comp, i, m_src);
+
+		cpt_inst_w5.s.gather_sz = ((i + 2) / 3);
+		g_size_bytes = ((i + 2) / 3) * sizeof(struct roc_sg2list_comp);
+
+		i = 0;
+		scatter_comp = (struct roc_sg2list_comp *)((uint8_t *)gather_comp + g_size_bytes);
+
+		if (m_dst == NULL)
+			m_dst = m_src;
+		i = fill_sg2_comp_from_pkt(scatter_comp, i, m_dst);
+
+		cpt_inst_w6.s.scatter_sz = ((i + 2) / 3);
+
+		cpt_inst_w5.s.dptr = (uint64_t)gather_comp;
+		cpt_inst_w6.s.rptr = (uint64_t)scatter_comp;
+
+		inst->w5.u64 = cpt_inst_w5.u64;
+		inst->w6.u64 = cpt_inst_w6.u64;
+		w4.u64 = sess->inst.w4;
+		w4.s.dlen = pkt_len + tail_len;
+		w4.s.param1 = w4.s.dlen;
+		w4.s.opcode_major &= (~(ROC_IE_OW_INPLACE_BIT));
+		inst->w4.u64 = w4.u64;
+	}
+
+	return 0;
+}
+#endif /* __CN20K_TLS_OPS_H__ */
-- 
2.25.1

