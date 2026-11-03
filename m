Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2EB6606BA15
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=ZDQu1wGs
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9896142D97;
	Tue,  3 Nov 2026 16:04:55 +0100 (CET)
Received: from mta0.migadu.com (out-226.mta0.migadu.com [91.218.175.226])
 by mails.dpdk.org (Postfix) with ESMTPS id E9DB24278B
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:04:53 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=fzAagMnJ5JDZ2ohk5kQuBxDnJL+tRkGUB3/asMe0i50=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793718293; v=1; x=1794323093;
 b=ZDQu1wGsr/12TcjSVTbFES9fukWc9FAEz8A4phkA9zo9dBJM2gEt2bqdbhBf4+dFHWNscFdE
 88IDIEl+pIGj0FpqZeEs0AmLUX+4p1mgVzPhbdZ7nV0N4x/lJtDT882SHoeAKznze0slGv5DGzY
 g6cMoFJRfngKjZbXwBoShKdg=
X-Envelope-To: dev@dpdk.org
Received: by mta10.migadu.com with ESMTPS id d82e5081ef3b0510;
 Tue, 03 Nov 2026 15:04:53 +0000
X-Mizu-Trace-ID: d82e5081ef3b0510
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 071/227] crypto/mlx5: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:50:29 +0800
Message-ID: <20261103145306.487255-72-chengwen.feng@linux.dev>
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
 drivers/crypto/mlx5/mlx5_crypto.c     |  2 +-
 drivers/crypto/mlx5/mlx5_crypto_gcm.c | 16 ++++++++--------
 drivers/crypto/mlx5/mlx5_crypto_xts.c | 10 +++++-----
 3 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/crypto/mlx5/mlx5_crypto.c b/drivers/crypto/mlx5/mlx5_crypto.c
