Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22867606A7AB
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Cjkv90He
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ED40E42EA3;
	Tue,  3 Nov 2026 16:13:39 +0100 (CET)
Received: from mta0.migadu.com (out-28.mta0.migadu.com [91.218.175.28])
 by mails.dpdk.org (Postfix) with ESMTPS id A303942EA3
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:13:38 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=mFVluVPZuosx7K/+N2/0ei29u+fJjCsnQg2pZmfFpB4=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793718817; v=1; x=1794323617;
 b=Cjkv90HeEUJxgrG82YKBWJ9/FES2SN72ZggRwLDifH2pifzqXu0fo0IvTDsFJhVU3sI4kSik
 YN3JroyVpTf5gbyfjVB2gTtKEKxhNM5BkeTPS+f3ImtJbUqS0edz+nFzer1iY4rZnOyex9gVM9+
 c5RBUm5VNvPu2HIg1lbaXsw8=
X-Envelope-To: dev@dpdk.org
Received: by mta11.migadu.com with ESMTPS id 7c3eb264cd09d40c;
 Tue, 03 Nov 2026 15:13:37 +0000
X-Mizu-Trace-ID: 7c3eb264cd09d40c
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 129/227] net/mvneta: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:51:27 +0800
Message-ID: <20261103145306.487255-130-chengwen.feng@linux.dev>
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
 drivers/net/mvneta/mvneta_ethdev.c | 2 +-
 drivers/net/mvneta/mvneta_rxtx.c   | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/mvneta/mvneta_ethdev.c b/drivers/net/mvneta/mvneta_ethdev.c
index 975d3da81e..a58a5df6d9 100644
--- a/drivers/net/mvneta/mvneta_ethdev.c
+++ b/drivers/net/mvneta/mvneta_ethdev.c
@@ -814,7 +814,7 @@ mvneta_eth_dev_create(struct rte_vdev_device *vdev, const char *name)
 	if (!eth_dev)
 		return -ENOMEM;
 
-	priv = rte_zmalloc_socket(name, sizeof(*priv), 0, rte_socket_id());
+	priv = rte_zmalloc_numa(name, sizeof(*priv), 0, rte_numa_id());
 	if (!priv) {
 		ret = -ENOMEM;
 		goto out_free;
diff --git a/drivers/net/mvneta/mvneta_rxtx.c b/drivers/net/mvneta/mvneta_rxtx.c
index 952e982275..e46050bd76 100644
--- a/drivers/net/mvneta/mvneta_rxtx.c
+++ b/drivers/net/mvneta/mvneta_rxtx.c
@@ -731,7 +731,7 @@ mvneta_rx_queue_setup(struct rte_eth_dev *dev, uint16_t idx, uint16_t desc,
 		dev->data->rx_queues[idx] = NULL;
 	}
 
-	rxq = rte_zmalloc_socket("rxq", sizeof(*rxq), 0, socket);
+	rxq = rte_zmalloc_numa("rxq", sizeof(*rxq), 0, socket);
 	if (!rxq)
 		return -ENOMEM;
 
@@ -780,7 +780,7 @@ mvneta_tx_queue_setup(struct rte_eth_dev *dev, uint16_t idx, uint16_t desc,
 		dev->data->tx_queues[idx] = NULL;
 	}
 
-	txq = rte_zmalloc_socket("txq", sizeof(*txq), 0, socket);
+	txq = rte_zmalloc_numa("txq", sizeof(*txq), 0, socket);
 	if (!txq)
 		return -ENOMEM;
 
-- 
2.55.0

