Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C458CD342F
	for <dpdk-dev@archiver.kernel.org>; Tue,  5 May 2026 10:45:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6679D40272;
	Tue,  5 May 2026 12:45:22 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 8E1E04026C;
 Tue,  5 May 2026 12:45:20 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 645ASAMl171268; Tue, 5 May 2026 03:45:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=WLO2wkK6WTU8mXhKtSE3Omx
 kPWRtxCyxzTPvYikh3O0=; b=PgZWrwjHJSXERZJaNehsRuZbcY+cyqp70ofU//h
 Y6s9j2m0JYPROJHPI1654EtJo6N6jb4ncVHJFBEXdeduAviNp3TARqs+9+aMXCm8
 nPRGpGZwaVfwpO9btCXtbCT58nP/ON2WpQ2lmahpfIYPoAhrqxXTVSMXfkJztXjQ
 G19dLo8+zqBT0GRdJP2cGo4HlHaSYzT5SBj8kGv+HQWT5EVR7SOwmQyv7zqZWGai
 3GsE275Bfp3NpjAiJWYGGaUu7TNwYf+QdkVnu+Gyredxh9FtKhCPPP8rYxD+1Jub
 uWooHZYi+whqqYRJDhk4KIhj5d6Wl6uwHaaZRWVYkyzdcBQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4dyetf012x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 05 May 2026 03:45:19 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 5 May 2026 03:45:18 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 5 May 2026 03:45:18 -0700
Received: from cavium-System-Product-Name.. (unknown [10.28.40.118])
 by maili.marvell.com (Postfix) with ESMTP id 564533F70B3;
 Tue,  5 May 2026 03:45:15 -0700 (PDT)
From: Aarnav JP <ajp@marvell.com>
To: <dev@dpdk.org>, Akhil Goyal <gakhil@marvell.com>, Anoob Joseph
 <anoobj@marvell.com>, Vamsi Attunuru <vattunuru@marvell.com>
CC: <jerinj@marvell.com>, <ndabilpuram@marvell.com>, <rbhansali@marvell.com>, 
 Aarnav JP <ajp@marvell.com>, <stable@dpdk.org>
Subject: [PATCH] test: sync soft expiry check in inline IPsec
Date: Tue, 5 May 2026 16:13:50 +0530
Message-ID: <20260505104351.2678817-1-ajp@marvell.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 0_oBt20NZieJ4wHarJ6LBIrFy5xiw1N5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDEwMSBTYWx0ZWRfX2AIHJWlMLoNh
 g9XS0uhAIkK/IJ0j4629UDZLDlz0HE4bZybRmAWf40RDuA9o9enq0k1KLdWl2R5kb/wv6eWGg7v
 5LePDj3c49aHhCbyaNUd8StoDvO937jBNtU7633a1LM+a29LpgsSj6d46ck6/wxFjHvVdgkCyud
 Ou0WIjeIhKhyvVDQzwXhF8c6HHIUOe4SvVHCTdAhWQFrlBn6zpGWOiWQkVIXeIiFb9YYg94ubq0
 CLbp8Vh5EKg2aJ0iQQZBqNE+kSo72x2uzVnwqOpYKYxiGGUygCzR3/n14Zv9/2/Nr88TeokLlP9
 SSQkTZRJxfCLYvkIx2YOoqUajDmrxmECwB7QolGL0p4F7uXGlyafyAmNRO54sQB2ZLFKnKLL8Q9
 9EzkA62tq7m5+byK32jnVGNE0wRXlVMJvH+ODrYcqADsoXK5l8T0u1nthNkIYDr0B69ry8rW2vV
 z5VLzuU9ttQ029i/2cw==
X-Authority-Analysis: v=2.4 cv=GKU41ONK c=1 sm=1 tr=0 ts=69f9ca3f cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=QXcCYyLzdtTjyudCfB6f:22 a=8rWy6zfcAAAA:8
 a=M5GUcnROAAAA:8 a=xOeKAmmU5iJEIi27trEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=YjdVzJdQTyZRADMV7wFX:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: 0_oBt20NZieJ4wHarJ6LBIrFy5xiw1N5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
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

