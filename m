Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29053CAC5A5
	for <dpdk-dev@archiver.kernel.org>; Thu, 25 Sep 2025 12:09:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0EB864042F;
	Thu, 25 Sep 2025 14:09:53 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 292AF402AB
 for <dev@dpdk.org>; Thu, 25 Sep 2025 14:09:51 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58P1XQoO012994
 for <dev@dpdk.org>; Thu, 25 Sep 2025 05:09:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=RbQCk3zab2IZPvPEJHH4XZI
 WAKIt77DpC0q8aV1Eb3k=; b=ausQ+wg61I0o46e8iG6DXZlU1qSy7tvURK3nws9
 FcLA6H4nIvc0V/ErkR/Pi3FBCHKR2U9Q/c7YJLJhTfK1W3K5xeersbsGK/M3t6QE
 jSs5gEc75tYDMVxHIFhNJTN9QnHWu8BZNu0JggGhegECwOvai4YISTPasf2Qzaba
 vbQBJRfu6a8MbvG+sYUc2L+ftWjTwY7JJ59IVsiuv5+yco0bdcEwbFsRMdn8UTBc
 4PHsqARNVMALQVP2PO+chJL+3rhkPqFlC5s1JYNMJTGhBjDpFFfaNPMbH4iZiJgL
 bsw/ITWVKAJ7wFRogrV415T0EGZDn+1zO55jyePlxsiZmhw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 49cv6798ax-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Thu, 25 Sep 2025 05:09:49 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 25 Sep 2025 05:09:49 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 25 Sep 2025 05:09:49 -0700
Received: from localhost.localdomain (unknown [10.28.34.29])
 by maili.marvell.com (Postfix) with ESMTP id 5EDB83F7043;
 Thu, 25 Sep 2025 05:09:47 -0700 (PDT)
From: Shijith Thotton <sthotton@marvell.com>
To: <jerinj@marvell.com>
CC: Shijith Thotton <sthotton@marvell.com>, <dev@dpdk.org>,
 <pbhagavatula@marvell.com>
Subject: [PATCH] event/cnxk: update queue weight mapping for CN20K
Date: Thu, 25 Sep 2025 17:39:12 +0530
Message-ID: <20250925120912.1137360-1-sthotton@marvell.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=Vef3PEp9 c=1 sm=1 tr=0 ts=68d5310d cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=yJojWOMRYYMA:10 a=M5GUcnROAAAA:8 a=VFDFmSU8EEjFXhA4Kb8A:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: gOMHS9kY6N20kInREiR_6vXEAqAD9WB1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDAxMiBTYWx0ZWRfX8M+clPHIXvg4
 PT16rfRdcpK+QSGHNaIa5OyBY9Cfk39X7UwyRj/qp9NALHSiLpAEeQNmj9eByA8HiWjg1zWE3E7
 bCZWsljTIBt+R+qabEkjJItHlC+CrU7LvfouXNssSIUB7BzmGlD0cyEVLsmnjow3iU2jOgjv1VY
 JFp7YI2gRlkgB5Gcp0HbpGBSf4dogunFW6Pu+6Uc6XY43CMA4sRAGfX7qemSFcae9CrEEHpGYeQ
 Bj7M7Vd2vc39qmtOncmkhVevmC0LoMiGR4NRB8hn0DtcnUuo7SnyWHiYQKij3Q0d1lw/NFXpKct
 g1oOgjOk3mM87nbl1tfNwucqjGvgdcDcXE3t/9IkVFoze58w1ecS5c55NBAdncQjKxxvsO4YdjZ
 c8i4bN/I
X-Proofpoint-ORIG-GUID: gOMHS9kY6N20kInREiR_6vXEAqAD9WB1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-25_01,2025-09-24_01,2025-03-28_01
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

The CN20K platform accepts weights in the range of 1 to 255, while DPDK
allows weights from 0 to 255. This patch aligns DPDK's weight values
with the hardware-supported range.

Signed-off-by: Shijith Thotton <sthotton@marvell.com>
---
 drivers/event/cnxk/cn20k_eventdev.c | 70 ++++++++++++++++++++++++++++-
 drivers/event/cnxk/cn20k_eventdev.h |  1 +
 2 files changed, 69 insertions(+), 2 deletions(-)

diff --git a/drivers/event/cnxk/cn20k_eventdev.c b/drivers/event/cnxk/cn20k_eventdev.c
index 4552f6da97..b25e570211 100644
--- a/drivers/event/cnxk/cn20k_eventdev.c
+++ b/drivers/event/cnxk/cn20k_eventdev.c
@@ -20,6 +20,72 @@
 #define CN20K_SET_EVDEV_ENQ_OP(dev, enq_op, enq_ops)                                               \
 	enq_op = enq_ops[dev->tx_offloads & (NIX_TX_OFFLOAD_MAX - 1)]
 
