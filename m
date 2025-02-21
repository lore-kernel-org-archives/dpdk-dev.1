Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43E5EC021B5
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Feb 2025 17:31:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2B3D242670;
	Fri, 21 Feb 2025 18:30:59 +0100 (CET)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id B6814410DF
 for <dev@dpdk.org>; Fri, 21 Feb 2025 18:30:57 +0100 (CET)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51L8OaC2019453;
 Fri, 21 Feb 2025 09:30:57 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=M
 naO4uWz9JWXkjavDgPNqF0nKbbxw2wnzEOSakwuGtY=; b=k+XTLv0UBJ6Y5jYio
 mCaN0nIfPBk4FTo2CYruszl6gc/shQGAdr3K32g/IHGRBFUghfGpvrZbBO+94C4+
 zmsY0G72AGfgbMkMnwk6nYCM6xFcwzu+T/eJ3hlnH0kyVHDNSd9YGcxfv4Gy8M4S
 c6mL0qAmfQps+/RZ4k1ATfLx07dGdqtYo8ZGvVHgTKmH1cOWI6BoJfkb4I/epxFl
 DvxZ1/xLMhHEDxpbiLxzUwHDU/peljXSDeYqWo8FBU6OTTkblumFfjDlk7djc5KX
 lGQ3tsIlRLN+qlo1Zq6gdKMUxgJg1vp5BICnlQaStwDAvIN7Wre9Y7g5lfr/Y8Eh
 XBTkg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 44xnxu91f7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 21 Feb 2025 09:30:56 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 21 Feb 2025 09:30:55 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 21 Feb 2025 09:30:55 -0800
Received: from IN-lckQE5Rwctls.marvell.com (unknown [10.193.66.72])
 by maili.marvell.com (Postfix) with ESMTP id DF0AC3F7090;
 Fri, 21 Feb 2025 09:30:52 -0800 (PST)
From: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
To: <dev@dpdk.org>, <maxime.coquelin@redhat.com>, Chenbo Xia
 <chenbox@nvidia.com>
CC: <anoobj@marvell.com>, Akhil Goyal <gakhil@marvell.com>, "Gowrishankar
 Muthukrishnan" <gmuthukrishn@marvell.com>
Subject: [v3 4/5] vhost: support asymmetric RSA crypto ops
Date: Fri, 21 Feb 2025 23:00:12 +0530
Message-ID: <caacd94d3905cad682eea4cc6838561b4dd4bbb2.1740156665.git.gmuthukrishn@marvell.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <cover.1740156665.git.gmuthukrishn@marvell.com>
References: <cover.1740156665.git.gmuthukrishn@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: yBJeJFkiQy_n6hcI0cRx6f1yq_xaFTvN
X-Proofpoint-ORIG-GUID: yBJeJFkiQy_n6hcI0cRx6f1yq_xaFTvN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-21_05,2025-02-20_02,2024-11-22_01
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

Support asymmetric RSA crypto operations in vhost-user.

Signed-off-by: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
---
v3:
 - TLV decode optimization for fast path.
 - virtio_crypto.h changes moved from virtio PMD patch series into this series
   as asymmetric support starts essentially from library.
---

 lib/vhost/vhost_crypto.c  | 492 +++++++++++++++++++++++++++++++++++---
 lib/vhost/virtio_crypto.h |  67 ++++++
 2 files changed, 524 insertions(+), 35 deletions(-)

diff --git a/lib/vhost/vhost_crypto.c b/lib/vhost/vhost_crypto.c
index 05f3c85884..9892603891 100644
--- a/lib/vhost/vhost_crypto.c
+++ b/lib/vhost/vhost_crypto.c
@@ -54,6 +54,14 @@ RTE_LOG_REGISTER_SUFFIX(vhost_crypto_logtype, crypto, INFO);
  */
 #define vhost_crypto_desc vring_desc
 
+struct vhost_crypto_session {
+	union {
+		struct rte_cryptodev_asym_session *asym;
+		struct rte_cryptodev_sym_session *sym;
+	};
+	enum rte_crypto_op_type type;
+};
+
 static int
 cipher_algo_transform(uint32_t virtio_cipher_algo,
 		enum rte_crypto_cipher_algorithm *algo)
