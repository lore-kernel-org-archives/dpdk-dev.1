Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46DE5606B258
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=JBtzqlfv
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 16F4A427CE;
	Tue,  3 Nov 2026 16:02:24 +0100 (CET)
Received: from mta1.migadu.com (out-51.mta1.migadu.com [95.215.58.51])
 by mails.dpdk.org (Postfix) with ESMTPS id 397C2427E5
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:02:23 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=6mfOl6R79QYDDeITNE6ierL9rpNStkS4NoePLYuXGdo=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793718142; v=1; x=1794322942;
 b=JBtzqlfvxbS7TWp2W/Q7VFa917Eh432202AQQU54pQLcrgApfVl9PqmkPTRiHEE+onWxSeBS
 UlyaVgDNi7nodly9+ECGYF89SnLGCo9vMLVqKiNsINuDX2xaL+dpWyM6ILnspL9l9RVvfMBbD+y
 OUgCUMuS4+JiaOWoQe+oYcOg=
X-Envelope-To: dev@dpdk.org
Received: by mta12.migadu.com with ESMTPS id 2155d21c1122b9b2;
 Tue, 03 Nov 2026 15:02:22 +0000
X-Mizu-Trace-ID: 2155d21c1122b9b2
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 057/227] compress/nitrox: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:50:15 +0800
Message-ID: <20261103145306.487255-58-chengwen.feng@linux.dev>
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
 drivers/compress/nitrox/nitrox_comp.c        | 14 +++++++-------
 drivers/compress/nitrox/nitrox_comp_reqmgr.c | 14 +++++++-------
 drivers/compress/nitrox/nitrox_comp_reqmgr.h |  2 +-
 3 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/compress/nitrox/nitrox_comp.c b/drivers/compress/nitrox/nitrox_comp.c
