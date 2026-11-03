Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7DA1606D2FB
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=dxgrb+bc
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6404E42F23;
	Tue,  3 Nov 2026 16:19:18 +0100 (CET)
Received: from mta0.migadu.com (out-202.mta0.migadu.com [91.218.175.202])
 by mails.dpdk.org (Postfix) with ESMTPS id A06EF42F4D
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:19:15 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=rYRPEUFJA2uJ8BWr7e7UxwlH7nBOBGpisfDSTe26x7c=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793719155; v=1; x=1794323955;
 b=dxgrb+bckTLH00VDPDqrlWnaGdOhqrMEix+PUdE2gN0RwRuzIsF/75u0PErRn9WfyxsMp6XG
 gMJt80ylZ0hq2DvgyNkRjfFO4MT3HOpUGGgXz1DTjhpbe0YWWNiniVSrWxNbE/7eIXonQHElo1L
 HfHfVMAA7Nng30NW/olMCEQQ=
X-Envelope-To: dev@dpdk.org
Received: by mta11.migadu.com with ESMTPS id a4ca92c049605976;
 Tue, 03 Nov 2026 15:19:15 +0000
X-Mizu-Trace-ID: a4ca92c049605976
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 166/227] regex/mlx5: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:52:04 +0800
Message-ID: <20261103145306.487255-167-chengwen.feng@linux.dev>
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
 drivers/regex/mlx5/mlx5_regex_control.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/regex/mlx5/mlx5_regex_control.c b/drivers/regex/mlx5/mlx5_regex_control.c
index 92cf5f495e..f837a24c74 100644
--- a/drivers/regex/mlx5/mlx5_regex_control.c
+++ b/drivers/regex/mlx5/mlx5_regex_control.c
@@ -83,7 +83,7 @@ regex_ctrl_create_cq(struct mlx5_regex_priv *priv, struct mlx5_regex_cq *cq)
 
 	cq->ci = 0;
 	ret = mlx5_devx_cq_create(priv->cdev->ctx, &cq->cq_obj, cq->log_nb_desc,
-				  &attr, SOCKET_ID_ANY);
+				  &attr, RTE_NUMA_ID_ANY);
 	if (ret) {
 		DRV_LOG(ERR, "Can't create CQ object.");
 		memset(cq, 0, sizeof(*cq));
@@ -155,7 +155,7 @@ regex_ctrl_create_hw_qp(struct mlx5_regex_priv *priv, struct mlx5_regex_qp *qp,
 	attr.mmo = priv->mmo_regex_qp_cap;
 	ret = mlx5_devx_qp_create(priv->cdev->ctx, &qp_obj->qp_obj,
 			attr.num_of_send_wqbbs * MLX5_WQE_SIZE, &attr,
-			SOCKET_ID_ANY);
+			RTE_NUMA_ID_ANY);
 	if (ret) {
 		DRV_LOG(ERR, "Can't create QP object.");
 		rte_errno = ENOMEM;
@@ -248,7 +248,7 @@ mlx5_regex_qp_setup(struct rte_regexdev *dev, uint16_t qp_ind,
 	}
 
 	ret = mlx5_mr_ctrl_init(&qp->mr_ctrl, &priv->cdev->mr_scache.dev_gen,
-				rte_socket_id());
+				rte_numa_id());
 	if (ret) {
 		DRV_LOG(ERR, "Error setting up mr btree");
 		goto err_btree;
-- 
2.55.0

