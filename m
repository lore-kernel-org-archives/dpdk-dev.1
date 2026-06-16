Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DA61CD98DA
	for <dpdk-dev@archiver.kernel.org>; Tue, 16 Jun 2026 11:21:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 68BEB40E1E;
	Tue, 16 Jun 2026 13:21:29 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id CBD7540E15
 for <dev@dpdk.org>; Tue, 16 Jun 2026 13:21:27 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65GBJRnA2588652; Tue, 16 Jun 2026 04:21:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=o
 jQ8nShQx6CxSrLu7zgDWGkxHfSk22OcJCkNaCa9oN8=; b=YtzUv7o9fQPV+I0e0
 PKTFCLycMCl4YadtNLhNGNTQmueUOeHVeo7d0oIFNq7Zq3ds2SnqvgzmJaBabkZd
 M+kFPvOBxlPLPiB1yDOsZHetyQSImYaw3l3vTBV8O0lV0bWTkg28HBGPoXHyvMBy
 30fksVkgefAueV8NNfl4b18gwKAt8KWx+4kxBJ43HNsvGUdbuX/IkLlDdkNMzt7B
 FdgaK7lhlx5byNqPKoeCd2R60gh1AcJW0pG/ZU7lVr6sILAHy0J3XvtbMrbrpxmG
 tjqT61vw8Jc4dfo0OHj2k9RsVwqm34qLf5Ay+EPZ/DEAowb3NX/ENdCzcFVUBukY
 zoQmQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4etu38jcee-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Jun 2026 04:21:27 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 16 Jun 2026 04:21:26 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 16 Jun 2026 04:21:26 -0700
Received: from hyd1554.caveonetworks.com (unknown [10.29.56.32])
 by maili.marvell.com (Postfix) with ESMTP id 462783F7094;
 Tue, 16 Jun 2026 04:21:24 -0700 (PDT)
From: Tejasree Kondoj <ktejasree@marvell.com>
To: Akhil Goyal <gakhil@marvell.com>, Fan Zhang <fanzhang.oss@gmail.com>
CC: Vidya Sagar Velumuri <vvelumuri@marvell.com>, Anoob Joseph
 <anoobj@marvell.com>, <dev@dpdk.org>
Subject: [PATCH 4/4] test/crypto: add unit test for Rx inject multi seg
Date: Tue, 16 Jun 2026 16:51:13 +0530
Message-ID: <20260616112113.73680-5-ktejasree@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260616112113.73680-1-ktejasree@marvell.com>
References: <20260616112113.73680-1-ktejasree@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: ePc8MbNbOCQDEAUWOn6GpW1CjX_S6tt9
X-Proofpoint-ORIG-GUID: ePc8MbNbOCQDEAUWOn6GpW1CjX_S6tt9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDExNCBTYWx0ZWRfX326pOeXwO1Qs
 Ro7FUXxKa6AxTIUIG3++Y7rm0ntD4JPJCFjELYMoX445VJs8vk50oHqyDYm0FftWmS8xcFnzKYF
 oktGHiuzxRA4zFaPjRc89FMvQNk26eQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDExNCBTYWx0ZWRfXyKhy+C7A80FD
 X75MbGF8ZUg2/ryR9oF9DjjA6vDFLKpT2FhdwXGx25ZQe8Kuf1amMEj5Bx5uYacRlfgCXYen2M6
 JoECZjJ78KA4MWPlD96OXLoyaVRjtggdj4jgOmUThB+QvpmELfJdW6on53xWVFsjWGqG6XWtY0g
 JZ5yuz7FjH3wYxUolgaS0vT2BxLiXPzvdp+yKPV0MBby3dVyBYj/a2RhNhr+PA3xj364rc8QZbC
 X3xkEP/iVncssj7gfvtbs9dZwQXUmhXQ+dtekKrwoYWRX8s21fwiR8WOgoSLznjlS8yhtrJpgsk
 6NQ4Q+St8QdiVscMgmg50Y1a9kkn2Y2PKsAJZ1TVBMPhnT7XPMtTqwYg5tOK+NU/rMvZCVapB3H
 itnjg9+dbR4QkvpXgexRg5Oo+VZetRECzIefXd3/eneLs6QK4qIntW2TTLKsHqJ5948aa2UamAa
 5F1ygVjy9Bk+nPEfGtw==
X-Authority-Analysis: v=2.4 cv=SeXHsPRu c=1 sm=1 tr=0 ts=6a3131b7 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=M5GUcnROAAAA:8 a=Wr31DqYP4mucbMYCTD4A:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_03,2026-06-15_04,2025-10-01_01
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

From: Vidya Sagar Velumuri <vvelumuri@marvell.com>

Add unit test to verify the multi segment support in RX Inject

Signed-off-by: Vidya Sagar Velumuri <vvelumuri@marvell.com>
---
 app/test/test_cryptodev.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/app/test/test_cryptodev.c b/app/test/test_cryptodev.c
index bd726ddcf9..a11bc00963 100644
--- a/app/test/test_cryptodev.c
+++ b/app/test/test_cryptodev.c
@@ -1564,7 +1564,8 @@ ut_setup_security_rx_inject(void)
 	struct rte_eth_conf port_conf = {
 		.rxmode = {
 			.offloads = RTE_ETH_RX_OFFLOAD_CHECKSUM |
-				    RTE_ETH_RX_OFFLOAD_SECURITY,
+				    RTE_ETH_RX_OFFLOAD_SECURITY |
+					RTE_ETH_RX_OFFLOAD_SCATTER,
 		},
 		.txmode = {
 			.offloads = RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE,
@@ -10781,6 +10782,25 @@ test_ipsec_proto_known_vec_inb_rx_inject(const void *test_data)
 	return test_ipsec_proto_process(&td_inb, NULL, 1, false, &flags);
 }
 
+static int
+test_ipsec_proto_known_vec_inb_rx_inject_multi_seg(const void *test_data)
+{
+	const struct ipsec_test_data *td = test_data;
+	struct ipsec_test_flags flags;
+	struct ipsec_test_data td_inb;
+
+	memset(&flags, 0, sizeof(flags));
+	flags.rx_inject = true;
+	flags.nb_segs_in_mbuf = 4;
+
+	if (td->ipsec_xform.direction == RTE_SECURITY_IPSEC_SA_DIR_EGRESS)
+		test_ipsec_td_in_from_out(td, &td_inb);
+	else
+		memcpy(&td_inb, td, sizeof(td_inb));
+
+	return test_ipsec_proto_process(&td_inb, NULL, 1, false, &flags);
+}
+
 static int
 test_ipsec_proto_all(const struct ipsec_test_flags *flags)
 {
@@ -18389,6 +18409,11 @@ static struct unit_test_suite ipsec_proto_testsuite  = {
 			"Inbound known vector (ESP tunnel mode IPv4 AES-GCM 128) Rx inject",
 			ut_setup_security_rx_inject, ut_teardown_rx_inject,
 			test_ipsec_proto_known_vec_inb_rx_inject, &pkt_aes_128_gcm),
+		TEST_CASE_NAMED_WITH_DATA(
+			"Inbound known vector (ESP tunnel mode IPv4 AES-GCM 128) Rx inject multi seg",
+			ut_setup_security_rx_inject, ut_teardown_rx_inject,
+			test_ipsec_proto_known_vec_inb_rx_inject_multi_seg, &pkt_aes_128_gcm),
+
 		TEST_CASES_END() /**< NULL terminate unit test array */
 	}
 };
-- 
2.34.1

