Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0B83C021B5
	for <dpdk-dev@archiver.kernel.org>; Sat, 22 Feb 2025 09:17:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A7FF942D8C;
	Sat, 22 Feb 2025 10:17:12 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 91EDA42D72
 for <dev@dpdk.org>; Sat, 22 Feb 2025 10:17:10 +0100 (CET)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51M9GhIJ020591;
 Sat, 22 Feb 2025 01:17:09 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=o
 Zvcy8NwOVDAAWDUb+sET4uTNAZ8NeZff1FR3/wqwr8=; b=XZPDu8Oe6axqsaLkI
 Mms0btbyPJ5dUlPRsgSSasPcORlgNyCNxyDekw8N9QkLHRTZ9RSMNGdGDq0M8iRw
 cjdnP0dztQUwOL93neo1rwVEliGpVZq3de3ZZ1EN47YJMOmrVXMkn3qW1PEFUsnM
 fjC9DciflzWHJFlLCB77LTLl0shdMU6tcF6W+2Hys4s/FD49mPARFfEVhwqwM4Ef
 Ql/CfSegNizSmZijwEnjMCzxzoqa9tUkISB6apBM6WHBu9rQskgJ0pPDP3w3G+qb
 aiWYuD3zfgQcECy11AO+XZgoVbVZUUsGAf3t5iPwRzrLZjzZ06aeUYIlYrXszwuH
 tia4Q==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 44ya2203pe-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 22 Feb 2025 01:17:09 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sat, 22 Feb 2025 01:17:08 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Sat, 22 Feb 2025 01:17:08 -0800
Received: from IN-lckQE5Rwctls.marvell.com (IN-lckQE5Rwctls.marvell.com
 [10.28.163.68])
 by maili.marvell.com (Postfix) with ESMTP id 3A3E23F705E;
 Sat, 22 Feb 2025 01:17:04 -0800 (PST)
From: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
To: <dev@dpdk.org>, Jay Zhou <jianjay.zhou@huawei.com>, Akhil Goyal
 <gakhil@marvell.com>, Fan Zhang <fanzhang.oss@gmail.com>
CC: <anoobj@marvell.com>, Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
Subject: [v4 1/6] crypto/virtio: add asymmetric RSA support
Date: Sat, 22 Feb 2025 14:46:50 +0530
Message-ID: <10d0e6e6398e7bb4f98a0874add9d4b0586838e4.1740212415.git.gmuthukrishn@marvell.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <cover.1740212415.git.gmuthukrishn@marvell.com>
References: <cover.1740212415.git.gmuthukrishn@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: aw5Pa8GehVvNSSq_dCz3PMKdnG7ilap-
X-Proofpoint-ORIG-GUID: aw5Pa8GehVvNSSq_dCz3PMKdnG7ilap-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-22_03,2025-02-20_02,2024-11-22_01
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

Asymmetric RSA operations (SIGN, VERIFY, ENCRYPT and DECRYPT) are
supported in virtio PMD.

Signed-off-by: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
---
Depends-on: series-34682 ("vhost: add RSA support")
---
 .../virtio/virtio_crypto_capabilities.h       |  19 +
 drivers/crypto/virtio/virtio_cryptodev.c      | 347 +++++++++++++++---
 drivers/crypto/virtio/virtio_cryptodev.h      |   2 +
 drivers/crypto/virtio/virtio_rxtx.c           | 243 ++++++++++--
 lib/cryptodev/cryptodev_pmd.h                 |   6 +
 5 files changed, 539 insertions(+), 78 deletions(-)

diff --git a/drivers/crypto/virtio/virtio_crypto_capabilities.h b/drivers/crypto/virtio/virtio_crypto_capabilities.h
index 03c30deefd..1b26ff6720 100644
--- a/drivers/crypto/virtio/virtio_crypto_capabilities.h
+++ b/drivers/crypto/virtio/virtio_crypto_capabilities.h
@@ -48,4 +48,23 @@
 		}, }							\
 	}
 
+#define VIRTIO_ASYM_CAPABILITIES					\
+	{       /* RSA */						\
+		.op = RTE_CRYPTO_OP_TYPE_ASYMMETRIC,			\
+		{.asym = {						\
+			.xform_capa = {					\
+			.xform_type = RTE_CRYPTO_ASYM_XFORM_RSA,	\
+			.op_types = ((1 << RTE_CRYPTO_ASYM_OP_SIGN) |	\
+					(1 << RTE_CRYPTO_ASYM_OP_VERIFY) |  \
+					(1 << RTE_CRYPTO_ASYM_OP_ENCRYPT) | \
+					(1 << RTE_CRYPTO_ASYM_OP_DECRYPT)), \
+			{.modlen = {					\
+				.min = 1,				\
+				.max = 1024,				\
+				.increment = 1				\
+			}, }						\
+		}							\
+		 }, }							\
+	}
+
 #endif /* _VIRTIO_CRYPTO_CAPABILITIES_H_ */