index 56a90a35c5..d6a7ae1629 100644
--- a/drivers/compress/nitrox/nitrox_comp.c
+++ b/drivers/compress/nitrox/nitrox_comp.c
@@ -153,7 +153,7 @@ static void nitrox_comp_dev_info_get(struct rte_compressdev *dev,
 
 static int nitrox_comp_queue_pair_setup(struct rte_compressdev *dev,
 					uint16_t qp_id,
-					uint32_t max_inflight_ops, int socket_id)
+					uint32_t max_inflight_ops, int numa_id)
 {
 	struct nitrox_comp_device *comp_dev = dev->data->dev_private;
 	struct nitrox_device *ndev = comp_dev->ndev;
@@ -173,9 +173,9 @@ static int nitrox_comp_queue_pair_setup(struct rte_compressdev *dev,
 			return err;
 	}
 
-	qp = rte_zmalloc_socket("nitrox PMD qp", sizeof(*qp),
+	qp = rte_zmalloc_numa("nitrox PMD qp", sizeof(*qp),
 				RTE_CACHE_LINE_SIZE,
-				socket_id);
+				numa_id);
 	if (!qp) {
 		NITROX_LOG_LINE(ERR, "Failed to allocate nitrox qp");
 		return -ENOMEM;
@@ -185,12 +185,12 @@ static int nitrox_comp_queue_pair_setup(struct rte_compressdev *dev,
 	qp->qno = qp_id;
 	err = nitrox_qp_setup(qp, ndev->bar_addr, dev->data->name,
 			      max_inflight_ops, ZIP_INSTR_SIZE,
-			      socket_id);
+			      numa_id);
 	if (unlikely(err))
 		goto qp_setup_err;
 
 	qp->sr_mp = nitrox_comp_req_pool_create(dev, qp->count, qp_id,
-						socket_id);
+						numa_id);
 	if (unlikely(!qp->sr_mp))
 		goto req_pool_err;
 
@@ -410,7 +410,7 @@ static int nitrox_comp_stream_create(struct rte_compressdev *dev,
 		nxform->window_size = NITROX_DEFAULT_DEFLATE_SEARCH_DEPTH;
 	}
 
-	nxform->history_window = rte_zmalloc_socket(NULL, nxform->window_size,
+	nxform->history_window = rte_zmalloc_numa(NULL, nxform->window_size,
 					8, comp_dev->xform_pool->numa_id);
 	if (unlikely(nxform->history_window == NULL)) {
 		err = -ENOMEM;
@@ -420,7 +420,7 @@ static int nitrox_comp_stream_create(struct rte_compressdev *dev,
 	if (xform->type == RTE_COMP_COMPRESS)
 		return 0;
 
-	nxform->context = rte_zmalloc_socket(NULL,
+	nxform->context = rte_zmalloc_numa(NULL,
 					NITROX_DECOMP_CTX_SIZE, 8,
 					comp_dev->xform_pool->numa_id);
 	if (unlikely(nxform->context == NULL)) {
diff --git a/drivers/compress/nitrox/nitrox_comp_reqmgr.c b/drivers/compress/nitrox/nitrox_comp_reqmgr.c
index 42358cd14f..e8689d608b 100644
--- a/drivers/compress/nitrox/nitrox_comp_reqmgr.c
+++ b/drivers/compress/nitrox/nitrox_comp_reqmgr.c
@@ -523,7 +523,7 @@ static int handle_zero_length_compression(struct nitrox_softreq *sr,
 static int create_sglist_from_mbuf(struct nitrox_sgtable *sgtbl,
 				   struct rte_mbuf *mbuf, uint32_t off,
 				   uint32_t datalen, uint8_t extra_segs,
-				   int socket_id)
+				   int numa_id)
 {
 	struct rte_mbuf *m;
 	union nitrox_zip_zptr *sgl;
@@ -555,9 +555,9 @@ static int create_sglist_from_mbuf(struct nitrox_sgtable *sgtbl,
 
 		NITROX_LOG_LINE(INFO, "Mbuf has more segs %d than allocated %d",
 			   nb_segs, sgtbl->nb_sgls);
-		sgl = rte_realloc_socket(sgtbl->sgl,
+		sgl = rte_realloc_numa(sgtbl->sgl,
 					 sizeof(*sgtbl->sgl) * nb_segs,
-					 8, socket_id);
+					 8, numa_id);
 		if (unlikely(!sgl)) {
 			NITROX_LOG_LINE(ERR, "Failed to expand sglist memory");
 			return -ENOMEM;
@@ -1159,10 +1159,10 @@ static void req_pool_obj_init(struct rte_mempool *mp, void *arg, void *obj,
 	RTE_SET_USED(mp);
 	RTE_SET_USED(obj_idx);
 	sr = obj;
-	sr->src.sgl = rte_zmalloc_socket(NULL,
+	sr->src.sgl = rte_zmalloc_numa(NULL,
 				sizeof(*sr->src.sgl) * NITROX_ZIP_SGL_COUNT,
 				8, mp->numa_id);
-	sr->dst.sgl = rte_zmalloc_socket(NULL,
+	sr->dst.sgl = rte_zmalloc_numa(NULL,
 				sizeof(*sr->dst.sgl) * NITROX_ZIP_SGL_COUNT,
 				8, mp->numa_id);
 	if (sr->src.sgl == NULL || sr->dst.sgl == NULL) {
@@ -1178,7 +1178,7 @@ static void req_pool_obj_init(struct rte_mempool *mp, void *arg, void *obj,
 
 struct rte_mempool *
 nitrox_comp_req_pool_create(struct rte_compressdev *dev, uint32_t nobjs,
-			   uint16_t qp_id, int socket_id)
+			   uint16_t qp_id, int numa_id)
 {
 	char softreq_pool_name[RTE_RING_NAMESIZE];
 	struct rte_mempool *mp;
@@ -1190,7 +1190,7 @@ nitrox_comp_req_pool_create(struct rte_compressdev *dev, uint32_t nobjs,
 				RTE_ALIGN_MUL_CEIL(nobjs, 64),
 				sizeof(struct nitrox_softreq),
 				64, 0, NULL, NULL, req_pool_obj_init, &err,
-				socket_id, 0);
+				numa_id, 0);
 	if (unlikely(!mp))
 		NITROX_LOG_LINE(ERR, "Failed to create req pool, qid %d, err %d",
 			   qp_id, rte_errno);
diff --git a/drivers/compress/nitrox/nitrox_comp_reqmgr.h b/drivers/compress/nitrox/nitrox_comp_reqmgr.h
index f0cd1eb8fd..d544acb25f 100644
--- a/drivers/compress/nitrox/nitrox_comp_reqmgr.h
+++ b/drivers/compress/nitrox/nitrox_comp_reqmgr.h
@@ -52,7 +52,7 @@ int nitrox_check_comp_req(struct nitrox_softreq *sr, struct rte_comp_op **op);
 void *nitrox_comp_instr_addr(struct nitrox_softreq *sr);
 struct rte_mempool *nitrox_comp_req_pool_create(struct rte_compressdev *cdev,
 					       uint32_t nobjs, uint16_t qp_id,
-					       int socket_id);
+					       int numa_id);
 void nitrox_comp_req_pool_free(struct rte_mempool *mp);
 
 #endif /* _NITROX_COMP_REQMGR_H_ */
-- 
2.55.0

