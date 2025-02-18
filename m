Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D527C021A9
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Feb 2025 09:16:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5E63540609;
	Tue, 18 Feb 2025 10:16:28 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id D604840611
 for <dev@dpdk.org>; Tue, 18 Feb 2025 10:16:26 +0100 (CET)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51I2RMEL004431;
 Tue, 18 Feb 2025 01:16:26 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=r
 23nPNfv1ffXJnUKKMwYmXA4qjq0RbbEcoizQIM/Z78=; b=PZyqkV27SJiz4iO2a
 N7tX3qsOHQD2Kb62AmNeyhWUh1JSignp8I6SkfD7tTv1/DAsZDjETUL2yVsollCP
 JcKfICYe0jOj+v7Exp8D3Kd2FM1f+aMejo31+T+VwAA33utCbyD7/a3N7ZYB4TO6
 PFx5K0C8YbT+DWzAyX603rxSsgbmCjxI9+4mPy/rnRxg37lkLMdXsSaDt14VxKB7
 fRM+7N4FjdF9Fjf8fBraDaFWu3ggUUh0HEvvyTR247x4DNMaFfX/iDMthdjwORP6
 IPs0kl/mSL7pnyamcwzHv+H0rsrmmrSVdBXWsp5SlxWLDuOvzKceA1MK4GBAIxo/
 R1ZZw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 44v32qt031-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Feb 2025 01:16:26 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 18 Feb 2025 01:16:25 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 18 Feb 2025 01:16:25 -0800
Received: from localhost.localdomain (unknown [10.28.34.29])
 by maili.marvell.com (Postfix) with ESMTP id 66C493F7074;
 Tue, 18 Feb 2025 01:16:23 -0800 (PST)
From: Shijith Thotton <sthotton@marvell.com>
To: <s.v.naga.harish.k@intel.com>, <jerinj@marvell.com>
CC: Shijith Thotton <sthotton@marvell.com>, <dev@dpdk.org>,
 <pbhagavatula@marvell.com>
Subject: [PATCH v2 3/3] test/event: unit test to burst add Rx queues to adapter
Date: Tue, 18 Feb 2025 14:45:42 +0530
Message-ID: <20250218091543.282270-4-sthotton@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250207140910.721374-1-sthotton@marvell.com>
References: <20250207140910.721374-1-sthotton@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: yI04P633EeNEZiZJfb7torPcvLeSq9nx
X-Proofpoint-GUID: yI04P633EeNEZiZJfb7torPcvLeSq9nx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-18_03,2025-02-18_01,2024-11-22_01
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Unsubscribe: <https://mails.dpdk.org/options/dev>,
 <mailto:dev-request@dpdk.org?subject=unsubscribe>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
Errors-To: dev-bounces@dpdk.org

Added unit test for adding queues to Rx adapter in bursts using
rte_event_eth_rx_adapter_queues_add().

Signed-off-by: Shijith Thotton <sthotton@marvell.com>
---
 app/test/test_event_eth_rx_adapter.c | 86 ++++++++++++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/app/test/test_event_eth_rx_adapter.c b/app/test/test_event_eth_rx_adapter.c
index 0233c87779..92b7ff6d99 100644
--- a/app/test/test_event_eth_rx_adapter.c
+++ b/app/test/test_event_eth_rx_adapter.c
@@ -9,6 +9,7 @@
 #include <rte_mempool.h>
 #include <rte_mbuf.h>
 #include <rte_ethdev.h>
+#include <rte_malloc.h>
 
 #ifdef RTE_EXEC_ENV_WINDOWS
 static int
@@ -819,6 +820,89 @@ adapter_queue_add_del(void)
 	return TEST_SUCCESS;
 }
 
