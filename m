Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF444606A32F
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=VZBfKhN1
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A6BC2432E6;
	Tue,  3 Nov 2026 16:27:28 +0100 (CET)
Received: from mta1.migadu.com (out-75.mta1.migadu.com [95.215.58.75])
 by mails.dpdk.org (Postfix) with ESMTPS id 681AA432E6
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:27:26 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=UGoY6l3bqaBbt5lmC1VEBLB8tADESDntZac8pkhiUbw=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793719646; v=1; x=1794324446;
 b=VZBfKhN1WdJwvmAUZnHtqXr/oQZ6RooadC+Fh+r4PFoIV/LCYqQVJ+UVRG61zGvqX9BNx7Yv
 36VgBwxsdv3WhbhfFzvyE5AIbKoz0DArin1V6eTMU1fLEqRlcG6kb9v5HcfOq9O+jaiLHj15ylK
 uvVSly6W9PVMg+pvecJe7sLQ=
X-Envelope-To: dev@dpdk.org
Received: by mta12.migadu.com with ESMTPS id 757f8f43b63b4a1b;
 Tue, 03 Nov 2026 15:27:25 +0000
X-Mizu-Trace-ID: 757f8f43b63b4a1b
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 219/227] examples/vhost_crypto: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:52:57 +0800
Message-ID: <20261103145306.487255-220-chengwen.feng@linux.dev>
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

Rename socket_id parameters, local variables and comments to the
NUMA node terminology, and switch calls to the NUMA-named APIs.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 examples/vhost_crypto/main.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/examples/vhost_crypto/main.c b/examples/vhost_crypto/main.c
index 53bd8fa825..7f28d507f1 100644
--- a/examples/vhost_crypto/main.c
+++ b/examples/vhost_crypto/main.c
@@ -313,7 +313,7 @@ new_device(int vid)
 	}
 
 	ret = rte_vhost_crypto_create(vid, info->cid, info->sess_pool,
-			rte_lcore_to_socket_id(options.los[i].lcore_id));
+			rte_lcore_to_numa_id(options.los[i].lcore_id));
 	if (ret) {
 		RTE_LOG(ERR, USER1, "Cannot create vhost crypto\n");
 		return ret;
@@ -510,8 +510,8 @@ main(int argc, char *argv[])
 		struct lcore_option *lo = &options.los[i];
 		struct vhost_crypto_info *info;
 
-		info = rte_zmalloc_socket(NULL, sizeof(*info),
-				RTE_CACHE_LINE_SIZE, rte_lcore_to_socket_id(
+		info = rte_zmalloc_numa(NULL, sizeof(*info),
+				RTE_CACHE_LINE_SIZE, rte_lcore_to_numa_id(
 						lo->lcore_id));
 		if (!info) {
 			ret = -ENOMEM;
@@ -544,7 +544,7 @@ main(int argc, char *argv[])
 		}
 
 		config.nb_queue_pairs = dev_info.max_nb_queue_pairs;
-		config.socket_id = rte_lcore_to_socket_id(lo->lcore_id);
+		config.numa_id = rte_lcore_to_numa_id(lo->lcore_id);
 		config.ff_disable = RTE_CRYPTODEV_FF_SECURITY;
 
 		ret = rte_cryptodev_configure(info->cid, &config);
@@ -560,13 +560,13 @@ main(int argc, char *argv[])
 					SESSION_MAP_ENTRIES,
 					rte_cryptodev_sym_get_private_session_size(
 					info->cid), 0, 0,
-					rte_lcore_to_socket_id(lo->lcore_id));
+					rte_lcore_to_numa_id(lo->lcore_id));
 			cop_type = RTE_CRYPTO_OP_TYPE_SYMMETRIC;
 		} else {
 			snprintf(name, 127, "ASYM_SESS_POOL_%u", lo->lcore_id);
 			info->sess_pool = rte_cryptodev_asym_session_pool_create(name,
 					SESSION_MAP_ENTRIES, 0, 64,
-					rte_lcore_to_socket_id(lo->lcore_id));
+					rte_lcore_to_numa_id(lo->lcore_id));
 			cop_type = RTE_CRYPTO_OP_TYPE_ASYMMETRIC;
 		}
 
@@ -579,7 +579,7 @@ main(int argc, char *argv[])
 		info->cop_pool = rte_crypto_op_pool_create(name,
 				cop_type, NB_MEMPOOL_OBJS,
 				NB_CACHE_OBJS, VHOST_CRYPTO_MAX_IV_LEN,
-				rte_lcore_to_socket_id(lo->lcore_id));
+				rte_lcore_to_numa_id(lo->lcore_id));
 
 		if (!info->cop_pool) {
 			RTE_LOG(ERR, USER1, "Failed to create crypto pool");
@@ -596,7 +596,7 @@ main(int argc, char *argv[])
 
 		for (j = 0; j < dev_info.max_nb_queue_pairs; j++) {
 			ret = rte_cryptodev_queue_pair_setup(info->cid, j,
-					&qp_conf, rte_lcore_to_socket_id(
+					&qp_conf, rte_lcore_to_numa_id(
 							lo->lcore_id));
 			if (ret < 0) {
 				RTE_LOG(ERR, USER1, "Failed to configure qp\n");
-- 
2.55.0

