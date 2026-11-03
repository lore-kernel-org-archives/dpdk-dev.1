Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4F0606A7BD
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=jwjKFqdz
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3699742F39;
	Tue,  3 Nov 2026 16:19:26 +0100 (CET)
Received: from mta0.migadu.com (out-208.mta0.migadu.com [91.218.175.208])
 by mails.dpdk.org (Postfix) with ESMTPS id 5B68642F39
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:19:24 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=dlSJ/E9o8gq6nOCpx1QFbdRw1g2i3sjAaXkkn7ccO/U=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793719163; v=1; x=1794323963;
 b=jwjKFqdzk1rp9HM+A+drpPGCZNywVirZ2+vWgqm5i1q/2aVt8nmeHdSU3tgBKxAeVw13mwhB
 aEJJOC4JModivs0e0+wKBPFN/CbnDaCChHZcjWfwoDF2DksTGRd6X0+Nj0HQEYcKnq5gan5vAxh
 gf2wXUpoZ/ce27HkA+IrRE+g=
X-Envelope-To: dev@dpdk.org
Received: by mta12.migadu.com with ESMTPS id 61f1de1b8e04b708;
 Tue, 03 Nov 2026 15:19:23 +0000
X-Mizu-Trace-ID: 61f1de1b8e04b708
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 167/227] vdpa/mlx5: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:52:05 +0800
Message-ID: <20261103145306.487255-168-chengwen.feng@linux.dev>
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
 drivers/vdpa/mlx5/mlx5_vdpa_cthread.c | 2 +-
 drivers/vdpa/mlx5/mlx5_vdpa_event.c   | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/vdpa/mlx5/mlx5_vdpa_cthread.c b/drivers/vdpa/mlx5/mlx5_vdpa_cthread.c
index 84f611c1ab..6b173957e8 100644
--- a/drivers/vdpa/mlx5/mlx5_vdpa_cthread.c
+++ b/drivers/vdpa/mlx5/mlx5_vdpa_cthread.c
@@ -265,7 +265,7 @@ mlx5_vdpa_c_thread_create(void)
 			thrd_idx);
 		conf_thread_mng.cthrd[thrd_idx].rng = rte_ring_create_elem(name,
 			sizeof(struct mlx5_vdpa_task), ring_num,
-			rte_socket_id(),
+			rte_numa_id(),
 			RING_F_MP_HTS_ENQ | RING_F_MC_HTS_DEQ |
 			RING_F_EXACT_SZ);
 		if (!conf_thread_mng.cthrd[thrd_idx].rng) {
diff --git a/drivers/vdpa/mlx5/mlx5_vdpa_event.c b/drivers/vdpa/mlx5/mlx5_vdpa_event.c
index d18cf7d7e5..fc7eabf9d0 100644
--- a/drivers/vdpa/mlx5/mlx5_vdpa_event.c
+++ b/drivers/vdpa/mlx5/mlx5_vdpa_event.c
@@ -96,7 +96,7 @@ mlx5_vdpa_cq_create(struct mlx5_vdpa_priv *priv, uint16_t log_desc_n,
 	int ret;
 
 	ret = mlx5_devx_cq_create(priv->cdev->ctx, &cq->cq_obj, log_desc_n,
-				  &attr, SOCKET_ID_ANY);
+				  &attr, RTE_NUMA_ID_ANY);
 	if (ret)
 		goto error;
 	cq->cq_ci = 0;
@@ -671,7 +671,7 @@ mlx5_vdpa_event_qp_prepare(struct mlx5_vdpa_priv *priv, uint16_t desc_n,
 		mlx5_ts_format_conv(priv->cdev->config.hca_attr.qp_ts_format);
 	ret = mlx5_devx_qp_create(priv->cdev->ctx, &(eqp->sw_qp),
 				  attr.num_of_receive_wqes * MLX5_WSEG_SIZE,
-				  &attr, SOCKET_ID_ANY);
+				  &attr, RTE_NUMA_ID_ANY);
 	if (ret) {
 		DRV_LOG(ERR, "Failed to create SW QP(%u).", rte_errno);
 		goto error;
-- 
2.55.0