+static int
+adapter_queues_add_del(void)
+{
+	struct rte_event_eth_rx_adapter_queue_conf *queue_conf;
+	struct rte_event_dev_info event_dev_info;
+	struct rte_eth_dev_info dev_info;
+	uint16_t i, max_rx_queues;
+	int32_t *rx_queue_ids;
+	struct rte_event ev;
+	uint32_t cap;
+	int err;
+
+	err = rte_event_eth_rx_adapter_caps_get(TEST_DEV_ID, TEST_ETHDEV_ID, &cap);
+	TEST_ASSERT(err == 0, "Expected 0 got %d", err);
+
+	err = rte_eth_dev_info_get(TEST_ETHDEV_ID, &dev_info);
+	TEST_ASSERT(err == 0, "Expected 0 got %d", err);
+
+	max_rx_queues = RTE_MIN(dev_info.max_rx_queues, MAX_NUM_RX_QUEUE);
+
+	err = rte_event_dev_info_get(TEST_DEV_ID, &event_dev_info);
+	TEST_ASSERT(err == 0, "Expected 0 got %d", err);
+
+	queue_conf = rte_zmalloc(NULL, sizeof(*queue_conf) * max_rx_queues, 0);
+	TEST_ASSERT(queue_conf != NULL, "Failed to allocate memory");
+
+	rx_queue_ids = rte_zmalloc(NULL, sizeof(*rx_queue_ids) * max_rx_queues, 0);
+	TEST_ASSERT(rx_queue_ids != NULL, "Failed to allocate memory");
+
+	ev.sched_type = RTE_SCHED_TYPE_ATOMIC;
+	for (i = 0; i < max_rx_queues; i++) {
+		rx_queue_ids[i] = i;
+		ev.queue_id = i % event_dev_info.max_event_queues;
+		if (cap & RTE_EVENT_ETH_RX_ADAPTER_CAP_OVERRIDE_FLOW_ID) {
+			ev.flow_id = 1;
+			queue_conf[i].rx_queue_flags =
+				RTE_EVENT_ETH_RX_ADAPTER_QUEUE_FLOW_ID_VALID;
+		}
+		queue_conf[i].ev = ev;
+		queue_conf[i].servicing_weight = 1;
+	}
+
+	err = rte_event_eth_rx_adapter_queues_add(TEST_INST_ID,
+						  rte_eth_dev_count_total(),
+						  rx_queue_ids, queue_conf, 0);
+	TEST_ASSERT(err == -EINVAL, "Expected -EINVAL got %d", err);
+
+	err = rte_event_eth_rx_adapter_queues_add(TEST_INST_ID + 1, TEST_ETHDEV_ID,
+						  NULL, queue_conf, 0);
+	TEST_ASSERT(err == -EINVAL, "Expected -EINVAL got %d", err);
+
+	err = rte_event_eth_rx_adapter_queues_add(TEST_INST_ID, TEST_ETHDEV_ID,
+						  rx_queue_ids, queue_conf, 1);
+	TEST_ASSERT(err == 0, "Expected 0 got %d", err);
+
+	err = rte_event_eth_rx_adapter_queue_del(TEST_INST_ID, TEST_ETHDEV_ID, 0);
+	TEST_ASSERT(err == 0, "Expected 0 got %d", err);
+
+	if (cap & RTE_EVENT_ETH_RX_ADAPTER_CAP_MULTI_EVENTQ) {
+		err = rte_event_eth_rx_adapter_queues_add(
+			TEST_INST_ID, TEST_ETHDEV_ID, rx_queue_ids, queue_conf,
+			max_rx_queues);
+		TEST_ASSERT(err == 0, "Expected 0 got %d", err);
+
+		err = rte_event_eth_rx_adapter_queue_del(TEST_INST_ID,
+							 TEST_ETHDEV_ID, -1);
+		TEST_ASSERT(err == 0, "Expected 0 got %d", err);
+	} else {
+		err = rte_event_eth_rx_adapter_queues_add(
+			TEST_INST_ID, TEST_ETHDEV_ID, NULL, queue_conf, 0);
+		TEST_ASSERT(err == 0, "Expected 0 got %d", err);
+
+		err = rte_event_eth_rx_adapter_queue_del(TEST_INST_ID,
+							 TEST_ETHDEV_ID, -1);
+		TEST_ASSERT(err == 0, "Expected 0 got %d", err);
+	}
+
+	rte_free(rx_queue_ids);
+	rte_free(queue_conf);
+
+	return TEST_SUCCESS;
+}
+
 static int
 adapter_multi_eth_add_del(void)
 {
@@ -1423,6 +1507,8 @@ static struct unit_test_suite event_eth_rx_tests = {
 		TEST_CASE_ST(NULL, NULL, adapter_create_free_with_params),
 		TEST_CASE_ST(adapter_create, adapter_free,
 					adapter_queue_add_del),
+		TEST_CASE_ST(adapter_create, adapter_free,
+					adapter_queues_add_del),
 		TEST_CASE_ST(adapter_create, adapter_free,
 					adapter_multi_eth_add_del),
 		TEST_CASE_ST(adapter_create, adapter_free, adapter_start_stop),
-- 
2.25.1