Soft expiry events are delivered asynchronously via
the err-ring polling thread. The test checked notify_event
right after the RX loop, before the polling thread could
process the err-ring entry — causing intermittent failures
with fast algorithms where TX/RX completes faster than the
polling thread's usleep() wake-up.

Add a bounded poll loop after RX for soft expiry cases, using
rte_io_rmb() to ensure cross-core visibility. Fix store ordering
in the callback with rte_io_wmb() so that the event subtype is
visible before notify_event is set.

Fixes: 34e8a9d9b4f2 ("test/security: add inline IPsec SA soft expiry cases")
Cc: stable@dpdk.org

Signed-off-by: Aarnav JP <ajp@marvell.com>
---
 app/test/test_security_inline_proto.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/app/test/test_security_inline_proto.c b/app/test/test_security_inline_proto.c
index b0cce5ebd9..5db8718a34 100644
--- a/app/test/test_security_inline_proto.c
+++ b/app/test/test_security_inline_proto.c
@@ -38,6 +38,7 @@ test_inline_ipsec_sg(void)
 
 #else
 
+#include <rte_cycles.h>
 #include <rte_eventdev.h>
 #include <rte_event_eth_rx_adapter.h>
 #include <rte_event_eth_tx_adapter.h>
@@ -1306,7 +1307,6 @@ test_ipsec_inline_sa_exp_event_callback(uint16_t port_id,
 		printf("Event descriptor not set\n");
 		return -1;
 	}
-	vector->notify_event = true;
 	if (event_desc->metadata != (uint64_t)vector->sa_data) {
 		printf("Mismatch in event specific metadata\n");
 		return -1;
@@ -1329,6 +1329,10 @@ test_ipsec_inline_sa_exp_event_callback(uint16_t port_id,
 		return -1;
 	}
 
+	/* Ensure event subtype is visible before signaling notify_event. */
+	rte_io_wmb();
+	vector->notify_event = true;
+
 	return 0;
 }
 
@@ -1483,6 +1487,16 @@ test_ipsec_inline_proto_process(struct ipsec_test_data *td,
 				break;
 		} while (j++ < 5 || nb_rx == 0);
 
+	/* Wait for soft expiry event from the err-ring poll thread. */
+	if ((flags->sa_expiry_pkts_soft || flags->sa_expiry_bytes_soft) &&
+	    td->ipsec_xform.direction == RTE_SECURITY_IPSEC_SA_DIR_EGRESS) {
+		j = 0;
+		while (!vector.notify_event && j++ < 100) {
+			rte_delay_us(1000);
+			rte_io_rmb();
+		}
+	}
+
 	if (!flags->sa_expiry_pkts_hard &&
 			!flags->sa_expiry_bytes_hard &&
 			(nb_rx != nb_sent)) {
@@ -1546,10 +1560,13 @@ test_ipsec_inline_proto_process(struct ipsec_test_data *td,
 		destroy_default_flow(port_id);
 	if (flags->sa_expiry_pkts_soft || flags->sa_expiry_bytes_soft ||
 		flags->sa_expiry_pkts_hard || flags->sa_expiry_bytes_hard) {
-		if (vector.notify_event && (vector.event == event))
-			ret = TEST_SUCCESS;
-		else
+		if (vector.notify_event) {
+			rte_io_rmb();
+			ret = (vector.event == event) ?
+				TEST_SUCCESS : TEST_FAILED;
+		} else {
 			ret = TEST_FAILED;
+		}
 
 		rte_eth_dev_callback_unregister(port_id, RTE_ETH_EVENT_IPSEC,
 			test_ipsec_inline_sa_exp_event_callback, &vector);
-- 
2.43.0