@@ -206,8 +214,10 @@ struct __rte_cache_aligned vhost_crypto {
 
 	uint64_t last_session_id;
 
-	uint64_t cache_session_id;
-	struct rte_cryptodev_sym_session *cache_session;
+	uint64_t cache_sym_session_id;
+	struct rte_cryptodev_sym_session *cache_sym_session;
+	uint64_t cache_asym_session_id;
+	struct rte_cryptodev_asym_session *cache_asym_session;
 	/** socket id for the device */
 	int socket_id;
 
@@ -334,10 +344,11 @@ transform_chain_param(struct rte_crypto_sym_xform *xforms,
 }
 
 static void
-vhost_crypto_create_sess(struct vhost_crypto *vcrypto,
+vhost_crypto_create_sym_sess(struct vhost_crypto *vcrypto,
 		VhostUserCryptoSessionParam *sess_param)
 {
 	struct rte_crypto_sym_xform xform1 = {0}, xform2 = {0};
+	struct vhost_crypto_session *vhost_session;
 	struct rte_cryptodev_sym_session *session;
 	int ret;
 
@@ -384,42 +395,277 @@ vhost_crypto_create_sess(struct vhost_crypto *vcrypto,
 		return;
 	}
 
-	/* insert hash to map */
-	if (rte_hash_add_key_data(vcrypto->session_map,
-			&vcrypto->last_session_id, session) < 0) {
+	vhost_session = rte_zmalloc(NULL, sizeof(*vhost_session), 0);
+	if (vhost_session == NULL) {
+		VC_LOG_ERR("Failed to alloc session memory");
+		goto error_exit;
+	}
+
+	vhost_session->type = RTE_CRYPTO_OP_TYPE_SYMMETRIC;
+	vhost_session->sym = session;
+
+	/* insert session to map */
+	if ((rte_hash_add_key_data(vcrypto->session_map,
+		&vcrypto->last_session_id, vhost_session) < 0)) {
 		VC_LOG_ERR("Failed to insert session to hash table");
+		goto error_exit;
+	}
+
+	VC_LOG_INFO("Session %"PRIu64" created for vdev %i.",
+			vcrypto->last_session_id, vcrypto->dev->vid);
+
+	sess_param->session_id = vcrypto->last_session_id;
+	vcrypto->last_session_id++;
+	return;
+
+error_exit:
+	if (rte_cryptodev_sym_session_free(vcrypto->cid, session) < 0)
+		VC_LOG_ERR("Failed to free session");
+
+	sess_param->session_id = -VIRTIO_CRYPTO_ERR;
+	rte_free(vhost_session);
+}
+
+static int
+tlv_decode(uint8_t *tlv, uint8_t type, uint8_t **data, size_t *data_len)
+{
+	size_t tlen = -EINVAL, len;
+
+	if (tlv[0] != type)
+		return -EINVAL;
+
+	if (tlv[1] == 0x82) {
+		len = (tlv[2] << 8) | tlv[3];
+		*data = &tlv[4];
+		tlen = len + 4;
+	} else if (tlv[1] == 0x81) {
+		len = tlv[2];
+		*data = &tlv[3];
+		tlen = len + 3;
+	} else {
+		len = tlv[1];
+		*data = &tlv[2];
+		tlen = len + 2;
+	}
+
+	*data_len = len;
+	return tlen;
+}
+
+static int
+virtio_crypto_asym_rsa_der_to_xform(uint8_t *der, size_t der_len,
+		struct rte_crypto_asym_xform *xform)
+{
+	uint8_t *n = NULL, *e = NULL, *d = NULL, *p = NULL, *q = NULL, *dp = NULL,
+		*dq = NULL, *qinv = NULL, *v = NULL, *tlv;
+	size_t nlen, elen, dlen, plen, qlen, dplen, dqlen, qinvlen, vlen;
+	int len;
+
+	RTE_SET_USED(der_len);
+
+	if (der[0] != 0x30)
+		return -EINVAL;
+
+	if (der[1] == 0x82)
+		tlv = &der[4];
+	else if (der[1] == 0x81)
+		tlv = &der[3];
+	else
+		return -EINVAL;
+
+	len = tlv_decode(tlv, 0x02, &v, &vlen);
+	if (len < 0 || v[0] != 0x0 || vlen != 1)
+		return -EINVAL;
+
+	tlv = tlv + len;
+	len = tlv_decode(tlv, 0x02, &n, &nlen);
+	if (len < 0)
+		return len;
+
+	tlv = tlv + len;
+	len = tlv_decode(tlv, 0x02, &e, &elen);
+	if (len < 0)
+		return len;
+
+	tlv = tlv + len;
+	len = tlv_decode(tlv, 0x02, &d, &dlen);
+	if (len < 0)
+		return len;
+
+	tlv = tlv + len;
+	len = tlv_decode(tlv, 0x02, &p, &plen);
+	if (len < 0)
+		return len;
+
+	tlv = tlv + len;
+	len = tlv_decode(tlv, 0x02, &q, &qlen);
+	if (len < 0)
+		return len;
+
+	tlv = tlv + len;
+	len = tlv_decode(tlv, 0x02, &dp, &dplen);
+	if (len < 0)
+		return len;
+
+	tlv = tlv + len;
+	len = tlv_decode(tlv, 0x02, &dq, &dqlen);
+	if (len < 0)
+		return len;
+
+	tlv = tlv + len;
+	len = tlv_decode(tlv, 0x02, &qinv, &qinvlen);
+	if (len < 0)
+		return len;
+
+	xform->rsa.n.data = n;
+	xform->rsa.n.length = nlen;
+	xform->rsa.e.data = e;
+	xform->rsa.e.length = elen;
+	xform->rsa.d.data = d;
+	xform->rsa.d.length = dlen;
+	xform->rsa.qt.p.data = p;
+	xform->rsa.qt.p.length = plen;
+	xform->rsa.qt.q.data = q;
+	xform->rsa.qt.q.length = qlen;
+	xform->rsa.qt.dP.data = dp;
+	xform->rsa.qt.dP.length = dplen;
+	xform->rsa.qt.dQ.data = dq;
+	xform->rsa.qt.dQ.length = dqlen;
+	xform->rsa.qt.qInv.data = qinv;
+	xform->rsa.qt.qInv.length = qinvlen;
+
+	RTE_ASSERT((tlv + len - &der[0]) == der_len);
+	return 0;
+}
+
+static int
+rsa_param_transform(struct rte_crypto_asym_xform *xform,
+		VhostUserCryptoAsymSessionParam *param)
+{
+	int ret;
 
-		if (rte_cryptodev_sym_session_free(vcrypto->cid, session) < 0)
-			VC_LOG_ERR("Failed to free session");
+	ret = virtio_crypto_asym_rsa_der_to_xform(param->key_buf, param->key_len, xform);
+	if (ret < 0)
+		return ret;
+
+	switch (param->u.rsa.padding_algo) {
+	case VIRTIO_CRYPTO_RSA_RAW_PADDING:
+		xform->rsa.padding.type = RTE_CRYPTO_RSA_PADDING_NONE;
+		break;
+	case VIRTIO_CRYPTO_RSA_PKCS1_PADDING:
+		xform->rsa.padding.type = RTE_CRYPTO_RSA_PADDING_PKCS1_5;
+		break;
+	default:
+		VC_LOG_ERR("Unknown padding type");
+		return -EINVAL;
+	}
+
+	xform->rsa.key_type = RTE_RSA_KEY_TYPE_QT;
+	xform->xform_type = RTE_CRYPTO_ASYM_XFORM_RSA;
+	return 0;
+}
+
+static void
+vhost_crypto_create_asym_sess(struct vhost_crypto *vcrypto,
+		VhostUserCryptoSessionParam *sess_param)
+{
+	struct rte_cryptodev_asym_session *session = NULL;
+	struct vhost_crypto_session *vhost_session;
+	struct rte_crypto_asym_xform xform = {0};
+	int ret;
+
+	switch (sess_param->u.asym_sess.algo) {
+	case VIRTIO_CRYPTO_AKCIPHER_RSA:
+		ret = rsa_param_transform(&xform, &sess_param->u.asym_sess);
+		if (unlikely(ret < 0)) {
+			VC_LOG_ERR("Error transform session msg (%i)", ret);
+			sess_param->session_id = ret;
+			return;
+		}
+		break;
+	default:
+		VC_LOG_ERR("Invalid op algo");
 		sess_param->session_id = -VIRTIO_CRYPTO_ERR;
 		return;
 	}
 
+	ret = rte_cryptodev_asym_session_create(vcrypto->cid, &xform,
+		vcrypto->sess_pool, (void *)&session);
+	if (session == NULL) {
+		VC_LOG_ERR("Failed to create session");
+		sess_param->session_id = -VIRTIO_CRYPTO_ERR;
+		return;
+	}
+
+	vhost_session = rte_zmalloc(NULL, sizeof(*vhost_session), 0);
+	if (vhost_session == NULL) {
+		VC_LOG_ERR("Failed to alloc session memory");
+		goto error_exit;
+	}
+
+	vhost_session->type = RTE_CRYPTO_OP_TYPE_ASYMMETRIC;
+	vhost_session->asym = session;
+
+	/* insert session to map */
+	if ((rte_hash_add_key_data(vcrypto->session_map,
+			&vcrypto->last_session_id, vhost_session) < 0)) {
+		VC_LOG_ERR("Failed to insert session to hash table");
+		goto error_exit;
+	}
+
 	VC_LOG_INFO("Session %"PRIu64" created for vdev %i.",
 			vcrypto->last_session_id, vcrypto->dev->vid);
 
 	sess_param->session_id = vcrypto->last_session_id;
 	vcrypto->last_session_id++;
+	return;
+
+error_exit:
+	if (rte_cryptodev_asym_session_free(vcrypto->cid, session) < 0)
+		VC_LOG_ERR("Failed to free session");
+	sess_param->session_id = -VIRTIO_CRYPTO_ERR;
+	rte_free(vhost_session);
+}
+
+static void
+vhost_crypto_create_sess(struct vhost_crypto *vcrypto,
+		VhostUserCryptoSessionParam *sess_param)
+{
+	if (sess_param->op_code == VIRTIO_CRYPTO_AKCIPHER_CREATE_SESSION)
+		vhost_crypto_create_asym_sess(vcrypto, sess_param);
+	else
+		vhost_crypto_create_sym_sess(vcrypto, sess_param);
 }
 
 static int
 vhost_crypto_close_sess(struct vhost_crypto *vcrypto, uint64_t session_id)
 {
-	struct rte_cryptodev_sym_session *session;
+	struct vhost_crypto_session *vhost_session = NULL;
 	uint64_t sess_id = session_id;
 	int ret;
 
 	ret = rte_hash_lookup_data(vcrypto->session_map, &sess_id,
-			(void **)&session);
-
+				(void **)&vhost_session);
 	if (unlikely(ret < 0)) {
-		VC_LOG_ERR("Failed to delete session %"PRIu64".", session_id);
+		VC_LOG_ERR("Failed to find session for id %"PRIu64".", session_id);
 		return -VIRTIO_CRYPTO_INVSESS;
 	}
 
-	if (rte_cryptodev_sym_session_free(vcrypto->cid, session) < 0) {
-		VC_LOG_DBG("Failed to free session");
-		return -VIRTIO_CRYPTO_ERR;
+	if (vhost_session->type == RTE_CRYPTO_OP_TYPE_SYMMETRIC) {
+		if (rte_cryptodev_sym_session_free(vcrypto->cid,
+			vhost_session->sym) < 0) {
+			VC_LOG_DBG("Failed to free session");
+			return -VIRTIO_CRYPTO_ERR;
+		}
+	} else if (vhost_session->type == RTE_CRYPTO_OP_TYPE_ASYMMETRIC) {
+		if (rte_cryptodev_asym_session_free(vcrypto->cid,
+			vhost_session->asym) < 0) {
+			VC_LOG_DBG("Failed to free session");
+			return -VIRTIO_CRYPTO_ERR;
+			}
+	} else {
+		VC_LOG_ERR("Invalid session for id %"PRIu64".", session_id);
+		return -VIRTIO_CRYPTO_INVSESS;
 	}
 
 	if (rte_hash_del_key(vcrypto->session_map, &sess_id) < 0) {
@@ -430,6 +676,7 @@ vhost_crypto_close_sess(struct vhost_crypto *vcrypto, uint64_t session_id)
 	VC_LOG_INFO("Session %"PRIu64" deleted for vdev %i.", sess_id,
 			vcrypto->dev->vid);
 
+	rte_free(vhost_session);
 	return 0;
 }
 
@@ -1123,6 +1370,115 @@ prepare_sym_chain_op(struct vhost_crypto *vcrypto, struct rte_crypto_op *op,
 	return ret;
 }
 
+static __rte_always_inline uint8_t
+vhost_crypto_check_akcipher_request(struct virtio_crypto_akcipher_data_req *req)
+{
+	RTE_SET_USED(req);
+	return VIRTIO_CRYPTO_OK;
+}
+
+static __rte_always_inline uint8_t
+prepare_asym_rsa_op(struct vhost_crypto *vcrypto, struct rte_crypto_op *op,
+		struct vhost_crypto_data_req *vc_req,
+		struct virtio_crypto_op_data_req *req,
+		struct vhost_crypto_desc *head,
+		uint32_t max_n_descs)
+{
+	struct rte_crypto_rsa_op_param *rsa = &op->asym->rsa;
+	struct vhost_crypto_desc *desc = head;
+	uint8_t ret = VIRTIO_CRYPTO_ERR;
+	uint16_t wlen = 0;
+
+	/* prepare */
+	switch (vcrypto->option) {
+	case RTE_VHOST_CRYPTO_ZERO_COPY_DISABLE:
+		vc_req->wb_pool = vcrypto->wb_pool;
+		if (req->header.opcode == VIRTIO_CRYPTO_AKCIPHER_SIGN) {
+			rsa->op_type = RTE_CRYPTO_ASYM_OP_SIGN;
+			rsa->message.data = get_data_ptr(vc_req, desc, VHOST_ACCESS_RO);
+			rsa->message.length = req->u.akcipher_req.para.src_data_len;
+			rsa->sign.length = req->u.akcipher_req.para.dst_data_len;
+			wlen = rsa->sign.length;
+			desc = find_write_desc(head, desc, max_n_descs);
+			if (unlikely(!desc)) {
+				VC_LOG_ERR("Cannot find write location");
+				ret = VIRTIO_CRYPTO_BADMSG;
+				goto error_exit;
+			}
+
+			rsa->sign.data = get_data_ptr(vc_req, desc, VHOST_ACCESS_RW);
+			if (unlikely(rsa->sign.data == NULL)) {
+				ret = VIRTIO_CRYPTO_ERR;
+				goto error_exit;
+			}
+
+			desc += 1;
+		} else if (req->header.opcode == VIRTIO_CRYPTO_AKCIPHER_VERIFY) {
+			rsa->op_type = RTE_CRYPTO_ASYM_OP_VERIFY;
+			rsa->sign.data = get_data_ptr(vc_req, desc, VHOST_ACCESS_RO);
+			rsa->sign.length = req->u.akcipher_req.para.src_data_len;
+			desc += 1;
+			rsa->message.data = get_data_ptr(vc_req, desc, VHOST_ACCESS_RO);
+			rsa->message.length = req->u.akcipher_req.para.dst_data_len;
+			desc += 1;
+		} else if (req->header.opcode == VIRTIO_CRYPTO_AKCIPHER_ENCRYPT) {
+			rsa->op_type = RTE_CRYPTO_ASYM_OP_ENCRYPT;
+			rsa->message.data = get_data_ptr(vc_req, desc, VHOST_ACCESS_RO);
+			rsa->message.length = req->u.akcipher_req.para.src_data_len;
+			rsa->cipher.length = req->u.akcipher_req.para.dst_data_len;
+			wlen = rsa->cipher.length;
+			desc = find_write_desc(head, desc, max_n_descs);
+			if (unlikely(!desc)) {
+				VC_LOG_ERR("Cannot find write location");
+				ret = VIRTIO_CRYPTO_BADMSG;
+				goto error_exit;
+			}
+
+			rsa->cipher.data = get_data_ptr(vc_req, desc, VHOST_ACCESS_RW);
+			if (unlikely(rsa->cipher.data == NULL)) {
+				ret = VIRTIO_CRYPTO_ERR;
+				goto error_exit;
+			}
+
+			desc += 1;
+		} else if (req->header.opcode == VIRTIO_CRYPTO_AKCIPHER_DECRYPT) {
+			rsa->op_type = RTE_CRYPTO_ASYM_OP_DECRYPT;
+			rsa->cipher.data = get_data_ptr(vc_req, desc, VHOST_ACCESS_RO);
+			rsa->cipher.length = req->u.akcipher_req.para.src_data_len;
+			desc += 1;
+			rsa->message.data = get_data_ptr(vc_req, desc, VHOST_ACCESS_RO);
+			rsa->message.length = req->u.akcipher_req.para.dst_data_len;
+			desc += 1;
+		} else {
+			goto error_exit;
+		}
+		break;
+	case RTE_VHOST_CRYPTO_ZERO_COPY_ENABLE:
+	default:
+		ret = VIRTIO_CRYPTO_BADMSG;
+		goto error_exit;
+	}
+
+	op->type = RTE_CRYPTO_OP_TYPE_ASYMMETRIC;
+	op->sess_type = RTE_CRYPTO_OP_WITH_SESSION;
+
+	vc_req->inhdr = get_data_ptr(vc_req, desc, VHOST_ACCESS_WO);
+	if (unlikely(vc_req->inhdr == NULL)) {
+		ret = VIRTIO_CRYPTO_BADMSG;
+		goto error_exit;
+	}
+
+	vc_req->inhdr->status = VIRTIO_CRYPTO_OK;
+	vc_req->len = wlen + INHDR_LEN;
+	return 0;
+error_exit:
+	if (vc_req->wb)
+		free_wb_data(vc_req->wb, vc_req->wb_pool);
+
+	vc_req->len = INHDR_LEN;
+	return ret;
+}
+
 /**
  * Process on descriptor
  */
@@ -1133,17 +1489,21 @@ vhost_crypto_process_one_req(struct vhost_crypto *vcrypto,
 		uint16_t desc_idx)
 	__rte_no_thread_safety_analysis /* FIXME: requires iotlb_lock? */
 {
-	struct vhost_crypto_data_req *vc_req = rte_mbuf_to_priv(op->sym->m_src);
-	struct rte_cryptodev_sym_session *session;
+	struct vhost_crypto_data_req *vc_req, *vc_req_out;
+	struct rte_cryptodev_asym_session *asym_session;
+	struct rte_cryptodev_sym_session *sym_session;
+	struct vhost_crypto_session *vhost_session;
+	struct vhost_crypto_desc *desc = descs;
+	uint32_t nb_descs = 0, max_n_descs, i;
+	struct vhost_crypto_data_req data_req;
 	struct virtio_crypto_op_data_req req;
 	struct virtio_crypto_inhdr *inhdr;
-	struct vhost_crypto_desc *desc = descs;
 	struct vring_desc *src_desc;
 	uint64_t session_id;
 	uint64_t dlen;
-	uint32_t nb_descs = 0, max_n_descs, i;
 	int err;
 
+	vc_req = &data_req;
 	vc_req->desc_idx = desc_idx;
 	vc_req->dev = vcrypto->dev;
 	vc_req->vq = vq;
@@ -1226,12 +1586,14 @@ vhost_crypto_process_one_req(struct vhost_crypto *vcrypto,
 	switch (req.header.opcode) {
 	case VIRTIO_CRYPTO_CIPHER_ENCRYPT:
 	case VIRTIO_CRYPTO_CIPHER_DECRYPT:
+		vc_req_out = rte_mbuf_to_priv(op->sym->m_src);
+		memcpy(vc_req_out, vc_req, sizeof(struct vhost_crypto_data_req));
 		session_id = req.header.session_id;
 
 		/* one branch to avoid unnecessary table lookup */
-		if (vcrypto->cache_session_id != session_id) {
+		if (vcrypto->cache_sym_session_id != session_id) {
 			err = rte_hash_lookup_data(vcrypto->session_map,
-					&session_id, (void **)&session);
+					&session_id, (void **)&vhost_session);
 			if (unlikely(err < 0)) {
 				err = VIRTIO_CRYPTO_ERR;
 				VC_LOG_ERR("Failed to find session %"PRIu64,
@@ -1239,13 +1601,14 @@ vhost_crypto_process_one_req(struct vhost_crypto *vcrypto,
 				goto error_exit;
 			}
 
-			vcrypto->cache_session = session;
-			vcrypto->cache_session_id = session_id;
+			vcrypto->cache_sym_session = vhost_session->sym;
+			vcrypto->cache_sym_session_id = session_id;
 		}
 
-		session = vcrypto->cache_session;
+		sym_session = vcrypto->cache_sym_session;
+		op->type = RTE_CRYPTO_OP_TYPE_SYMMETRIC;
 
-		err = rte_crypto_op_attach_sym_session(op, session);
+		err = rte_crypto_op_attach_sym_session(op, sym_session);
 		if (unlikely(err < 0)) {
 			err = VIRTIO_CRYPTO_ERR;
 			VC_LOG_ERR("Failed to attach session to op");
@@ -1257,12 +1620,12 @@ vhost_crypto_process_one_req(struct vhost_crypto *vcrypto,
 			err = VIRTIO_CRYPTO_NOTSUPP;
 			break;
 		case VIRTIO_CRYPTO_SYM_OP_CIPHER:
-			err = prepare_sym_cipher_op(vcrypto, op, vc_req,
+			err = prepare_sym_cipher_op(vcrypto, op, vc_req_out,
 					&req.u.sym_req.u.cipher, desc,
 					max_n_descs);
 			break;
 		case VIRTIO_CRYPTO_SYM_OP_ALGORITHM_CHAINING:
-			err = prepare_sym_chain_op(vcrypto, op, vc_req,
+			err = prepare_sym_chain_op(vcrypto, op, vc_req_out,
 					&req.u.sym_req.u.chain, desc,
 					max_n_descs);
 			break;
@@ -1271,6 +1634,53 @@ vhost_crypto_process_one_req(struct vhost_crypto *vcrypto,
 			VC_LOG_ERR("Failed to process sym request");
 			goto error_exit;
 		}
+		break;
+	case VIRTIO_CRYPTO_AKCIPHER_SIGN:
+	case VIRTIO_CRYPTO_AKCIPHER_VERIFY:
+	case VIRTIO_CRYPTO_AKCIPHER_ENCRYPT:
+	case VIRTIO_CRYPTO_AKCIPHER_DECRYPT:
+		session_id = req.header.session_id;
+
+		/* one branch to avoid unnecessary table lookup */
+		if (vcrypto->cache_asym_session_id != session_id) {
+			err = rte_hash_lookup_data(vcrypto->session_map,
+					&session_id, (void **)&vhost_session);
+			if (unlikely(err < 0)) {
+				err = VIRTIO_CRYPTO_ERR;
+				VC_LOG_ERR("Failed to find asym session %"PRIu64,
+						   session_id);
+				goto error_exit;
+			}
+
+			vcrypto->cache_asym_session = vhost_session->asym;
+			vcrypto->cache_asym_session_id = session_id;
+		}
+
+		asym_session = vcrypto->cache_asym_session;
+		op->type = RTE_CRYPTO_OP_TYPE_ASYMMETRIC;
+
+		err = rte_crypto_op_attach_asym_session(op, asym_session);
+		if (unlikely(err < 0)) {
+			err = VIRTIO_CRYPTO_ERR;
+			VC_LOG_ERR("Failed to attach asym session to op");
+			goto error_exit;
+		}
+
+		vc_req_out = rte_cryptodev_asym_session_get_user_data(asym_session);
+		rte_memcpy(vc_req_out, vc_req, sizeof(struct vhost_crypto_data_req));
+		vc_req_out->wb = NULL;
+
+		switch (req.header.algo) {
+		case VIRTIO_CRYPTO_AKCIPHER_RSA:
+			err = prepare_asym_rsa_op(vcrypto, op, vc_req_out,
+					&req, desc, max_n_descs);
+			break;
+		}
+		if (unlikely(err != 0)) {
+			VC_LOG_ERR("Failed to process asym request");
+			goto error_exit;
+		}
+
 		break;
 	default:
 		err = VIRTIO_CRYPTO_ERR;
@@ -1294,12 +1704,22 @@ static __rte_always_inline struct vhost_virtqueue *
 vhost_crypto_finalize_one_request(struct rte_crypto_op *op,
 		struct vhost_virtqueue *old_vq)
 {
-	struct rte_mbuf *m_src = op->sym->m_src;
-	struct rte_mbuf *m_dst = op->sym->m_dst;
-	struct vhost_crypto_data_req *vc_req = rte_mbuf_to_priv(m_src);
+	struct rte_mbuf *m_src = NULL, *m_dst = NULL;
+	struct vhost_crypto_data_req *vc_req;
 	struct vhost_virtqueue *vq;
 	uint16_t used_idx, desc_idx;
 
+	if (op->type == RTE_CRYPTO_OP_TYPE_SYMMETRIC) {
+		m_src = op->sym->m_src;
+		m_dst = op->sym->m_dst;
+		vc_req = rte_mbuf_to_priv(m_src);
+	} else if (op->type == RTE_CRYPTO_OP_TYPE_ASYMMETRIC) {
+		vc_req = rte_cryptodev_asym_session_get_user_data(op->asym->session);
+	} else {
+		VC_LOG_ERR("Invalid crypto op type");
+		return NULL;
+	}
+
 	if (unlikely(!vc_req)) {
 		VC_LOG_ERR("Failed to retrieve vc_req");
 		return NULL;
@@ -1321,10 +1741,11 @@ vhost_crypto_finalize_one_request(struct rte_crypto_op *op,
 	vq->used->ring[desc_idx].id = vq->avail->ring[desc_idx];
 	vq->used->ring[desc_idx].len = vc_req->len;
 
-	rte_mempool_put(m_src->pool, (void *)m_src);
-
-	if (m_dst)
-		rte_mempool_put(m_dst->pool, (void *)m_dst);
+	if (op->type == RTE_CRYPTO_OP_TYPE_SYMMETRIC) {
+		rte_mempool_put(m_src->pool, (void *)m_src);
+		if (m_dst)
+			rte_mempool_put(m_dst->pool, (void *)m_dst);
+	}
 
 	return vc_req->vq;
 }
@@ -1407,7 +1828,8 @@ rte_vhost_crypto_create(int vid, uint8_t cryptodev_id,
 
 	vcrypto->sess_pool = sess_pool;
 	vcrypto->cid = cryptodev_id;
-	vcrypto->cache_session_id = UINT64_MAX;
+	vcrypto->cache_sym_session_id = UINT64_MAX;
+	vcrypto->cache_asym_session_id = UINT64_MAX;
 	vcrypto->last_session_id = 1;
 	vcrypto->dev = dev;
 	vcrypto->option = RTE_VHOST_CRYPTO_ZERO_COPY_DISABLE;
diff --git a/lib/vhost/virtio_crypto.h b/lib/vhost/virtio_crypto.h
index 28877a5da3..23af171030 100644
--- a/lib/vhost/virtio_crypto.h
+++ b/lib/vhost/virtio_crypto.h
@@ -9,6 +9,7 @@
 #define VIRTIO_CRYPTO_SERVICE_HASH   1
 #define VIRTIO_CRYPTO_SERVICE_MAC    2
 #define VIRTIO_CRYPTO_SERVICE_AEAD   3
+#define VIRTIO_CRYPTO_SERVICE_AKCIPHER 4
 
 #define VIRTIO_CRYPTO_OPCODE(service, op)   (((service) << 8) | (op))
 
@@ -29,6 +30,10 @@ struct virtio_crypto_ctrl_header {
 	   VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_AEAD, 0x02)
 #define VIRTIO_CRYPTO_AEAD_DESTROY_SESSION \
 	   VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_AEAD, 0x03)
+#define VIRTIO_CRYPTO_AKCIPHER_CREATE_SESSION \
+	   VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_AKCIPHER, 0x04)
+#define VIRTIO_CRYPTO_AKCIPHER_DESTROY_SESSION \
+	   VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_AKCIPHER, 0x05)
 	uint32_t opcode;
 	uint32_t algo;
 	uint32_t flag;
@@ -152,6 +157,45 @@ struct virtio_crypto_aead_create_session_req {
 	uint8_t padding[32];
 };
 
+struct virtio_crypto_rsa_session_para {
+#define VIRTIO_CRYPTO_RSA_RAW_PADDING   0
+#define VIRTIO_CRYPTO_RSA_PKCS1_PADDING 1
+	uint32_t padding_algo;
+
+#define VIRTIO_CRYPTO_RSA_NO_HASH   0
+#define VIRTIO_CRYPTO_RSA_MD2       1
+#define VIRTIO_CRYPTO_RSA_MD3       2
+#define VIRTIO_CRYPTO_RSA_MD4       3
+#define VIRTIO_CRYPTO_RSA_MD5       4
+#define VIRTIO_CRYPTO_RSA_SHA1      5
+#define VIRTIO_CRYPTO_RSA_SHA256    6
+#define VIRTIO_CRYPTO_RSA_SHA384    7
+#define VIRTIO_CRYPTO_RSA_SHA512    8
+#define VIRTIO_CRYPTO_RSA_SHA224    9
+	uint32_t hash_algo;
+};
+
+struct virtio_crypto_akcipher_session_para {
+#define VIRTIO_CRYPTO_NO_AKCIPHER    0
+#define VIRTIO_CRYPTO_AKCIPHER_RSA   1
+#define VIRTIO_CRYPTO_AKCIPHER_DSA   2
+	uint32_t algo;
+
+#define VIRTIO_CRYPTO_AKCIPHER_KEY_TYPE_PUBLIC  1
+#define VIRTIO_CRYPTO_AKCIPHER_KEY_TYPE_PRIVATE 2
+	uint32_t keytype;
+	uint32_t keylen;
+
+	union {
+		struct virtio_crypto_rsa_session_para rsa;
+	} u;
+};
+
+struct virtio_crypto_akcipher_create_session_req {
+	struct virtio_crypto_akcipher_session_para para;
+	uint8_t padding[36];
+};
+
 struct virtio_crypto_alg_chain_session_para {
 #define VIRTIO_CRYPTO_SYM_ALG_CHAIN_ORDER_HASH_THEN_CIPHER  1
 #define VIRTIO_CRYPTO_SYM_ALG_CHAIN_ORDER_CIPHER_THEN_HASH  2
@@ -219,6 +263,8 @@ struct virtio_crypto_op_ctrl_req {
 			mac_create_session;
 		struct virtio_crypto_aead_create_session_req
 			aead_create_session;
+		struct virtio_crypto_akcipher_create_session_req
+			akcipher_create_session;
 		struct virtio_crypto_destroy_session_req
 			destroy_session;
 		uint8_t padding[56];
@@ -238,6 +284,14 @@ struct virtio_crypto_op_header {
 	VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_AEAD, 0x00)
 #define VIRTIO_CRYPTO_AEAD_DECRYPT \
 	VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_AEAD, 0x01)
+#define VIRTIO_CRYPTO_AKCIPHER_ENCRYPT \
+	VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_AKCIPHER, 0x00)
+#define VIRTIO_CRYPTO_AKCIPHER_DECRYPT \
+	VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_AKCIPHER, 0x01)
+#define VIRTIO_CRYPTO_AKCIPHER_SIGN \
+	VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_AKCIPHER, 0x02)
+#define VIRTIO_CRYPTO_AKCIPHER_VERIFY \
+	VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_AKCIPHER, 0x03)
 	uint32_t opcode;
 	/* algo should be service-specific algorithms */
 	uint32_t algo;
@@ -362,6 +416,16 @@ struct virtio_crypto_aead_data_req {
 	uint8_t padding[32];
 };
 
+struct virtio_crypto_akcipher_para {
+	uint32_t src_data_len;
+	uint32_t dst_data_len;
+};
+
+struct virtio_crypto_akcipher_data_req {
+	struct virtio_crypto_akcipher_para para;
+	uint8_t padding[40];
+};
+
 /* The request of the data virtqueue's packet */
 struct virtio_crypto_op_data_req {
 	struct virtio_crypto_op_header header;
@@ -371,6 +435,7 @@ struct virtio_crypto_op_data_req {
 		struct virtio_crypto_hash_data_req hash_req;
 		struct virtio_crypto_mac_data_req mac_req;
 		struct virtio_crypto_aead_data_req aead_req;
+		struct virtio_crypto_akcipher_data_req akcipher_req;
 		uint8_t padding[48];
 	} u;
 };
@@ -380,6 +445,8 @@ struct virtio_crypto_op_data_req {
 #define VIRTIO_CRYPTO_BADMSG    2
 #define VIRTIO_CRYPTO_NOTSUPP   3
 #define VIRTIO_CRYPTO_INVSESS   4 /* Invalid session id */
+#define VIRTIO_CRYPTO_NOSPC     5 /* no free session ID */
+#define VIRTIO_CRYPTO_KEY_REJECTED 6 /* Signature verification failed */
 
 /* The accelerator hardware is ready */
 #define VIRTIO_CRYPTO_S_HW_READY  (1 << 0)
-- 
2.25.1

