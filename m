Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E8A3C021B5
	for <dpdk-dev@archiver.kernel.org>; Sat, 22 Feb 2025 09:17:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AEDE542DE3;
	Sat, 22 Feb 2025 10:17:18 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 9436042DBE
 for <dev@dpdk.org>; Sat, 22 Feb 2025 10:17:16 +0100 (CET)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51M9GhIR020591;
 Sat, 22 Feb 2025 01:17:15 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=U
 iAJKWM+svBoWfsvXlFxhrQQ7OzApJ91X7CQlCjJYKc=; b=L1tu6drj9ANIO5kKU
 9VJotI/bI9HU4hkpOKT1HmtxtvUzG7FPMhLuM8i1sbT0n9mw4uwfywe6kI4fy5+r
 WokkxBAnI1eujImHdvdVQNJxmlobtMTcHVg9SiaYGcSaMX4vcb5hwg7tGIzOJKSn
 XZ/xH1XrSY8XetuSUuguqn7aBCbLu/skEJeTZgDnF08MHSgN1Zo99y5o+vw2kCld
 PXgQK/bAvwWJm3EZSmO7FC7hzVgDm04pmvplalv35O+wotxtFyFCQsRAyGSqG2NZ
 2Y+ta1RjmUxZ6XUQioGTyJ7wb3HCpQNb60xDTHZwW6klqRrdmpd97VsrmI1yPyEv
 MIKNw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 44ya2203q8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 22 Feb 2025 01:17:15 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sat, 22 Feb 2025 01:17:14 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Sat, 22 Feb 2025 01:17:14 -0800
Received: from IN-lckQE5Rwctls.marvell.com (IN-lckQE5Rwctls.marvell.com
 [10.28.163.68])
 by maili.marvell.com (Postfix) with ESMTP id 30DB73F705E;
 Sat, 22 Feb 2025 01:17:10 -0800 (PST)
From: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
To: <dev@dpdk.org>, Jay Zhou <jianjay.zhou@huawei.com>
CC: <anoobj@marvell.com>, Akhil Goyal <gakhil@marvell.com>, "Gowrishankar
 Muthukrishnan" <gmuthukrishn@marvell.com>
Subject: [v4 2/6] crypto/virtio: refactor queue operations
Date: Sat, 22 Feb 2025 14:46:51 +0530
Message-ID: <f11ba21bbd10267cd8b6ea6780e3c10cbac01da1.1740212415.git.gmuthukrishn@marvell.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <cover.1740212415.git.gmuthukrishn@marvell.com>
References: <cover.1740212415.git.gmuthukrishn@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: B3BUlNZBY6cqL_rpgkLboBZHWOnVxMtv
X-Proofpoint-ORIG-GUID: B3BUlNZBY6cqL_rpgkLboBZHWOnVxMtv
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

Move existing control queue operations into a common place
that would be shared with other virtio type of devices.

Signed-off-by: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
---
Depends-on: series-34682 ("vhost: add RSA support")
---
 drivers/crypto/virtio/meson.build          |   1 +
 drivers/crypto/virtio/virtio_crypto_algs.h |   2 +-
 drivers/crypto/virtio/virtio_cryptodev.c   | 563 ++++++++-------------
 drivers/crypto/virtio/virtio_cvq.c         | 129 +++++
 drivers/crypto/virtio/virtio_cvq.h         |  33 ++
 drivers/crypto/virtio/virtio_pci.h         |   6 +-
 drivers/crypto/virtio/virtio_ring.h        |  12 +-
 drivers/crypto/virtio/virtio_rxtx.c        |  42 +-
 drivers/crypto/virtio/virtio_rxtx.h        |  13 +
 drivers/crypto/virtio/virtqueue.c          | 191 ++++++-
 drivers/crypto/virtio/virtqueue.h          |  89 +++-
 11 files changed, 691 insertions(+), 390 deletions(-)
 create mode 100644 drivers/crypto/virtio/virtio_cvq.c
 create mode 100644 drivers/crypto/virtio/virtio_cvq.h
 create mode 100644 drivers/crypto/virtio/virtio_rxtx.h

diff --git a/drivers/crypto/virtio/meson.build b/drivers/crypto/virtio/meson.build
index 45533c9b89..d2c3b3ad07 100644
--- a/drivers/crypto/virtio/meson.build
+++ b/drivers/crypto/virtio/meson.build
@@ -11,6 +11,7 @@ includes += include_directories('../../../lib/vhost')
 deps += 'bus_pci'
 sources = files(
         'virtio_cryptodev.c',
+        'virtio_cvq.c',
         'virtio_pci.c',
         'virtio_rxtx.c',
         'virtqueue.c',
diff --git a/drivers/crypto/virtio/virtio_crypto_algs.h b/drivers/crypto/virtio/virtio_crypto_algs.h
index 4c44af3733..3824017ca5 100644
--- a/drivers/crypto/virtio/virtio_crypto_algs.h
+++ b/drivers/crypto/virtio/virtio_crypto_algs.h
@@ -22,7 +22,7 @@ struct virtio_crypto_session {
 		phys_addr_t phys_addr;
 	} aad;
 
-	struct virtio_crypto_op_ctrl_req ctrl;
+	struct virtio_pmd_ctrl ctrl;
 };
 
 #endif /* _VIRTIO_CRYPTO_ALGS_H_ */