index 821dd54b31..c668b2d04a 100644
--- a/drivers/crypto/mlx5/mlx5_crypto.c
+++ b/drivers/crypto/mlx5/mlx5_crypto.c
@@ -353,7 +353,7 @@ mlx5_crypto_dev_probe(struct mlx5_common_device *cdev,
 	struct rte_cryptodev_pmd_init_params init_params = {
 		.name = "",
 		.private_data_size = sizeof(struct mlx5_crypto_priv),
-		.socket_id = cdev->dev->numa_node,
+		.numa_id = cdev->dev->numa_node,
 		.max_nb_queue_pairs =
 				RTE_CRYPTODEV_PMD_DEFAULT_MAX_NB_QUEUE_PAIRS,
 	};
diff --git a/drivers/crypto/mlx5/mlx5_crypto_gcm.c b/drivers/crypto/mlx5/mlx5_crypto_gcm.c
index d0f01dab4a..078162e7b4 100644
--- a/drivers/crypto/mlx5/mlx5_crypto_gcm.c
+++ b/drivers/crypto/mlx5/mlx5_crypto_gcm.c
@@ -264,7 +264,7 @@ mlx5_crypto_gcm_init_qp(struct mlx5_crypto_qp *qp)
 
 static inline int
 mlx5_crypto_gcm_umr_qp_setup(struct rte_cryptodev *dev, struct mlx5_crypto_qp *qp,
-			     int socket_id)
+			     int numa_id)
 {
 	struct mlx5_crypto_priv *priv = dev->data->dev_private;
 	struct mlx5_devx_qp_attr attr = {0};
@@ -284,7 +284,7 @@ mlx5_crypto_gcm_umr_qp_setup(struct rte_cryptodev *dev, struct mlx5_crypto_qp *q
 	attr.cd_master = 1;
 	ret = mlx5_devx_qp_create(priv->cdev->ctx, &qp->umr_qp_obj,
 				  attr.num_of_send_wqbbs * MLX5_SEND_WQE_BB,
-				  &attr, socket_id);
+				  &attr, numa_id);
 	if (ret) {
 		DRV_LOG(ERR, "Failed to create UMR QP.");
 		return -1;
@@ -301,7 +301,7 @@ mlx5_crypto_gcm_umr_qp_setup(struct rte_cryptodev *dev, struct mlx5_crypto_qp *q
 static int
 mlx5_crypto_gcm_qp_setup(struct rte_cryptodev *dev, uint16_t qp_id,
 			 const struct rte_cryptodev_qp_conf *qp_conf,
-			 int socket_id)
+			 int numa_id)
 {
 	struct mlx5_crypto_priv *priv = dev->data->dev_private;
 	struct mlx5_hca_attr *attr = &priv->cdev->config.hca_attr;
@@ -332,8 +332,8 @@ mlx5_crypto_gcm_qp_setup(struct rte_cryptodev *dev, uint16_t qp_id,
 	alloc_size = RTE_ALIGN(alloc_size, RTE_CACHE_LINE_SIZE);
 	alloc_size += (sizeof(struct rte_crypto_op *) +
 		       extra_obj_size) * entries;
-	qp = rte_zmalloc_socket(__func__, alloc_size, RTE_CACHE_LINE_SIZE,
-				socket_id);
+	qp = rte_zmalloc_numa(__func__, alloc_size, RTE_CACHE_LINE_SIZE,
+				numa_id);
 	if (qp == NULL) {
 		DRV_LOG(ERR, "Failed to allocate qp memory.");
 		rte_errno = ENOMEM;
@@ -377,7 +377,7 @@ mlx5_crypto_gcm_qp_setup(struct rte_cryptodev *dev, uint16_t qp_id,
 	qp->cq_entries_n = rte_align32pow2(entries * (mlx5_crypto_is_ipsec_opt(priv) ? 1 : 3));
 	ret = mlx5_devx_cq_create(priv->cdev->ctx, &qp->cq_obj,
 				  rte_log2_u32(qp->cq_entries_n),
-				  &cq_attr, socket_id);
+				  &cq_attr, numa_id);
 	if (ret != 0) {
 		DRV_LOG(ERR, "Failed to create CQ.");
 		goto err;
@@ -391,7 +391,7 @@ mlx5_crypto_gcm_qp_setup(struct rte_cryptodev *dev, uint16_t qp_id,
 	qp_attr.cd_slave_send = !mlx5_crypto_is_ipsec_opt(priv);
 	ret = mlx5_devx_qp_create(priv->cdev->ctx, &qp->qp_obj,
 				  qp_attr.num_of_send_wqbbs * MLX5_WQE_SIZE,
-				  &qp_attr, socket_id);
+				  &qp_attr, numa_id);
 	if (ret != 0) {
 		DRV_LOG(ERR, "Failed to create QP.");
 		goto err;
@@ -403,7 +403,7 @@ mlx5_crypto_gcm_qp_setup(struct rte_cryptodev *dev, uint16_t qp_id,
 	qp->ops = (struct rte_crypto_op **)(qp + 1);
 	if (!mlx5_crypto_is_ipsec_opt(priv)) {
 		qp->mkey = (struct mlx5_devx_obj **)(qp->ops + entries);
-		if (mlx5_crypto_gcm_umr_qp_setup(dev, qp, socket_id)) {
+		if (mlx5_crypto_gcm_umr_qp_setup(dev, qp, numa_id)) {
 			DRV_LOG(ERR, "Failed to setup UMR QP.");
 			goto err;
 		}
diff --git a/drivers/crypto/mlx5/mlx5_crypto_xts.c b/drivers/crypto/mlx5/mlx5_crypto_xts.c
index badde267a7..26b2bcbe1c 100644
--- a/drivers/crypto/mlx5/mlx5_crypto_xts.c
+++ b/drivers/crypto/mlx5/mlx5_crypto_xts.c
@@ -460,7 +460,7 @@ mlx5_crypto_gcm_mkey_klm_update(struct mlx5_crypto_priv *priv,
 static int
 mlx5_crypto_xts_queue_pair_setup(struct rte_cryptodev *dev, uint16_t qp_id,
 				 const struct rte_cryptodev_qp_conf *qp_conf,
-				 int socket_id)
+				 int numa_id)
 {
 	struct mlx5_crypto_priv *priv = dev->data->dev_private;
 	struct mlx5_devx_qp_attr attr = {0};
@@ -486,15 +486,15 @@ mlx5_crypto_xts_queue_pair_setup(struct rte_cryptodev *dev, uint16_t qp_id,
 	alloc_size += (sizeof(struct rte_crypto_op *) +
 		       sizeof(struct mlx5_devx_obj *)) *
 		       (size_t)RTE_BIT32(log_nb_desc);
-	qp = rte_zmalloc_socket(__func__, alloc_size, RTE_CACHE_LINE_SIZE,
-				socket_id);
+	qp = rte_zmalloc_numa(__func__, alloc_size, RTE_CACHE_LINE_SIZE,
+				numa_id);
 	if (qp == NULL) {
 		DRV_LOG(ERR, "Failed to allocate QP memory.");
 		rte_errno = ENOMEM;
 		return -rte_errno;
 	}
 	if (mlx5_devx_cq_create(priv->cdev->ctx, &qp->cq_obj, log_nb_desc,
-				&cq_attr, socket_id) != 0) {
+				&cq_attr, numa_id) != 0) {
 		DRV_LOG(ERR, "Failed to create CQ.");
 		goto error;
 	}
@@ -509,7 +509,7 @@ mlx5_crypto_xts_queue_pair_setup(struct rte_cryptodev *dev, uint16_t qp_id,
 		mlx5_ts_format_conv(priv->cdev->config.hca_attr.qp_ts_format);
 	ret = mlx5_devx_qp_create(priv->cdev->ctx, &qp->qp_obj,
 					attr.num_of_send_wqbbs * MLX5_WQE_SIZE,
-					&attr, socket_id);
+					&attr, numa_id);
 	if (ret) {
 		DRV_LOG(ERR, "Failed to create QP.");
 		goto error;
-- 
2.55.0

