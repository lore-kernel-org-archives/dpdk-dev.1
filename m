Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F482606A78D
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=fYY6IGkI
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2EDDF42DCB;
	Tue,  3 Nov 2026 16:06:10 +0100 (CET)
Received: from mta1.migadu.com (out-32.mta1.migadu.com [95.215.58.32])
 by mails.dpdk.org (Postfix) with ESMTPS id DA22C4113D
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:06:08 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=WHBmiC91DqdrzUa+fvmwZqFa7K+KwY4tHmUkwz05wzk=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793718368; v=1; x=1794323168;
 b=fYY6IGkI41QctSkILFfqDnU0ykjIbIIOtRhIaErJz2tej7UviKuuBh/V1c4U4tgcvWWEq+pu
 psk/LtN1Dj4PjCeSRCCnpXJWPuP9zdyZAC935DrG+Ko6Fh3PAbJ2/sQkohfUIqtrawLsE5oD+p1
 Bz1WdGmLt2/IyxqCAon2Nmn4=
X-Envelope-To: dev@dpdk.org
Received: by mta11.migadu.com with ESMTPS id e31a9bbd83bd1b64;
 Tue, 03 Nov 2026 15:06:08 +0000
X-Mizu-Trace-ID: e31a9bbd83bd1b64
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 079/227] crypto/virtio: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:50:37 +0800
Message-ID: <20261103145306.487255-80-chengwen.feng@linux.dev>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261103145306.487255-1-chengwen.feng@linux.dev>
References: <20261103145306.487255-1-chengwen.feng@linux.dev>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Chengwen Feng <fengchengwen@huawei.com>

Rename socket_id parameters, internal structure fields, variables
and comments to the NUMA node terminology, and switch calls to
the NUMA-named APIs.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 drivers/crypto/virtio/virtio_cryptodev.c | 12 ++++++------
 drivers/crypto/virtio/virtio_cryptodev.h |  2 +-
 drivers/crypto/virtio/virtqueue.c        |  2 +-
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/crypto/virtio/virtio_cryptodev.c b/drivers/crypto/virtio/virtio_cryptodev.c
index d0fe21947c..9f1df7be50 100644
--- a/drivers/crypto/virtio/virtio_cryptodev.c
+++ b/drivers/crypto/virtio/virtio_cryptodev.c
@@ -30,7 +30,7 @@ static void virtio_crypto_dev_stats_reset(struct rte_cryptodev *dev);
 static int virtio_crypto_qp_setup(struct rte_cryptodev *dev,
 		uint16_t queue_pair_id,
 		const struct rte_cryptodev_qp_conf *qp_conf,
-		int socket_id);
+		int numa_id);
 static int virtio_crypto_qp_release(struct rte_cryptodev *dev,
 		uint16_t queue_pair_id);
 static void virtio_crypto_dev_free_mbufs(struct rte_cryptodev *dev);
@@ -90,7 +90,7 @@ virtio_crypto_queue_setup(struct rte_cryptodev *dev,
 		int queue_type,
 		uint16_t vtpci_queue_idx,
 		uint16_t nb_desc,
-		int socket_id,
+		int numa_id,
 		struct virtqueue **pvq)
 {
 	char vq_name[VIRTQUEUE_MAX_NAME_SZ];
@@ -144,7 +144,7 @@ virtio_crypto_queue_setup(struct rte_cryptodev *dev,
 		vq = hw->vqs[vtpci_queue_idx];
 	else
 		vq = virtcrypto_queue_alloc(hw, vtpci_queue_idx, nb_desc,
-				socket_id, vq_name);
+				numa_id, vq_name);
 	if (vq == NULL) {
 		VIRTIO_CRYPTO_INIT_LOG_ERR("Can not allocate virtqueue");
 		return -ENOMEM;
@@ -162,7 +162,7 @@ virtio_crypto_queue_setup(struct rte_cryptodev *dev,
 					nb_desc,
 					sizeof(struct virtio_crypto_op_cookie),
 					RTE_CACHE_LINE_SIZE, 0,
-					NULL, NULL, NULL, NULL, socket_id,
+					NULL, NULL, NULL, NULL, numa_id,
 					0);
 		if (!vq->mpool) {
 			VIRTIO_CRYPTO_DRV_LOG_ERR("Virtio Crypto PMD "
@@ -298,7 +298,7 @@ virtio_crypto_dev_stats_reset(struct rte_cryptodev *dev)
 static int
 virtio_crypto_qp_setup(struct rte_cryptodev *dev, uint16_t queue_pair_id,
 		const struct rte_cryptodev_qp_conf *qp_conf,
-		int socket_id)
+		int numa_id)
 {
 	int ret;
 	struct virtqueue *vq;
@@ -310,7 +310,7 @@ virtio_crypto_qp_setup(struct rte_cryptodev *dev, uint16_t queue_pair_id,
 		return 0;
 
 	ret = virtio_crypto_queue_setup(dev, VTCRYPTO_DATAQ, queue_pair_id,
-			qp_conf->nb_descriptors, socket_id, &vq);
+			qp_conf->nb_descriptors, numa_id, &vq);
 	if (ret < 0) {
 		VIRTIO_CRYPTO_INIT_LOG_ERR(
 			"virtio crypto data queue initialization failed");
diff --git a/drivers/crypto/virtio/virtio_cryptodev.h b/drivers/crypto/virtio/virtio_cryptodev.h
index 075b5ff444..2ca1e77492 100644
--- a/drivers/crypto/virtio/virtio_cryptodev.h
+++ b/drivers/crypto/virtio/virtio_cryptodev.h
@@ -63,7 +63,7 @@ int virtio_crypto_queue_setup(struct rte_cryptodev *dev,
 		int queue_type,
 		uint16_t vtpci_queue_idx,
 		uint16_t nb_desc,
-		int socket_id,
+		int numa_id,
 		struct virtqueue **pvq);
 
 void virtio_crypto_queue_release(struct virtqueue *vq);
diff --git a/drivers/crypto/virtio/virtqueue.c b/drivers/crypto/virtio/virtqueue.c
index 061aa09dbe..d76e0a0cf5 100644
--- a/drivers/crypto/virtio/virtqueue.c
+++ b/drivers/crypto/virtio/virtqueue.c
@@ -190,7 +190,7 @@ virtcrypto_queue_alloc(struct virtio_crypto_hw *hw, uint16_t index, uint16_t num
 	size = sizeof(*vq) + num * sizeof(struct vq_desc_extra);
 	size = RTE_ALIGN_CEIL(size, RTE_CACHE_LINE_SIZE);
 
-	vq = rte_zmalloc_socket(name, size, RTE_CACHE_LINE_SIZE, node);
+	vq = rte_zmalloc_numa(name, size, RTE_CACHE_LINE_SIZE, node);
 	if (vq == NULL) {
 		PMD_INIT_LOG(ERR, "can not allocate vq");
 		return NULL;
-- 
2.55.0