diff --git a/drivers/crypto/virtio/virtio_cryptodev.c b/drivers/crypto/virtio/virtio_cryptodev.c
index 793f50059f..6a264bc24a 100644
--- a/drivers/crypto/virtio/virtio_cryptodev.c
+++ b/drivers/crypto/virtio/virtio_cryptodev.c
@@ -41,6 +41,11 @@ static void virtio_crypto_sym_clear_session(struct rte_cryptodev *dev,
 static int virtio_crypto_sym_configure_session(struct rte_cryptodev *dev,
 		struct rte_crypto_sym_xform *xform,
 		struct rte_cryptodev_sym_session *session);
+static void virtio_crypto_asym_clear_session(struct rte_cryptodev *dev,
+		struct rte_cryptodev_asym_session *sess);
+static int virtio_crypto_asym_configure_session(struct rte_cryptodev *dev,
+		struct rte_crypto_asym_xform *xform,
+		struct rte_cryptodev_asym_session *session);
 
 /*
  * The set of PCI devices this driver supports
@@ -53,6 +58,7 @@ static const struct rte_pci_id pci_id_virtio_crypto_map[] = {
 
 static const struct rte_cryptodev_capabilities virtio_capabilities[] = {
 	VIRTIO_SYM_CAPABILITIES,
+	VIRTIO_ASYM_CAPABILITIES,
 	RTE_CRYPTODEV_END_OF_CAPABILITIES_LIST()
 };
 
@@ -103,22 +109,24 @@ virtio_crypto_send_command(struct virtqueue *vq,
 	}
 
 	/* calculate the length of cipher key */
-	if (cipher_key) {
+	if (session->ctrl.header.algo == VIRTIO_CRYPTO_SERVICE_CIPHER) {
 		switch (ctrl->u.sym_create_session.op_type) {
 		case VIRTIO_CRYPTO_SYM_OP_CIPHER:
-			len_cipher_key
-				= ctrl->u.sym_create_session.u.cipher
-							.para.keylen;
+			len_cipher_key = ctrl->u.sym_create_session.u.cipher.para.keylen;
 			break;
 		case VIRTIO_CRYPTO_SYM_OP_ALGORITHM_CHAINING:
-			len_cipher_key
-				= ctrl->u.sym_create_session.u.chain
-					.para.cipher_param.keylen;
+			len_cipher_key =
+				ctrl->u.sym_create_session.u.chain.para.cipher_param.keylen;
 			break;
 		default:
 			VIRTIO_CRYPTO_SESSION_LOG_ERR("invalid op type");
 			return -EINVAL;
 		}
+	} else if (session->ctrl.header.algo == VIRTIO_CRYPTO_AKCIPHER_RSA) {
+		len_cipher_key = ctrl->u.akcipher_create_session.para.keylen;
+	} else {
+		VIRTIO_CRYPTO_SESSION_LOG_ERR("Invalid crypto service for cipher key");
+		return -EINVAL;
 	}
 
 	/* calculate the length of auth key */
@@ -513,7 +521,10 @@ static struct rte_cryptodev_ops virtio_crypto_dev_ops = {
 	/* Crypto related operations */
 	.sym_session_get_size		= virtio_crypto_sym_get_session_private_size,
 	.sym_session_configure		= virtio_crypto_sym_configure_session,
-	.sym_session_clear		= virtio_crypto_sym_clear_session
+	.sym_session_clear		= virtio_crypto_sym_clear_session,
+	.asym_session_get_size		= virtio_crypto_sym_get_session_private_size,
+	.asym_session_configure		= virtio_crypto_asym_configure_session,
+	.asym_session_clear		= virtio_crypto_asym_clear_session
 };
 
 static void
@@ -737,6 +748,8 @@ crypto_virtio_create(const char *name, struct rte_pci_device *pci_dev,
 	cryptodev->dequeue_burst = virtio_crypto_pkt_rx_burst;
 
 	cryptodev->feature_flags = RTE_CRYPTODEV_FF_SYMMETRIC_CRYPTO |
+		RTE_CRYPTODEV_FF_ASYMMETRIC_CRYPTO |
+		RTE_CRYPTODEV_FF_RSA_PRIV_OP_KEY_QT |
 		RTE_CRYPTODEV_FF_SYM_OPERATION_CHAINING |
 		RTE_CRYPTODEV_FF_OOP_LB_IN_LB_OUT;
 
@@ -923,32 +936,24 @@ virtio_crypto_check_sym_clear_session_paras(
 #define NUM_ENTRY_SYM_CLEAR_SESSION 2
 
 static void
-virtio_crypto_sym_clear_session(
+virtio_crypto_clear_session(
 		struct rte_cryptodev *dev,
-		struct rte_cryptodev_sym_session *sess)
+		struct virtio_crypto_op_ctrl_req *ctrl)
 {
 	struct virtio_crypto_hw *hw;
 	struct virtqueue *vq;
-	struct virtio_crypto_session *session;
-	struct virtio_crypto_op_ctrl_req *ctrl;
 	struct vring_desc *desc;
 	uint8_t *status;
 	uint8_t needed = 1;
 	uint32_t head;
-	uint8_t *malloc_virt_addr;
 	uint64_t malloc_phys_addr;
 	uint8_t len_inhdr = sizeof(struct virtio_crypto_inhdr);
 	uint32_t len_op_ctrl_req = sizeof(struct virtio_crypto_op_ctrl_req);
 	uint32_t desc_offset = len_op_ctrl_req + len_inhdr;
-
-	PMD_INIT_FUNC_TRACE();
-
-	if (virtio_crypto_check_sym_clear_session_paras(dev, sess) < 0)
-		return;
+	uint64_t session_id = ctrl->u.destroy_session.session_id;
 
 	hw = dev->data->dev_private;
 	vq = hw->cvq;
-	session = CRYPTODEV_GET_SYM_SESS_PRIV(sess);
 
 	VIRTIO_CRYPTO_SESSION_LOG_INFO("vq->vq_desc_head_idx = %d, "
 			"vq = %p", vq->vq_desc_head_idx, vq);
@@ -960,34 +965,15 @@ virtio_crypto_sym_clear_session(
 		return;
 	}
 
-	/*
-	 * malloc memory to store information of ctrl request op,
-	 * returned status and desc vring
-	 */
-	malloc_virt_addr = rte_malloc(NULL, len_op_ctrl_req + len_inhdr
-		+ NUM_ENTRY_SYM_CLEAR_SESSION
-		* sizeof(struct vring_desc), RTE_CACHE_LINE_SIZE);
-	if (malloc_virt_addr == NULL) {
-		VIRTIO_CRYPTO_SESSION_LOG_ERR("not enough heap room");
-		return;
-	}
-	malloc_phys_addr = rte_malloc_virt2iova(malloc_virt_addr);
-
-	/* assign ctrl request op part */
-	ctrl = (struct virtio_crypto_op_ctrl_req *)malloc_virt_addr;
-	ctrl->header.opcode = VIRTIO_CRYPTO_CIPHER_DESTROY_SESSION;
-	/* default data virtqueue is 0 */
-	ctrl->header.queue_id = 0;
-	ctrl->u.destroy_session.session_id = session->session_id;
+	malloc_phys_addr = rte_malloc_virt2iova(ctrl);
 
 	/* status part */
 	status = &(((struct virtio_crypto_inhdr *)
-		((uint8_t *)malloc_virt_addr + len_op_ctrl_req))->status);
+		((uint8_t *)ctrl + len_op_ctrl_req))->status);
 	*status = VIRTIO_CRYPTO_ERR;
 
 	/* indirect desc vring part */
-	desc = (struct vring_desc *)((uint8_t *)malloc_virt_addr
-		+ desc_offset);
+	desc = (struct vring_desc *)((uint8_t *)ctrl + desc_offset);
 
 	/* ctrl request part */
 	desc[0].addr = malloc_phys_addr;
@@ -1049,8 +1035,8 @@ virtio_crypto_sym_clear_session(
 	if (*status != VIRTIO_CRYPTO_OK) {
 		VIRTIO_CRYPTO_SESSION_LOG_ERR("Close session failed "
 				"status=%"PRIu32", session_id=%"PRIu64"",
-				*status, session->session_id);
-		rte_free(malloc_virt_addr);
+				*status, session_id);
+		rte_free(ctrl);
 		return;
 	}
 
@@ -1058,9 +1044,86 @@ virtio_crypto_sym_clear_session(
 	VIRTIO_CRYPTO_INIT_LOG_DBG("vq->vq_desc_head_idx=%d", vq->vq_desc_head_idx);
 
 	VIRTIO_CRYPTO_SESSION_LOG_INFO("Close session %"PRIu64" successfully ",
-			session->session_id);
+			session_id);
 
-	rte_free(malloc_virt_addr);
+	rte_free(ctrl);
+}
+
+static void
+virtio_crypto_sym_clear_session(
+		struct rte_cryptodev *dev,
+		struct rte_cryptodev_sym_session *sess)
+{
+	uint32_t len_op_ctrl_req = sizeof(struct virtio_crypto_op_ctrl_req);
+	uint8_t len_inhdr = sizeof(struct virtio_crypto_inhdr);
+	struct virtio_crypto_op_ctrl_req *ctrl;
+	struct virtio_crypto_session *session;
+	uint8_t *malloc_virt_addr;
+
+	PMD_INIT_FUNC_TRACE();
+
+	if (virtio_crypto_check_sym_clear_session_paras(dev, sess) < 0)
+		return;
+
+	session = CRYPTODEV_GET_SYM_SESS_PRIV(sess);
+
+	/*
+	 * malloc memory to store information of ctrl request op,
+	 * returned status and desc vring
+	 */
+	malloc_virt_addr = rte_malloc(NULL, len_op_ctrl_req + len_inhdr
+		+ NUM_ENTRY_SYM_CLEAR_SESSION
+		* sizeof(struct vring_desc), RTE_CACHE_LINE_SIZE);
+	if (malloc_virt_addr == NULL) {
+		VIRTIO_CRYPTO_SESSION_LOG_ERR("not enough heap room");
+		return;
+	}
+
+	/* assign ctrl request op part */
+	ctrl = (struct virtio_crypto_op_ctrl_req *)malloc_virt_addr;
+	ctrl->header.opcode = VIRTIO_CRYPTO_CIPHER_DESTROY_SESSION;
+	/* default data virtqueue is 0 */
+	ctrl->header.queue_id = 0;
+	ctrl->u.destroy_session.session_id = session->session_id;
+
+	return virtio_crypto_clear_session(dev, ctrl);
+}
+
+static void
+virtio_crypto_asym_clear_session(
+		struct rte_cryptodev *dev,
+		struct rte_cryptodev_asym_session *sess)
+{
+	uint32_t len_op_ctrl_req = sizeof(struct virtio_crypto_op_ctrl_req);
+	uint8_t len_inhdr = sizeof(struct virtio_crypto_inhdr);
+	struct virtio_crypto_op_ctrl_req *ctrl;
+	struct virtio_crypto_session *session;
+	uint8_t *malloc_virt_addr;
+
+	PMD_INIT_FUNC_TRACE();
+
+	session = CRYPTODEV_GET_ASYM_SESS_PRIV(sess);
+
+	/*
+	 * malloc memory to store information of ctrl request op,
+	 * returned status and desc vring
+	 */
+	malloc_virt_addr = rte_malloc(NULL, len_op_ctrl_req + len_inhdr
+		+ NUM_ENTRY_SYM_CLEAR_SESSION
+		* sizeof(struct vring_desc), RTE_CACHE_LINE_SIZE);
+	if (malloc_virt_addr == NULL) {
+		VIRTIO_CRYPTO_SESSION_LOG_ERR("not enough heap room");
+		return;
+	}
+
+	/* assign ctrl request op part */
+	ctrl = (struct virtio_crypto_op_ctrl_req *)malloc_virt_addr;
+	ctrl->header.opcode = VIRTIO_CRYPTO_AKCIPHER_DESTROY_SESSION;
+	/* default data virtqueue is 0 */
+	ctrl->header.queue_id = 0;
+	ctrl->u.destroy_session.session_id = session->session_id;
+
+	return virtio_crypto_clear_session(dev, ctrl);
 }
 
 static struct rte_crypto_cipher_xform *
@@ -1291,6 +1354,23 @@ virtio_crypto_check_sym_configure_session_paras(
 	return 0;
 }
 
+static int
+virtio_crypto_check_asym_configure_session_paras(
+		struct rte_cryptodev *dev,
+		struct rte_crypto_asym_xform *xform,
+		struct rte_cryptodev_asym_session *asym_sess)
+{
+	if (unlikely(xform == NULL) || unlikely(asym_sess == NULL)) {
+		VIRTIO_CRYPTO_SESSION_LOG_ERR("NULL pointer");
+		return -1;
+	}
+
+	if (virtio_crypto_check_sym_session_paras(dev) < 0)
+		return -1;
+
+	return 0;
+}
+
 static int
 virtio_crypto_sym_configure_session(
 		struct rte_cryptodev *dev,
@@ -1383,6 +1463,183 @@ virtio_crypto_sym_configure_session(
 	return ret;
 }
 
+static size_t
+tlv_encode(uint8_t *tlv, uint8_t type, uint8_t *data, size_t len)
+{
+	uint8_t *lenval = tlv;
+	size_t lenval_n = 0;
+
+	if (len > 65535) {
+		goto _exit;
+	} else if (len > 255) {
+		lenval_n = 4 + len;
+		lenval[0] = type;
+		lenval[1] = 0x82;
+		lenval[2] = (len & 0xFF00) >> 8;
+		lenval[3] = (len & 0xFF);
+		rte_memcpy(&lenval[4], data, len);
+	} else if (len > 127) {
+		lenval_n = 3 + len;
+		lenval[0] = type;
+		lenval[1] = 0x81;
+		lenval[2] = len;
+		rte_memcpy(&lenval[3], data, len);
+	} else {
+		lenval_n = 2 + len;
+		lenval[0] = type;
+		lenval[1] = len;
+		rte_memcpy(&lenval[2], data, len);
+	}
+
+_exit:
+	return lenval_n;
+}
+
+static int
+virtio_crypto_asym_rsa_xform_to_der(
+		struct rte_crypto_asym_xform *xform,
+		uint8_t *der)
+{
+	uint8_t data[VIRTIO_CRYPTO_MAX_CTRL_DATA];
+	uint8_t ver[3] = {0x02, 0x01, 0x00};
+	size_t tlen, len;
+	uint8_t *tlv;
+
+	if (xform->xform_type != RTE_CRYPTO_ASYM_XFORM_RSA)
+		return -EINVAL;
+
+	tlv = data;
+	rte_memcpy(tlv, ver, RTE_DIM(ver));
+	tlen = RTE_DIM(ver);
+	len = tlv_encode(tlv + tlen, 0x02, xform->rsa.n.data, xform->rsa.n.length);
+	tlen += len;
+	len = tlv_encode(tlv + tlen, 0x02, xform->rsa.e.data, xform->rsa.e.length);
+	tlen += len;
+	len = tlv_encode(tlv + tlen, 0x02, xform->rsa.d.data, xform->rsa.d.length);
+	tlen += len;
+	len = tlv_encode(tlv + tlen, 0x02, xform->rsa.qt.p.data, xform->rsa.qt.p.length);
+	tlen += len;
+	len = tlv_encode(tlv + tlen, 0x02, xform->rsa.qt.q.data, xform->rsa.qt.q.length);
+	tlen += len;
+	len = tlv_encode(tlv + tlen, 0x02, xform->rsa.qt.dP.data, xform->rsa.qt.dP.length);
+	tlen += len;
+	len = tlv_encode(tlv + tlen, 0x02, xform->rsa.qt.dQ.data, xform->rsa.qt.dQ.length);
+	tlen += len;
+	len = tlv_encode(tlv + tlen, 0x02, xform->rsa.qt.qInv.data, xform->rsa.qt.qInv.length);
+	tlen += len;
+
+	RTE_ASSERT(tlen < VIRTIO_CRYPTO_MAX_CTRL_DATA);
+	len = tlv_encode(der, 0x30, data, tlen);
+	return len;
+}
+
+static int
+virtio_crypto_asym_rsa_configure_session(
+		struct rte_crypto_rsa_xform *rsa,
+		struct virtio_crypto_akcipher_session_para *para)
+{
+	para->algo = VIRTIO_CRYPTO_AKCIPHER_RSA;
+	if (rsa->key_type == RTE_RSA_KEY_TYPE_EXP)
+		para->keytype = VIRTIO_CRYPTO_AKCIPHER_KEY_TYPE_PUBLIC;
+	else
+		para->keytype = VIRTIO_CRYPTO_AKCIPHER_KEY_TYPE_PRIVATE;
+
+	if (rsa->padding.type == RTE_CRYPTO_RSA_PADDING_NONE) {
+		para->u.rsa.padding_algo = VIRTIO_CRYPTO_RSA_RAW_PADDING;
+	} else if (rsa->padding.type == RTE_CRYPTO_RSA_PADDING_PKCS1_5) {
+		para->u.rsa.padding_algo = VIRTIO_CRYPTO_RSA_PKCS1_PADDING;
+		switch (rsa->padding.hash) {
+		case  RTE_CRYPTO_AUTH_SHA1:
+			para->u.rsa.hash_algo = VIRTIO_CRYPTO_RSA_SHA1;
+			break;
+		case  RTE_CRYPTO_AUTH_SHA224:
+			para->u.rsa.hash_algo = VIRTIO_CRYPTO_RSA_SHA224;
+			break;
+		case  RTE_CRYPTO_AUTH_SHA256:
+			para->u.rsa.hash_algo = VIRTIO_CRYPTO_RSA_SHA256;
+			break;
+		case  RTE_CRYPTO_AUTH_SHA512:
+			para->u.rsa.hash_algo = VIRTIO_CRYPTO_RSA_SHA512;
+			break;
+		case  RTE_CRYPTO_AUTH_MD5:
+			para->u.rsa.hash_algo = VIRTIO_CRYPTO_RSA_MD5;
+			break;
+		default:
+			para->u.rsa.hash_algo = VIRTIO_CRYPTO_RSA_NO_HASH;
+		}
+	} else {
+		VIRTIO_CRYPTO_SESSION_LOG_ERR("Invalid padding type");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int
+virtio_crypto_asym_configure_session(
+		struct rte_cryptodev *dev,
+		struct rte_crypto_asym_xform *xform,
+		struct rte_cryptodev_asym_session *sess)
+{
+	struct virtio_crypto_akcipher_session_para *para;
+	struct virtio_crypto_op_ctrl_req *ctrl_req;
+	uint8_t key[VIRTIO_CRYPTO_MAX_CTRL_DATA];
+	struct virtio_crypto_session *session;
+	struct virtio_crypto_hw *hw;
+	struct virtqueue *control_vq;
+	int ret;
+
+	PMD_INIT_FUNC_TRACE();
+
+	ret = virtio_crypto_check_asym_configure_session_paras(dev, xform,
+			sess);
+	if (ret < 0) {
+		VIRTIO_CRYPTO_SESSION_LOG_ERR("Invalid parameters");
+		return ret;
+	}
+
+	session = CRYPTODEV_GET_ASYM_SESS_PRIV(sess);
+	memset(session, 0, sizeof(struct virtio_crypto_session));
+	ctrl_req = &session->ctrl;
+	ctrl_req->header.opcode = VIRTIO_CRYPTO_AKCIPHER_CREATE_SESSION;
+	ctrl_req->header.queue_id = 0;
+	para = &ctrl_req->u.akcipher_create_session.para;
+
+	switch (xform->xform_type) {
+	case RTE_CRYPTO_ASYM_XFORM_RSA:
+		ctrl_req->header.algo = VIRTIO_CRYPTO_AKCIPHER_RSA;
+		ret = virtio_crypto_asym_rsa_configure_session(&xform->rsa, para);
+		if (ret < 0) {
+			VIRTIO_CRYPTO_SESSION_LOG_ERR("Invalid RSA parameters");
+			return ret;
+		}
+
+		ret = virtio_crypto_asym_rsa_xform_to_der(xform, key);
+		if (ret <= 0) {
+			VIRTIO_CRYPTO_SESSION_LOG_ERR("Invalid RSA primitives");
+			return ret;
+		}
+
+		ctrl_req->u.akcipher_create_session.para.keylen = ret;
+		break;
+	default:
+		para->algo = VIRTIO_CRYPTO_NO_AKCIPHER;
+	}
+
+	hw = dev->data->dev_private;
+	control_vq = hw->cvq;
+	ret = virtio_crypto_send_command(control_vq, ctrl_req,
+				key, NULL, session);
+	if (ret < 0) {
+		VIRTIO_CRYPTO_SESSION_LOG_ERR("create session failed: %d", ret);
+		goto error_out;
+	}
+
+	return 0;
+error_out:
+	return -1;
+}
+
 static void
 virtio_crypto_dev_info_get(struct rte_cryptodev *dev,
 		struct rte_cryptodev_info *info)
diff --git a/drivers/crypto/virtio/virtio_cryptodev.h b/drivers/crypto/virtio/virtio_cryptodev.h
index 215bce7863..d8b1e1abdd 100644
--- a/drivers/crypto/virtio/virtio_cryptodev.h
+++ b/drivers/crypto/virtio/virtio_cryptodev.h
@@ -20,6 +20,8 @@
 
 #define VIRTIO_CRYPTO_MAX_KEY_SIZE 256
 
+#define VIRTIO_CRYPTO_MAX_CTRL_DATA 2048
+
 extern uint8_t cryptodev_virtio_driver_id;
 
 enum virtio_crypto_cmd_id {
diff --git a/drivers/crypto/virtio/virtio_rxtx.c b/drivers/crypto/virtio/virtio_rxtx.c
index d02486661f..3cf25d8c1f 100644
--- a/drivers/crypto/virtio/virtio_rxtx.c
+++ b/drivers/crypto/virtio/virtio_rxtx.c
@@ -107,7 +107,7 @@ virtqueue_dequeue_burst_rx(struct virtqueue *vq,
 	return i;
 }
 
-static int
+static inline int
 virtqueue_crypto_sym_pkt_header_arrange(
 		struct rte_crypto_op *cop,
 		struct virtio_crypto_op_data_req *data,
@@ -187,7 +187,7 @@ virtqueue_crypto_sym_pkt_header_arrange(
 	return 0;
 }
 
-static int
+static inline int
 virtqueue_crypto_sym_enqueue_xmit(
 		struct virtqueue *txvq,
 		struct rte_crypto_op *cop)
@@ -343,24 +343,190 @@ virtqueue_crypto_sym_enqueue_xmit(
 	return 0;
 }
 
-static int
-virtqueue_crypto_enqueue_xmit(struct virtqueue *txvq,
-		struct rte_crypto_op *cop)
+static inline int
+virtqueue_crypto_asym_pkt_header_arrange(
+		struct rte_crypto_op *cop,
+		struct virtio_crypto_op_data_req *data,
+		struct virtio_crypto_session *session)
 {
-	int ret;
+	struct virtio_crypto_op_ctrl_req *ctrl = &session->ctrl;
+	struct virtio_crypto_op_data_req *req_data = data;
+	struct rte_crypto_asym_op *asym_op = cop->asym;
+
+	req_data->header.session_id = session->session_id;
+
+	switch (ctrl->header.algo)	{
+	case VIRTIO_CRYPTO_AKCIPHER_RSA:
+		req_data->header.algo = ctrl->header.algo;
+		if (asym_op->rsa.op_type == RTE_CRYPTO_ASYM_OP_SIGN) {
+			req_data->header.opcode = VIRTIO_CRYPTO_AKCIPHER_SIGN;
+			req_data->u.akcipher_req.para.src_data_len
+				= asym_op->rsa.message.length;
+			req_data->u.akcipher_req.para.dst_data_len
+				= asym_op->rsa.sign.length;
+		} else if (asym_op->rsa.op_type == RTE_CRYPTO_ASYM_OP_VERIFY) {
+			req_data->header.opcode = VIRTIO_CRYPTO_AKCIPHER_VERIFY;
+			req_data->u.akcipher_req.para.src_data_len
+				= asym_op->rsa.sign.length;
+			req_data->u.akcipher_req.para.dst_data_len
+				= asym_op->rsa.message.length;
+		} else if (asym_op->rsa.op_type == RTE_CRYPTO_ASYM_OP_ENCRYPT) {
+			req_data->header.opcode = VIRTIO_CRYPTO_AKCIPHER_ENCRYPT;
+			req_data->u.akcipher_req.para.src_data_len
+				= asym_op->rsa.message.length;
+			req_data->u.akcipher_req.para.dst_data_len
+				= asym_op->rsa.cipher.length;
+		} else if (asym_op->rsa.op_type == RTE_CRYPTO_ASYM_OP_DECRYPT) {
+			req_data->header.opcode = VIRTIO_CRYPTO_AKCIPHER_DECRYPT;
+			req_data->u.akcipher_req.para.src_data_len
+				= asym_op->rsa.cipher.length;
+			req_data->u.akcipher_req.para.dst_data_len
+				= asym_op->rsa.message.length;
+		} else {
+			return -EINVAL;
+		}
 
-	switch (cop->type) {
-	case RTE_CRYPTO_OP_TYPE_SYMMETRIC:
-		ret = virtqueue_crypto_sym_enqueue_xmit(txvq, cop);
 		break;
 	default:
-		VIRTIO_CRYPTO_TX_LOG_ERR("invalid crypto op type %u",
-				cop->type);
-		ret = -EFAULT;
-		break;
+		req_data->header.algo = VIRTIO_CRYPTO_NO_AKCIPHER;
+	}
+
+	return 0;
+}
+
+static inline int
+virtqueue_crypto_asym_enqueue_xmit(
+		struct virtqueue *txvq,
+		struct rte_crypto_op *cop)
+{
+	uint16_t req_data_len = sizeof(struct virtio_crypto_op_data_req);
+	uint32_t indirect_vring_addr_offset = req_data_len +
+		sizeof(struct virtio_crypto_inhdr);
+	struct virtio_crypto_session *session =
+		CRYPTODEV_GET_ASYM_SESS_PRIV(cop->asym->session);
+	struct virtio_crypto_op_cookie *crypto_op_cookie;
+	struct rte_crypto_asym_op *asym_op = cop->asym;
+	struct virtio_crypto_op_data_req *op_data_req;
+	uint64_t indirect_op_data_req_phys_addr;
+	struct vring_desc *start_dp;
+	struct vq_desc_extra *dxp;
+	struct vring_desc *desc;
+	uint16_t needed = 1;
+	uint16_t num_entry;
+	uint16_t head_idx;
+	uint16_t idx = 0;
+
+	if (unlikely(txvq->vq_free_cnt == 0))
+		return -ENOSPC;
+	if (unlikely(txvq->vq_free_cnt < needed))
+		return -EMSGSIZE;
+	head_idx = txvq->vq_desc_head_idx;
+	if (unlikely(head_idx >= txvq->vq_nentries))
+		return -EFAULT;
+
+	dxp = &txvq->vq_descx[head_idx];
+
+	if (rte_mempool_get(txvq->mpool, &dxp->cookie)) {
+		VIRTIO_CRYPTO_TX_LOG_ERR("can not get cookie");
+		return -EFAULT;
+	}
+	crypto_op_cookie = dxp->cookie;
+	indirect_op_data_req_phys_addr =
+		rte_mempool_virt2iova(crypto_op_cookie);
+	op_data_req = (struct virtio_crypto_op_data_req *)crypto_op_cookie;
+	if (virtqueue_crypto_asym_pkt_header_arrange(cop, op_data_req, session))
+		return -EFAULT;
+
+	/* status is initialized to VIRTIO_CRYPTO_ERR */
+	((struct virtio_crypto_inhdr *)
+		((uint8_t *)op_data_req + req_data_len))->status =
+		VIRTIO_CRYPTO_ERR;
+
+	/* point to indirect vring entry */
+	desc = (struct vring_desc *)
+		((uint8_t *)op_data_req + indirect_vring_addr_offset);
+	for (idx = 0; idx < (NUM_ENTRY_VIRTIO_CRYPTO_OP - 1); idx++)
+		desc[idx].next = idx + 1;
+	desc[NUM_ENTRY_VIRTIO_CRYPTO_OP - 1].next = VQ_RING_DESC_CHAIN_END;
+
+	idx = 0;
+
+	/* indirect vring: first part, virtio_crypto_op_data_req */
+	desc[idx].addr = indirect_op_data_req_phys_addr;
+	desc[idx].len = req_data_len;
+	desc[idx++].flags = VRING_DESC_F_NEXT;
+
+	if (asym_op->rsa.op_type == RTE_CRYPTO_ASYM_OP_SIGN) {
+		/* indirect vring: src data */
+		desc[idx].addr = rte_mem_virt2iova(asym_op->rsa.message.data);
+		desc[idx].len = asym_op->rsa.message.length;
+		desc[idx++].flags = VRING_DESC_F_NEXT;
+
+		/* indirect vring: dst data */
+		desc[idx].addr = rte_mem_virt2iova(asym_op->rsa.sign.data);
+		desc[idx].len = asym_op->rsa.sign.length;
+		desc[idx++].flags = VRING_DESC_F_NEXT | VRING_DESC_F_WRITE;
+	} else if (asym_op->rsa.op_type == RTE_CRYPTO_ASYM_OP_VERIFY) {
+		/* indirect vring: src data */
+		desc[idx].addr = rte_mem_virt2iova(asym_op->rsa.sign.data);
+		desc[idx].len = asym_op->rsa.sign.length;
+		desc[idx++].flags = VRING_DESC_F_NEXT;
+
+		/* indirect vring: dst data */
+		desc[idx].addr = rte_mem_virt2iova(asym_op->rsa.message.data);
+		desc[idx].len = asym_op->rsa.message.length;
+		desc[idx++].flags = VRING_DESC_F_NEXT;
+	} else if (asym_op->rsa.op_type == RTE_CRYPTO_ASYM_OP_ENCRYPT) {
+		/* indirect vring: src data */
+		desc[idx].addr = rte_mem_virt2iova(asym_op->rsa.message.data);
+		desc[idx].len = asym_op->rsa.message.length;
+		desc[idx++].flags = VRING_DESC_F_NEXT;
+
+		/* indirect vring: dst data */
+		desc[idx].addr = rte_mem_virt2iova(asym_op->rsa.cipher.data);
+		desc[idx].len = asym_op->rsa.cipher.length;
+		desc[idx++].flags = VRING_DESC_F_NEXT | VRING_DESC_F_WRITE;
+	} else if (asym_op->rsa.op_type == RTE_CRYPTO_ASYM_OP_DECRYPT) {
+		/* indirect vring: src data */
+		desc[idx].addr = rte_mem_virt2iova(asym_op->rsa.cipher.data);
+		desc[idx].len = asym_op->rsa.cipher.length;
+		desc[idx++].flags = VRING_DESC_F_NEXT;
+
+		/* indirect vring: dst data */
+		desc[idx].addr = rte_mem_virt2iova(asym_op->rsa.message.data);
+		desc[idx].len = asym_op->rsa.message.length;
+		desc[idx++].flags = VRING_DESC_F_NEXT | VRING_DESC_F_WRITE;
+	} else {
+		VIRTIO_CRYPTO_TX_LOG_ERR("Invalid asym op");
+		return -EINVAL;
 	}
 
-	return ret;
+	/* indirect vring: last part, status returned */
+	desc[idx].addr = indirect_op_data_req_phys_addr + req_data_len;
+	desc[idx].len = sizeof(struct virtio_crypto_inhdr);
+	desc[idx++].flags = VRING_DESC_F_WRITE;
+
+	num_entry = idx;
+
+	/* save the infos to use when receiving packets */
+	dxp->crypto_op = (void *)cop;
+	dxp->ndescs = needed;
+
+	/* use a single buffer */
+	start_dp = txvq->vq_ring.desc;
+	start_dp[head_idx].addr = indirect_op_data_req_phys_addr +
+		indirect_vring_addr_offset;
+	start_dp[head_idx].len = num_entry * sizeof(struct vring_desc);
+	start_dp[head_idx].flags = VRING_DESC_F_INDIRECT;
+
+	idx = start_dp[head_idx].next;
+	txvq->vq_desc_head_idx = idx;
+	if (txvq->vq_desc_head_idx == VQ_RING_DESC_CHAIN_END)
+		txvq->vq_desc_tail_idx = idx;
+	txvq->vq_free_cnt = (uint16_t)(txvq->vq_free_cnt - needed);
+	vq_update_avail_ring(txvq, head_idx);
+
+	return 0;
 }
 
 static int
@@ -475,31 +641,40 @@ virtio_crypto_pkt_tx_burst(void *tx_queue, struct rte_crypto_op **tx_pkts,
 	VIRTIO_CRYPTO_TX_LOG_DBG("%d packets to xmit", nb_pkts);
 
 	for (nb_tx = 0; nb_tx < nb_pkts; nb_tx++) {
-		struct rte_mbuf *txm = tx_pkts[nb_tx]->sym->m_src;
-		/* nb_segs is always 1 at virtio crypto situation */
-		int need = txm->nb_segs - txvq->vq_free_cnt;
-
-		/*
-		 * Positive value indicates it hasn't enough space in vring
-		 * descriptors
-		 */
-		if (unlikely(need > 0)) {
+		if (tx_pkts[nb_tx]->type == RTE_CRYPTO_OP_TYPE_SYMMETRIC) {
+			struct rte_mbuf *txm = tx_pkts[nb_tx]->sym->m_src;
+			/* nb_segs is always 1 at virtio crypto situation */
+			int need = txm->nb_segs - txvq->vq_free_cnt;
+
 			/*
-			 * try it again because the receive process may be
-			 * free some space
+			 * Positive value indicates it hasn't enough space in vring
+			 * descriptors
 			 */
-			need = txm->nb_segs - txvq->vq_free_cnt;
 			if (unlikely(need > 0)) {
-				VIRTIO_CRYPTO_TX_LOG_DBG("No free tx "
-					"descriptors to transmit");
-				break;
+				/*
+				 * try it again because the receive process may be
+				 * free some space
+				 */
+				need = txm->nb_segs - txvq->vq_free_cnt;
+				if (unlikely(need > 0)) {
+					VIRTIO_CRYPTO_TX_LOG_DBG("No free tx "
+											 "descriptors to transmit");
+					break;
+				}
 			}
-		}
 
-		txvq->packets_sent_total++;
+			/* Enqueue Packet buffers */
+			error = virtqueue_crypto_sym_enqueue_xmit(txvq, tx_pkts[nb_tx]);
+		} else if (tx_pkts[nb_tx]->type == RTE_CRYPTO_OP_TYPE_ASYMMETRIC) {
+			/* Enqueue Packet buffers */
+			error = virtqueue_crypto_asym_enqueue_xmit(txvq, tx_pkts[nb_tx]);
+		} else {
+			VIRTIO_CRYPTO_TX_LOG_ERR("invalid crypto op type %u",
+				tx_pkts[nb_tx]->type);
+			txvq->packets_sent_failed++;
+			continue;
+		}
 
-		/* Enqueue Packet buffers */
-		error = virtqueue_crypto_enqueue_xmit(txvq, tx_pkts[nb_tx]);
 		if (unlikely(error)) {
 			if (error == ENOSPC)
 				VIRTIO_CRYPTO_TX_LOG_ERR(
@@ -513,6 +688,8 @@ virtio_crypto_pkt_tx_burst(void *tx_queue, struct rte_crypto_op **tx_pkts,
 			txvq->packets_sent_failed++;
 			break;
 		}
+
+		txvq->packets_sent_total++;
 	}
 
 	if (likely(nb_tx)) {
diff --git a/lib/cryptodev/cryptodev_pmd.h b/lib/cryptodev/cryptodev_pmd.h
index 5c84a3b847..929c6defe9 100644
--- a/lib/cryptodev/cryptodev_pmd.h
+++ b/lib/cryptodev/cryptodev_pmd.h
@@ -715,6 +715,12 @@ struct rte_cryptodev_asym_session {
 	uint8_t sess_private_data[];
 };
 
+/**
+ * Helper macro to get session private data
+ */
+#define CRYPTODEV_GET_ASYM_SESS_PRIV(s) \
+	((void *)(((struct rte_cryptodev_asym_session *)s)->sess_private_data))
+
 #ifdef __cplusplus
 }
 #endif
-- 
2.25.1