diff --git a/drivers/crypto/virtio/virtio_cryptodev.c b/drivers/crypto/virtio/virtio_cryptodev.c
index 6a264bc24a..6bb76ff15e 100644
--- a/drivers/crypto/virtio/virtio_cryptodev.c
+++ b/drivers/crypto/virtio/virtio_cryptodev.c
@@ -64,211 +64,6 @@ static const struct rte_cryptodev_capabilities virtio_capabilities[] = {
 
 uint8_t cryptodev_virtio_driver_id;
 
-#define NUM_ENTRY_SYM_CREATE_SESSION 4
-
-static int
-virtio_crypto_send_command(struct virtqueue *vq,
-		struct virtio_crypto_op_ctrl_req *ctrl, uint8_t *cipher_key,
-		uint8_t *auth_key, struct virtio_crypto_session *session)
-{
-	uint8_t idx = 0;
-	uint8_t needed = 1;
-	uint32_t head = 0;
-	uint32_t len_cipher_key = 0;
-	uint32_t len_auth_key = 0;
-	uint32_t len_ctrl_req = sizeof(struct virtio_crypto_op_ctrl_req);
-	uint32_t len_session_input = sizeof(struct virtio_crypto_session_input);
-	uint32_t len_total = 0;
-	uint32_t input_offset = 0;
-	void *virt_addr_started = NULL;
-	phys_addr_t phys_addr_started;
-	struct vring_desc *desc;
-	uint32_t desc_offset;
-	struct virtio_crypto_session_input *input;
-	int ret;
-
-	PMD_INIT_FUNC_TRACE();
-
-	if (session == NULL) {
-		VIRTIO_CRYPTO_SESSION_LOG_ERR("session is NULL.");
-		return -EINVAL;
-	}
-	/* cipher only is supported, it is available if auth_key is NULL */
-	if (!cipher_key) {
-		VIRTIO_CRYPTO_SESSION_LOG_ERR("cipher key is NULL.");
-		return -EINVAL;
-	}
-
-	head = vq->vq_desc_head_idx;
-	VIRTIO_CRYPTO_INIT_LOG_DBG("vq->vq_desc_head_idx = %d, vq = %p",
-					head, vq);
-
-	if (vq->vq_free_cnt < needed) {
-		VIRTIO_CRYPTO_SESSION_LOG_ERR("Not enough entry");
-		return -ENOSPC;
-	}
-
-	/* calculate the length of cipher key */
-	if (session->ctrl.header.algo == VIRTIO_CRYPTO_SERVICE_CIPHER) {
-		switch (ctrl->u.sym_create_session.op_type) {
-		case VIRTIO_CRYPTO_SYM_OP_CIPHER:
-			len_cipher_key = ctrl->u.sym_create_session.u.cipher.para.keylen;
-			break;
-		case VIRTIO_CRYPTO_SYM_OP_ALGORITHM_CHAINING:
-			len_cipher_key =
-				ctrl->u.sym_create_session.u.chain.para.cipher_param.keylen;
-			break;
-		default:
-			VIRTIO_CRYPTO_SESSION_LOG_ERR("invalid op type");
-			return -EINVAL;
-		}
-	} else if (session->ctrl.header.algo == VIRTIO_CRYPTO_AKCIPHER_RSA) {
-		len_cipher_key = ctrl->u.akcipher_create_session.para.keylen;
-	} else {
-		VIRTIO_CRYPTO_SESSION_LOG_ERR("Invalid crypto service for cipher key");
-		return -EINVAL;
-	}
-
-	/* calculate the length of auth key */
-	if (auth_key) {
-		len_auth_key =
-			ctrl->u.sym_create_session.u.chain.para.u.mac_param
-				.auth_key_len;
-	}
-
-	/*
-	 * malloc memory to store indirect vring_desc entries, including
-	 * ctrl request, cipher key, auth key, session input and desc vring
-	 */
-	desc_offset = len_ctrl_req + len_cipher_key + len_auth_key
-		+ len_session_input;
-	virt_addr_started = rte_malloc(NULL,
-		desc_offset + NUM_ENTRY_SYM_CREATE_SESSION
-			* sizeof(struct vring_desc), RTE_CACHE_LINE_SIZE);
-	if (virt_addr_started == NULL) {
-		VIRTIO_CRYPTO_SESSION_LOG_ERR("not enough heap memory");
-		return -ENOSPC;
-	}
-	phys_addr_started = rte_malloc_virt2iova(virt_addr_started);
-
-	/* address to store indirect vring desc entries */
-	desc = (struct vring_desc *)
-		((uint8_t *)virt_addr_started + desc_offset);
-
-	/*  ctrl req part */
-	memcpy(virt_addr_started, ctrl, len_ctrl_req);
-	desc[idx].addr = phys_addr_started;
-	desc[idx].len = len_ctrl_req;
-	desc[idx].flags = VRING_DESC_F_NEXT;
-	desc[idx].next = idx + 1;
-	idx++;
-	len_total += len_ctrl_req;
-	input_offset += len_ctrl_req;
-
-	/* cipher key part */
-	if (len_cipher_key > 0) {
-		memcpy((uint8_t *)virt_addr_started + len_total,
-			cipher_key, len_cipher_key);
-
-		desc[idx].addr = phys_addr_started + len_total;
-		desc[idx].len = len_cipher_key;
-		desc[idx].flags = VRING_DESC_F_NEXT;
-		desc[idx].next = idx + 1;
-		idx++;
-		len_total += len_cipher_key;
-		input_offset += len_cipher_key;
-	}
-
-	/* auth key part */
-	if (len_auth_key > 0) {
-		memcpy((uint8_t *)virt_addr_started + len_total,
-			auth_key, len_auth_key);
-
-		desc[idx].addr = phys_addr_started + len_total;
-		desc[idx].len = len_auth_key;
-		desc[idx].flags = VRING_DESC_F_NEXT;
-		desc[idx].next = idx + 1;
-		idx++;
-		len_total += len_auth_key;
-		input_offset += len_auth_key;
-	}
-
-	/* input part */
-	input = (struct virtio_crypto_session_input *)
-		((uint8_t *)virt_addr_started + input_offset);
-	input->status = VIRTIO_CRYPTO_ERR;
-	input->session_id = ~0ULL;
-	desc[idx].addr = phys_addr_started + len_total;
-	desc[idx].len = len_session_input;
-	desc[idx].flags = VRING_DESC_F_WRITE;
-	idx++;
-
-	/* use a single desc entry */
-	vq->vq_ring.desc[head].addr = phys_addr_started + desc_offset;
-	vq->vq_ring.desc[head].len = idx * sizeof(struct vring_desc);
-	vq->vq_ring.desc[head].flags = VRING_DESC_F_INDIRECT;
-	vq->vq_free_cnt--;
-
-	vq->vq_desc_head_idx = vq->vq_ring.desc[head].next;
-
-	vq_update_avail_ring(vq, head);
-	vq_update_avail_idx(vq);
-
-	VIRTIO_CRYPTO_INIT_LOG_DBG("vq->vq_queue_index = %d",
-					vq->vq_queue_index);
-
-	virtqueue_notify(vq);
-
-	rte_rmb();
-	while (vq->vq_used_cons_idx == vq->vq_ring.used->idx) {
-		rte_rmb();
-		usleep(100);
-	}
-
-	while (vq->vq_used_cons_idx != vq->vq_ring.used->idx) {
-		uint32_t idx, desc_idx, used_idx;
-		struct vring_used_elem *uep;
-
-		used_idx = (uint32_t)(vq->vq_used_cons_idx
-				& (vq->vq_nentries - 1));
-		uep = &vq->vq_ring.used->ring[used_idx];
-		idx = (uint32_t) uep->id;
-		desc_idx = idx;
-
-		while (vq->vq_ring.desc[desc_idx].flags & VRING_DESC_F_NEXT) {
-			desc_idx = vq->vq_ring.desc[desc_idx].next;
-			vq->vq_free_cnt++;
-		}
-
-		vq->vq_ring.desc[desc_idx].next = vq->vq_desc_head_idx;
-		vq->vq_desc_head_idx = idx;
-
-		vq->vq_used_cons_idx++;
-		vq->vq_free_cnt++;
-	}
-
-	VIRTIO_CRYPTO_INIT_LOG_DBG("vq->vq_free_cnt=%d", vq->vq_free_cnt);
-	VIRTIO_CRYPTO_INIT_LOG_DBG("vq->vq_desc_head_idx=%d", vq->vq_desc_head_idx);
-
-	/* get the result */
-	if (input->status != VIRTIO_CRYPTO_OK) {
-		VIRTIO_CRYPTO_SESSION_LOG_ERR("Something wrong on backend! "
-				"status=%u, session_id=%" PRIu64 "",
-				input->status, input->session_id);
-		rte_free(virt_addr_started);
-		ret = -1;
-	} else {
-		session->session_id = input->session_id;
-
-		VIRTIO_CRYPTO_SESSION_LOG_INFO("Create session successfully, "
-				"session_id=%" PRIu64 "", input->session_id);
-		rte_free(virt_addr_started);
-		ret = 0;
-	}
-
-	return ret;
-}
-
 void
 virtio_crypto_queue_release(struct virtqueue *vq)
 {
@@ -281,6 +76,7 @@ virtio_crypto_queue_release(struct virtqueue *vq)
 		/* Select and deactivate the queue */
 		VTPCI_OPS(hw)->del_queue(hw, vq);
 
+		hw->vqs[vq->vq_queue_index] = NULL;
 		rte_memzone_free(vq->mz);
 		rte_mempool_free(vq->mpool);
 		rte_free(vq);
@@ -299,8 +95,7 @@ virtio_crypto_queue_setup(struct rte_cryptodev *dev,
 {
 	char vq_name[VIRTQUEUE_MAX_NAME_SZ];
 	char mpool_name[MPOOL_MAX_NAME_SZ];
-	const struct rte_memzone *mz;
-	unsigned int vq_size, size;
+	unsigned int vq_size;
 	struct virtio_crypto_hw *hw = dev->data->dev_private;
 	struct virtqueue *vq = NULL;
 	uint32_t i = 0;
@@ -339,16 +134,26 @@ virtio_crypto_queue_setup(struct rte_cryptodev *dev,
 				"dev%d_controlqueue_mpool",
 				dev->data->dev_id);
 	}
-	size = RTE_ALIGN_CEIL(sizeof(*vq) +
-				vq_size * sizeof(struct vq_desc_extra),
-				RTE_CACHE_LINE_SIZE);
-	vq = rte_zmalloc_socket(vq_name, size, RTE_CACHE_LINE_SIZE,
-				socket_id);
+
+	/*
+	 * Using part of the vring entries is permitted, but the maximum
+	 * is vq_size
+	 */
+	if (nb_desc == 0 || nb_desc > vq_size)
+		nb_desc = vq_size;
+
+	if (hw->vqs[vtpci_queue_idx])
+		vq = hw->vqs[vtpci_queue_idx];
+	else
+		vq = virtcrypto_queue_alloc(hw, vtpci_queue_idx, nb_desc,
+				socket_id, vq_name);
 	if (vq == NULL) {
 		VIRTIO_CRYPTO_INIT_LOG_ERR("Can not allocate virtqueue");
 		return -ENOMEM;
 	}
 
+	hw->vqs[vtpci_queue_idx] = vq;
+
 	if (queue_type == VTCRYPTO_DATAQ) {
 		/* pre-allocate a mempool and use it in the data plane to
 		 * improve performance
@@ -356,7 +161,7 @@ virtio_crypto_queue_setup(struct rte_cryptodev *dev,
 		vq->mpool = rte_mempool_lookup(mpool_name);
 		if (vq->mpool == NULL)
 			vq->mpool = rte_mempool_create(mpool_name,
-					vq_size,
+					nb_desc,
 					sizeof(struct virtio_crypto_op_cookie),
 					RTE_CACHE_LINE_SIZE, 0,
 					NULL, NULL, NULL, NULL, socket_id,
@@ -366,7 +171,7 @@ virtio_crypto_queue_setup(struct rte_cryptodev *dev,
 					"Cannot create mempool");
 			goto mpool_create_err;
 		}
-		for (i = 0; i < vq_size; i++) {
+		for (i = 0; i < nb_desc; i++) {
 			vq->vq_descx[i].cookie =
 				rte_zmalloc("crypto PMD op cookie pointer",
 					sizeof(struct virtio_crypto_op_cookie),
@@ -379,67 +184,10 @@ virtio_crypto_queue_setup(struct rte_cryptodev *dev,
 		}
 	}
 
-	vq->hw = hw;
-	vq->dev_id = dev->data->dev_id;
-	vq->vq_queue_index = vtpci_queue_idx;
-	vq->vq_nentries = vq_size;
-
-	/*
-	 * Using part of the vring entries is permitted, but the maximum
-	 * is vq_size
-	 */
-	if (nb_desc == 0 || nb_desc > vq_size)
-		nb_desc = vq_size;
-	vq->vq_free_cnt = nb_desc;
-
-	/*
-	 * Reserve a memzone for vring elements
-	 */
-	size = vring_size(vq_size, VIRTIO_PCI_VRING_ALIGN);
-	vq->vq_ring_size = RTE_ALIGN_CEIL(size, VIRTIO_PCI_VRING_ALIGN);
-	VIRTIO_CRYPTO_INIT_LOG_DBG("%s vring_size: %d, rounded_vring_size: %d",
-			(queue_type == VTCRYPTO_DATAQ) ? "dataq" : "ctrlq",
-			size, vq->vq_ring_size);
-
-	mz = rte_memzone_reserve_aligned(vq_name, vq->vq_ring_size,
-			socket_id, 0, VIRTIO_PCI_VRING_ALIGN);
-	if (mz == NULL) {
-		if (rte_errno == EEXIST)
-			mz = rte_memzone_lookup(vq_name);
-		if (mz == NULL) {
-			VIRTIO_CRYPTO_INIT_LOG_ERR("not enough memory");
-			goto mz_reserve_err;
-		}
-	}
-
-	/*
-	 * Virtio PCI device VIRTIO_PCI_QUEUE_PF register is 32bit,
-	 * and only accepts 32 bit page frame number.
-	 * Check if the allocated physical memory exceeds 16TB.
-	 */
-	if ((mz->iova + vq->vq_ring_size - 1)
-				>> (VIRTIO_PCI_QUEUE_ADDR_SHIFT + 32)) {
-		VIRTIO_CRYPTO_INIT_LOG_ERR("vring address shouldn't be "
-					"above 16TB!");
-		goto vring_addr_err;
-	}
-
-	memset(mz->addr, 0, sizeof(mz->len));
-	vq->mz = mz;
-	vq->vq_ring_mem = mz->iova;
-	vq->vq_ring_virt_mem = mz->addr;
-	VIRTIO_CRYPTO_INIT_LOG_DBG("vq->vq_ring_mem(physical): 0x%"PRIx64,
-					(uint64_t)mz->iova);
-	VIRTIO_CRYPTO_INIT_LOG_DBG("vq->vq_ring_virt_mem: 0x%"PRIx64,
-					(uint64_t)(uintptr_t)mz->addr);
-
 	*pvq = vq;
 
 	return 0;
 
-vring_addr_err:
-	rte_memzone_free(mz);
-mz_reserve_err:
 cookie_alloc_err:
 	rte_mempool_free(vq->mpool);
 	if (i != 0) {
@@ -451,31 +199,6 @@ virtio_crypto_queue_setup(struct rte_cryptodev *dev,
 	return -ENOMEM;
 }
 
-static int
-virtio_crypto_ctrlq_setup(struct rte_cryptodev *dev, uint16_t queue_idx)
-{
-	int ret;
-	struct virtqueue *vq;
-	struct virtio_crypto_hw *hw = dev->data->dev_private;
-
-	/* if virtio device has started, do not touch the virtqueues */
-	if (dev->data->dev_started)
-		return 0;
-
-	PMD_INIT_FUNC_TRACE();
-
-	ret = virtio_crypto_queue_setup(dev, VTCRYPTO_CTRLQ, queue_idx,
-			0, SOCKET_ID_ANY, &vq);
-	if (ret < 0) {
-		VIRTIO_CRYPTO_INIT_LOG_ERR("control vq initialization failed");
-		return ret;
-	}
-
-	hw->cvq = vq;
-
-	return 0;
-}
-
 static void
 virtio_crypto_free_queues(struct rte_cryptodev *dev)
 {
@@ -484,10 +207,6 @@ virtio_crypto_free_queues(struct rte_cryptodev *dev)
 
 	PMD_INIT_FUNC_TRACE();
 
-	/* control queue release */
-	virtio_crypto_queue_release(hw->cvq);
-	hw->cvq = NULL;
-
 	/* data queue release */
 	for (i = 0; i < hw->max_dataqueues; i++) {
 		virtio_crypto_queue_release(dev->data->queue_pairs[i]);
@@ -498,6 +217,15 @@ virtio_crypto_free_queues(struct rte_cryptodev *dev)
 static int
 virtio_crypto_dev_close(struct rte_cryptodev *dev __rte_unused)
 {
+	struct virtio_crypto_hw *hw = dev->data->dev_private;
+
+	PMD_INIT_FUNC_TRACE();
+
+	/* control queue release */
+	if (hw->cvq)
+		virtio_crypto_queue_release(virtcrypto_cq_to_vq(hw->cvq));
+
+	hw->cvq = NULL;
 	return 0;
 }
 
@@ -678,6 +406,99 @@ virtio_negotiate_features(struct virtio_crypto_hw *hw, uint64_t req_features)
 	return 0;
 }
 
+static void
+virtio_control_queue_notify(struct virtqueue *vq, __rte_unused void *cookie)
+{
+	virtqueue_notify(vq);
+}
+
+static int
+virtio_crypto_init_queue(struct rte_cryptodev *dev, uint16_t queue_idx)
+{
+	struct virtio_crypto_hw *hw = dev->data->dev_private;
+	int queue_type = virtio_get_queue_type(hw, queue_idx);
+	int numa_node = dev->device->numa_node;
+	char vq_name[VIRTQUEUE_MAX_NAME_SZ];
+	unsigned int vq_size;
+	struct virtqueue *vq;
+	int ret;
+
+	PMD_INIT_LOG(INFO, "setting up queue: %u on NUMA node %d",
+			queue_idx, numa_node);
+
+	/*
+	 * Read the virtqueue size from the Queue Size field
+	 * Always power of 2 and if 0 virtqueue does not exist
+	 */
+	vq_size = VTPCI_OPS(hw)->get_queue_num(hw, queue_idx);
+	PMD_INIT_LOG(DEBUG, "vq_size: %u", vq_size);
+	if (vq_size == 0) {
+		PMD_INIT_LOG(ERR, "virtqueue does not exist");
+		return -EINVAL;
+	}
+
+	if (!rte_is_power_of_2(vq_size)) {
+		PMD_INIT_LOG(ERR, "split virtqueue size is not power of 2");
+		return -EINVAL;
+	}
+
+	snprintf(vq_name, sizeof(vq_name), "dev%d_vq%d", dev->data->dev_id, queue_idx);
+
+	vq = virtcrypto_queue_alloc(hw, queue_idx, vq_size, numa_node, vq_name);
+	if (!vq) {
+		PMD_INIT_LOG(ERR, "virtqueue init failed");
+		return -ENOMEM;
+	}
+
+	hw->vqs[queue_idx] = vq;
+
+	if (queue_type == VTCRYPTO_CTRLQ) {
+		hw->cvq = &vq->cq;
+		vq->cq.notify_queue = &virtio_control_queue_notify;
+	}
+
+	if (VTPCI_OPS(hw)->setup_queue(hw, vq) < 0) {
+		PMD_INIT_LOG(ERR, "setup_queue failed");
+		ret = -EINVAL;
+		goto clean_vq;
+	}
+
+	return 0;
+
+clean_vq:
+	if (queue_type == VTCRYPTO_CTRLQ)
+		hw->cvq = NULL;
+	virtcrypto_queue_free(vq);
+	hw->vqs[queue_idx] = NULL;
+
+	return ret;
+}
+
+static int
+virtio_crypto_alloc_queues(struct rte_cryptodev *dev)
+{
+	struct virtio_crypto_hw *hw = dev->data->dev_private;
+	uint16_t nr_vq = hw->max_dataqueues + 1;
+	uint16_t i;
+	int ret;
+
+	hw->vqs = rte_zmalloc(NULL, sizeof(struct virtqueue *) * nr_vq, 0);
+	if (!hw->vqs) {
+		PMD_INIT_LOG(ERR, "failed to allocate vqs");
+		return -ENOMEM;
+	}
+
+	for (i = 0; i < nr_vq; i++) {
+		ret = virtio_crypto_init_queue(dev, i);
+		if (ret < 0) {
+			virtio_crypto_free_queues(dev);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
 /* reset device and renegotiate features if needed */
 static int
 virtio_crypto_init_device(struct rte_cryptodev *cryptodev,
@@ -803,8 +624,6 @@ static int
 virtio_crypto_dev_configure(struct rte_cryptodev *cryptodev,
 	struct rte_cryptodev_config *config __rte_unused)
 {
-	struct virtio_crypto_hw *hw = cryptodev->data->dev_private;
-
 	PMD_INIT_FUNC_TRACE();
 
 	if (virtio_crypto_init_device(cryptodev,
@@ -815,10 +634,11 @@ virtio_crypto_dev_configure(struct rte_cryptodev *cryptodev,
 	 * [0, 1, ... ,(config->max_dataqueues - 1)] are data queues
 	 * config->max_dataqueues is the control queue
 	 */
-	if (virtio_crypto_ctrlq_setup(cryptodev, hw->max_dataqueues) < 0) {
-		VIRTIO_CRYPTO_INIT_LOG_ERR("control queue setup error");
+	if (virtio_crypto_alloc_queues(cryptodev) < 0) {
+		VIRTIO_CRYPTO_DRV_LOG_ERR("failed to create virtqueues");
 		return -1;
 	}
+
 	virtio_crypto_ctrlq_start(cryptodev);
 
 	return 0;
@@ -953,7 +773,7 @@ virtio_crypto_clear_session(
 	uint64_t session_id = ctrl->u.destroy_session.session_id;
 
 	hw = dev->data->dev_private;
-	vq = hw->cvq;
+	vq = virtcrypto_cq_to_vq(hw->cvq);
 
 	VIRTIO_CRYPTO_SESSION_LOG_INFO("vq->vq_desc_head_idx = %d, "
 			"vq = %p", vq->vq_desc_head_idx, vq);
@@ -988,14 +808,14 @@ virtio_crypto_clear_session(
 
 	/* use only a single desc entry */
 	head = vq->vq_desc_head_idx;
-	vq->vq_ring.desc[head].flags = VRING_DESC_F_INDIRECT;
-	vq->vq_ring.desc[head].addr = malloc_phys_addr + desc_offset;
-	vq->vq_ring.desc[head].len
+	vq->vq_split.ring.desc[head].flags = VRING_DESC_F_INDIRECT;
+	vq->vq_split.ring.desc[head].addr = malloc_phys_addr + desc_offset;
+	vq->vq_split.ring.desc[head].len
 		= NUM_ENTRY_SYM_CLEAR_SESSION
 		* sizeof(struct vring_desc);
 	vq->vq_free_cnt -= needed;
 
-	vq->vq_desc_head_idx = vq->vq_ring.desc[head].next;
+	vq->vq_desc_head_idx = vq->vq_split.ring.desc[head].next;
 
 	vq_update_avail_ring(vq, head);
 	vq_update_avail_idx(vq);
@@ -1006,27 +826,27 @@ virtio_crypto_clear_session(
 	virtqueue_notify(vq);
 
 	rte_rmb();
-	while (vq->vq_used_cons_idx == vq->vq_ring.used->idx) {
+	while (vq->vq_used_cons_idx == vq->vq_split.ring.used->idx) {
 		rte_rmb();
 		usleep(100);
 	}
 
-	while (vq->vq_used_cons_idx != vq->vq_ring.used->idx) {
+	while (vq->vq_used_cons_idx != vq->vq_split.ring.used->idx) {
 		uint32_t idx, desc_idx, used_idx;
 		struct vring_used_elem *uep;
 
 		used_idx = (uint32_t)(vq->vq_used_cons_idx
 				& (vq->vq_nentries - 1));
-		uep = &vq->vq_ring.used->ring[used_idx];
+		uep = &vq->vq_split.ring.used->ring[used_idx];
 		idx = (uint32_t) uep->id;
 		desc_idx = idx;
-		while (vq->vq_ring.desc[desc_idx].flags
+		while (vq->vq_split.ring.desc[desc_idx].flags
 				& VRING_DESC_F_NEXT) {
-			desc_idx = vq->vq_ring.desc[desc_idx].next;
+			desc_idx = vq->vq_split.ring.desc[desc_idx].next;
 			vq->vq_free_cnt++;
 		}
 
-		vq->vq_ring.desc[desc_idx].next = vq->vq_desc_head_idx;
+		vq->vq_split.ring.desc[desc_idx].next = vq->vq_desc_head_idx;
 		vq->vq_desc_head_idx = idx;
 		vq->vq_used_cons_idx++;
 		vq->vq_free_cnt++;
@@ -1377,14 +1197,16 @@ virtio_crypto_sym_configure_session(
 		struct rte_crypto_sym_xform *xform,
 		struct rte_cryptodev_sym_session *sess)
 {
-	int ret;
-	struct virtio_crypto_session *session;
-	struct virtio_crypto_op_ctrl_req *ctrl_req;
-	enum virtio_crypto_cmd_id cmd_id;
 	uint8_t cipher_key_data[VIRTIO_CRYPTO_MAX_KEY_SIZE] = {0};
 	uint8_t auth_key_data[VIRTIO_CRYPTO_MAX_KEY_SIZE] = {0};
+	struct virtio_crypto_op_ctrl_req *ctrl_req;
+	struct virtio_crypto_session_input *input;
+	struct virtio_crypto_session *session;
+	enum virtio_crypto_cmd_id cmd_id;
 	struct virtio_crypto_hw *hw;
-	struct virtqueue *control_vq;
+	struct virtio_pmd_ctrl *ctrl;
+	int dlen[2], dnum;
+	int ret;
 
 	PMD_INIT_FUNC_TRACE();
 
@@ -1396,13 +1218,13 @@ virtio_crypto_sym_configure_session(
 	}
 	session = CRYPTODEV_GET_SYM_SESS_PRIV(sess);
 	memset(session, 0, sizeof(struct virtio_crypto_session));
-	ctrl_req = &session->ctrl;
+	ctrl = &session->ctrl;
+	ctrl_req = &ctrl->hdr;
 	ctrl_req->header.opcode = VIRTIO_CRYPTO_CIPHER_CREATE_SESSION;
 	/* FIXME: support multiqueue */
 	ctrl_req->header.queue_id = 0;
 
 	hw = dev->data->dev_private;
-	control_vq = hw->cvq;
 
 	cmd_id = virtio_crypto_get_chain_order(xform);
 	if (cmd_id == VIRTIO_CRYPTO_CMD_CIPHER_HASH)
@@ -1414,7 +1236,13 @@ virtio_crypto_sym_configure_session(
 
 	switch (cmd_id) {
 	case VIRTIO_CRYPTO_CMD_CIPHER_HASH:
-	case VIRTIO_CRYPTO_CMD_HASH_CIPHER:
+	case VIRTIO_CRYPTO_CMD_HASH_CIPHER: {
+		struct rte_crypto_cipher_xform *cipher_xform = NULL;
+		struct rte_crypto_auth_xform *auth_xform = NULL;
+
+		cipher_xform = virtio_crypto_get_cipher_xform(xform);
+		auth_xform = virtio_crypto_get_auth_xform(xform);
+
 		ctrl_req->u.sym_create_session.op_type
 			= VIRTIO_CRYPTO_SYM_OP_ALGORITHM_CHAINING;
 
@@ -1425,15 +1253,19 @@ virtio_crypto_sym_configure_session(
 				"padding sym op ctrl req failed");
 			goto error_out;
 		}
-		ret = virtio_crypto_send_command(control_vq, ctrl_req,
-			cipher_key_data, auth_key_data, session);
-		if (ret < 0) {
-			VIRTIO_CRYPTO_SESSION_LOG_ERR(
-				"create session failed: %d", ret);
-			goto error_out;
-		}
+
+		dlen[0] = cipher_xform->key.length;
+		memcpy(ctrl->data, cipher_key_data, dlen[0]);
+		dlen[1] = auth_xform->key.length;
+		memcpy(ctrl->data + dlen[0], auth_key_data, dlen[1]);
+		dnum = 2;
 		break;
-	case VIRTIO_CRYPTO_CMD_CIPHER:
+	}
+	case VIRTIO_CRYPTO_CMD_CIPHER: {
+		struct rte_crypto_cipher_xform *cipher_xform = NULL;
+
+		cipher_xform = virtio_crypto_get_cipher_xform(xform);
+
 		ctrl_req->u.sym_create_session.op_type
 			= VIRTIO_CRYPTO_SYM_OP_CIPHER;
 		ret = virtio_crypto_sym_pad_op_ctrl_req(ctrl_req, xform,
@@ -1443,22 +1275,43 @@ virtio_crypto_sym_configure_session(
 				"padding sym op ctrl req failed");
 			goto error_out;
 		}
-		ret = virtio_crypto_send_command(control_vq, ctrl_req,
-			cipher_key_data, NULL, session);
-		if (ret < 0) {
-			VIRTIO_CRYPTO_SESSION_LOG_ERR(
-				"create session failed: %d", ret);
-			goto error_out;
-		}
+
+		dlen[0] = cipher_xform->key.length;
+		memcpy(ctrl->data, cipher_key_data, dlen[0]);
+		dnum = 1;
 		break;
+	}
 	default:
 		ret = -ENOTSUP;
 		VIRTIO_CRYPTO_SESSION_LOG_ERR(
 			"Unsupported operation chain order parameter");
 		goto error_out;
 	}
-	return 0;
 
+	input = &ctrl->input;
+	input->status = VIRTIO_CRYPTO_ERR;
+	input->session_id = ~0ULL;
+
+	ret = virtio_crypto_send_command(hw->cvq, ctrl, dlen, dnum);
+	if (ret < 0) {
+		VIRTIO_CRYPTO_SESSION_LOG_ERR("create session failed: %d", ret);
+		goto error_out;
+	}
+
+	ctrl = hw->cvq->hdr_mz->addr;
+	input = &ctrl->input;
+	if (input->status != VIRTIO_CRYPTO_OK) {
+		VIRTIO_CRYPTO_SESSION_LOG_ERR("Something wrong on backend! "
+				"status=%u, session_id=%" PRIu64 "",
+				input->status, input->session_id);
+		goto error_out;
+	} else {
+		session->session_id = input->session_id;
+		VIRTIO_CRYPTO_SESSION_LOG_INFO("Create session successfully, "
+				"session_id=%" PRIu64 "", input->session_id);
+	}
+
+	return 0;
 error_out:
 	return ret;
 }
@@ -1583,10 +1436,11 @@ virtio_crypto_asym_configure_session(
 {
 	struct virtio_crypto_akcipher_session_para *para;
 	struct virtio_crypto_op_ctrl_req *ctrl_req;
-	uint8_t key[VIRTIO_CRYPTO_MAX_CTRL_DATA];
+	struct virtio_crypto_session_input *input;
 	struct virtio_crypto_session *session;
 	struct virtio_crypto_hw *hw;
-	struct virtqueue *control_vq;
+	struct virtio_pmd_ctrl *ctrl;
+	int dlen[1];
 	int ret;
 
 	PMD_INIT_FUNC_TRACE();
@@ -1600,7 +1454,8 @@ virtio_crypto_asym_configure_session(
 
 	session = CRYPTODEV_GET_ASYM_SESS_PRIV(sess);
 	memset(session, 0, sizeof(struct virtio_crypto_session));
-	ctrl_req = &session->ctrl;
+	ctrl = &session->ctrl;
+	ctrl_req = &ctrl->hdr;
 	ctrl_req->header.opcode = VIRTIO_CRYPTO_AKCIPHER_CREATE_SESSION;
 	ctrl_req->header.queue_id = 0;
 	para = &ctrl_req->u.akcipher_create_session.para;
@@ -1614,7 +1469,7 @@ virtio_crypto_asym_configure_session(
 			return ret;
 		}
 
-		ret = virtio_crypto_asym_rsa_xform_to_der(xform, key);
+		ret = virtio_crypto_asym_rsa_xform_to_der(xform, ctrl->data);
 		if (ret <= 0) {
 			VIRTIO_CRYPTO_SESSION_LOG_ERR("Invalid RSA primitives");
 			return ret;
@@ -1626,15 +1481,31 @@ virtio_crypto_asym_configure_session(
 		para->algo = VIRTIO_CRYPTO_NO_AKCIPHER;
 	}
 
+	dlen[0] = ret;
+	input = &ctrl->input;
+	input->status = VIRTIO_CRYPTO_ERR;
+	input->session_id = ~0ULL;
+
 	hw = dev->data->dev_private;
-	control_vq = hw->cvq;
-	ret = virtio_crypto_send_command(control_vq, ctrl_req,
-				key, NULL, session);
+	ret = virtio_crypto_send_command(hw->cvq, ctrl, dlen, 1);
 	if (ret < 0) {
 		VIRTIO_CRYPTO_SESSION_LOG_ERR("create session failed: %d", ret);
 		goto error_out;
 	}
 
+	ctrl = hw->cvq->hdr_mz->addr;
+	input = &ctrl->input;
+	if (input->status != VIRTIO_CRYPTO_OK) {
+		VIRTIO_CRYPTO_SESSION_LOG_ERR("Something wrong on backend! "
+				"status=%u, session_id=%" PRIu64 "",
+				input->status, input->session_id);
+		goto error_out;
+	} else {
+		session->session_id = input->session_id;
+		VIRTIO_CRYPTO_SESSION_LOG_INFO("Create session successfully, "
+				"session_id=%" PRIu64 "", input->session_id);
+	}
+
 	return 0;
 error_out:
 	return -1;
diff --git a/drivers/crypto/virtio/virtio_cvq.c b/drivers/crypto/virtio/virtio_cvq.c
new file mode 100644
index 0000000000..c4df4a6176
--- /dev/null
+++ b/drivers/crypto/virtio/virtio_cvq.c
@@ -0,0 +1,129 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2025 Marvell
+ */
+
+#include <unistd.h>
+
+#include <rte_common.h>
+#include <rte_eal.h>
+#include <rte_errno.h>
+
+#include "virtio_cvq.h"
+#include "virtqueue.h"
+
+static struct virtio_pmd_ctrl *
+virtio_send_command(struct virtcrypto_ctl *cvq,
+			  struct virtio_pmd_ctrl *ctrl,
+			  int *dlen, int dnum)
+{
+	struct virtqueue *vq = virtcrypto_cq_to_vq(cvq);
+	struct virtio_pmd_ctrl *result;
+	uint32_t head, i;
+	int k, sum = 0;
+
+	head = vq->vq_desc_head_idx;
+
+	/*
+	 * Format is enforced in qemu code:
+	 * One TX packet for header;
+	 * At least one TX packet per argument;
+	 * One RX packet for ACK.
+	 */
+	vq->vq_split.ring.desc[head].flags = VRING_DESC_F_NEXT;
+	vq->vq_split.ring.desc[head].addr = cvq->hdr_mem;
+	vq->vq_split.ring.desc[head].len = sizeof(struct virtio_crypto_op_ctrl_req);
+	vq->vq_free_cnt--;
+	i = vq->vq_split.ring.desc[head].next;
+
+	for (k = 0; k < dnum; k++) {
+		vq->vq_split.ring.desc[i].flags = VRING_DESC_F_NEXT;
+		vq->vq_split.ring.desc[i].addr = cvq->hdr_mem
+			+ sizeof(struct virtio_crypto_op_ctrl_req)
+			+ sizeof(ctrl->input) + sizeof(uint8_t) * sum;
+		vq->vq_split.ring.desc[i].len = dlen[k];
+		sum += dlen[k];
+		vq->vq_free_cnt--;
+		i = vq->vq_split.ring.desc[i].next;
+	}
+
+	vq->vq_split.ring.desc[i].flags = VRING_DESC_F_WRITE;
+	vq->vq_split.ring.desc[i].addr = cvq->hdr_mem
+			+ sizeof(struct virtio_crypto_op_ctrl_req);
+	vq->vq_split.ring.desc[i].len = sizeof(ctrl->input);
+	vq->vq_free_cnt--;
+
+	vq->vq_desc_head_idx = vq->vq_split.ring.desc[i].next;
+
+	vq_update_avail_ring(vq, head);
+	vq_update_avail_idx(vq);
+
+	PMD_INIT_LOG(DEBUG, "vq->vq_queue_index = %d", vq->vq_queue_index);
+
+	cvq->notify_queue(vq, cvq->notify_cookie);
+
+	while (virtqueue_nused(vq) == 0)
+		usleep(100);
+
+	while (virtqueue_nused(vq)) {
+		uint32_t idx, desc_idx, used_idx;
+		struct vring_used_elem *uep;
+
+		used_idx = (uint32_t)(vq->vq_used_cons_idx
+				& (vq->vq_nentries - 1));
+		uep = &vq->vq_split.ring.used->ring[used_idx];
+		idx = (uint32_t)uep->id;
+		desc_idx = idx;
+
+		while (vq->vq_split.ring.desc[desc_idx].flags &
+				VRING_DESC_F_NEXT) {
+			desc_idx = vq->vq_split.ring.desc[desc_idx].next;
+			vq->vq_free_cnt++;
+		}
+
+		vq->vq_split.ring.desc[desc_idx].next = vq->vq_desc_head_idx;
+		vq->vq_desc_head_idx = idx;
+
+		vq->vq_used_cons_idx++;
+		vq->vq_free_cnt++;
+	}
+
+	PMD_INIT_LOG(DEBUG, "vq->vq_free_cnt=%d vq->vq_desc_head_idx=%d",
+			vq->vq_free_cnt, vq->vq_desc_head_idx);
+
+	result = cvq->hdr_mz->addr;
+	return result;
+}
+
+int
+virtio_crypto_send_command(struct virtcrypto_ctl *cvq, struct virtio_pmd_ctrl *ctrl,
+	int *dlen, int dnum)
+{
+	struct virtio_pmd_ctrl *result;
+	struct virtqueue *vq;
+	uint8_t status = ~0;
+
+	ctrl->input.status = status;
+
+	if (!cvq) {
+		PMD_INIT_LOG(ERR, "Control queue is not supported.");
+		return -1;
+	}
+
+	rte_spinlock_lock(&cvq->lock);
+	vq = virtcrypto_cq_to_vq(cvq);
+
+	PMD_INIT_LOG(DEBUG, "vq->vq_desc_head_idx = %d, status = %d, "
+		"vq->hw->cvq = %p vq = %p",
+		vq->vq_desc_head_idx, status, vq->hw->cvq, vq);
+
+	if (vq->vq_free_cnt < dnum + 2 || dnum < 1) {
+		rte_spinlock_unlock(&cvq->lock);
+		return -1;
+	}
+
+	memcpy(cvq->hdr_mz->addr, ctrl, sizeof(struct virtio_pmd_ctrl));
+	result = virtio_send_command(cvq, ctrl, dlen, dnum);
+
+	rte_spinlock_unlock(&cvq->lock);
+	return result->input.status;
+}
diff --git a/drivers/crypto/virtio/virtio_cvq.h b/drivers/crypto/virtio/virtio_cvq.h
new file mode 100644
index 0000000000..1935ce1844
--- /dev/null
+++ b/drivers/crypto/virtio/virtio_cvq.h
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2025 Marvell
+ */
+
+#ifndef _VIRTIO_CVQ_H_
+#define _VIRTIO_CVQ_H_
+
+#include <rte_spinlock.h>
+#include <virtio_crypto.h>
+
+#include "virtio_cryptodev.h"
+
+struct virtqueue;
+
+struct virtcrypto_ctl {
+	const struct rte_memzone *hdr_mz; /**< memzone to populate hdr. */
+	rte_iova_t hdr_mem;               /**< hdr for each xmit packet */
+	rte_spinlock_t lock;              /**< spinlock for control queue. */
+	void (*notify_queue)(struct virtqueue *vq, void *cookie); /**< notify ops. */
+	void *notify_cookie;              /**< cookie for notify ops */
+};
+
+struct virtio_pmd_ctrl {
+	struct virtio_crypto_op_ctrl_req hdr;
+	struct virtio_crypto_session_input input;
+	uint8_t data[VIRTIO_CRYPTO_MAX_CTRL_DATA];
+};
+
+int
+virtio_crypto_send_command(struct virtcrypto_ctl *cvq, struct virtio_pmd_ctrl *ctrl,
+	int *dlen, int pkt_num);
+
+#endif /* _VIRTIO_CVQ_H_ */
diff --git a/drivers/crypto/virtio/virtio_pci.h b/drivers/crypto/virtio/virtio_pci.h
index 41949c3d13..7e94c6a3c5 100644
--- a/drivers/crypto/virtio/virtio_pci.h
+++ b/drivers/crypto/virtio/virtio_pci.h
@@ -176,8 +176,7 @@ struct virtio_pci_ops {
 };
 
 struct virtio_crypto_hw {
-	/* control queue */
-	struct virtqueue *cvq;
+	struct virtqueue **vqs;
 	uint16_t    dev_id;
 	uint16_t    max_dataqueues;
 	uint64_t    req_guest_features;
@@ -190,6 +189,9 @@ struct virtio_crypto_hw {
 	struct virtio_pci_common_cfg *common_cfg;
 	struct virtio_crypto_config *dev_cfg;
 	const struct rte_cryptodev_capabilities *virtio_dev_capabilities;
+	uint8_t weak_barriers;
+	struct virtcrypto_ctl *cvq;
+	bool use_va;
 };
 
 /*
diff --git a/drivers/crypto/virtio/virtio_ring.h b/drivers/crypto/virtio/virtio_ring.h
index 55839279fd..e5b0ad74d2 100644
--- a/drivers/crypto/virtio/virtio_ring.h
+++ b/drivers/crypto/virtio/virtio_ring.h
@@ -59,6 +59,7 @@ struct vring_used {
 
 struct vring {
 	unsigned int num;
+	rte_iova_t desc_iova;
 	struct vring_desc  *desc;
 	struct vring_avail *avail;
 	struct vring_used  *used;
@@ -111,17 +112,24 @@ vring_size(unsigned int num, unsigned long align)
 }
 
 static inline void
-vring_init(struct vring *vr, unsigned int num, uint8_t *p,
-	unsigned long align)
+vring_init_split(struct vring *vr, uint8_t *p, rte_iova_t iova,
+		 unsigned long align, unsigned int num)
 {
 	vr->num = num;
 	vr->desc = (struct vring_desc *) p;
+	vr->desc_iova = iova;
 	vr->avail = (struct vring_avail *) (p +
 		num * sizeof(struct vring_desc));
 	vr->used = (void *)
 		RTE_ALIGN_CEIL((uintptr_t)(&vr->avail->ring[num]), align);
 }
 
+static inline void
+vring_init(struct vring *vr, unsigned int num, uint8_t *p, unsigned long align)
+{
+	vring_init_split(vr, p, 0, align, num);
+}
+
 /*
  * The following is used with VIRTIO_RING_F_EVENT_IDX.
  * Assuming a given event_idx value from the other size, if we have
diff --git a/drivers/crypto/virtio/virtio_rxtx.c b/drivers/crypto/virtio/virtio_rxtx.c
index 3cf25d8c1f..68fccef84b 100644
--- a/drivers/crypto/virtio/virtio_rxtx.c
+++ b/drivers/crypto/virtio/virtio_rxtx.c
@@ -14,13 +14,13 @@ vq_ring_free_chain(struct virtqueue *vq, uint16_t desc_idx)
 	struct vq_desc_extra *dxp;
 	uint16_t desc_idx_last = desc_idx;
 
-	dp = &vq->vq_ring.desc[desc_idx];
+	dp = &vq->vq_split.ring.desc[desc_idx];
 	dxp = &vq->vq_descx[desc_idx];
 	vq->vq_free_cnt = (uint16_t)(vq->vq_free_cnt + dxp->ndescs);
 	if ((dp->flags & VRING_DESC_F_INDIRECT) == 0) {
 		while (dp->flags & VRING_DESC_F_NEXT) {
 			desc_idx_last = dp->next;
-			dp = &vq->vq_ring.desc[dp->next];
+			dp = &vq->vq_split.ring.desc[dp->next];
 		}
 	}
 	dxp->ndescs = 0;
@@ -33,7 +33,7 @@ vq_ring_free_chain(struct virtqueue *vq, uint16_t desc_idx)
 	if (vq->vq_desc_tail_idx == VQ_RING_DESC_CHAIN_END) {
 		vq->vq_desc_head_idx = desc_idx;
 	} else {
-		dp_tail = &vq->vq_ring.desc[vq->vq_desc_tail_idx];
+		dp_tail = &vq->vq_split.ring.desc[vq->vq_desc_tail_idx];
 		dp_tail->next = desc_idx;
 	}
 
@@ -56,7 +56,7 @@ virtqueue_dequeue_burst_rx(struct virtqueue *vq,
 	for (i = 0; i < num ; i++) {
 		used_idx = (uint16_t)(vq->vq_used_cons_idx
 				& (vq->vq_nentries - 1));
-		uep = &vq->vq_ring.used->ring[used_idx];
+		uep = &vq->vq_split.ring.used->ring[used_idx];
 		desc_idx = (uint16_t)uep->id;
 		cop = (struct rte_crypto_op *)
 				vq->vq_descx[desc_idx].crypto_op;
@@ -115,7 +115,7 @@ virtqueue_crypto_sym_pkt_header_arrange(
 {
 	struct rte_crypto_sym_op *sym_op = cop->sym;
 	struct virtio_crypto_op_data_req *req_data = data;
-	struct virtio_crypto_op_ctrl_req *ctrl = &session->ctrl;
+	struct virtio_crypto_op_ctrl_req *ctrl = &session->ctrl.hdr;
 	struct virtio_crypto_sym_create_session_req *sym_sess_req =
 		&ctrl->u.sym_create_session;
 	struct virtio_crypto_alg_chain_session_para *chain_para =
@@ -304,7 +304,7 @@ virtqueue_crypto_sym_enqueue_xmit(
 	desc[idx++].flags = VRING_DESC_F_WRITE | VRING_DESC_F_NEXT;
 
 	/* indirect vring: digest result */
-	para = &(session->ctrl.u.sym_create_session.u.chain.para);
+	para = &(session->ctrl.hdr.u.sym_create_session.u.chain.para);
 	if (para->hash_mode == VIRTIO_CRYPTO_SYM_HASH_MODE_PLAIN)
 		hash_result_len = para->u.hash_param.hash_result_len;
 	if (para->hash_mode == VIRTIO_CRYPTO_SYM_HASH_MODE_AUTH)
@@ -327,7 +327,7 @@ virtqueue_crypto_sym_enqueue_xmit(
 	dxp->ndescs = needed;
 
 	/* use a single buffer */
-	start_dp = txvq->vq_ring.desc;
+	start_dp = txvq->vq_split.ring.desc;
 	start_dp[head_idx].addr = indirect_op_data_req_phys_addr +
 		indirect_vring_addr_offset;
 	start_dp[head_idx].len = num_entry * sizeof(struct vring_desc);
@@ -349,7 +349,7 @@ virtqueue_crypto_asym_pkt_header_arrange(
 		struct virtio_crypto_op_data_req *data,
 		struct virtio_crypto_session *session)
 {
-	struct virtio_crypto_op_ctrl_req *ctrl = &session->ctrl;
+	struct virtio_crypto_op_ctrl_req *ctrl = &session->ctrl.hdr;
 	struct virtio_crypto_op_data_req *req_data = data;
 	struct rte_crypto_asym_op *asym_op = cop->asym;
 
@@ -513,7 +513,7 @@ virtqueue_crypto_asym_enqueue_xmit(
 	dxp->ndescs = needed;
 
 	/* use a single buffer */
-	start_dp = txvq->vq_ring.desc;
+	start_dp = txvq->vq_split.ring.desc;
 	start_dp[head_idx].addr = indirect_op_data_req_phys_addr +
 		indirect_vring_addr_offset;
 	start_dp[head_idx].len = num_entry * sizeof(struct vring_desc);
@@ -533,25 +533,14 @@ static int
 virtio_crypto_vring_start(struct virtqueue *vq)
 {
 	struct virtio_crypto_hw *hw = vq->hw;
-	int i, size = vq->vq_nentries;
-	struct vring *vr = &vq->vq_ring;
 	uint8_t *ring_mem = vq->vq_ring_virt_mem;
 
 	PMD_INIT_FUNC_TRACE();
 
-	vring_init(vr, size, ring_mem, VIRTIO_PCI_VRING_ALIGN);
-	vq->vq_desc_tail_idx = (uint16_t)(vq->vq_nentries - 1);
-	vq->vq_free_cnt = vq->vq_nentries;
-
-	/* Chain all the descriptors in the ring with an END */
-	for (i = 0; i < size - 1; i++)
-		vr->desc[i].next = (uint16_t)(i + 1);
-	vr->desc[i].next = VQ_RING_DESC_CHAIN_END;
-
-	/*
-	 * Disable device(host) interrupting guest
-	 */
-	virtqueue_disable_intr(vq);
+	if (ring_mem == NULL) {
+		VIRTIO_CRYPTO_INIT_LOG_ERR("virtqueue ring memory is NULL");
+		return -EINVAL;
+	}
 
 	/*
 	 * Set guest physical address of the virtqueue
@@ -572,8 +561,9 @@ virtio_crypto_ctrlq_start(struct rte_cryptodev *dev)
 	struct virtio_crypto_hw *hw = dev->data->dev_private;
 
 	if (hw->cvq) {
-		virtio_crypto_vring_start(hw->cvq);
-		VIRTQUEUE_DUMP((struct virtqueue *)hw->cvq);
+		rte_spinlock_init(&hw->cvq->lock);
+		virtio_crypto_vring_start(virtcrypto_cq_to_vq(hw->cvq));
+		VIRTQUEUE_DUMP(virtcrypto_cq_to_vq(hw->cvq));
 	}
 }
 
diff --git a/drivers/crypto/virtio/virtio_rxtx.h b/drivers/crypto/virtio/virtio_rxtx.h
new file mode 100644
index 0000000000..2771062e44
--- /dev/null
+++ b/drivers/crypto/virtio/virtio_rxtx.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2025 Marvell.
+ */
+
+#ifndef _VIRTIO_RXTX_H_
+#define _VIRTIO_RXTX_H_
+
+struct virtcrypto_data {
+	const struct rte_memzone *hdr_mz; /**< memzone to populate hdr. */
+	rte_iova_t hdr_mem;               /**< hdr for each xmit packet */
+};
+
+#endif /* _VIRTIO_RXTX_H_ */
diff --git a/drivers/crypto/virtio/virtqueue.c b/drivers/crypto/virtio/virtqueue.c
index 3e2db1ebd2..af7f121f67 100644
--- a/drivers/crypto/virtio/virtqueue.c
+++ b/drivers/crypto/virtio/virtqueue.c
@@ -7,7 +7,9 @@
 #include <rte_mbuf.h>
 #include <rte_crypto.h>
 #include <rte_malloc.h>
+#include <rte_errno.h>
 
+#include "virtio_cryptodev.h"
 #include "virtqueue.h"
 
 void
@@ -18,7 +20,7 @@ virtqueue_disable_intr(struct virtqueue *vq)
 	 * not to interrupt when it consumes packets
 	 * Note: this is only considered a hint to the host
 	 */
-	vq->vq_ring.avail->flags |= VRING_AVAIL_F_NO_INTERRUPT;
+	vq->vq_split.ring.avail->flags |= VRING_AVAIL_F_NO_INTERRUPT;
 }
 
 void
@@ -32,10 +34,193 @@ virtqueue_detatch_unused(struct virtqueue *vq)
 		for (idx = 0; idx < vq->vq_nentries; idx++) {
 			cop = vq->vq_descx[idx].crypto_op;
 			if (cop) {
-				rte_pktmbuf_free(cop->sym->m_src);
-				rte_pktmbuf_free(cop->sym->m_dst);
+				if (cop->type == RTE_CRYPTO_OP_TYPE_SYMMETRIC) {
+					rte_pktmbuf_free(cop->sym->m_src);
+					rte_pktmbuf_free(cop->sym->m_dst);
+				}
+
 				rte_crypto_op_free(cop);
 				vq->vq_descx[idx].crypto_op = NULL;
 			}
 		}
 }
+
+static void
+virtio_init_vring(struct virtqueue *vq)
+{
+	uint8_t *ring_mem = vq->vq_ring_virt_mem;
+	struct vring *vr = &vq->vq_split.ring;
+	int size = vq->vq_nentries;
+
+	PMD_INIT_FUNC_TRACE();
+
+	memset(ring_mem, 0, vq->vq_ring_size);
+
+	vq->vq_used_cons_idx = 0;
+	vq->vq_desc_head_idx = 0;
+	vq->vq_avail_idx = 0;
+	vq->vq_desc_tail_idx = (uint16_t)(vq->vq_nentries - 1);
+	vq->vq_free_cnt = vq->vq_nentries;
+	memset(vq->vq_descx, 0, sizeof(struct vq_desc_extra) * vq->vq_nentries);
+
+	vring_init_split(vr, ring_mem, vq->vq_ring_mem, VIRTIO_PCI_VRING_ALIGN, size);
+	vring_desc_init_split(vr->desc, size);
+
+	/*
+	 * Disable device(host) interrupting guest
+	 */
+	virtqueue_disable_intr(vq);
+}
+
+static int
+virtio_alloc_queue_headers(struct virtqueue *vq, int numa_node, const char *name)
+{
+	char hdr_name[VIRTQUEUE_MAX_NAME_SZ];
+	const struct rte_memzone **hdr_mz;
+	rte_iova_t *hdr_mem;
+	ssize_t size;
+	int queue_type;
+
+	queue_type = virtio_get_queue_type(vq->hw, vq->vq_queue_index);
+	switch (queue_type) {
+	case VTCRYPTO_DATAQ:
+		/*
+		 * Op cookie for every ring element. This memory can be optimized
+		 * based on descriptor requirements. For example, if a descriptor
+		 * is indirect, then the cookie can be shared among all the
+		 * descriptors in the chain.
+		 */
+		size = vq->vq_nentries * sizeof(struct virtio_crypto_op_cookie);
+		hdr_mz = &vq->dq.hdr_mz;
+		hdr_mem = &vq->dq.hdr_mem;
+		break;
+	case VTCRYPTO_CTRLQ:
+		/* One control operation at a time in control queue */
+		size = sizeof(struct virtio_pmd_ctrl);
+		hdr_mz = &vq->cq.hdr_mz;
+		hdr_mem = &vq->cq.hdr_mem;
+		break;
+	default:
+		return 0;
+	}
+
+	snprintf(hdr_name, sizeof(hdr_name), "%s_hdr", name);
+	*hdr_mz = rte_memzone_reserve_aligned(hdr_name, size, numa_node,
+			RTE_MEMZONE_IOVA_CONTIG, RTE_CACHE_LINE_SIZE);
+	if (*hdr_mz == NULL) {
+		if (rte_errno == EEXIST)
+			*hdr_mz = rte_memzone_lookup(hdr_name);
+		if (*hdr_mz == NULL)
+			return -ENOMEM;
+	}
+
+	memset((*hdr_mz)->addr, 0, size);
+
+	if (vq->hw->use_va)
+		*hdr_mem = (uintptr_t)(*hdr_mz)->addr;
+	else
+		*hdr_mem = (uintptr_t)(*hdr_mz)->iova;
+
+	return 0;
+}
+
+static void
+virtio_free_queue_headers(struct virtqueue *vq)
+{
+	const struct rte_memzone **hdr_mz;
+	rte_iova_t *hdr_mem;
+	int queue_type;
+
+	queue_type = virtio_get_queue_type(vq->hw, vq->vq_queue_index);
+	switch (queue_type) {
+	case VTCRYPTO_DATAQ:
+		hdr_mz = &vq->dq.hdr_mz;
+		hdr_mem = &vq->dq.hdr_mem;
+		break;
+	case VTCRYPTO_CTRLQ:
+		hdr_mz = &vq->cq.hdr_mz;
+		hdr_mem = &vq->cq.hdr_mem;
+		break;
+	default:
+		return;
+	}
+
+	rte_memzone_free(*hdr_mz);
+	*hdr_mz = NULL;
+	*hdr_mem = 0;
+}
+
+struct virtqueue *
+virtcrypto_queue_alloc(struct virtio_crypto_hw *hw, uint16_t index, uint16_t num,
+		int node, const char *name)
+{
+	const struct rte_memzone *mz;
+	struct virtqueue *vq;
+	unsigned int size;
+
+	size = sizeof(*vq) + num * sizeof(struct vq_desc_extra);
+	size = RTE_ALIGN_CEIL(size, RTE_CACHE_LINE_SIZE);
+
+	vq = rte_zmalloc_socket(name, size, RTE_CACHE_LINE_SIZE, node);
+	if (vq == NULL) {
+		PMD_INIT_LOG(ERR, "can not allocate vq");
+		return NULL;
+	}
+
+	PMD_INIT_LOG(DEBUG, "vq: %p", vq);
+	vq->hw = hw;
+	vq->vq_queue_index = index;
+	vq->vq_nentries = num;
+
+	/*
+	 * Reserve a memzone for vring elements
+	 */
+	size = vring_size(num, VIRTIO_PCI_VRING_ALIGN);
+	vq->vq_ring_size = RTE_ALIGN_CEIL(size, VIRTIO_PCI_VRING_ALIGN);
+	PMD_INIT_LOG(DEBUG, "vring_size: %d, rounded_vring_size: %d", size, vq->vq_ring_size);
+
+	mz = rte_memzone_reserve_aligned(name, vq->vq_ring_size, node,
+			RTE_MEMZONE_IOVA_CONTIG, VIRTIO_PCI_VRING_ALIGN);
+	if (mz == NULL) {
+		if (rte_errno == EEXIST)
+			mz = rte_memzone_lookup(name);
+		if (mz == NULL)
+			goto free_vq;
+	}
+
+	memset(mz->addr, 0, mz->len);
+	vq->mz = mz;
+	vq->vq_ring_virt_mem = mz->addr;
+
+	if (hw->use_va)
+		vq->vq_ring_mem = (uintptr_t)mz->addr;
+	else
+		vq->vq_ring_mem = mz->iova;
+
+	PMD_INIT_LOG(DEBUG, "vq->vq_ring_mem: 0x%" PRIx64, vq->vq_ring_mem);
+	PMD_INIT_LOG(DEBUG, "vq->vq_ring_virt_mem: %p", vq->vq_ring_virt_mem);
+
+	virtio_init_vring(vq);
+
+	if (virtio_alloc_queue_headers(vq, node, name)) {
+		PMD_INIT_LOG(ERR, "Failed to alloc queue headers");
+		goto free_mz;
+	}
+
+	return vq;
+
+free_mz:
+	rte_memzone_free(mz);
+free_vq:
+	rte_free(vq);
+
+	return NULL;
+}
+
+void
+virtcrypto_queue_free(struct virtqueue *vq)
+{
+	virtio_free_queue_headers(vq);
+	rte_memzone_free(vq->mz);
+	rte_free(vq);
+}
diff --git a/drivers/crypto/virtio/virtqueue.h b/drivers/crypto/virtio/virtqueue.h
index cb08bea94f..9191d1f732 100644
--- a/drivers/crypto/virtio/virtqueue.h
+++ b/drivers/crypto/virtio/virtqueue.h
@@ -12,10 +12,12 @@
 #include <rte_memzone.h>
 #include <rte_mempool.h>
 
+#include "virtio_cvq.h"
 #include "virtio_pci.h"
 #include "virtio_ring.h"
 #include "virtio_logs.h"
 #include "virtio_crypto.h"
+#include "virtio_rxtx.h"
 
 struct rte_mbuf;
 
@@ -46,11 +48,26 @@ struct vq_desc_extra {
 	void     *crypto_op;
 	void     *cookie;
 	uint16_t ndescs;
+	uint16_t next;
 };
 
+#define virtcrypto_dq_to_vq(dvq) container_of(dvq, struct virtqueue, dq)
+#define virtcrypto_cq_to_vq(cvq) container_of(cvq, struct virtqueue, cq)
+
 struct virtqueue {
 	/**< virtio_crypto_hw structure pointer. */
 	struct virtio_crypto_hw *hw;
+	union {
+		struct {
+			/**< vring keeping desc, used and avail */
+			struct vring ring;
+		} vq_split;
+	};
+	union {
+		struct virtcrypto_data dq;
+		struct virtcrypto_ctl cq;
+	};
+
 	/**< mem zone to populate RX ring. */
 	const struct rte_memzone *mz;
 	/**< memzone to populate hdr and request. */
@@ -62,7 +79,6 @@ struct virtqueue {
 	unsigned int vq_ring_size;
 	phys_addr_t vq_ring_mem;          /**< physical address of vring */
 
-	struct vring vq_ring;    /**< vring keeping desc, used and avail */
 	uint16_t    vq_free_cnt; /**< num of desc available */
 	uint16_t    vq_nentries; /**< vring desc numbers */
 
@@ -101,6 +117,11 @@ void virtqueue_disable_intr(struct virtqueue *vq);
  */
 void virtqueue_detatch_unused(struct virtqueue *vq);
 
+struct virtqueue *virtcrypto_queue_alloc(struct virtio_crypto_hw *hw, uint16_t index,
+		uint16_t num, int node, const char *name);
+
+void virtcrypto_queue_free(struct virtqueue *vq);
+
 static inline int
 virtqueue_full(const struct virtqueue *vq)
 {
@@ -108,13 +129,13 @@ virtqueue_full(const struct virtqueue *vq)
 }
 
 #define VIRTQUEUE_NUSED(vq) \
-	((uint16_t)((vq)->vq_ring.used->idx - (vq)->vq_used_cons_idx))
+	((uint16_t)((vq)->vq_split.ring.used->idx - (vq)->vq_used_cons_idx))
 
 static inline void
 vq_update_avail_idx(struct virtqueue *vq)
 {
 	virtio_wmb();
-	vq->vq_ring.avail->idx = vq->vq_avail_idx;
+	vq->vq_split.ring.avail->idx = vq->vq_avail_idx;
 }
 
 static inline void
@@ -129,15 +150,15 @@ vq_update_avail_ring(struct virtqueue *vq, uint16_t desc_idx)
 	 * descriptor.
 	 */
 	avail_idx = (uint16_t)(vq->vq_avail_idx & (vq->vq_nentries - 1));
-	if (unlikely(vq->vq_ring.avail->ring[avail_idx] != desc_idx))
-		vq->vq_ring.avail->ring[avail_idx] = desc_idx;
+	if (unlikely(vq->vq_split.ring.avail->ring[avail_idx] != desc_idx))
+		vq->vq_split.ring.avail->ring[avail_idx] = desc_idx;
 	vq->vq_avail_idx++;
 }
 
 static inline int
 virtqueue_kick_prepare(struct virtqueue *vq)
 {
-	return !(vq->vq_ring.used->flags & VRING_USED_F_NO_NOTIFY);
+	return !(vq->vq_split.ring.used->flags & VRING_USED_F_NO_NOTIFY);
 }
 
 static inline void
@@ -151,21 +172,69 @@ virtqueue_notify(struct virtqueue *vq)
 	VTPCI_OPS(vq->hw)->notify_queue(vq->hw, vq);
 }
 
+/* Chain all the descriptors in the ring with an END */
+static inline void
+vring_desc_init_split(struct vring_desc *dp, uint16_t n)
+{
+	uint16_t i;
+
+	for (i = 0; i < n - 1; i++)
+		dp[i].next = (uint16_t)(i + 1);
+	dp[i].next = VQ_RING_DESC_CHAIN_END;
+}
+
+static inline int
+virtio_get_queue_type(struct virtio_crypto_hw *hw, uint16_t vq_idx)
+{
+	if (vq_idx == hw->max_dataqueues)
+		return VTCRYPTO_CTRLQ;
+	else
+		return VTCRYPTO_DATAQ;
+}
+
+/* virtqueue_nused has load-acquire or rte_io_rmb insed */
+static inline uint16_t
+virtqueue_nused(const struct virtqueue *vq)
+{
+	uint16_t idx;
+
+	if (vq->hw->weak_barriers) {
+	/**
+	 * x86 prefers to using rte_smp_rmb over rte_atomic_load_explicit as it
+	 * reports a slightly better perf, which comes from the saved
+	 * branch by the compiler.
+	 * The if and else branches are identical with the smp and io
+	 * barriers both defined as compiler barriers on x86.
+	 */
+#ifdef RTE_ARCH_X86_64
+		idx = vq->vq_split.ring.used->idx;
+		virtio_rmb();
+#else
+		idx = rte_atomic_load_explicit(&(vq)->vq_split.ring.used->idx,
+				rte_memory_order_acquire);
+#endif
+	} else {
+		idx = vq->vq_split.ring.used->idx;
+		rte_io_rmb();
+	}
+	return idx - vq->vq_used_cons_idx;
+}
+
 /**
  * Dump virtqueue internal structures, for debug purpose only.
  */
 #define VIRTQUEUE_DUMP(vq) do { \
 	uint16_t used_idx, nused; \
-	used_idx = (vq)->vq_ring.used->idx; \
+	used_idx = (vq)->vq_split.ring.used->idx; \
 	nused = (uint16_t)(used_idx - (vq)->vq_used_cons_idx); \
 	VIRTIO_CRYPTO_INIT_LOG_DBG(\
 	  "VQ: - size=%d; free=%d; used=%d; desc_head_idx=%d;" \
 	  " avail.idx=%d; used_cons_idx=%d; used.idx=%d;" \
 	  " avail.flags=0x%x; used.flags=0x%x", \
 	  (vq)->vq_nentries, (vq)->vq_free_cnt, nused, \
-	  (vq)->vq_desc_head_idx, (vq)->vq_ring.avail->idx, \
-	  (vq)->vq_used_cons_idx, (vq)->vq_ring.used->idx, \
-	  (vq)->vq_ring.avail->flags, (vq)->vq_ring.used->flags); \
+	  (vq)->vq_desc_head_idx, (vq)->vq_split.ring.avail->idx, \
+	  (vq)->vq_used_cons_idx, (vq)->vq_split.ring.used->idx, \
+	  (vq)->vq_split.ring.avail->flags, (vq)->vq_split.ring.used->flags); \
 } while (0)
 
 #endif /* _VIRTQUEUE_H_ */
-- 
2.25.1

