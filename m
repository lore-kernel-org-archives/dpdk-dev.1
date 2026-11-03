Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764A7606B26A
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=KSQua75D
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 36C56427DA;
	Tue,  3 Nov 2026 16:02:21 +0100 (CET)
Received: from mta1.migadu.com (out-44.mta1.migadu.com [95.215.58.44])
 by mails.dpdk.org (Postfix) with ESMTPS id BB8834013F
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:02:19 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=++bAzizo+g++Uw7y3oy07d8tvSVNM+LZAjE/u/UYMbg=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793718137; v=1; x=1794322937;
 b=KSQua75DXaAYdX3tlg1JJ66rsjGjLk4ejQdFGeiJo9sW2tOI42GbhCHT8H1ScpI2C1ZGIpYx
 94hwLPiKEFBOAVOQ0Wtb7/oHWaxSDzVUw0x6XR5tSEkTj/p4siOwScnNNWmSdmaqrM+lq1CS5aF
 6RJKM1m7GHXprFF5Oe6piz0c=
X-Envelope-To: dev@dpdk.org
Received: by mta12.migadu.com with ESMTPS id 965bb8337781a9d7;
 Tue, 03 Nov 2026 15:02:17 +0000
X-Mizu-Trace-ID: 965bb8337781a9d7
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 056/227] compress/mlx5: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:50:14 +0800
Message-ID: <20261103145306.487255-57-chengwen.feng@linux.dev>
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
 drivers/compress/mlx5/mlx5_compress.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/compress/mlx5/mlx5_compress.c b/drivers/compress/mlx5/mlx5_compress.c
index d122715672..0c64c2f97a 100644
--- a/drivers/compress/mlx5/mlx5_compress.c
+++ b/drivers/compress/mlx5/mlx5_compress.c
@@ -57,7 +57,7 @@ struct mlx5_compress_qp {
 	uint16_t pi;
 	uint16_t ci;
 	struct mlx5_mr_ctrl mr_ctrl;
-	int socket_id;
+	int numa_id;
 	struct mlx5_devx_cq cq;
 	struct mlx5_devx_qp qp;
 	struct mlx5_pmd_mr opaque_mr;
@@ -150,7 +150,7 @@ mlx5_compress_init_qp(struct mlx5_compress_qp *qp)
 
 static int
 mlx5_compress_qp_setup(struct rte_compressdev *dev, uint16_t qp_id,
-		       uint32_t max_inflight_ops, int socket_id)
+		       uint32_t max_inflight_ops, int numa_id)
 {
 	struct mlx5_compress_priv *priv = dev->data->dev_private;
 	struct mlx5_hca_attr *attr = &priv->cdev->config.hca_attr;
@@ -170,8 +170,8 @@ mlx5_compress_qp_setup(struct rte_compressdev *dev, uint16_t qp_id,
 
 	alloc_size = RTE_ALIGN(alloc_size, RTE_CACHE_LINE_SIZE);
 	alloc_size += sizeof(struct rte_comp_op *) * (1u << log_ops_n);
-	qp = rte_zmalloc_socket(__func__, alloc_size, RTE_CACHE_LINE_SIZE,
-				socket_id);
+	qp = rte_zmalloc_numa(__func__, alloc_size, RTE_CACHE_LINE_SIZE,
+				numa_id);
 	if (qp == NULL) {
 		DRV_LOG(ERR, "Failed to allocate qp memory.");
 		rte_errno = ENOMEM;
@@ -194,7 +194,7 @@ mlx5_compress_qp_setup(struct rte_compressdev *dev, uint16_t qp_id,
 		goto err;
 	}
 	qp->entries_n = 1 << log_ops_n;
-	qp->socket_id = socket_id;
+	qp->numa_id = numa_id;
 	qp->qp_id = qp_id;
 	qp->priv = priv;
 	qp->ops = (struct rte_comp_op **)RTE_ALIGN((uintptr_t)(qp + 1),
@@ -208,7 +208,7 @@ mlx5_compress_qp_setup(struct rte_compressdev *dev, uint16_t qp_id,
 		goto err;
 	}
 	ret = mlx5_devx_cq_create(priv->cdev->ctx, &qp->cq, log_ops_n, &cq_attr,
-				  socket_id);
+				  numa_id);
 	if (ret != 0) {
 		DRV_LOG(ERR, "Failed to create CQ.");
 		goto err;
@@ -223,7 +223,7 @@ mlx5_compress_qp_setup(struct rte_compressdev *dev, uint16_t qp_id,
 		      attr->decomp_deflate_v1_en || attr->decomp_deflate_v2_en;
 	ret = mlx5_devx_qp_create(priv->cdev->ctx, &qp->qp,
 					qp_attr.num_of_send_wqbbs *
-					MLX5_WQE_SIZE, &qp_attr, socket_id);
+					MLX5_WQE_SIZE, &qp_attr, numa_id);
 	if (ret != 0) {
 		DRV_LOG(ERR, "Failed to create QP.");
 		goto err;
@@ -368,7 +368,7 @@ mlx5_compress_xform_create(struct rte_compressdev *dev,
 	ret = mlx5_compress_xform_validate(xform, &priv->cdev->config.hca_attr);
 	if (ret < 0)
 		return ret;
-	xfrm = rte_zmalloc_socket(__func__, sizeof(*xfrm), 0,
+	xfrm = rte_zmalloc_numa(__func__, sizeof(*xfrm), 0,
 						    priv->dev_config.numa_id);
 	if (xfrm == NULL)
 		return -ENOMEM;
@@ -828,7 +828,7 @@ mlx5_compress_dev_probe(struct mlx5_common_device *cdev,
 	struct mlx5_compress_devarg_params devarg_prms = {0};
 	struct rte_compressdev_pmd_init_params init_params = {
 		.name = "",
-		.socket_id = cdev->dev->numa_node,
+		.numa_id = cdev->dev->numa_node,
 	};
 	const char *ibdev_name = mlx5_os_get_ctx_device_name(cdev->ctx);
 	uint32_t crc32_opaq_offset;
-- 
2.55.0

