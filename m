Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE2F606A78E
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=PFz2tO/O
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 104F442E00;
	Tue,  3 Nov 2026 16:07:07 +0100 (CET)
Received: from mta0.migadu.com (out-77.mta0.migadu.com [91.218.175.77])
 by mails.dpdk.org (Postfix) with ESMTPS id DA5FE42DD5
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:07:05 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=f0a262pp4PvJbLUazKeYMTCU+ocP5C7SsiYj+B/zEvs=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793718425; v=1; x=1794323225;
 b=PFz2tO/OGeFF7ImRtPySc3ZHk+g8hhmfn9PRqiIhon0H5/DdfUsgJ4gdFbTFcqx/2gJqVRXE
 I9SzUwmT5ABIllWdm3LT51jFsK6P9r2hiN6N3eIfahFY2Hwf4NoOWWvDv7ujYgh+YIIdzqrFBDv
 KzYClhnA94BeX2+554/7HjU8=
X-Envelope-To: dev@dpdk.org
Received: by mta10.migadu.com with ESMTPS id 370a12cad82ad5a0;
 Tue, 03 Nov 2026 15:07:05 +0000
X-Mizu-Trace-ID: 370a12cad82ad5a0
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 083/227] dma/dpaa: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:50:41 +0800
Message-ID: <20261103145306.487255-84-chengwen.feng@linux.dev>
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
 drivers/dma/dpaa/dpaa_qdma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/dpaa/dpaa_qdma.c b/drivers/dma/dpaa/dpaa_qdma.c
index d8bece700a..eb4cddae3e 100644
--- a/drivers/dma/dpaa/dpaa_qdma.c
+++ b/drivers/dma/dpaa/dpaa_qdma.c
@@ -1500,7 +1500,7 @@ dpaa_qdma_probe(__rte_unused struct rte_dpaa_driver *dpaa_drv,
 	}
 
 	dmadev = rte_dma_pmd_allocate(dpaa_dev->device.name,
-				      rte_socket_id(),
+				      rte_numa_id(),
 				      sizeof(struct fsl_qdma_engine));
 	if (!dmadev) {
 		DPAA_QDMA_ERR("Unable to allocate dmadevice");
-- 
2.55.0

