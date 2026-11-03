Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE85606A7BA
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=rqyr0FCO
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4143442EE4;
	Tue,  3 Nov 2026 16:16:13 +0100 (CET)
Received: from mta1.migadu.com (out-206.mta1.migadu.com [95.215.58.206])
 by mails.dpdk.org (Postfix) with ESMTPS id C1A0E427C7
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:16:11 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=e4Wtv1vRr49D5zf4nn0pI4ryrWTXFXbEMYhnK4e8sY0=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793718971; v=1; x=1794323771;
 b=rqyr0FCO4TXsA7oTPx4FGuG4rHyWPKGbWzTDbJJpBbhWoeoFDYiE6awFq5jKT7YnoLkIVMse
 c5nnpR+cL6ic7psIh9kZXATQ7EOuTdEih8F/sI8W7Nnw+2WC5DXW0HoCZR++G7wUihShnhGaKdi
 d0JIoYuhcGPTNCyG6VA9qS5M=
X-Envelope-To: dev@dpdk.org
Received: by mta11.migadu.com with ESMTPS id 727c00f634a85978;
 Tue, 03 Nov 2026 15:16:11 +0000
X-Mizu-Trace-ID: 727c00f634a85978
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 147/227] net/softnic: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:51:45 +0800
Message-ID: <20261103145306.487255-148-chengwen.feng@linux.dev>
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
 drivers/net/softnic/rte_eth_softnic.c        | 6 +++---
 drivers/net/softnic/rte_eth_softnic_thread.c | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/softnic/rte_eth_softnic.c b/drivers/net/softnic/rte_eth_softnic.c
index 868e194509..857c70da4a 100644
--- a/drivers/net/softnic/rte_eth_softnic.c
+++ b/drivers/net/softnic/rte_eth_softnic.c
@@ -79,7 +79,7 @@ static int
 pmd_rx_queue_setup(struct rte_eth_dev *dev,
 	uint16_t rx_queue_id,
 	uint16_t nb_rx_desc,
-	unsigned int socket_id __rte_unused,
+	unsigned int numa_id __rte_unused,
 	const struct rte_eth_rxconf *rx_conf __rte_unused,
 	struct rte_mempool *mb_pool __rte_unused)
 {
@@ -107,7 +107,7 @@ static int
 pmd_tx_queue_setup(struct rte_eth_dev *dev,
 	uint16_t tx_queue_id,
 	uint16_t nb_tx_desc,
-	unsigned int socket_id __rte_unused,
+	unsigned int numa_id __rte_unused,
 	const struct rte_eth_txconf *tx_conf __rte_unused)
 {
 	char name[NAME_SIZE];
@@ -254,7 +254,7 @@ pmd_init(struct pmd_params *params)
 	struct pmd_internals *p;
 	int status;
 
-	p = rte_zmalloc_socket(params->name,
+	p = rte_zmalloc_numa(params->name,
 		sizeof(struct pmd_internals),
 		0,
 		params->cpu_id);
diff --git a/drivers/net/softnic/rte_eth_softnic_thread.c b/drivers/net/softnic/rte_eth_softnic_thread.c
index a6d47c8b33..f45b63f481 100644
--- a/drivers/net/softnic/rte_eth_softnic_thread.c
+++ b/drivers/net/softnic/rte_eth_softnic_thread.c
@@ -41,7 +41,7 @@ softnic_thread_init(struct pmd_internals *softnic)
 		struct rte_ring *msgq_req, *msgq_rsp;
 		struct softnic_thread *t = &softnic->thread[i];
 		struct softnic_thread_data *t_data = &softnic->thread_data[i];
-		uint32_t cpu_id = rte_lcore_to_socket_id(i);
+		uint32_t cpu_id = rte_lcore_to_numa_id(i);
 
 		/* MSGQs */
 		snprintf(ring_name, sizeof(ring_name), "%s-TH%u-REQ",
-- 
2.55.0

