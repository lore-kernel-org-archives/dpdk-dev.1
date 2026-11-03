Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 771D5606A7B8
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=D78Cmxsb
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C3B6042EAF;
	Tue,  3 Nov 2026 16:13:44 +0100 (CET)
Received: from mta1.migadu.com (out-39.mta1.migadu.com [95.215.58.39])
 by mails.dpdk.org (Postfix) with ESMTPS id 60E9B42E88
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:13:43 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=nIGJze2EExJREcQK3/z3fsb/OIXuzrYhlwod90zI6t4=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793718822; v=1; x=1794323622;
 b=D78CmxsbnMyyXhru1Cz9VVbFAzlPZhdoh2X5JlRRjCPiCLbFWrI05ylSJPO3VzbZBWQw+650
 kEO9y5mry5G4iY5Qmufa9UOCz2Zr/4HWa8muDYqojJWOay9F9AEphc2DTuHa8yxnbhC9hv3xzgv
 FyJt+Jaq9RBNp91QND99NqC8=
X-Envelope-To: dev@dpdk.org
Received: by mta12.migadu.com with ESMTPS id 9f8275030a282e9b;
 Tue, 03 Nov 2026 15:13:42 +0000
X-Mizu-Trace-ID: 9f8275030a282e9b
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 130/227] net/mvpp2: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:51:28 +0800
Message-ID: <20261103145306.487255-131-chengwen.feng@linux.dev>
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
 drivers/net/mvpp2/mrvl_ethdev.c | 6 +++---
 drivers/net/mvpp2/mrvl_flow.c   | 8 ++++----
 drivers/net/mvpp2/mrvl_mtr.c    | 4 ++--
 drivers/net/mvpp2/mrvl_qos.c    | 4 ++--
 drivers/net/mvpp2/mrvl_tm.c     | 6 +++---
 5 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/net/mvpp2/mrvl_ethdev.c b/drivers/net/mvpp2/mrvl_ethdev.c
index 9be3e5a92d..695031ca6c 100644
--- a/drivers/net/mvpp2/mrvl_ethdev.c
+++ b/drivers/net/mvpp2/mrvl_ethdev.c
@@ -2021,7 +2021,7 @@ mrvl_rx_queue_setup(struct rte_eth_dev *dev, uint16_t idx, uint16_t desc,
 		dev->data->rx_queues[idx] = NULL;
 	}
 
-	rxq = rte_zmalloc_socket("rxq", sizeof(*rxq), 0, socket);
+	rxq = rte_zmalloc_numa("rxq", sizeof(*rxq), 0, socket);
 	if (!rxq)
 		return -ENOMEM;
 
@@ -2124,7 +2124,7 @@ mrvl_tx_queue_setup(struct rte_eth_dev *dev, uint16_t idx, uint16_t desc,
 		dev->data->tx_queues[idx] = NULL;
 	}
 
-	txq = rte_zmalloc_socket("txq", sizeof(*txq), 0, socket);
+	txq = rte_zmalloc_numa("txq", sizeof(*txq), 0, socket);
 	if (!txq)
 		return -ENOMEM;
 
@@ -3060,7 +3060,7 @@ mrvl_priv_create(const char *dev_name)
 	uint16_t max_frame_size;
 	int ret, bpool_bit;
 
-	priv = rte_zmalloc_socket(dev_name, sizeof(*priv), 0, rte_socket_id());
+	priv = rte_zmalloc_numa(dev_name, sizeof(*priv), 0, rte_numa_id());
 	if (!priv)
 		return NULL;
 
