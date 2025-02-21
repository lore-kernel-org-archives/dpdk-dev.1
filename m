Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AD8EC021B6
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Feb 2025 17:42:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A5A2141133;
	Fri, 21 Feb 2025 18:42:18 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 3263B41133
 for <dev@dpdk.org>; Fri, 21 Feb 2025 18:42:17 +0100 (CET)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51LCq8Bp005095;
 Fri, 21 Feb 2025 09:42:16 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=9
 hIP8FlwLgjkaZNbotQLlDS1sHGMZJjh3pxeiWXqJC8=; b=RqP5UEc06m9aeDEF3
 x/3q7EoBMMggjYsKpJcmsgH4+81p+4Www6HWdZoVwkliFqhCbxx+CHmoTR4lZ2eC
 bpnBGuYdRT0sZkrqtMcbYFnB7guVWxftJbRX+ncTrborr+ykoJoM38jkzfCb124l
 1e9t2MC5wBAp9kdCiLMfZz4hadnGyey8p4j/NZyZfS2o3KNmte7VaKFZga4K/psQ
 qANzZCUnUC+1plcyQ2pCNNC3+o21H2APTz/0+SYOrtQTMuN1GnS1hZLi9qZBDQaC
 XgLFDl3mDd/4qBmIqaH8tn16eyo9L64mTe3QogvjasbYZZk69INt8SHZzH7/kikw
 b25QA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 44xnbgh5yt-4
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 21 Feb 2025 09:42:16 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 21 Feb 2025 09:41:42 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 21 Feb 2025 09:41:42 -0800
Received: from IN-lckQE5Rwctls.marvell.com (unknown [10.193.66.72])
 by maili.marvell.com (Postfix) with ESMTP id 534735B692A;
 Fri, 21 Feb 2025 09:41:40 -0800 (PST)
From: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
To: <dev@dpdk.org>, Jay Zhou <jianjay.zhou@huawei.com>
CC: <anoobj@marvell.com>, Akhil Goyal <gakhil@marvell.com>, "Gowrishankar
 Muthukrishnan" <gmuthukrishn@marvell.com>
Subject: [v3 3/6] crypto/virtio: add packed ring support
Date: Fri, 21 Feb 2025 23:11:13 +0530
Message-ID: <32ecb230ba55b44770eac05184bda166bb6454c6.1740156584.git.gmuthukrishn@marvell.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <cover.1740156584.git.gmuthukrishn@marvell.com>
References: <cover.1740156584.git.gmuthukrishn@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: -RzjDfhjlldAxG2dUvkW5twmUDazq7HB
X-Proofpoint-ORIG-GUID: -RzjDfhjlldAxG2dUvkW5twmUDazq7HB
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

Add packed ring support.

Signed-off-by: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
---
 drivers/crypto/virtio/virtio_cryptodev.c | 125 +++++++
 drivers/crypto/virtio/virtio_cryptodev.h |  13 +-
 drivers/crypto/virtio/virtio_cvq.c       | 103 +++++-
 drivers/crypto/virtio/virtio_pci.h       |  25 ++
 drivers/crypto/virtio/virtio_ring.h      |  59 ++-
 drivers/crypto/virtio/virtio_rxtx.c      | 444 ++++++++++++++++++++++-
 drivers/crypto/virtio/virtqueue.c        |  50 ++-
 drivers/crypto/virtio/virtqueue.h        | 134 ++++++-
 8 files changed, 924 insertions(+), 29 deletions(-)

diff --git a/drivers/crypto/virtio/virtio_cryptodev.c b/drivers/crypto/virtio/virtio_cryptodev.c
index 6bb76ff15e..92fea557ab 100644
--- a/drivers/crypto/virtio/virtio_cryptodev.c
+++ b/drivers/crypto/virtio/virtio_cryptodev.c
@@ -869,6 +869,125 @@ virtio_crypto_clear_session(
 	rte_free(ctrl);
 }
 
