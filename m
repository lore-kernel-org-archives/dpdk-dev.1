Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FA13D25B7E
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 Jan 2026 13:43:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0EF02402BD;
	Wed, 28 Jan 2026 14:43:24 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 34A454003C
 for <dev@dpdk.org>; Wed, 28 Jan 2026 14:43:22 +0100 (CET)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 60SB2SSD1647351 for <dev@dpdk.org>; Wed, 28 Jan 2026 05:43:21 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=dUf/06cbn+ePgI6+GZTp5BG
 Mhndg1tb8V/ScJ7UMCNM=; b=VOwowgliMF3iuwYIt/ksWx5SZpvrvrpTcPaf4gt
 mTzrvvDaepglm7Au5A0daV2mtI9ayrRVU9ifnKBppzw1Y0ExtBGvgLAJI8CuEbF4
 cUK4Bv9FvKt9RHYd6zCwjZVCN3zuMikcJzJOofpLoE0qozaRPjF4SSfp2Fz5mY1N
 gWZk/qshLyU/Om03qg1F8Uw2IoAyQTzFfT3mSt3d2kstQpfo950wsCNpRtII7fbL
 K486QVYRO1vbN+tA0W/khGFUZ2LbSh3DIKaYZMtz3n7AlG2D8t/3rMYDKJBfAtTg
 l6deNCWluGEh/NAxJfH4pLxG9VsEASfL0wYu3UT6Vmsx8LA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4bvxfjrkcn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Wed, 28 Jan 2026 05:43:21 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 28 Jan 2026 05:43:35 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 28 Jan 2026 05:43:35 -0800
Received: from cavium-RAHUL-BM.. (unknown [10.28.36.48])
 by maili.marvell.com (Postfix) with ESMTP id 6215D3F7076;
 Wed, 28 Jan 2026 05:43:18 -0800 (PST)
From: Rahul Bhansali <rbhansali@marvell.com>
To: <dev@dpdk.org>, Akhil Goyal <gakhil@marvell.com>, Anoob Joseph
 <anoobj@marvell.com>
CC: Rahul Bhansali <rbhansali@marvell.com>
Subject: [PATCH] test/security: IPsec rule for out-of-place tests
Date: Wed, 28 Jan 2026 19:13:08 +0530
Message-ID: <20260128134308.571158-1-rbhansali@marvell.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 2SK8Yp0bmsnBgDEz8_dZH6VfbQudrGYU
X-Proofpoint-ORIG-GUID: 2SK8Yp0bmsnBgDEz8_dZH6VfbQudrGYU
X-Authority-Analysis: v=2.4 cv=S9LUAYsP c=1 sm=1 tr=0 ts=697a1279 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8
 a=aBMHGL7_DZ97MFOJAe0A:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI4MDExMyBTYWx0ZWRfX1cJ7MWqytZLo
 ktI+APzYJ9UPaC+SXnfYagO38JJoH3G8APqDGuamh38Mv3ltsT5jACLDVn+0moLIY9qyQLGhkUQ
 uN3MWxeU6WKrSIR8cU9mg/gNrWgZUMswJsk0ecPa1DgNIg/Ct8m2V9ICKf5hkpRQ8b5NykVRzXo
 BtNW4SkNHb4ZdqvbG4wBShavq3njm/tUYLVGtUAYDQSELlkObF5cAJovcz4eG0JVcQaNnBWAShU
 AL4/obJa8gSAeEcm80nzncJ7JScgH4Jrj9ukwyF1WR6kVF7syxfNvqU/qF51xGfzTjm1xxilreP
 4IM2OjX1oTH3aqVyqoWLYKkFDfRqx0GnIS8ue8Rtrc/2BcF87ScTdOfU8zICOlksn7YG56GVzHi
 hdb0eMAchtOv72OFbakNnaaxoTx7sTQIYTTHfJsyyhT2hskZIjmx6H5EXV5WBqbhzjyygbeCN6W
 xqJVhLNk3+g38bqPSCA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-28_02,2026-01-28_02,2025-10-01_01
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

For out-of-place (OOP) inline ingress test, some of the
hardware supports ESP specific flow rule instead of
default flow rule.
OOP test case will try first using ESP specific flow rule
with SPI specified in flow pattern. If ESP rule is not
supported then will retry with default flow rule.

Signed-off-by: Rahul Bhansali <rbhansali@marvell.com>
---
 app/test/test_security_inline_proto.c | 52 ++++++++++++++++++++++++++-
 1 file changed, 51 insertions(+), 1 deletion(-)

diff --git a/app/test/test_security_inline_proto.c b/app/test/test_security_inline_proto.c
index 04ecfd02c6..3f3fe0cfe9 100644
--- a/app/test/test_security_inline_proto.c
+++ b/app/test/test_security_inline_proto.c
@@ -542,6 +542,48 @@ init_mempools(unsigned int nb_mbuf)
 	return 0;
 }
 
+static int
+create_ipsec_flow(uint16_t portid, void *ses, uint32_t spi)
+{
+	struct rte_flow_item_esp esp_spec;
+	struct rte_flow_action action[2];
+	struct rte_flow_item pattern[2];
+	struct rte_flow_attr attr = {0};
+	struct rte_flow_error err;
+	struct rte_flow *flow;
+	int ret;
+
+	esp_spec.hdr.spi = rte_cpu_to_be_32(spi);
+
+	pattern[0].type = RTE_FLOW_ITEM_TYPE_ESP;
+	pattern[0].spec = &esp_spec;
+	pattern[0].mask = &rte_flow_item_esp_mask;
+	pattern[0].last = NULL;
+	pattern[1].type = RTE_FLOW_ITEM_TYPE_END;
+
+	action[0].type = RTE_FLOW_ACTION_TYPE_SECURITY;
+	action[0].conf = ses;
+	action[1].type = RTE_FLOW_ACTION_TYPE_END;
+	action[1].conf = NULL;
+
+	attr.ingress = 1;
+
+	ret = rte_flow_validate(portid, &attr, pattern, action, &err);
+	if (ret) {
+		printf("\nValidate ESP flow failed, ret = %d\n", ret);
+		return -1;
+	}
+	flow = rte_flow_create(portid, &attr, pattern, action, &err);
+	if (flow == NULL) {
+		printf("\nESP flow rule create failed\n");
+		return -1;
+	}
+
+	default_flow[portid] = flow;
+
+	return 0;
+}
+
 static int
 create_default_flow(uint16_t portid)
 {
@@ -1373,7 +1415,15 @@ test_ipsec_inline_proto_process(struct ipsec_test_data *td,
 	}
 
 	if (td->ipsec_xform.direction == RTE_SECURITY_IPSEC_SA_DIR_INGRESS) {
-		ret = create_default_flow(port_id);
+		if (flags->inb_oop) {
+			ret = create_ipsec_flow(port_id, ses, td->ipsec_xform.spi);
+			if (ret) {
+				/* Check with default flow rule */
+				printf("\nFailed to create ESP flow, try with default flow");
+				ret = create_default_flow(port_id);
+			}
+		} else
+			ret = create_default_flow(port_id);
 		if (ret)
 			goto out;
 	}
-- 
2.34.1

