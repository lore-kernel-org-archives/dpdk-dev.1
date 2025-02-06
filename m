Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C389DC02194
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Feb 2025 15:31:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A9804402F1;
	Thu,  6 Feb 2025 16:31:28 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 74B9B4029A;
 Thu,  6 Feb 2025 16:31:27 +0100 (CET)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 516FDncn022372;
 Thu, 6 Feb 2025 07:31:26 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=CMj6TTpqM7p6SKZ0oO21Ksg
 AwZ1QJZ/8Y1lsN8OfvU0=; b=emDPzJIyme7Vag7MXB75FuDh++iWcjZvPHZrseL
 sQTi2DSArwjyRoux7SYcMy0+3rUGBcWq6dX7LK4llYJ5WIwR4t32UmJK6/Qx1nGH
 1PV961ayQhOVZnrgO+FO2U8NE8F1RHyi8QV208JRuFb7dECMunDFaMYJisZY9/Vs
 xLtQvYJQLkXczVuhfroaBOTCSKnmSHXtK4WS9hbcxVXIkxLsCK3NXMNUijIEZUJi
 GWHK3YYF1m38iaEBN8N7Sg5+1y25f1iMCMW8RssONaX4FrV4irZ0k4Kf/5dfgcg/
 2TUK9bHN5Xtd7lB2m0Rve7mifrUCLoJAPHomWOjDOKiXxOA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 44myhk01a5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 06 Feb 2025 07:31:26 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 6 Feb 2025 07:31:25 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 6 Feb 2025 07:31:25 -0800
Received: from localhost.localdomain (unknown [10.28.34.29])
 by maili.marvell.com (Postfix) with ESMTP id 99286626D0F;
 Thu,  6 Feb 2025 06:33:10 -0800 (PST)
From: Shijith Thotton <sthotton@marvell.com>
To: <jerinj@marvell.com>
CC: <dev@dpdk.org>, <pbhagavatula@marvell.com>, Shijith Thotton
 <sthotton@marvell.com>, <stable@dpdk.org>, Naga Harish K S V
 <s.v.naga.harish.k@intel.com>
Subject: [PATCH] test/event: fix number of queues in eventdev conf
Date: Thu, 6 Feb 2025 20:02:44 +0530
Message-ID: <20250206143244.524451-1-sthotton@marvell.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: dnNB4PW9y63KFND5f3SWd4IEdYe_1iYa
X-Proofpoint-ORIG-GUID: dnNB4PW9y63KFND5f3SWd4IEdYe_1iYa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-06_03,2025-02-05_03,2024-11-22_01
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

The unit test adapter_pollq_instance_get requires three event queues,
but the test suite was only configuring a single queue. This patch
updates the test suite setup function to configure max available queues.

Fixes: a1793ee8aba0 ("eventdev/eth_rx: add adapter instance get API")
Cc: stable@dpdk.org

Signed-off-by: Shijith Thotton <sthotton@marvell.com>
---
 app/test/test_event_eth_rx_adapter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/app/test/test_event_eth_rx_adapter.c b/app/test/test_event_eth_rx_adapter.c
index 0233c87779..9a60e34352 100644
--- a/app/test/test_event_eth_rx_adapter.c
+++ b/app/test/test_event_eth_rx_adapter.c
@@ -230,7 +230,6 @@ testsuite_setup(void)
 	}
 
 	struct rte_event_dev_config config = {
-			.nb_event_queues = 1,
 			.nb_event_ports = 1,
 	};
 
@@ -242,6 +241,7 @@ testsuite_setup(void)
 			dev_info.max_event_port_enqueue_depth;
 	config.nb_events_limit =
 			dev_info.max_num_events;
+	config.nb_event_queues = dev_info.max_event_queues;
 	err = rte_event_dev_configure(TEST_DEV_ID, &config);
 	TEST_ASSERT(err == 0, "Event device initialization failed err %d\n",
 			err);
-- 
2.25.1