+static void
+virtio_crypto_clear_session_packed(
+		struct rte_cryptodev *dev,
+		struct virtio_crypto_op_ctrl_req *ctrl)
+{
+	struct virtio_crypto_hw *hw;
+	struct virtqueue *vq;
+	struct vring_packed_desc *desc;
+	uint8_t *status;
+	uint8_t needed = 1;
+	uint32_t head;
+	uint64_t malloc_phys_addr;
+	uint8_t len_inhdr = sizeof(struct virtio_crypto_inhdr);
+	uint32_t len_op_ctrl_req = sizeof(struct virtio_crypto_op_ctrl_req);
+	uint64_t session_id = ctrl->u.destroy_session.session_id;
+	uint16_t flags;
+	uint8_t nb_descs = 0;
+
+	hw = dev->data->dev_private;
+	vq = virtcrypto_cq_to_vq(hw->cvq);
+	head = vq->vq_avail_idx;
+	flags = vq->vq_packed.cached_flags;
+
+	VIRTIO_CRYPTO_SESSION_LOG_INFO("vq->vq_desc_head_idx = %d, "
+			"vq = %p", vq->vq_desc_head_idx, vq);
+
+	if (vq->vq_free_cnt < needed) {
+		VIRTIO_CRYPTO_SESSION_LOG_ERR(
+				"vq->vq_free_cnt = %d is less than %d, "
+				"not enough", vq->vq_free_cnt, needed);
+		return;
+	}
+
+	malloc_phys_addr = rte_malloc_virt2iova(ctrl);
+
+	/* status part */
+	status = &(((struct virtio_crypto_inhdr *)
+		((uint8_t *)ctrl + len_op_ctrl_req))->status);
+	*status = VIRTIO_CRYPTO_ERR;
+
+	/* indirect desc vring part */
+	desc = vq->vq_packed.ring.desc;
+
+	/* ctrl request part */
+	desc[head].addr = malloc_phys_addr;
+	desc[head].len = len_op_ctrl_req;
+	desc[head].flags = VRING_DESC_F_NEXT | vq->vq_packed.cached_flags;
+	vq->vq_free_cnt--;
+	nb_descs++;
+	if (++vq->vq_avail_idx >= vq->vq_nentries) {
+		vq->vq_avail_idx -= vq->vq_nentries;
+		vq->vq_packed.cached_flags ^= VRING_PACKED_DESC_F_AVAIL_USED;
+	}
+
+	/* status part */
+	desc[vq->vq_avail_idx].addr = malloc_phys_addr + len_op_ctrl_req;
+	desc[vq->vq_avail_idx].len = len_inhdr;
+	desc[vq->vq_avail_idx].flags = VRING_DESC_F_WRITE;
+	vq->vq_free_cnt--;
+	nb_descs++;
+	if (++vq->vq_avail_idx >= vq->vq_nentries) {
+		vq->vq_avail_idx -= vq->vq_nentries;
+		vq->vq_packed.cached_flags ^= VRING_PACKED_DESC_F_AVAIL_USED;
+	}
+
+	virtqueue_store_flags_packed(&desc[head], VRING_DESC_F_NEXT | flags,
+			vq->hw->weak_barriers);
+
+	virtio_wmb(vq->hw->weak_barriers);
+	virtqueue_notify(vq);
+
+	/* wait for used desc in virtqueue
+	 * desc_is_used has a load-acquire or rte_io_rmb inside
+	 */
+	rte_rmb();
+	while (!desc_is_used(&desc[head], vq)) {
+		rte_rmb();
+		usleep(100);
+	}
+
+	/* now get used descriptors */
+	vq->vq_free_cnt += nb_descs;
+	vq->vq_used_cons_idx += nb_descs;
+	if (vq->vq_used_cons_idx >= vq->vq_nentries) {
+		vq->vq_used_cons_idx -= vq->vq_nentries;
+		vq->vq_packed.used_wrap_counter ^= 1;
+	}
+
+	PMD_INIT_LOG(DEBUG, "vq->vq_free_cnt=%d "
+			"vq->vq_queue_idx=%d "
+			"vq->vq_avail_idx=%d "
+			"vq->vq_used_cons_idx=%d "
+			"vq->vq_packed.cached_flags=0x%x "
+			"vq->vq_packed.used_wrap_counter=%d",
+			vq->vq_free_cnt,
+			vq->vq_queue_index,
+			vq->vq_avail_idx,
+			vq->vq_used_cons_idx,
+			vq->vq_packed.cached_flags,
+			vq->vq_packed.used_wrap_counter);
+
+	if (*status != VIRTIO_CRYPTO_OK) {
+		VIRTIO_CRYPTO_SESSION_LOG_ERR("Close session failed "
+				"status=%"PRIu32", session_id=%"PRIu64"",
+				*status, session_id);
+		rte_free(ctrl);
+		return;
+	}
+
+	VIRTIO_CRYPTO_INIT_LOG_DBG("vq->vq_free_cnt=%d "
+			"vq->vq_desc_head_idx=%d",
+			vq->vq_free_cnt, vq->vq_desc_head_idx);
+
+	VIRTIO_CRYPTO_SESSION_LOG_INFO("Close session %"PRIu64" successfully ",
+			session_id);
+
+	rte_free(ctrl);
+}
+
 static void
 virtio_crypto_sym_clear_session(
 		struct rte_cryptodev *dev,
@@ -906,6 +1025,9 @@ virtio_crypto_sym_clear_session(
 	ctrl->header.queue_id = 0;
 	ctrl->u.destroy_session.session_id = session->session_id;
 
+	if (vtpci_with_packed_queue(dev->data->dev_private))
+		return virtio_crypto_clear_session_packed(dev, ctrl);
+
 	return virtio_crypto_clear_session(dev, ctrl);
 }
 
@@ -943,6 +1065,9 @@ virtio_crypto_asym_clear_session(
 	ctrl->header.queue_id = 0;
 	ctrl->u.destroy_session.session_id = session->session_id;
 
+	if (vtpci_with_packed_queue(dev->data->dev_private))
+		return virtio_crypto_clear_session_packed(dev, ctrl);
+
 	return virtio_crypto_clear_session(dev, ctrl);
 }
 
diff --git a/drivers/crypto/virtio/virtio_cryptodev.h b/drivers/crypto/virtio/virtio_cryptodev.h
index d8b1e1abdd..f8498246e2 100644
--- a/drivers/crypto/virtio/virtio_cryptodev.h
+++ b/drivers/crypto/virtio/virtio_cryptodev.h
@@ -10,13 +10,21 @@
 #include "virtio_ring.h"
 
 /* Features desired/implemented by this driver. */
-#define VIRTIO_CRYPTO_PMD_GUEST_FEATURES (1ULL << VIRTIO_F_VERSION_1)
+#define VIRTIO_CRYPTO_PMD_GUEST_FEATURES (1ULL << VIRTIO_F_VERSION_1 | \
+	1ULL << VIRTIO_F_IN_ORDER                | \
+	1ULL << VIRTIO_F_RING_PACKED             | \
+	1ULL << VIRTIO_F_NOTIFICATION_DATA       | \
+	1ULL << VIRTIO_RING_F_INDIRECT_DESC      | \
+	1ULL << VIRTIO_F_ORDER_PLATFORM)
 
 #define CRYPTODEV_NAME_VIRTIO_PMD crypto_virtio
 
 #define NUM_ENTRY_VIRTIO_CRYPTO_OP 7
 
 #define VIRTIO_CRYPTO_MAX_IV_SIZE 16
+#define VIRTIO_CRYPTO_MAX_MSG_SIZE 512
+#define VIRTIO_CRYPTO_MAX_SIGN_SIZE 512
+#define VIRTIO_CRYPTO_MAX_CIPHER_SIZE 1024
 
 #define VIRTIO_CRYPTO_MAX_KEY_SIZE 256
 
