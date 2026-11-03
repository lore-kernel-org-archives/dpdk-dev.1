Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18026606BA3E
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=ZmYMcyFL
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8538E42D7D;
	Tue,  3 Nov 2026 16:04:26 +0100 (CET)
Received: from mta1.migadu.com (out-165.mta1.migadu.com [95.215.58.165])
 by mails.dpdk.org (Postfix) with ESMTPS id 5A51242D2E
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:04:25 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=w23bLuAe+e7Je7IYPGb/9ZcAN6PDwgYOwBtozBhO1yQ=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793718264; v=1; x=1794323064;
 b=ZmYMcyFLdFmlAt4X18oApVcjpoDxXLPrnGWGKVmlCxhRSKpdejF5GpDNHjOkZY/z6dT1dIx/
 d1BGx8Airu4OQMTrwIjDcaRnJC2BovI8VIj203l+UCKJG6MZYCk9eNalrEaOO7wV9LJaS78dMNm
 SlcLLf1RdUG+suxGhA2/NJZM=
X-Envelope-To: dev@dpdk.org
Received: by mta12.migadu.com with ESMTPS id 2b4417d2fe751474;
 Tue, 03 Nov 2026 15:04:24 +0000
X-Mizu-Trace-ID: 2b4417d2fe751474
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 068/227] crypto/dpaa_sec: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:50:26 +0800
Message-ID: <20261103145306.487255-69-chengwen.feng@linux.dev>
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
 drivers/crypto/dpaa_sec/dpaa_sec.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/crypto/dpaa_sec/dpaa_sec.c b/drivers/crypto/dpaa_sec/dpaa_sec.c
index 65b3573a1a..9eb7772b05 100644
--- a/drivers/crypto/dpaa_sec/dpaa_sec.c
+++ b/drivers/crypto/dpaa_sec/dpaa_sec.c
@@ -2135,7 +2135,7 @@ dpaa_sec_queue_pair_release(struct rte_cryptodev *dev,
 static int
 dpaa_sec_queue_pair_setup(struct rte_cryptodev *dev, uint16_t qp_id,
 		__rte_unused const struct rte_cryptodev_qp_conf *qp_conf,
-		__rte_unused int socket_id)
+		__rte_unused int numa_id)
 {
 	struct dpaa_sec_dev_private *internals;
 	struct dpaa_sec_qp *qp = NULL;
@@ -2160,7 +2160,7 @@ dpaa_sec_queue_pair_setup(struct rte_cryptodev *dev, uint16_t qp_id,
 							CTX_POOL_BUF_SIZE,
 							CTX_POOL_CACHE_SIZE, 0,
 							NULL, NULL, NULL, NULL,
-							SOCKET_ID_ANY, 0);
+							RTE_NUMA_ID_ANY, 0);
 		if (!qp->ctx_pool) {
 			DPAA_SEC_ERR("%s create failed", str);
 			return -ENOMEM;
@@ -3619,7 +3619,7 @@ dpaa_sec_uninit(struct rte_cryptodev *dev)
 
 	rte_free(dev->security_ctx);
 	DPAA_SEC_INFO("Closing DPAA_SEC device %s on numa socket %u",
-		      dev->data->name, rte_socket_id());
+		      dev->data->name, rte_numa_id());
 
 	return 0;
 }
-- 
2.55.0