diff --git a/drivers/net/mvpp2/mrvl_flow.c b/drivers/net/mvpp2/mrvl_flow.c
index 9932e28edc..14b691eaf4 100644
--- a/drivers/net/mvpp2/mrvl_flow.c
+++ b/drivers/net/mvpp2/mrvl_flow.c
@@ -35,13 +35,13 @@
 static int
 mrvl_alloc_key_mask(struct pp2_cls_rule_key_field *field)
 {
-	unsigned int id = rte_socket_id();
+	unsigned int id = rte_numa_id();
 
-	field->key = rte_zmalloc_socket(NULL, MRVL_CLS_STR_SIZE_MAX, 0, id);
+	field->key = rte_zmalloc_numa(NULL, MRVL_CLS_STR_SIZE_MAX, 0, id);
 	if (!field->key)
 		goto out;
 
-	field->mask = rte_zmalloc_socket(NULL, MRVL_CLS_STR_SIZE_MAX, 0, id);
+	field->mask = rte_zmalloc_numa(NULL, MRVL_CLS_STR_SIZE_MAX, 0, id);
 	if (!field->mask)
 		goto out_mask;
 
@@ -1721,7 +1721,7 @@ mrvl_flow_create(struct rte_eth_dev *dev,
 		return NULL;
 	}
 
-	flow = rte_zmalloc_socket(NULL, sizeof(*flow), 0, rte_socket_id());
+	flow = rte_zmalloc_numa(NULL, sizeof(*flow), 0, rte_numa_id());
 	if (!flow)
 		return NULL;
 
diff --git a/drivers/net/mvpp2/mrvl_mtr.c b/drivers/net/mvpp2/mrvl_mtr.c
index c07ac95ddc..f8ca04118b 100644
--- a/drivers/net/mvpp2/mrvl_mtr.c
+++ b/drivers/net/mvpp2/mrvl_mtr.c
@@ -100,7 +100,7 @@ mrvl_meter_profile_add(struct rte_eth_dev *dev, uint32_t meter_profile_id,
 					  RTE_MTR_ERROR_TYPE_METER_PROFILE_ID,
 					  NULL, "Profile id already exists\n");
 
-	prof = rte_zmalloc_socket(NULL, sizeof(*prof), 0, rte_socket_id());
+	prof = rte_zmalloc_numa(NULL, sizeof(*prof), 0, rte_numa_id());
 	if (!prof)
 		return -rte_mtr_error_set(error, ENOMEM,
 					  RTE_MTR_ERROR_TYPE_UNSPECIFIED,
@@ -347,7 +347,7 @@ mrvl_create(struct rte_eth_dev *dev, uint32_t mtr_id,
 					  RTE_MTR_ERROR_TYPE_MTR_ID, NULL,
 					  "Meter id already exists\n");
 
-	mtr = rte_zmalloc_socket(NULL, sizeof(*mtr), 0, rte_socket_id());
+	mtr = rte_zmalloc_numa(NULL, sizeof(*mtr), 0, rte_numa_id());
 	if (!mtr)
 		return -rte_mtr_error_set(error, ENOMEM,
 					  RTE_MTR_ERROR_TYPE_UNSPECIFIED,
diff --git a/drivers/net/mvpp2/mrvl_qos.c b/drivers/net/mvpp2/mrvl_qos.c
index e298da2724..d53a5c8d65 100644
--- a/drivers/net/mvpp2/mrvl_qos.c
+++ b/drivers/net/mvpp2/mrvl_qos.c
@@ -936,9 +936,9 @@ setup_tc(struct pp2_ppio_tc_params *param, uint8_t inqs,
 	param->pools[0][1] = dummy_pool[bpool->pp2_id];
 	param->default_color = color;
 
-	inq_params = rte_zmalloc_socket("inq_params",
+	inq_params = rte_zmalloc_numa("inq_params",
 		inqs * sizeof(*inq_params),
-		0, rte_socket_id());
+		0, rte_numa_id());
 	if (!inq_params)
 		return -ENOMEM;
 
diff --git a/drivers/net/mvpp2/mrvl_tm.c b/drivers/net/mvpp2/mrvl_tm.c
index c5046490ae..09d349a794 100644
--- a/drivers/net/mvpp2/mrvl_tm.c
+++ b/drivers/net/mvpp2/mrvl_tm.c
@@ -429,8 +429,8 @@ mrvl_shaper_profile_add(struct rte_eth_dev *dev, uint32_t shaper_profile_id,
 					 RTE_TM_ERROR_TYPE_SHAPER_PROFILE_ID,
 					 NULL, "Profile id already exists\n");
 
-	profile = rte_zmalloc_socket(NULL, sizeof(*profile), 0,
-				     rte_socket_id());
+	profile = rte_zmalloc_numa(NULL, sizeof(*profile), 0,
+				     rte_numa_id());
 	if (!profile)
 		return -rte_tm_error_set(error, ENOMEM,
 					 RTE_TM_ERROR_TYPE_UNSPECIFIED,
@@ -657,7 +657,7 @@ mrvl_node_add(struct rte_eth_dev *dev, uint32_t node_id,
 					 RTE_TM_ERROR_TYPE_NODE_ID,
 					 NULL, "Node id already exists\n");
 
-	node = rte_zmalloc_socket(NULL, sizeof(*node), 0, rte_socket_id());
+	node = rte_zmalloc_numa(NULL, sizeof(*node), 0, rte_numa_id());
 	if (!node)
 		return -rte_tm_error_set(error, ENOMEM,
 					 RTE_TM_ERROR_TYPE_UNSPECIFIED,
-- 
2.55.0