@@ -36,6 +44,9 @@ struct virtio_crypto_op_cookie {
 	struct virtio_crypto_inhdr inhdr;
 	struct vring_desc desc[NUM_ENTRY_VIRTIO_CRYPTO_OP];
 	uint8_t iv[VIRTIO_CRYPTO_MAX_IV_SIZE];
+	uint8_t message[VIRTIO_CRYPTO_MAX_MSG_SIZE];
+	uint8_t sign[VIRTIO_CRYPTO_MAX_SIGN_SIZE];
+	uint8_t cipher[VIRTIO_CRYPTO_MAX_CIPHER_SIZE];
 };
 
 /*
diff --git a/drivers/crypto/virtio/virtio_cvq.c b/drivers/crypto/virtio/virtio_cvq.c
index c4df4a6176..b69c31b7d5 100644
--- a/drivers/crypto/virtio/virtio_cvq.c
+++ b/drivers/crypto/virtio/virtio_cvq.c
@@ -12,7 +12,102 @@
 #include "virtqueue.h"
 
 static struct virtio_pmd_ctrl *
-virtio_send_command(struct virtcrypto_ctl *cvq,
+virtio_send_command_packed(struct virtcrypto_ctl *cvq,
+			   struct virtio_pmd_ctrl *ctrl,
+			   int *dlen, int dnum)
+{
+	struct virtqueue *vq = virtcrypto_cq_to_vq(cvq);
+	int head;
+	struct vring_packed_desc *desc = vq->vq_packed.ring.desc;
+	struct virtio_pmd_ctrl *result;
+	uint16_t flags;
+	int sum = 0;
+	int nb_descs = 0;
+	int k;
+
+	/*
+	 * Format is enforced in qemu code:
+	 * One TX packet for header;
+	 * At least one TX packet per argument;
+	 * One RX packet for ACK.
+	 */
+	head = vq->vq_avail_idx;
+	flags = vq->vq_packed.cached_flags;
+	desc[head].addr = cvq->hdr_mem;
+	desc[head].len = sizeof(struct virtio_crypto_op_ctrl_req);
+	vq->vq_free_cnt--;
+	nb_descs++;
+	if (++vq->vq_avail_idx >= vq->vq_nentries) {
+		vq->vq_avail_idx -= vq->vq_nentries;
+		vq->vq_packed.cached_flags ^= VRING_PACKED_DESC_F_AVAIL_USED;
+	}
+
+	for (k = 0; k < dnum; k++) {
+		desc[vq->vq_avail_idx].addr = cvq->hdr_mem
+			+ sizeof(struct virtio_crypto_op_ctrl_req)
+			+ sizeof(ctrl->input) + sizeof(uint8_t) * sum;
+		desc[vq->vq_avail_idx].len = dlen[k];
+		desc[vq->vq_avail_idx].flags = VRING_DESC_F_NEXT |
+			vq->vq_packed.cached_flags;
+		sum += dlen[k];
+		vq->vq_free_cnt--;
+		nb_descs++;
+		if (++vq->vq_avail_idx >= vq->vq_nentries) {
+			vq->vq_avail_idx -= vq->vq_nentries;
+			vq->vq_packed.cached_flags ^=
+				VRING_PACKED_DESC_F_AVAIL_USED;
+		}
+	}
+
+	desc[vq->vq_avail_idx].addr = cvq->hdr_mem
+		+ sizeof(struct virtio_crypto_op_ctrl_req);
+	desc[vq->vq_avail_idx].len = sizeof(ctrl->input);
+	desc[vq->vq_avail_idx].flags = VRING_DESC_F_WRITE |
+		vq->vq_packed.cached_flags;
+	vq->vq_free_cnt--;
+	nb_descs++;
+	if (++vq->vq_avail_idx >= vq->vq_nentries) {
+		vq->vq_avail_idx -= vq->vq_nentries;
+		vq->vq_packed.cached_flags ^= VRING_PACKED_DESC_F_AVAIL_USED;
+	}
+
+	virtqueue_store_flags_packed(&desc[head], VRING_DESC_F_NEXT | flags,
+			vq->hw->weak_barriers);
+
+	virtio_wmb(vq->hw->weak_barriers);
+	cvq->notify_queue(vq, cvq->notify_cookie);
+
+	/* wait for used desc in virtqueue
+	 * desc_is_used has a load-acquire or rte_io_rmb inside
+	 */
+	while (!desc_is_used(&desc[head], vq))
+		usleep(100);
+
+	/* now get used descriptors */
+	vq->vq_free_cnt += nb_descs;
+	vq->vq_used_cons_idx += nb_descs;
+	if (vq->vq_used_cons_idx >= vq->vq_nentries) {
+		vq->vq_used_cons_idx -= vq->vq_nentries;
+		vq->vq_packed.used_wrap_counter ^= 1;
+	}
+
+	PMD_INIT_LOG(DEBUG, "vq->vq_free_cnt=%d "
+			"vq->vq_avail_idx=%d "
+			"vq->vq_used_cons_idx=%d "
+			"vq->vq_packed.cached_flags=0x%x "
+			"vq->vq_packed.used_wrap_counter=%d",
+			vq->vq_free_cnt,
+			vq->vq_avail_idx,
+			vq->vq_used_cons_idx,
+			vq->vq_packed.cached_flags,
+			vq->vq_packed.used_wrap_counter);
+
+	result = cvq->hdr_mz->addr;
+	return result;
+}
+
+static struct virtio_pmd_ctrl *
+virtio_send_command_split(struct virtcrypto_ctl *cvq,
 			  struct virtio_pmd_ctrl *ctrl,
 			  int *dlen, int dnum)
 {
@@ -122,7 +217,11 @@ virtio_crypto_send_command(struct virtcrypto_ctl *cvq, struct virtio_pmd_ctrl *c
 	}
 
 	memcpy(cvq->hdr_mz->addr, ctrl, sizeof(struct virtio_pmd_ctrl));
-	result = virtio_send_command(cvq, ctrl, dlen, dnum);
+
+	if (vtpci_with_packed_queue(vq->hw))
+		result = virtio_send_command_packed(cvq, ctrl, dlen, dnum);
+	else
+		result = virtio_send_command_split(cvq, ctrl, dlen, dnum);
 
 	rte_spinlock_unlock(&cvq->lock);
 	return result->input.status;
diff --git a/drivers/crypto/virtio/virtio_pci.h b/drivers/crypto/virtio/virtio_pci.h
index 7e94c6a3c5..79945cb88e 100644
--- a/drivers/crypto/virtio/virtio_pci.h
+++ b/drivers/crypto/virtio/virtio_pci.h
@@ -83,6 +83,25 @@ struct virtqueue;
 
 #define VIRTIO_F_VERSION_1		32
 #define VIRTIO_F_IOMMU_PLATFORM	33
+#define VIRTIO_F_RING_PACKED	34
+
+/*
+ * Inorder feature indicates that all buffers are used by the device
+ * in the same order in which they have been made available.
+ */
+#define VIRTIO_F_IN_ORDER 35
+
+/*
+ * This feature indicates that memory accesses by the driver and the device
+ * are ordered in a way described by the platform.
+ */
+#define VIRTIO_F_ORDER_PLATFORM 36
+
+/*
+ * This feature indicates that the driver passes extra data (besides
+ * identifying the virtqueue) in its device notifications.
+ */
+#define VIRTIO_F_NOTIFICATION_DATA 38
 
 /* The Guest publishes the used index for which it expects an interrupt
  * at the end of the avail ring. Host should ignore the avail->flags field.
@@ -230,6 +249,12 @@ vtpci_with_feature(struct virtio_crypto_hw *hw, uint64_t bit)
 	return (hw->guest_features & (1ULL << bit)) != 0;
 }
 
+static inline int
+vtpci_with_packed_queue(struct virtio_crypto_hw *hw)
+{
+	return vtpci_with_feature(hw, VIRTIO_F_RING_PACKED);
+}
+
 /*
  * Function declaration from virtio_pci.c
  */
diff --git a/drivers/crypto/virtio/virtio_ring.h b/drivers/crypto/virtio/virtio_ring.h
index e5b0ad74d2..c74d1172b7 100644
--- a/drivers/crypto/virtio/virtio_ring.h
+++ b/drivers/crypto/virtio/virtio_ring.h
@@ -16,6 +16,15 @@
 /* This means the buffer contains a list of buffer descriptors. */
 #define VRING_DESC_F_INDIRECT   4
 
+/* This flag means the descriptor was made available by the driver */
+#define VRING_PACKED_DESC_F_AVAIL	(1 << 7)
+/* This flag means the descriptor was used by the device */
+#define VRING_PACKED_DESC_F_USED	(1 << 15)
+
+/* Frequently used combinations */
+#define VRING_PACKED_DESC_F_AVAIL_USED	(VRING_PACKED_DESC_F_AVAIL | \
+					 VRING_PACKED_DESC_F_USED)
+
 /* The Host uses this in used->flags to advise the Guest: don't kick me
  * when you add a buffer.  It's unreliable, so it's simply an
  * optimization.  Guest will still kick if it's out of buffers.
@@ -57,6 +66,32 @@ struct vring_used {
 	struct vring_used_elem ring[];
 };
 
+/* For support of packed virtqueues in Virtio 1.1 the format of descriptors
+ * looks like this.
+ */
+struct vring_packed_desc {
+	uint64_t addr;
+	uint32_t len;
+	uint16_t id;
+	uint16_t flags;
+};
+
+#define RING_EVENT_FLAGS_ENABLE 0x0
+#define RING_EVENT_FLAGS_DISABLE 0x1
+#define RING_EVENT_FLAGS_DESC 0x2
+struct vring_packed_desc_event {
+	uint16_t desc_event_off_wrap;
+	uint16_t desc_event_flags;
+};
+
+struct vring_packed {
+	unsigned int num;
+	rte_iova_t desc_iova;
+	struct vring_packed_desc *desc;
+	struct vring_packed_desc_event *driver;
+	struct vring_packed_desc_event *device;
+};
+
 struct vring {
 	unsigned int num;
 	rte_iova_t desc_iova;
@@ -99,10 +134,18 @@ struct vring {
 #define vring_avail_event(vr) (*(uint16_t *)&(vr)->used->ring[(vr)->num])
 
 static inline size_t
-vring_size(unsigned int num, unsigned long align)
+vring_size(struct virtio_crypto_hw *hw, unsigned int num, unsigned long align)
 {
 	size_t size;
 
+	if (vtpci_with_packed_queue(hw)) {
+		size = num * sizeof(struct vring_packed_desc);
+		size += sizeof(struct vring_packed_desc_event);
+		size = RTE_ALIGN_CEIL(size, align);
+		size += sizeof(struct vring_packed_desc_event);
+		return size;
+	}
+
 	size = num * sizeof(struct vring_desc);
 	size += sizeof(struct vring_avail) + (num * sizeof(uint16_t));
 	size = RTE_ALIGN_CEIL(size, align);
@@ -124,6 +167,20 @@ vring_init_split(struct vring *vr, uint8_t *p, rte_iova_t iova,
 		RTE_ALIGN_CEIL((uintptr_t)(&vr->avail->ring[num]), align);
 }
 
+static inline void
+vring_init_packed(struct vring_packed *vr, uint8_t *p, rte_iova_t iova,
+		  unsigned long align, unsigned int num)
+{
+	vr->num = num;
+	vr->desc = (struct vring_packed_desc *)p;
+	vr->desc_iova = iova;
+	vr->driver = (struct vring_packed_desc_event *)(p +
+			vr->num * sizeof(struct vring_packed_desc));
+	vr->device = (struct vring_packed_desc_event *)
+		RTE_ALIGN_CEIL(((uintptr_t)vr->driver +
+				sizeof(struct vring_packed_desc_event)), align);
+}
+
 static inline void
 vring_init(struct vring *vr, unsigned int num, uint8_t *p, unsigned long align)
 {
diff --git a/drivers/crypto/virtio/virtio_rxtx.c b/drivers/crypto/virtio/virtio_rxtx.c
index 68fccef84b..4490034c99 100644
--- a/drivers/crypto/virtio/virtio_rxtx.c
+++ b/drivers/crypto/virtio/virtio_rxtx.c
@@ -4,6 +4,7 @@
 #include <cryptodev_pmd.h>
 
 #include "virtqueue.h"
+#include "virtio_ring.h"
 #include "virtio_cryptodev.h"
 #include "virtio_crypto_algs.h"
 
@@ -107,6 +108,91 @@ virtqueue_dequeue_burst_rx(struct virtqueue *vq,
 	return i;
 }
 
+static uint16_t
+virtqueue_dequeue_burst_rx_packed(struct virtqueue *vq,
+		struct rte_crypto_op **rx_pkts, uint16_t num)
+{
+	struct rte_crypto_op *cop;
+	uint16_t used_idx;
+	uint16_t i;
+	struct virtio_crypto_inhdr *inhdr;
+	struct virtio_crypto_op_cookie *op_cookie;
+	struct vring_packed_desc *desc;
+
+	desc = vq->vq_packed.ring.desc;
+
+	/* Caller does the check */
+	for (i = 0; i < num ; i++) {
+		used_idx = vq->vq_used_cons_idx;
+		if (!desc_is_used(&desc[used_idx], vq))
+			break;
+
+		cop = (struct rte_crypto_op *)
+				vq->vq_descx[used_idx].crypto_op;
+		if (unlikely(cop == NULL)) {
+			VIRTIO_CRYPTO_RX_LOG_DBG("vring descriptor with no "
+					"mbuf cookie at %u",
+					vq->vq_used_cons_idx);
+			break;
+		}
+
+		op_cookie = (struct virtio_crypto_op_cookie *)
+						vq->vq_descx[used_idx].cookie;
+		inhdr = &(op_cookie->inhdr);
+		switch (inhdr->status) {
+		case VIRTIO_CRYPTO_OK:
+			cop->status = RTE_CRYPTO_OP_STATUS_SUCCESS;
+			break;
+		case VIRTIO_CRYPTO_ERR:
+			cop->status = RTE_CRYPTO_OP_STATUS_ERROR;
+			vq->packets_received_failed++;
+			break;
+		case VIRTIO_CRYPTO_BADMSG:
+			cop->status = RTE_CRYPTO_OP_STATUS_INVALID_ARGS;
+			vq->packets_received_failed++;
+			break;
+		case VIRTIO_CRYPTO_NOTSUPP:
+			cop->status = RTE_CRYPTO_OP_STATUS_INVALID_ARGS;
+			vq->packets_received_failed++;
+			break;
+		case VIRTIO_CRYPTO_INVSESS:
+			cop->status = RTE_CRYPTO_OP_STATUS_INVALID_SESSION;
+			vq->packets_received_failed++;
+			break;
+		default:
+			break;
+		}
+
+		vq->packets_received_total++;
+
+		if (cop->asym->rsa.op_type == RTE_CRYPTO_ASYM_OP_SIGN)
+			memcpy(cop->asym->rsa.sign.data, op_cookie->sign,
+					cop->asym->rsa.sign.length);
+		else if (cop->asym->rsa.op_type == RTE_CRYPTO_ASYM_OP_VERIFY)
+			memcpy(cop->asym->rsa.message.data, op_cookie->message,
+					cop->asym->rsa.message.length);
+		else if (cop->asym->rsa.op_type == RTE_CRYPTO_ASYM_OP_ENCRYPT)
+			memcpy(cop->asym->rsa.cipher.data, op_cookie->cipher,
+					cop->asym->rsa.cipher.length);
+		else if (cop->asym->rsa.op_type == RTE_CRYPTO_ASYM_OP_DECRYPT)
+			memcpy(cop->asym->rsa.message.data, op_cookie->message,
+					cop->asym->rsa.message.length);
+
+		rx_pkts[i] = cop;
+		rte_mempool_put(vq->mpool, op_cookie);
+
+		vq->vq_free_cnt += 4;
+		vq->vq_used_cons_idx += 4;
+		vq->vq_descx[used_idx].crypto_op = NULL;
+		if (vq->vq_used_cons_idx >= vq->vq_nentries) {
+			vq->vq_used_cons_idx -= vq->vq_nentries;
+			vq->vq_packed.used_wrap_counter ^= 1;
+		}
+	}
+
+	return i;
+}
+
 static inline int
 virtqueue_crypto_sym_pkt_header_arrange(
 		struct rte_crypto_op *cop,
@@ -188,7 +274,7 @@ virtqueue_crypto_sym_pkt_header_arrange(
 }
 
 static inline int
-virtqueue_crypto_sym_enqueue_xmit(
+virtqueue_crypto_sym_enqueue_xmit_split(
 		struct virtqueue *txvq,
 		struct rte_crypto_op *cop)
 {
@@ -343,6 +429,160 @@ virtqueue_crypto_sym_enqueue_xmit(
 	return 0;
 }
 
+static inline int
+virtqueue_crypto_sym_enqueue_xmit_packed(
+		struct virtqueue *txvq,
+		struct rte_crypto_op *cop)
+{
+	uint16_t idx = 0;
+	uint16_t needed = 1;
+	uint16_t head_idx;
+	struct vq_desc_extra *dxp;
+	struct vring_packed_desc *start_dp;
+	struct vring_packed_desc *desc;
+	uint64_t op_data_req_phys_addr;
+	uint16_t req_data_len = sizeof(struct virtio_crypto_op_data_req);
+	uint32_t iv_addr_offset =
+			offsetof(struct virtio_crypto_op_cookie, iv);
+	struct rte_crypto_sym_op *sym_op = cop->sym;
+	struct virtio_crypto_session *session =
+		CRYPTODEV_GET_SYM_SESS_PRIV(cop->sym->session);
+	struct virtio_crypto_op_data_req *op_data_req;
+	uint32_t hash_result_len = 0;
+	struct virtio_crypto_op_cookie *crypto_op_cookie;
+	struct virtio_crypto_alg_chain_session_para *para;
+	uint16_t flags = VRING_DESC_F_NEXT;
+
+	if (unlikely(sym_op->m_src->nb_segs != 1))
+		return -EMSGSIZE;
+	if (unlikely(txvq->vq_free_cnt == 0))
+		return -ENOSPC;
+	if (unlikely(txvq->vq_free_cnt < needed))
+		return -EMSGSIZE;
+	head_idx = txvq->vq_desc_head_idx;
+	if (unlikely(head_idx >= txvq->vq_nentries))
+		return -EFAULT;
+	if (unlikely(session == NULL))
+		return -EFAULT;
+
+	dxp = &txvq->vq_descx[head_idx];
+
+	if (rte_mempool_get(txvq->mpool, &dxp->cookie)) {
+		VIRTIO_CRYPTO_TX_LOG_ERR("can not get cookie");
+		return -EFAULT;
+	}
+	crypto_op_cookie = dxp->cookie;
+	op_data_req_phys_addr = rte_mempool_virt2iova(crypto_op_cookie);
+	op_data_req = (struct virtio_crypto_op_data_req *)crypto_op_cookie;
+
+	if (virtqueue_crypto_sym_pkt_header_arrange(cop, op_data_req, session))
+		return -EFAULT;
+
+	/* status is initialized to VIRTIO_CRYPTO_ERR */
+	((struct virtio_crypto_inhdr *)
+		((uint8_t *)op_data_req + req_data_len))->status =
+		VIRTIO_CRYPTO_ERR;
+
+	desc = &txvq->vq_packed.ring.desc[txvq->vq_desc_head_idx];
+	needed = 4;
+	flags |= txvq->vq_packed.cached_flags;
+
+	start_dp = desc;
+	idx = 0;
+
+	/* packed vring: first part, virtio_crypto_op_data_req */
+	desc[idx].addr = op_data_req_phys_addr;
+	desc[idx].len = req_data_len;
+	desc[idx++].flags = flags;
+
+	/* packed vring: iv of cipher */
+	if (session->iv.length) {
+		if (cop->phys_addr)
+			desc[idx].addr = cop->phys_addr + session->iv.offset;
+		else {
+			if (session->iv.length > VIRTIO_CRYPTO_MAX_IV_SIZE)
+				return -ENOMEM;
+
+			rte_memcpy(crypto_op_cookie->iv,
+					rte_crypto_op_ctod_offset(cop,
+					uint8_t *, session->iv.offset),
+					session->iv.length);
+			desc[idx].addr = op_data_req_phys_addr + iv_addr_offset;
+		}
+
+		desc[idx].len = session->iv.length;
+		desc[idx++].flags = flags;
+	}
+
+	/* packed vring: additional auth data */
+	if (session->aad.length) {
+		desc[idx].addr = session->aad.phys_addr;
+		desc[idx].len = session->aad.length;
+		desc[idx++].flags = flags;
+	}
+
+	/* packed vring: src data */
+	desc[idx].addr = rte_pktmbuf_iova_offset(sym_op->m_src, 0);
+	desc[idx].len = (sym_op->cipher.data.offset
+		+ sym_op->cipher.data.length);
+	desc[idx++].flags = flags;
+
+	/* packed vring: dst data */
+	if (sym_op->m_dst) {
+		desc[idx].addr = rte_pktmbuf_iova_offset(sym_op->m_dst, 0);
+		desc[idx].len = (sym_op->cipher.data.offset
+			+ sym_op->cipher.data.length);
+	} else {
+		desc[idx].addr = rte_pktmbuf_iova_offset(sym_op->m_src, 0);
+		desc[idx].len = (sym_op->cipher.data.offset
+			+ sym_op->cipher.data.length);
+	}
+	desc[idx++].flags = VRING_DESC_F_WRITE | VRING_DESC_F_NEXT;
+
+	/* packed vring: digest result */
+	para = &(session->ctrl.hdr.u.sym_create_session.u.chain.para);
+	if (para->hash_mode == VIRTIO_CRYPTO_SYM_HASH_MODE_PLAIN)
+		hash_result_len = para->u.hash_param.hash_result_len;
+	if (para->hash_mode == VIRTIO_CRYPTO_SYM_HASH_MODE_AUTH)
+		hash_result_len = para->u.mac_param.hash_result_len;
+	if (hash_result_len > 0) {
+		desc[idx].addr = sym_op->auth.digest.phys_addr;
+		desc[idx].len = hash_result_len;
+		desc[idx++].flags = VRING_DESC_F_WRITE | VRING_DESC_F_NEXT;
+	}
+
+	/* packed vring: last part, status returned */
+	desc[idx].addr = op_data_req_phys_addr + req_data_len;
+	desc[idx].len = sizeof(struct virtio_crypto_inhdr);
+	desc[idx++].flags = flags | VRING_DESC_F_WRITE;
+
+	/* save the infos to use when receiving packets */
+	dxp->crypto_op = (void *)cop;
+	dxp->ndescs = needed;
+
+	txvq->vq_desc_head_idx += idx & (txvq->vq_nentries - 1);
+	if (txvq->vq_desc_head_idx == VQ_RING_DESC_CHAIN_END)
+		txvq->vq_desc_tail_idx = idx;
+	txvq->vq_free_cnt = (uint16_t)(txvq->vq_free_cnt - needed);
+	virtqueue_store_flags_packed(&start_dp[0],
+					start_dp[0].flags | flags,
+				    txvq->hw->weak_barriers);
+	virtio_wmb(txvq->hw->weak_barriers);
+
+	return 0;
+}
+
+static inline int
+virtqueue_crypto_sym_enqueue_xmit(
+		struct virtqueue *txvq,
+		struct rte_crypto_op *cop)
+{
+	if (vtpci_with_packed_queue(txvq->hw))
+		return virtqueue_crypto_sym_enqueue_xmit_packed(txvq, cop);
+	else
+		return virtqueue_crypto_sym_enqueue_xmit_split(txvq, cop);
+}
+
 static inline int
 virtqueue_crypto_asym_pkt_header_arrange(
 		struct rte_crypto_op *cop,
@@ -395,7 +635,7 @@ virtqueue_crypto_asym_pkt_header_arrange(
 }
 
 static inline int
-virtqueue_crypto_asym_enqueue_xmit(
+virtqueue_crypto_asym_enqueue_xmit_split(
 		struct virtqueue *txvq,
 		struct rte_crypto_op *cop)
 {
@@ -529,6 +769,179 @@ virtqueue_crypto_asym_enqueue_xmit(
 	return 0;
 }
 
+static inline int
+virtqueue_crypto_asym_enqueue_xmit_packed(
+		struct virtqueue *txvq,
+		struct rte_crypto_op *cop)
+{
+	uint16_t idx = 0;
+	uint16_t num_entry;
+	uint16_t needed = 1;
+	uint16_t head_idx;
+	struct vq_desc_extra *dxp;
+	struct vring_packed_desc *start_dp;
+	struct vring_packed_desc *desc;
+	uint64_t op_data_req_phys_addr;
+	uint16_t req_data_len = sizeof(struct virtio_crypto_op_data_req);
+	struct rte_crypto_asym_op *asym_op = cop->asym;
+	struct virtio_crypto_session *session =
+		CRYPTODEV_GET_ASYM_SESS_PRIV(cop->asym->session);
+	struct virtio_crypto_op_data_req *op_data_req;
+	struct virtio_crypto_op_cookie *crypto_op_cookie;
+	uint16_t flags = VRING_DESC_F_NEXT;
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
+	op_data_req_phys_addr =	rte_mempool_virt2iova(crypto_op_cookie);
+	op_data_req = (struct virtio_crypto_op_data_req *)crypto_op_cookie;
+	if (virtqueue_crypto_asym_pkt_header_arrange(cop, op_data_req, session))
+		return -EFAULT;
+
+	/* status is initialized to VIRTIO_CRYPTO_ERR */
+	((struct virtio_crypto_inhdr *)
+		((uint8_t *)op_data_req + req_data_len))->status =
+		VIRTIO_CRYPTO_ERR;
+
+	desc = &txvq->vq_packed.ring.desc[txvq->vq_desc_head_idx];
+	needed = 4;
+	flags |= txvq->vq_packed.cached_flags;
+
+	start_dp = desc;
+	idx = 0;
+
+	/* packed vring: first part, virtio_crypto_op_data_req */
+	desc[idx].addr = op_data_req_phys_addr;
+	desc[idx].len = sizeof(struct virtio_crypto_op_data_req);
+	desc[idx++].flags = flags;
+
+	if (asym_op->rsa.op_type == RTE_CRYPTO_ASYM_OP_SIGN) {
+		/* packed vring: src data */
+		if (asym_op->rsa.message.length > VIRTIO_CRYPTO_MAX_MSG_SIZE)
+			return -ENOMEM;
+		memcpy(crypto_op_cookie->message, asym_op->rsa.message.data,
+				asym_op->rsa.message.length);
+		desc[idx].addr = op_data_req_phys_addr +
+			offsetof(struct virtio_crypto_op_cookie, message);
+		desc[idx].len = asym_op->rsa.message.length;
+		desc[idx++].flags = flags;
+
+		/* packed vring: dst data */
+		if (asym_op->rsa.sign.length > VIRTIO_CRYPTO_MAX_SIGN_SIZE)
+			return -ENOMEM;
+		desc[idx].addr = op_data_req_phys_addr +
+			offsetof(struct virtio_crypto_op_cookie, sign);
+		desc[idx].len = asym_op->rsa.sign.length;
+		desc[idx++].flags = flags | VRING_DESC_F_WRITE;
+	} else if (asym_op->rsa.op_type == RTE_CRYPTO_ASYM_OP_VERIFY) {
+		/* packed vring: src data */
+		if (asym_op->rsa.sign.length > VIRTIO_CRYPTO_MAX_SIGN_SIZE)
+			return -ENOMEM;
+		memcpy(crypto_op_cookie->sign, asym_op->rsa.sign.data,
+				asym_op->rsa.sign.length);
+		desc[idx].addr = op_data_req_phys_addr +
+			offsetof(struct virtio_crypto_op_cookie, sign);
+		desc[idx].len = asym_op->rsa.sign.length;
+		desc[idx++].flags = flags;
+
+		/* packed vring: dst data */
+		if (asym_op->rsa.message.length > VIRTIO_CRYPTO_MAX_MSG_SIZE)
+			return -ENOMEM;
+		desc[idx].addr = op_data_req_phys_addr +
+			offsetof(struct virtio_crypto_op_cookie, message);
+		desc[idx].len = asym_op->rsa.message.length;
+		desc[idx++].flags = flags;
+	} else if (asym_op->rsa.op_type == RTE_CRYPTO_ASYM_OP_ENCRYPT) {
+		/* packed vring: src data */
+		if (asym_op->rsa.message.length > VIRTIO_CRYPTO_MAX_MSG_SIZE)
+			return -ENOMEM;
+		memcpy(crypto_op_cookie->message, asym_op->rsa.message.data,
+				asym_op->rsa.message.length);
+		desc[idx].addr = op_data_req_phys_addr +
+			offsetof(struct virtio_crypto_op_cookie, message);
+		desc[idx].len = asym_op->rsa.message.length;
+		desc[idx++].flags = flags;
+
+		/* packed vring: dst data */
+		if (asym_op->rsa.cipher.length > VIRTIO_CRYPTO_MAX_CIPHER_SIZE)
+			return -ENOMEM;
+		desc[idx].addr = op_data_req_phys_addr +
+			offsetof(struct virtio_crypto_op_cookie, cipher);
+		desc[idx].len = asym_op->rsa.cipher.length;
+		desc[idx++].flags = flags | VRING_DESC_F_WRITE;
+	} else if (asym_op->rsa.op_type == RTE_CRYPTO_ASYM_OP_DECRYPT) {
+		/* packed vring: src data */
+		if (asym_op->rsa.cipher.length > VIRTIO_CRYPTO_MAX_CIPHER_SIZE)
+			return -ENOMEM;
+		memcpy(crypto_op_cookie->cipher, asym_op->rsa.cipher.data,
+				asym_op->rsa.cipher.length);
+		desc[idx].addr = op_data_req_phys_addr +
+			offsetof(struct virtio_crypto_op_cookie, cipher);
+		desc[idx].len = asym_op->rsa.cipher.length;
+		desc[idx++].flags = flags;
+
+		/* packed vring: dst data */
+		if (asym_op->rsa.message.length > VIRTIO_CRYPTO_MAX_MSG_SIZE)
+			return -ENOMEM;
+		desc[idx].addr = op_data_req_phys_addr +
+			offsetof(struct virtio_crypto_op_cookie, message);
+		desc[idx].len = asym_op->rsa.message.length;
+		desc[idx++].flags = flags | VRING_DESC_F_WRITE;
+	} else {
+		VIRTIO_CRYPTO_TX_LOG_ERR("Invalid asym op");
+		return -EINVAL;
+	}
+
+	/* packed vring: last part, status returned */
+	desc[idx].addr = op_data_req_phys_addr + req_data_len;
+	desc[idx].len = sizeof(struct virtio_crypto_inhdr);
+	desc[idx++].flags = txvq->vq_packed.cached_flags | VRING_DESC_F_WRITE;
+
+	num_entry = idx;
+	txvq->vq_avail_idx += num_entry;
+	if (txvq->vq_avail_idx >= txvq->vq_nentries) {
+		txvq->vq_avail_idx -= txvq->vq_nentries;
+		txvq->vq_packed.cached_flags ^= VRING_PACKED_DESC_F_AVAIL_USED;
+	}
+
+	/* save the infos to use when receiving packets */
+	dxp->crypto_op = (void *)cop;
+	dxp->ndescs = needed;
+
+	txvq->vq_desc_head_idx = (txvq->vq_desc_head_idx + idx) & (txvq->vq_nentries - 1);
+	if (txvq->vq_desc_head_idx == VQ_RING_DESC_CHAIN_END)
+		txvq->vq_desc_tail_idx = idx;
+	txvq->vq_free_cnt = (uint16_t)(txvq->vq_free_cnt - needed);
+	virtqueue_store_flags_packed(&start_dp[0],
+					start_dp[0].flags | flags,
+				    txvq->hw->weak_barriers);
+	virtio_wmb(txvq->hw->weak_barriers);
+	return 0;
+}
+
+static inline int
+virtqueue_crypto_asym_enqueue_xmit(
+		struct virtqueue *txvq,
+		struct rte_crypto_op *cop)
+{
+	if (vtpci_with_packed_queue(txvq->hw))
+		return virtqueue_crypto_asym_enqueue_xmit_packed(txvq, cop);
+	else
+		return virtqueue_crypto_asym_enqueue_xmit_split(txvq, cop);
+}
+
 static int
 virtio_crypto_vring_start(struct virtqueue *vq)
 {
@@ -595,19 +1008,22 @@ virtio_crypto_pkt_rx_burst(void *tx_queue, struct rte_crypto_op **rx_pkts,
 	struct virtqueue *txvq = tx_queue;
 	uint16_t nb_used, num, nb_rx;
 
-	nb_used = VIRTQUEUE_NUSED(txvq);
-
-	virtio_rmb();
-
-	num = (uint16_t)(likely(nb_used <= nb_pkts) ? nb_used : nb_pkts);
-	num = (uint16_t)(likely(num <= VIRTIO_MBUF_BURST_SZ)
-		? num : VIRTIO_MBUF_BURST_SZ);
+	virtio_rmb(0);
 
+	num = (uint16_t)(likely(nb_pkts <= VIRTIO_MBUF_BURST_SZ)
+		? nb_pkts : VIRTIO_MBUF_BURST_SZ);
 	if (num == 0)
 		return 0;
 
-	nb_rx = virtqueue_dequeue_burst_rx(txvq, rx_pkts, num);
-	VIRTIO_CRYPTO_RX_LOG_DBG("used:%d dequeue:%d", nb_used, num);
+	if (likely(vtpci_with_packed_queue(txvq->hw))) {
+		nb_rx = virtqueue_dequeue_burst_rx_packed(txvq, rx_pkts, num);
+	} else {
+		nb_used = VIRTQUEUE_NUSED(txvq);
+		num = (uint16_t)(likely(num <= nb_used) ? num : nb_used);
+		nb_rx = virtqueue_dequeue_burst_rx(txvq, rx_pkts, num);
+	}
+
+	VIRTIO_CRYPTO_RX_LOG_DBG("used:%d dequeue:%d", nb_rx, num);
 
 	return nb_rx;
 }
@@ -683,6 +1099,12 @@ virtio_crypto_pkt_tx_burst(void *tx_queue, struct rte_crypto_op **tx_pkts,
 	}
 
 	if (likely(nb_tx)) {
+		if (vtpci_with_packed_queue(txvq->hw)) {
+			virtqueue_notify(txvq);
+			VIRTIO_CRYPTO_TX_LOG_DBG("Notified backend after xmit");
+			return nb_tx;
+		}
+
 		vq_update_avail_idx(txvq);
 
 		if (unlikely(virtqueue_kick_prepare(txvq))) {
diff --git a/drivers/crypto/virtio/virtqueue.c b/drivers/crypto/virtio/virtqueue.c
index af7f121f67..061aa09dbe 100644
--- a/drivers/crypto/virtio/virtqueue.c
+++ b/drivers/crypto/virtio/virtqueue.c
@@ -12,8 +12,23 @@
 #include "virtio_cryptodev.h"
 #include "virtqueue.h"
 
-void
-virtqueue_disable_intr(struct virtqueue *vq)
+static inline void
+virtqueue_disable_intr_packed(struct virtqueue *vq)
+{
+	/*
+	 * Set RING_EVENT_FLAGS_DISABLE to hint host
+	 * not to interrupt when it consumes packets
+	 * Note: this is only considered a hint to the host
+	 */
+	if (vq->vq_packed.event_flags_shadow != RING_EVENT_FLAGS_DISABLE) {
+		vq->vq_packed.event_flags_shadow = RING_EVENT_FLAGS_DISABLE;
+		vq->vq_packed.ring.driver->desc_event_flags =
+			vq->vq_packed.event_flags_shadow;
+	}
+}
+
+static inline void
+virtqueue_disable_intr_split(struct virtqueue *vq)
 {
 	/*
 	 * Set VRING_AVAIL_F_NO_INTERRUPT to hint host
@@ -23,6 +38,15 @@ virtqueue_disable_intr(struct virtqueue *vq)
 	vq->vq_split.ring.avail->flags |= VRING_AVAIL_F_NO_INTERRUPT;
 }
 
+void
+virtqueue_disable_intr(struct virtqueue *vq)
+{
+	if (vtpci_with_packed_queue(vq->hw))
+		virtqueue_disable_intr_packed(vq);
+	else
+		virtqueue_disable_intr_split(vq);
+}
+
 void
 virtqueue_detatch_unused(struct virtqueue *vq)
 {
@@ -49,7 +73,6 @@ static void
 virtio_init_vring(struct virtqueue *vq)
 {
 	uint8_t *ring_mem = vq->vq_ring_virt_mem;
-	struct vring *vr = &vq->vq_split.ring;
 	int size = vq->vq_nentries;
 
 	PMD_INIT_FUNC_TRACE();
@@ -62,10 +85,16 @@ virtio_init_vring(struct virtqueue *vq)
 	vq->vq_desc_tail_idx = (uint16_t)(vq->vq_nentries - 1);
 	vq->vq_free_cnt = vq->vq_nentries;
 	memset(vq->vq_descx, 0, sizeof(struct vq_desc_extra) * vq->vq_nentries);
-
-	vring_init_split(vr, ring_mem, vq->vq_ring_mem, VIRTIO_PCI_VRING_ALIGN, size);
-	vring_desc_init_split(vr->desc, size);
-
+	if (vtpci_with_packed_queue(vq->hw)) {
+		vring_init_packed(&vq->vq_packed.ring, ring_mem, vq->vq_ring_mem,
+				  VIRTIO_PCI_VRING_ALIGN, size);
+		vring_desc_init_packed(vq, size);
+	} else {
+		struct vring *vr = &vq->vq_split.ring;
+
+		vring_init_split(vr, ring_mem, vq->vq_ring_mem, VIRTIO_PCI_VRING_ALIGN, size);
+		vring_desc_init_split(vr->desc, size);
+	}
 	/*
 	 * Disable device(host) interrupting guest
 	 */
@@ -171,11 +200,16 @@ virtcrypto_queue_alloc(struct virtio_crypto_hw *hw, uint16_t index, uint16_t num
 	vq->hw = hw;
 	vq->vq_queue_index = index;
 	vq->vq_nentries = num;
+	if (vtpci_with_packed_queue(hw)) {
+		vq->vq_packed.used_wrap_counter = 1;
+		vq->vq_packed.cached_flags = VRING_PACKED_DESC_F_AVAIL;
+		vq->vq_packed.event_flags_shadow = 0;
+	}
 
 	/*
 	 * Reserve a memzone for vring elements
 	 */
-	size = vring_size(num, VIRTIO_PCI_VRING_ALIGN);
+	size = vring_size(hw, num, VIRTIO_PCI_VRING_ALIGN);
 	vq->vq_ring_size = RTE_ALIGN_CEIL(size, VIRTIO_PCI_VRING_ALIGN);
 	PMD_INIT_LOG(DEBUG, "vring_size: %d, rounded_vring_size: %d", size, vq->vq_ring_size);
 
diff --git a/drivers/crypto/virtio/virtqueue.h b/drivers/crypto/virtio/virtqueue.h
index 9191d1f732..97a3ace48c 100644
--- a/drivers/crypto/virtio/virtqueue.h
+++ b/drivers/crypto/virtio/virtqueue.h
@@ -28,9 +28,78 @@ struct rte_mbuf;
  *     sufficient.
  *
  */
-#define virtio_mb()	rte_smp_mb()
-#define virtio_rmb()	rte_smp_rmb()
-#define virtio_wmb()	rte_smp_wmb()
+static inline void
+virtio_mb(uint8_t weak_barriers)
+{
+	if (weak_barriers)
+		rte_atomic_thread_fence(rte_memory_order_seq_cst);
+	else
+		rte_mb();
+}
+
+static inline void
+virtio_rmb(uint8_t weak_barriers)
+{
+	if (weak_barriers)
+		rte_atomic_thread_fence(rte_memory_order_acquire);
+	else
+		rte_io_rmb();
+}
+
+static inline void
+virtio_wmb(uint8_t weak_barriers)
+{
+	if (weak_barriers)
+		rte_atomic_thread_fence(rte_memory_order_release);
+	else
+		rte_io_wmb();
+}
+
+static inline uint16_t
+virtqueue_fetch_flags_packed(struct vring_packed_desc *dp,
+			      uint8_t weak_barriers)
+{
+	uint16_t flags;
+
+	if (weak_barriers) {
+/* x86 prefers to using rte_io_rmb over rte_atomic_load_explicit as it reports
+ * a better perf(~1.5%), which comes from the saved branch by the compiler.
+ * The if and else branch are identical  on the platforms except Arm.
+ */
+#ifdef RTE_ARCH_ARM
+		flags = rte_atomic_load_explicit(&dp->flags, rte_memory_order_acquire);
+#else
+		flags = dp->flags;
+		rte_io_rmb();
+#endif
+	} else {
+		flags = dp->flags;
+		rte_io_rmb();
+	}
+
+	return flags;
+}
+
+static inline void
+virtqueue_store_flags_packed(struct vring_packed_desc *dp,
+			      uint16_t flags, uint8_t weak_barriers)
+{
+	if (weak_barriers) {
+/* x86 prefers to using rte_io_wmb over rte_atomic_store_explicit as it reports
+ * a better perf(~1.5%), which comes from the saved branch by the compiler.
+ * The if and else branch are identical on the platforms except Arm.
+ */
+#ifdef RTE_ARCH_ARM
+		rte_atomic_store_explicit(&dp->flags, flags, rte_memory_order_release);
+#else
+		rte_io_wmb();
+		dp->flags = flags;
+#endif
+	} else {
+		rte_io_wmb();
+		dp->flags = flags;
+	}
+}
 
 #define VIRTQUEUE_MAX_NAME_SZ 32
 
@@ -62,7 +131,16 @@ struct virtqueue {
 			/**< vring keeping desc, used and avail */
 			struct vring ring;
 		} vq_split;
+
+		struct {
+			/**< vring keeping descs and events */
+			struct vring_packed ring;
+			bool used_wrap_counter;
+			uint16_t cached_flags; /**< cached flags for descs */
+			uint16_t event_flags_shadow;
+		} vq_packed;
 	};
+
 	union {
 		struct virtcrypto_data dq;
 		struct virtcrypto_ctl cq;
@@ -134,7 +212,7 @@ virtqueue_full(const struct virtqueue *vq)
 static inline void
 vq_update_avail_idx(struct virtqueue *vq)
 {
-	virtio_wmb();
+	virtio_wmb(0);
 	vq->vq_split.ring.avail->idx = vq->vq_avail_idx;
 }
 
@@ -172,6 +250,30 @@ virtqueue_notify(struct virtqueue *vq)
 	VTPCI_OPS(vq->hw)->notify_queue(vq->hw, vq);
 }
 
+static inline int
+desc_is_used(struct vring_packed_desc *desc, struct virtqueue *vq)
+{
+	uint16_t used, avail, flags;
+
+	flags = virtqueue_fetch_flags_packed(desc, vq->hw->weak_barriers);
+	used = !!(flags & VRING_PACKED_DESC_F_USED);
+	avail = !!(flags & VRING_PACKED_DESC_F_AVAIL);
+
+	return avail == used && used == vq->vq_packed.used_wrap_counter;
+}
+
+static inline void
+vring_desc_init_packed(struct virtqueue *vq, int n)
+{
+	int i;
+	for (i = 0; i < n - 1; i++) {
+		vq->vq_packed.ring.desc[i].id = i;
+		vq->vq_descx[i].next = i + 1;
+	}
+	vq->vq_packed.ring.desc[i].id = i;
+	vq->vq_descx[i].next = VQ_RING_DESC_CHAIN_END;
+}
+
 /* Chain all the descriptors in the ring with an END */
 static inline void
 vring_desc_init_split(struct vring_desc *dp, uint16_t n)
@@ -208,7 +310,7 @@ virtqueue_nused(const struct virtqueue *vq)
 	 */
 #ifdef RTE_ARCH_X86_64
 		idx = vq->vq_split.ring.used->idx;
-		virtio_rmb();
+		virtio_rmb(0);
 #else
 		idx = rte_atomic_load_explicit(&(vq)->vq_split.ring.used->idx,
 				rte_memory_order_acquire);
@@ -223,7 +325,7 @@ virtqueue_nused(const struct virtqueue *vq)
 /**
  * Dump virtqueue internal structures, for debug purpose only.
  */
-#define VIRTQUEUE_DUMP(vq) do { \
+#define VIRTQUEUE_SPLIT_DUMP(vq) do { \
 	uint16_t used_idx, nused; \
 	used_idx = (vq)->vq_split.ring.used->idx; \
 	nused = (uint16_t)(used_idx - (vq)->vq_used_cons_idx); \
@@ -237,4 +339,24 @@ virtqueue_nused(const struct virtqueue *vq)
 	  (vq)->vq_split.ring.avail->flags, (vq)->vq_split.ring.used->flags); \
 } while (0)
 
+#define VIRTQUEUE_PACKED_DUMP(vq) do { \
+	uint16_t nused; \
+	nused = (vq)->vq_nentries - (vq)->vq_free_cnt; \
+	VIRTIO_CRYPTO_INIT_LOG_DBG(\
+	  "VQ: - size=%d; free=%d; used=%d; desc_head_idx=%d;" \
+	  " avail_idx=%d; used_cons_idx=%d;" \
+	  " avail.flags=0x%x; wrap_counter=%d", \
+	  (vq)->vq_nentries, (vq)->vq_free_cnt, nused, \
+	  (vq)->vq_desc_head_idx, (vq)->vq_avail_idx, \
+	  (vq)->vq_used_cons_idx, (vq)->vq_packed.cached_flags, \
+	  (vq)->vq_packed.used_wrap_counter); \
+} while (0)
+
+#define VIRTQUEUE_DUMP(vq) do { \
+	if (vtpci_with_packed_queue((vq)->hw)) \
+		VIRTQUEUE_PACKED_DUMP(vq); \
+	else \
+		VIRTQUEUE_SPLIT_DUMP(vq); \
+} while (0)
+
 #endif /* _VIRTQUEUE_H_ */
-- 
2.25.1

