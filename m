Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96653606A324
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=EGRrIOJQ
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4F2AB432D2;
	Tue,  3 Nov 2026 16:26:22 +0100 (CET)
Received: from mta0.migadu.com (out-136.mta0.migadu.com [91.218.175.136])
 by mails.dpdk.org (Postfix) with ESMTPS id 0820A40B97
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:26:21 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=mpFI9drAehfitxCYCQayoUmBWddqhWtOUS2/X3b2KE8=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793719580; v=1; x=1794324380;
 b=EGRrIOJQfPmpWckdTAIlsU7MC9C0gHc5RBbCl9/slRiaAhWohBSDW5NlsZwtY3TSMQ4lmsQK
 0HAoKPzrmH9vnZN3WLi63/JTAkiraee1O6HPFrV8i8VC4QBQmOpBpUEB9Nzl5CVzzIgVTpV+usl
 qhXZGqwfR+JWWBalocxNyJok=
X-Envelope-To: dev@dpdk.org
Received: by mta11.migadu.com with ESMTPS id 4dea272a233ad90c;
 Tue, 03 Nov 2026 15:26:20 +0000
X-Mizu-Trace-ID: 4dea272a233ad90c
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 210/227] examples/pipeline: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:52:48 +0800
Message-ID: <20261103145306.487255-211-chengwen.feng@linux.dev>
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
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Chengwen Feng <fengchengwen@huawei.com>

Rename socket_id parameters, local variables and comments to the
NUMA node terminology, and switch calls to the NUMA-named APIs.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 examples/pipeline/obj.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/examples/pipeline/obj.c b/examples/pipeline/obj.c
index 9f49df190e..edc437c60d 100644
--- a/examples/pipeline/obj.c
+++ b/examples/pipeline/obj.c
@@ -125,8 +125,8 @@ ethdev_config(const char *name, struct ethdev_params *params)
 		}
 	}
 
-	numa_node = rte_eth_dev_socket_id(port_id);
-	if (numa_node == SOCKET_ID_ANY)
+	numa_node = rte_eth_dev_numa_id(port_id);
+	if (numa_node == RTE_NUMA_ID_ANY)
 		numa_node = 0;
 
 	status = rte_eth_dev_configure(
@@ -205,7 +205,7 @@ cryptodev_config(const char *name, struct cryptodev_params *params)
 	struct rte_cryptodev_config dev_conf;
 	struct rte_cryptodev_qp_conf queue_conf;
 	uint8_t dev_id;
-	uint32_t socket_id, i;
+	uint32_t numa_id, i;
 	int status;
 
 	/* Check input parameters. */
@@ -225,11 +225,11 @@ cryptodev_config(const char *name, struct cryptodev_params *params)
 	if (params->n_queue_pairs > dev_info.max_nb_queue_pairs)
 		return -EINVAL;
 
-	socket_id = rte_cryptodev_socket_id(dev_id);
+	numa_id = rte_cryptodev_numa_id(dev_id);
 
 	/* Configure the crypto device. */
 	memset(&dev_conf, 0, sizeof(dev_conf));
-	dev_conf.socket_id = socket_id;
+	dev_conf.numa_id = numa_id;
 	dev_conf.nb_queue_pairs = params->n_queue_pairs;
 	dev_conf.ff_disable = 0;
 
@@ -243,7 +243,7 @@ cryptodev_config(const char *name, struct cryptodev_params *params)
 	queue_conf.mp_session = NULL;
 
 	for (i = 0; i < params->n_queue_pairs; i++) {
-		status = rte_cryptodev_queue_pair_setup(dev_id, i, &queue_conf, socket_id);
+		status = rte_cryptodev_queue_pair_setup(dev_id, i, &queue_conf, numa_id);
 		if (status)
 			return status;
 	}
-- 
2.55.0