+static uint8_t
+cn20k_sso_hw_weight(uint8_t weight)
+{
+	/* Map DPDK weight 0-255 to HW weight 1-255 */
+	return (weight + 1) > CN20K_SSO_WEIGHT_MAX ? CN20K_SSO_WEIGHT_MAX : (weight + 1);
+}
+
+static int
+cn20k_sso_queue_setup(struct rte_eventdev *event_dev, uint8_t queue_id,
+		      const struct rte_event_queue_conf *queue_conf)
+{
+	struct cnxk_sso_evdev *dev = cnxk_sso_pmd_priv(event_dev);
+	uint8_t priority, weight, affinity;
+
+	priority = CNXK_QOS_NORMALIZE(queue_conf->priority, 0, RTE_EVENT_DEV_PRIORITY_LOWEST,
+				      CNXK_SSO_PRIORITY_CNT);
+	weight = cn20k_sso_hw_weight(queue_conf->weight);
+	affinity = CNXK_QOS_NORMALIZE(queue_conf->affinity, 0, RTE_EVENT_QUEUE_AFFINITY_HIGHEST,
+				      CNXK_SSO_AFFINITY_CNT);
+
+	plt_sso_dbg("Queue=%u prio=%u weight=%u affinity=%u", queue_id, priority, weight, affinity);
+
+	return roc_sso_hwgrp_set_priority(&dev->sso, queue_id, weight, affinity, priority);
+}
+
+static int
+cn20k_sso_queue_attribute_set(struct rte_eventdev *event_dev, uint8_t queue_id, uint32_t attr_id,
+			      uint64_t attr_value)
+{
+	struct cnxk_sso_evdev *dev = cnxk_sso_pmd_priv(event_dev);
+	uint8_t priority, weight, affinity;
+	struct rte_event_queue_conf *conf;
+
+	conf = &event_dev->data->queues_cfg[queue_id];
+
+	switch (attr_id) {
+	case RTE_EVENT_QUEUE_ATTR_PRIORITY:
+		conf->priority = attr_value;
+		break;
+	case RTE_EVENT_QUEUE_ATTR_WEIGHT:
+		conf->weight = attr_value;
+		break;
+	case RTE_EVENT_QUEUE_ATTR_AFFINITY:
+		conf->affinity = attr_value;
+		break;
+	case RTE_EVENT_QUEUE_ATTR_NB_ATOMIC_FLOWS:
+	case RTE_EVENT_QUEUE_ATTR_NB_ATOMIC_ORDER_SEQUENCES:
+	case RTE_EVENT_QUEUE_ATTR_EVENT_QUEUE_CFG:
+	case RTE_EVENT_QUEUE_ATTR_SCHEDULE_TYPE:
+		/* FALLTHROUGH */
+		plt_sso_dbg("Unsupported attribute id %u", attr_id);
+		return -ENOTSUP;
+	default:
+		plt_err("Invalid attribute id %u", attr_id);
+		return -EINVAL;
+	}
+
+	priority = CNXK_QOS_NORMALIZE(conf->priority, 0, RTE_EVENT_DEV_PRIORITY_LOWEST,
+				      CNXK_SSO_PRIORITY_CNT);
+	weight = cn20k_sso_hw_weight(conf->weight);
+	affinity = CNXK_QOS_NORMALIZE(conf->affinity, 0, RTE_EVENT_QUEUE_AFFINITY_HIGHEST,
+				      CNXK_SSO_AFFINITY_CNT);
+
+	return roc_sso_hwgrp_set_priority(&dev->sso, queue_id, weight, affinity, priority);
+}
+
 static void *
 cn20k_sso_init_hws_mem(void *arg, uint8_t port_id)
 {
@@ -1114,9 +1180,9 @@ static struct eventdev_ops cn20k_sso_dev_ops = {
 	.dev_configure = cn20k_sso_dev_configure,
 
 	.queue_def_conf = cnxk_sso_queue_def_conf,
-	.queue_setup = cnxk_sso_queue_setup,
+	.queue_setup = cn20k_sso_queue_setup,
 	.queue_release = cnxk_sso_queue_release,
-	.queue_attr_set = cnxk_sso_queue_attribute_set,
+	.queue_attr_set = cn20k_sso_queue_attribute_set,
 
 	.port_def_conf = cnxk_sso_port_def_conf,
 	.port_setup = cn20k_sso_port_setup,
diff --git a/drivers/event/cnxk/cn20k_eventdev.h b/drivers/event/cnxk/cn20k_eventdev.h
index 8ea2878fa5..71f1fc6086 100644
--- a/drivers/event/cnxk/cn20k_eventdev.h
+++ b/drivers/event/cnxk/cn20k_eventdev.h
@@ -7,6 +7,7 @@
 
 #define CN20K_SSO_DEFAULT_STASH_OFFSET -1
 #define CN20K_SSO_DEFAULT_STASH_LENGTH 2
+#define CN20K_SSO_WEIGHT_MAX	       (0xff)
 
 struct __rte_cache_aligned cn20k_sso_hws {
 	uint64_t base;
-- 
2.25.1

