Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E925606A33E
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=vSJDkuQR
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4ED8542E37;
	Tue,  3 Nov 2026 16:07:42 +0100 (CET)
Received: from mta0.migadu.com (out-97.mta0.migadu.com [91.218.175.97])
 by mails.dpdk.org (Postfix) with ESMTPS id 7C72D42E02
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:07:40 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=cH0oaOXjf5xRYWpB8P+wITXaXEXEmJQN7icjHML3DZs=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793718460; v=1; x=1794323260;
 b=vSJDkuQRMa/ILgfxCDX3dgbjY8G9Rv+Up9RIl18pckI8APLoaTokF8xsWx0yb58anr6Sg5U3
 CmN3gg1K/FADMEHg+MxNbNYlpA6i5N7s/mRkLLIsBHuBp7imZafKbBLJMity+Je8n/qLjJ+KV+B
 gIWFgjPn50CDWNX4TdpLdKf0=
X-Envelope-To: dev@dpdk.org
Received: by mta12.migadu.com with ESMTPS id 15d52455014fcba5;
 Tue, 03 Nov 2026 15:07:40 +0000
X-Mizu-Trace-ID: 15d52455014fcba5
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 088/227] dma/odm: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:50:46 +0800
Message-ID: <20261103145306.487255-89-chengwen.feng@linux.dev>
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
 drivers/dma/odm/odm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/odm/odm.c b/drivers/dma/odm/odm.c
index 0633ce0b4b..cf56f89394 100644
--- a/drivers/dma/odm/odm.c
+++ b/drivers/dma/odm/odm.c
@@ -201,7 +201,7 @@ odm_vchan_setup(struct odm_dev *odm, int vchan, const struct rte_dma_vchan_conf
 	isize = RTE_ALIGN_CEIL(conf->nb_desc * ODM_IRING_ENTRY_SIZE_MAX * 8, 1024);
 	isize = RTE_MIN(isize, ODM_IRING_MAX_SIZE);
 	snprintf(name, sizeof(name), "vq%d_iring%d", odm->vfid, vchan);
-	mz = rte_memzone_reserve_aligned(name, isize, SOCKET_ID_ANY, 0, 1024);
+	mz = rte_memzone_reserve_aligned(name, isize, RTE_NUMA_ID_ANY, 0, 1024);
 	if (mz == NULL)
 		return -ENOMEM;
 	vq->iring_mz = mz;
@@ -211,7 +211,7 @@ odm_vchan_setup(struct odm_dev *odm, int vchan, const struct rte_dma_vchan_conf
 	max_nb_desc = (isize / (ODM_IRING_ENTRY_SIZE_MIN * 8));
 	csize = RTE_ALIGN_CEIL(max_nb_desc * sizeof(union odm_cmpl_ent_s), 1024);
 	snprintf(name, sizeof(name), "vq%d_cring%d", odm->vfid, vchan);
-	mz = rte_memzone_reserve_aligned(name, csize, SOCKET_ID_ANY, 0, 1024);
+	mz = rte_memzone_reserve_aligned(name, csize, RTE_NUMA_ID_ANY, 0, 1024);
 	if (mz == NULL) {
 		rc = -ENOMEM;
 		goto iring_free;
-- 
2.55.0

